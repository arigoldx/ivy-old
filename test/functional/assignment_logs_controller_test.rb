require File.dirname(__FILE__) + '/../test_helper'
require 'assignment_logs_controller'

# Re-raise errors caught by the controller.
class AssignmentLogsController; def rescue_action(e) raise e end; end

class AssignmentLogsControllerTest < Test::Unit::TestCase
  fixtures :assignment_logs

  def setup
    @controller = AssignmentLogsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:assignment_logs)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_assignment_log
    old_count = AssignmentLog.count
    post :create, :assignment_log => { }
    assert_equal old_count+1, AssignmentLog.count
    
    assert_redirected_to assignment_log_path(assigns(:assignment_log))
  end

  def test_should_show_assignment_log
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_assignment_log
    put :update, :id => 1, :assignment_log => { }
    assert_redirected_to assignment_log_path(assigns(:assignment_log))
  end
  
  def test_should_destroy_assignment_log
    old_count = AssignmentLog.count
    delete :destroy, :id => 1
    assert_equal old_count-1, AssignmentLog.count
    
    assert_redirected_to assignment_logs_path
  end
end
