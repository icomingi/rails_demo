class RouteRecordsController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]

	def create
		@route_record = current_user.route_records.build(params[:route_record])
		if @route_record.save and signed_in?
			flash[:success] = "complete the route"
			redirect_to root_path
		else
			render 'pages/home'
		end
	end

	def destroy
	end
end
