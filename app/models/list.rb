# t.string  :label
# t.string  :server_port
# t.string  :password
# t.float   "total_bytes", limit: 24
# t.float   "used_bytes",  limit: 24
# t.timestamps null: false
require 'open3'
class List < ActiveRecord::Base
  validates_uniqueness_of :server_port
  after_create :add_iptables_output
  after_destroy :delete_iptables_output

  def self.generate_config
    file = ShadowSock.first.local_path
    List.generate_file(file)
    File.open(file,'w') { |f| f.write(List.config_params) }
  end

  def self.generate_file(file)
    if !File.exist?(file)
      FileUtils.mkdir_p(File.dirname(file))
    end
  end

  def self.config_params
    ss = ShadowSock.first
    lists = List.all
    config = {}
    config[:server] = ss.server
    config[:port_password] = {}
    config[:timeout] = ss.timeout
    config[:method] = ss.method
    config[:fast_open] = ss.fast_open
    config[:workers] = ss.workers
    lists.each do |item|
      if item.total_bytes > item.used_bytes
        config[:port_password][item.server_port.to_sym] = item.password
      end
    end
    return config.to_json
  end

  def add_iptables_output
    o, s = Open3.capture2("iptables -A OUTPUT -p tcp --sport #{self.server_port}")
  end

  def delete_iptables_output
    o, s = Open3.capture2("iptables -D OUTPUT -p tcp --sport #{self.server_port}")
  end

  def usage_amount
    if self.total_bytes.present? && self.used_bytes.present?
      return (self.used_bytes * 100 /self.total_bytes).round(2)
    else
      return 0
    end
  end

  def sync_used_bytes
    amount = self.get_local_output
    if amount > 0
      self.update_attributes(used_bytes:amount)
    end
  end

  def get_local_output
    o, s = Open3.capture2("iptables -L -n -v -x | grep 'spt:#{self.server_port}' | awk '{print $2}'")
    if o.present?
      return o.chomp.to_i
    end
    0
  end

  def self.size_to_number(use_size)
    if use_size.upcase.include?('K')
      return use_size.to_i * 1024
    elsif use_size.upcase.include?('M')
      return use_size.to_i * 1024**2
    elsif use_size.upcase.include?('G')
      return use_size.to_i * 1024**3
    else
      return use_size.to_i
    end
  end

end
