require 'test_helper'

class FileMAnageControllerTest < ActionController::TestCase
  test "should get getFileContent" do
    get :getFileContent
    assert_response :success
  end

end
