class CreateShadowSocks < ActiveRecord::Migration
  def change
    create_table :shadow_socks do |t|
      t.string   :local_path
      t.string   :server
      t.integer  :timeout
      t.string   :method
      t.boolean  :fast_open
      t.integer  :workers
      t.timestamps null: false
    end
  end
end
