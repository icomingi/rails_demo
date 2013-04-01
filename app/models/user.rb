class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessible :email, :name, :password, :password_confirmation

	has_many :route_records, :dependent => :destroy
	has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
	has_many :following, :through => :relationships, :source => :route
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	# validates :name, :presence => true, :length => { :maximum => 50 }
	validates :email, :presence => true, :format => { :with => email_regex } 
	validates :password, :presence => true, 
	:confirmation => true, 
	:length => { :within => 6..10 }
	
	before_save :encrypt_password

	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end

	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end

	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
	end

	def following?(route)
		relationships.find_by_route_id(route)
	end

	def follow!(route)
		relationships.create!(：route_id => route.id	)
	end

	def unfollow!(route)
		relationships.find_by_route_id(route).destroy
	end
	
	private

	def encrypt_password
		self.salt = make_salt if new_record?
		self.encrypted_password = encrypt(password)
	end

	def encrypt(string)
		secure_hash("#{salt}--#{string}")
	end

	def make_salt
		secure_hash("#{Time.now.utc}--#{password}")		
	end

	def secure_hash(string)
		Digest::SHA2.hexdigest(string)
	end

end
