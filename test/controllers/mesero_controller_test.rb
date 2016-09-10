require 'test_helper'

class MeseroControllerTest < ActionController::TestCase
  test "should get pedido" do
    get :pedido
    assert_response :success
  end

end
