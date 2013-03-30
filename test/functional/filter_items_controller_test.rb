require 'test_helper'

class FilterItemsControllerTest < ActionController::TestCase
  setup do
    @filter_item = filter_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:filter_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create filter_item" do
    assert_difference('FilterItem.count') do
      post :create, filter_item: { driver_id: @filter_item.driver_id, result_id: @filter_item.result_id }
    end

    assert_redirected_to filter_item_path(assigns(:filter_item))
  end

  test "should show filter_item" do
    get :show, id: @filter_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @filter_item
    assert_response :success
  end

  test "should update filter_item" do
    put :update, id: @filter_item, filter_item: { driver_id: @filter_item.driver_id, result_id: @filter_item.result_id }
    assert_redirected_to filter_item_path(assigns(:filter_item))
  end

  test "should destroy filter_item" do
    assert_difference('FilterItem.count', -1) do
      delete :destroy, id: @filter_item
    end

    assert_redirected_to filter_items_path
  end
end
