class AddQuan < ActiveRecord::Migration
  def up
  	add_column :filter_items, :quantity, :integer, :default => 1
  end

  def down
  	remove_column :filter_items, :quantity
  end
end
