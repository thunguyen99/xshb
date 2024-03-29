ActionController::Routing::Routes.draw do |map|
  map.logout    '/logout', :controller => 'sessions', :action => 'destroy'
  map.login     '/login', :controller => 'sessions', :action => 'new'
  map.register  '/register', :controller => 'users', :action => 'create'
  map.signup    '/signup', :controller => 'users', :action => 'new'
  map.check_un  '/users/check_un', :controller => "users", :action => "check_un"
  map.check_email '/users/check_email', :controller => "users", :action => "check_email"
  map.subscription  '/subscription', :controller => "products", :action => "index"
  map.teaser    '/home/teaser/:id.:format', :controller => "home", :action => "teaser"
  map.forgot_password'/forgot_password', :controller => 'users', :action => 'forgot_password'
  map.forgot '/forgot', :controller => 'users', :action => 'forgot'
  map.reset_password  '/reset_password/:password_reset_code', :controller => 'users', :action => 'reset_password'
  map.reset  '/reset', :controller => 'users', :action => 'reset', :method => :put
  map.search  '/search', :controller => 'search', :action => 'index'

  map.resources :users,:member => {:edit_role => :get,:update_role => :put}

  map.resource :session

  map.resources :xsvips

  map.resources :products

  map.resources :categories

  map.resources :articles

  map.resources :panel_categories

  map.resources :panel_contents,:member => {:croper => :get,:crop => :put}

  map.resources :order_line_items,:member => {:update_quantity => :post}
  
  map.resources :albums,:member => {:assets_new => :get,:assets_create => :put,:assets_batch=>:put}
  
  map.resources :assets,:member => {:to_primary => :put}

  map.resources :orders,:member => {:mark => :get},
                        :collection => {:notify => :get,:done => :get,:show_order => :get}

  map.resources :my, :collection => {:orders => :get},
                     :member => {:order_show => :get}

  map.resources :search

  map.ws_teaser '/webservice/teaser_album/:id.:format', :controller => "webservice", :action => "teaser_album"

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"
  map.root :controller => 'home', :action => 'index'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end
