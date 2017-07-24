require 'test_helper'

class DiseasesControllerTest < ActionController::TestCase
  include SessionsHelper

  def setup
    log_in users(:mashuo)
  end


  # test "should get index" do
  #   get :index
  #   assert_response :success
  # end

end
