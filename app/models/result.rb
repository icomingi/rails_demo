class Result < ActiveRecord::Base
	has_many :filter_items, :dependent => :destroy
	def add_driver(driver_id)
		current_driver = filter_items.where(:product_id => product_id).first
		if current_driver
			current_driver.quantity += 1
		else
			current_driver = DriverRecord.new(:product_id=>product_id)
			filter_items << current_driver
		end
		current_driver
	end
# attr_accessible :title, :body


end
