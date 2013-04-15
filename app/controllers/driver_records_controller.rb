class DriverRecordsController < ApplicationController
  # GET /driver_records
  # GET /driver_records.json
  def index
    @title = "Home"
    @driver_records = DriverRecord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @driver_records }
    end
  end

  # GET /driver_records/1
  # GET /driver_records/1.json
  def show
    @driver_record = DriverRecord.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @driver_record }
    end
  end

  # GET /driver_records/new
  # GET /driver_records/new.json
  def new
    @driver_record = DriverRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @driver_record }
    end
  end

  # GET /driver_records/1/edit
  def edit
    @driver_record = DriverRecord.find(params[:id])
  end

  # POST /driver_records
  # POST /driver_records.json
  def create
    @driver_record = DriverRecord.new(params[:driver_record])
    respond_to do |format|
      if @driver_record.save
        format.html { redirect_to @driver_record, notice: 'Driver record was successfully created.' }
        format.json { render json: @driver_record, status: :created, location: @driver_record }
      else
        format.html { render action: "new" }
        format.json { render json: @driver_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /driver_records/1
  # PUT /driver_records/1.json
  def update
    @driver_record = DriverRecord.find(params[:id])

    respond_to do |format|
      if @driver_record.update_attributes(params[:driver_record])
        format.html { redirect_to @driver_record, notice: 'Driver record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @driver_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /driver_records/1
  # DELETE /driver_records/1.json
  def destroy
    @driver_record = DriverRecord.find(params[:id])
    @driver_record.destroy

    respond_to do |format|
      format.html { redirect_to driver_records_url }
      format.json { head :no_content }
    end
  end
end
