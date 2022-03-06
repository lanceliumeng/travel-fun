Rails.application.routes.draw do
  devise_for :users
  resources :trips

  #home page
  root 'static_pages#landing_page'
  #privacy policy page
  get 'privacy_policy', to: 'static_pages#privacy_policy', as: 'privacy_policy'
end
