require 'test_helper'

class RequetsControllerTest < ActionController::TestCase
  setup do
    @requet = requets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:requets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create requet" do
    assert_difference('Requet.count') do
      post :create, requet: { anotaciones: @requet.anotaciones, status: @requet.status, sucursal_id: @requet.sucursal_id }
    end

    assert_redirected_to requet_path(assigns(:requet))
  end

  test "should show requet" do
    get :show, id: @requet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @requet
    assert_response :success
  end

  test "should update requet" do
    patch :update, id: @requet, requet: { anotaciones: @requet.anotaciones, status: @requet.status, sucursal_id: @requet.sucursal_id }
    assert_redirected_to requet_path(assigns(:requet))
  end

  test "should destroy requet" do
    assert_difference('Requet.count', -1) do
      delete :destroy, id: @requet
    end

    assert_redirected_to requets_path
  end
end
