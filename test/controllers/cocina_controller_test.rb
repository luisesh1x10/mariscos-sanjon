require 'test_helper'

class CocinaControllerTest < ActionController::TestCase
  test "should get barra_fria" do
    get :barra_fria
    assert_response :success
  end

  test "should get barra_caliente" do
    get :barra_caliente
    assert_response :success
  end

end
