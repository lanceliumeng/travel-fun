Rails.application.routes.draw do
  #devise gems routes
  devise_for :users

  # trips routes
  resources :trips  #Rails provides a special resources notation, This line will automatically generate below routes
    # get '/trips', to: 'trips#index', as: 'trips'
    # post '/trips', to: 'trips#create'
    # get '/trips/new', to: 'trips#new', as: 'new_trip'
    # get '/trips/:id/edit', to: 'trips#edit', as: 'edit_trip'
    # get '/trips/:id', to: 'trips#show', as: 'trip'
    # patch '/trips/:id', to: 'trips#update'  
    # put '/trips/:id', to: 'trips#update'  
    # delete '/trips/:id', to: 'trips#destroy'
    
  # users routes 
  resources :users, only: :index

  #home page route
  root 'static_pages#landing_page'
  #privacy policy page route
  get 'privacy_policy', to: 'static_pages#privacy_policy', as: 'privacy_policy'
  #track activities routes:
  get 'track_activities', to: 'static_pages#track_activities', as: 'track_activities'
  
end
