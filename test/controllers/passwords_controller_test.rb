require 'test_helper'

class PasswordsControllerTest < ActionController::TestCase
  test "should get verificar" do
    get :verificar
    assert_response :success
  end

end
