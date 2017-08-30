class AddBytesToLists < ActiveRecord::Migration
  def change
    add_column :lists, :total_bytes, :float
    add_column :lists, :used_bytes,  :float
  end
end
