require 'test_helper'

class DriverRecordsControllerTest < ActionController::TestCase
  setup do
    @driver_record = driver_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:driver_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create driver_record" do
    assert_difference('DriverRecord.count') do
      post :create, driver_record: { description: @driver_record.description, end: @driver_record.end, image_url: @driver_record.image_url, name: @driver_record.name, price: @driver_record.price, seats: @driver_record.seats, start: @driver_record.start }
    end

    assert_redirected_to driver_record_path(assigns(:driver_record))
  end

  test "should show driver_record" do
    get :show, id: @driver_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @driver_record
    assert_response :success
  end

  test "should update driver_record" do
    put :update, id: @driver_record, driver_record: { description: @driver_record.description, end: @driver_record.end, image_url: @driver_record.image_url, name: @driver_record.name, price: @driver_record.price, seats: @driver_record.seats, start: @driver_record.start }
    assert_redirected_to driver_record_path(assigns(:driver_record))
  end

  test "should destroy driver_record" do
    assert_difference('DriverRecord.count', -1) do
      delete :destroy, id: @driver_record
    end

    assert_redirected_to driver_records_path
  end
end
