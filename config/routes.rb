Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'preferences', to: 'pages#preferences'
  get 'preferences/results', to: 'pages#results'
  get 'about', to: 'pages#about'
  get 'style-guide', to: 'pages#style_guide'
end
