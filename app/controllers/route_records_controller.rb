class RouteRecordsController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	respond_to :html, :json

	def create
		@route_record = current_user.route_records.build(params[:route_record])
		from_str = params[:route_record][:from]
		to_str = params[:route_record][:to]
		from_co = [params[:route_record][:lng_s], params[:route_record][:lat_s]]
		to_co = [params[:route_record][:lng_d], params[:route_record][:lat_d]]

		if params[:search] || !@route_record.save
			@results = do_search(from_str, from_co, to_co)
			render 'search'
		elsif @route_record.save and signed_in?
			flash[:success] = "complete the route"
			redirect_to root_path
		else
			render 'pages/home'
		end
	end

	def index
		@title = "route_records"
		@route_records = RouteRecord.paginate(:page => params[:page])
		if params[:user_id]
			@route_records = RouteRecord.where(:user_id => params[:user_id]).paginate(:page => params[:page])
		end
		respond_with(@route_records)
	end

	def show
		@title = "route_records"
		@route_record = RouteRecord.find(params[:id])
		respond_with(@route_record)
	end

	def search
		@title = "search result"
		kw = params[:kw]
		col = params[:col]
		search = RouteRecord.search do
			fulltext kw do
				fields(col)
			end
			order_by :created_at, :desc
		end
		@results = search.results
		respond_with(@results)
	end

	def edit
		@route_record = RouteRecord.find(params[:id])
		@title = "Edit route"
	end

	def update
		@route_record = RouteRecord.find(params[:id])

		respond_to do |format|
			if @route_record.update_attributes(params[:route_record])
				format.html { redirect_to @route_record, notice: 'Route was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @route_record.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@route_record = RouteRecord.find(params[:id])
		@route_record.destroy

		respond_to do |format|
			format.html { redirect_to route_records_path }
			format.json { head :no_content }
		end
	end

	def do_search(from_str, from_co, to_co)
		search = RouteRecord.search do
			fulltext from_str do
				fields(:from)
			end
			# order_by :created_at
			order_by_geodist(:location, from_co[0], from_co[1])
		end
		results = search.results
		@match_from_count = search.total
		# search.results.each do |result|
		# 	this_co = [result[:lng_s], result[:lat_s]]
		# 	result[:distance] = distance_between(from_co, this_co)
		# end
		return results
	end
end
