class RouteRecord < ActiveRecord::Base
  attr_accessible :data, :from, :to, :user_id

  belongs_to :user
  has_many :relationships, :foreign_key => "route_id", :dependent => :destroy
  
  validates :from, :presence => true, :length => { :maximum => 20 }
  validates :to, :presence => true, :length => { :maximum => 20 }

  default_scope :order => 'route_records.created_at DESC'
end
