class RouteRecord < ActiveRecord::Base
  attr_accessible :data, :from, :to, :user_id

  belongs_to :user

  validates :from, :presence => true, :length => { :maximum => 20 }
  validates :to, :presence => true, :length => { :maximum => 20 }

  default_scope :order => 'route_records.created_at DESC'
end
