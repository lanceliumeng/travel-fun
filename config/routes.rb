Rails.application.routes.draw do
  resources :orders do
    get :my_clients, on: :collection
  end
  #orders routes
  #  get '/orders', to: 'orders#index', as: 'orders' #=> orders_path
  #  post '/orders', to: 'orders#create'
  #  get '/orders/new', to: 'orders#new', as: 'new_order' #=>new_order_path
  #  get '/orders/:id/edit', to: 'orders#edit', as: 'edit_order' #=>edit_order_path
  #  get '/orders/:id', to: 'orders#show', as: 'order' #=>order_path 
  #  patch '/orders/:id', to: 'orders#update'    
  #  put '/orders/:id', to: 'orders#update  
  #  delete '/orders/:id', to: 'orders#destroy'
    
  #devise gems routes
  devise_for :users

  # trips routes
    # get '/trips', to: 'trips#index', as: 'trips'   #=> trips_path
    # post '/trips', to: 'trips#create'
    # get '/trips/new', to: 'trips#new', as: 'new_trip'  #=> new_trip_path
    # get '/trips/:id/edit', to: 'trips#edit', as: 'edit_trip'  #=> edit_trip_path
    # get '/trips/:id', to: 'trips#show', as: 'trip'  #=> trip_path
    # patch '/trips/:id', to: 'trips#update'  
    # put '/trips/:id', to: 'trips#update'  
    # delete '/trips/:id', to: 'trips#destroy'

  # itineraries routes
  # get '/itineraries/:id', to: 'itineraries#show', as: 'itinerary'   #=> itinerary_path
  # get '/itineraries/new', to: 'itineraries#new', as: 'new_itinerary' #=> new_itinerary_path
  # get '/itineraries/:id/edit', to: 'itineraries#edit', as: 'edit_itinerary' #=> edit_itinerary_path
  
  # Rails provides a special resources notation, it will automatically generate above routes
  # I have commented above simple routes, try to use reouseces notation + nest resources to let ininerary in trip
    resources :trips  do
      get :brought, :pending_review, :designed, :unapproved,  on: :collection  #the route for trips controller brought, pending review and desigend trip action
      member do
        get :analytics 
        patch :approve 
        patch :unapprove
      end
      #  member do for the routes below
      #  GET  '/trips/:id/analytics', to: 'trips#analytics' , as: 'analytics_trip'               
      #  PATCH '/trips/:id/approve', to: 'trips#approve', as: 'approve_trip'
      #  PATCH '/trips/:id/unapprove', to: 'trips#unapprove', as: 'unapprove_trip'

      resources :itineraries
      resources :orders, only: [:new, :create]
    end
    #nested routes also includes:
    # post '/trips/:trip_id/orders', to: 'orders#create', as: 'trip_orders' #=> trip_orders_path
    # get '/trips/:trip_id/orders/new', to: 'orders#new', as: 'new_trip_order' #=> new_trip_order_path

    
  # users routes, this resources includes devise users routes and I set some methods for uses roles routes
  resources :users, only: [:index, :edit, :show, :update]
      # routes for users roles show, edit, update
      # get '/users', to: 'users#index', as: 'users'   #=> users_path
      # get '/users/:id', to: 'users#show', as: 'user'  #=> user_path
      # get '/users/:id/edit', to: 'users#edit', as: 'edit_user'  #=> edit_user_path
      # patch '/users/:id', to: 'users#update'
      # put '/users/:id', to: 'users#update'
  
    

  #home page route
  root 'static_pages#landing_page'
  #privacy policy page route
  get 'privacy_policy', to: 'static_pages#privacy_policy', as: 'privacy_policy'
  #track activities route:
  get 'track_activities', to: 'static_pages#track_activities', as: 'track_activities'
  #analytics routes:
  get 'analytics', to: 'static_pages#analytics', as: 'analytics' #=> this route is for regular chart data load
  namespace :charts do  #use namespace gourp the charts routes to make them more clear
    get 'users_per_day'
    get 'orders_per_day'
  end
  #get 'charts/users_per_day', to: 'charts#users_per_day'  #=> this route is for chart data Eager Loading
  #get 'charts/orders_per_day', to: 'charts#orders_per_day' #=> this route is for chart data Eager Loading
end
