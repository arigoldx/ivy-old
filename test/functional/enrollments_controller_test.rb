require File.dirname(__FILE__) + '/../test_helper'
require 'enrollments_controller'

# Re-raise errors caught by the controller.
class EnrollmentsController; def rescue_action(e) raise e end; end

class EnrollmentsControllerTest < Test::Unit::TestCase
  fixtures :enrollments

  def setup
    @controller = EnrollmentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:enrollments)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_enrollment
    old_count = Enrollment.count
    post :create, :enrollment => { }
    assert_equal old_count+1, Enrollment.count
    
    assert_redirected_to enrollment_path(assigns(:enrollment))
  end

  def test_should_show_enrollment
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_enrollment
    put :update, :id => 1, :enrollment => { }
    assert_redirected_to enrollment_path(assigns(:enrollment))
  end
  
  def test_should_destroy_enrollment
    old_count = Enrollment.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Enrollment.count
    
    assert_redirected_to enrollments_path
  end
end
