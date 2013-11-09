require File.dirname(__FILE__) + '/../test_helper'
require 'assignments_controller'

# Re-raise errors caught by the controller.
class AssignmentsController; def rescue_action(e) raise e end; end

class AssignmentsControllerTest < Test::Unit::TestCase
  fixtures :assignments

  def setup
    @controller = AssignmentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:assignments)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_assignment
    old_count = Assignment.count
    post :create, :assignment => { }
    assert_equal old_count+1, Assignment.count
    
    assert_redirected_to assignment_path(assigns(:assignment))
  end

  def test_should_show_assignment
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_assignment
    put :update, :id => 1, :assignment => { }
    assert_redirected_to assignment_path(assigns(:assignment))
  end
  
  def test_should_destroy_assignment
    old_count = Assignment.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Assignment.count
    
    assert_redirected_to assignments_path
  end
end
