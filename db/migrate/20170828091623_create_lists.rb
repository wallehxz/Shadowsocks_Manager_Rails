class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string  :label
      t.string  :server_port
      t.string  :password
      t.timestamps null: false
    end
  end
end
