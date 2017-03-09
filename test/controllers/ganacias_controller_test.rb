require 'test_helper'

class GanaciasControllerTest < ActionController::TestCase
  test "should get mes" do
    get :mes
    assert_response :success
  end

  test "should get semana" do
    get :semana
    assert_response :success
  end

  test "should get ano" do
    get :ano
    assert_response :success
  end

end
