class PagesController < ApplicationController
  def home
  	@title = "HitchHiker | Home Page"
    if signed_in?
      @route_record = RouteRecord.new
    else
      @user = User.new
      @route_record = RouteRecord.new
    end
    
  	# render :js => "alert('for you');"
  	# render :status => :forbidden

  end

  def contact
  	@title = "Contact | HitchHiker"
  end

  def about
  	@title = "About | HitchHiker"
  end
end
