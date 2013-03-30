class PagesController < ApplicationController
  def home
  	@title = "HitchHiker | Home Page"
    @route_record = RouteRecord.new if signed_in?
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
