class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :route_id

      t.timestamps
    end
    add_index :relationships, :follower_id
    add_index :relationships, :route_id
  end

  def self.down
  	drop_table :relationships
  end
end
