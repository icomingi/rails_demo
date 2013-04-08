class RouteRecordsController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]

	def create
		@route_record = current_user.route_records.build(params[:route_record])
		from_str = params[:route_record][:from]
		to_str = params[:route_record][:to]
		if params[:search] || !@route_record.save
			search = RouteRecord.search do
				fulltext from_str do
					fields(:from)
				end
				order_by :created_at, :desc
			end
			@results = search.results
			render :action => 'search'
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
		respond_to do |format|
			format.html
			format.json { render json: @user }
		end
	end

	def show
		@title = "route_records"
		@route_record = RouteRecord.find(params[:id])
		respond_to do |format|
			format.html
			format.json { render json: @route_record }
		end
	end

	def search
		@title = "search result"
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

	def destroy
	end
end
