class RelationshipsController < ApplicationController
	before_filter :authenticate

	def create
		@route_record = RouteRecord.find_by_id(params[:relationship][:route_id])
		current_user.follow!(@route_record)
		respond_to do |format|
			format.html { redirect_to @route_record }
			format.js {}
		end
	end

	def destroy
		@route_record = Relationship.find(params[:id]).route
		current_user.unfollow!(@route_record)
		respond_to do |format|
			format.html { redirect_to @route_record }
			format.js
		end
	end
end