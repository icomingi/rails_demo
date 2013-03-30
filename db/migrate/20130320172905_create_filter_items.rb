class CreateFilterItems < ActiveRecord::Migration
  def change
    create_table :filter_items do |t|
      t.integer :driver_id
      t.integer :result_id

      t.timestamps
    end
  end
end
