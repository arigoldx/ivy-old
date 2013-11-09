require File.dirname(__FILE__) + '/../test_helper'
require 'chronicles_controller'

# Re-raise errors caught by the controller.
class ChroniclesController; def rescue_action(e) raise e end; end

class ChroniclesControllerTest < Test::Unit::TestCase
  fixtures :chronicles

  def setup
    @controller = ChroniclesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:chronicles)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_chronicle
    old_count = Chronicle.count
    post :create, :chronicle => { }
    assert_equal old_count+1, Chronicle.count
    
    assert_redirected_to chronicle_path(assigns(:chronicle))
  end

  def test_should_show_chronicle
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_chronicle
    put :update, :id => 1, :chronicle => { }
    assert_redirected_to chronicle_path(assigns(:chronicle))
  end
  
  def test_should_destroy_chronicle
    old_count = Chronicle.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Chronicle.count
    
    assert_redirected_to chronicles_path
  end
end
