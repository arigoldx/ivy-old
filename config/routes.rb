ActionController::Routing::Routes.draw do |map|
  map.resources :grade_logs

  # RESTfulness..
  map.resources :courses do |course|
    course.resources :enrollments
    course.resources :courseplans
    course.resources :coursenotes
    course.resources :lessons
  end

  map.resources :assignment_logs
  map.resources :students
  map.resources :activities
  map.resources :attendance_types
  map.resources :attendances
  map.resources :activity_logs
  map.resources :users
  map.resource  :session
  map.resources :assignments
  map.resources :assignment_logs

  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login  '/login', :controller => 'session', :action => 'new'
  map.logout '/logout', :controller => 'session', :action => 'destroy'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up ''
  # -- just remember to delete public/index.html.
  # map.connect '', :controller => "welcome"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
