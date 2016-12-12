# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :users
  resources :roles
  resources :users
  resources :notes
  root to: 'notes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
