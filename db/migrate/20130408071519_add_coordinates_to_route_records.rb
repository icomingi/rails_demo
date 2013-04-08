class AddCoordinatesToRouteRecords < ActiveRecord::Migration
  def change
    add_column :route_records, :lng_s, :string
    add_column :route_records, :lat_s, :string
    add_column :route_records, :lng_d, :string
    add_column :route_records, :lat_d, :string
  end
end
