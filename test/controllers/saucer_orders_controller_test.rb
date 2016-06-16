require 'test_helper'

class SaucerOrdersControllerTest < ActionController::TestCase
  setup do
    @saucer_order = saucer_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:saucer_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create saucer_order" do
    assert_difference('SaucerOrder.count') do
      post :create, saucer_order: {  }
    end

    assert_redirected_to saucer_order_path(assigns(:saucer_order))
  end

  test "should show saucer_order" do
    get :show, id: @saucer_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @saucer_order
    assert_response :success
  end

  test "should update saucer_order" do
    patch :update, id: @saucer_order, saucer_order: {  }
    assert_redirected_to saucer_order_path(assigns(:saucer_order))
  end

  test "should destroy saucer_order" do
    assert_difference('SaucerOrder.count', -1) do
      delete :destroy, id: @saucer_order
    end

    assert_redirected_to saucer_orders_path
  end
end
