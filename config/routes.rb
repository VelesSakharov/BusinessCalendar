# frozen_string_literal: true
Rails.application.routes.draw do
  telegram_webhooks TelegramWebhooksController
  devise_for :users, :path_prefix => 'my'

  resources :roles
  resources :users
  resources :notes do
    collection do
      get :all_notes
      get :get_user_notes
    end
  end
  root to: 'notes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
