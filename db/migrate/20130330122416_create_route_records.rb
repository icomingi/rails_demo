class CreateRouteRecords < ActiveRecord::Migration
  def self.up
    create_table :route_records do |t|
      t.string :from
      t.string :to
      t.string :data
      t.integer :user_id

      t.timestamps
    end
    add_index :route_records, :user_id
  end

  def self.down
  	drop_table :route_records
  end

end
