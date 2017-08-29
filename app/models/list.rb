# t.string  :label
# t.string  :server_port
# t.string  :password
# t.timestamps null: false

class List < ActiveRecord::Base
  validates_uniqueness_of :server_port

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
      config[:port_password][item.server_port.to_sym] = item.password
    end
    return config.to_json
  end

end
