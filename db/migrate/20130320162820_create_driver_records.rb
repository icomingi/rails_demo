class CreateDriverRecords < ActiveRecord::Migration
  def self.up
    create_table :driver_records do |t|
      t.string :name
      t.text :description
      t.string :seats
      t.string :start
      t.string :end
      t.string :image_url
      t.decimal :price

      t.timestamps
    end
  end

  def self.down
    drop_table :driver_records
  end
  
end
