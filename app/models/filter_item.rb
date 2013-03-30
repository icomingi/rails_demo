class FilterItem < ActiveRecord::Base
  attr_accessible :driver_id, :result_id
  belongs_to :driver_record
  belongs_to :result
end
