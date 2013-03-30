class StoreController < ApplicationController
  def index
  	@title = "Home Page"
    @driver_records = DriverRecord.all
  end
end
