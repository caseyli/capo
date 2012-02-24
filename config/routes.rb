Capo::Application.routes.draw do

  get "pages/about"
  get "sessions/new"
  get "main/home"
    
  get "open_mics/attend"
  get "open_mics/unattend"
  get "open_mics/attendee_list"
  get "open_mics/attending_info"
  match "open_mics/add_host" => "open_mics#add_host"
  match "open_mics/remove_host" => "open_mics#remove_host"
  
  get "users/show_me"
  post "users/ajax_update"

  get "sessions/signed_in"
  
  resources :users
  resources :open_mics do
    resources :posts
  end
  resources :sessions,            :only => [:new, :create, :destroy]
  resources :posts
  
  root :to => 'main#home'

  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/signup', :to => 'users#new'
  match '/feedback', :to => 'pages#feedback'
  
  match '/browsers/desktop', :to => 'browsers#desktop'
  match '/browsers/mobile', :to => 'browsers#mobile'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
