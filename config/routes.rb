Rails.application.routes.draw do
  resources :products
  #home page
  root 'static_pages#landing_page'

  #privacy policy page
  get 'privacy_policy', to: 'static_pages#privacy_policy', as: 'privacy_policy'
end
