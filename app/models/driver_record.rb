class DriverRecord < ActiveRecord::Base
  attr_accessible :description, :end, :image_url, :name, :price, :seats, :start
  default_scope :order => 'name'
  has_many :filter_items

  before_destroy :ensure_not_referenced_by_any_filter_item
  
  def ensure_not_referenced_by_any_item
    if filter_items.count.zero?
      return true
    else
      error[:base] << "line items present"
      return false
    end
  end

end
