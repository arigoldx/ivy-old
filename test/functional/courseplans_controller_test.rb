require File.dirname(__FILE__) + '/../test_helper'
require 'courseplans_controller'

# Re-raise errors caught by the controller.
class CourseplansController; def rescue_action(e) raise e end; end

class CourseplansControllerTest < Test::Unit::TestCase
  fixtures :courseplans

  def setup
    @controller = CourseplansController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:courseplans)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_courseplans
    old_count = Courseplans.count
    post :create, :courseplans => { }
    assert_equal old_count+1, Courseplans.count
    
    assert_redirected_to courseplans_path(assigns(:courseplans))
  end

  def test_should_show_courseplans
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_courseplans
    put :update, :id => 1, :courseplans => { }
    assert_redirected_to courseplans_path(assigns(:courseplans))
  end
  
  def test_should_destroy_courseplans
    old_count = Courseplans.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Courseplans.count
    
    assert_redirected_to courseplans_path
  end
end
