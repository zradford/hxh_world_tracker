Rails.application.routes.draw do
  resources :notes
  devise_for :users
  resources :abilities 
  resources :characters
  get 'leveling_up', controller: 'characters'
  patch 'level_up', controller: 'characters'
  
  root "characters#index"
end
