class FilterItemsController < ApplicationController
  # GET /filter_items
  # GET /filter_items.json
  def index
    @filter_items = FilterItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @filter_items }
    end
  end

  # GET /filter_items/1
  # GET /filter_items/1.json
  def show
    @filter_item = FilterItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @filter_item }
    end
  end

  # GET /filter_items/new
  # GET /filter_items/new.json
  def new
    @filter_item = FilterItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @filter_item }
    end
  end

  # GET /filter_items/1/edit
  def edit
    @filter_item = FilterItem.find(params[:id])
  end

  # POST /filter_items
  # POST /filter_items.json
  def create
    @result = current_result
    driver_record = DriverRecord.find(params[:driver_id])
    @filter_item = @result.filter_items.build(:driver_record => driver_record)

    respond_to do |format|
      if @filter_item.save

      end
    end
  end

  # PUT /filter_items/1
  # PUT /filter_items/1.json
  def update
    @filter_item = FilterItem.find(params[:id])

    respond_to do |format|
      if @filter_item.update_attributes(params[:filter_item])
        format.html { redirect_to @filter_item, notice: 'Filter item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @filter_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filter_items/1
  # DELETE /filter_items/1.json
  def destroy
    @filter_item = FilterItem.find(params[:id])
    @filter_item.destroy

    respond_to do |format|
      format.html { redirect_to filter_items_url }
      format.json { head :no_content }
    end
  end

end
