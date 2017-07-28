# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  devise_for :users, controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks',
      registrations: 'users/registrations'
  }
  root 'home#index'

  resource :registration_flow, controller: :registration_flow, only: %i[new create]

  resources :org, controller: :organizations do
    resources :sites do
      resources :historical_checks, only: %i[index show]
    end
  end

  get '/invites/accept_invite', to: 'invites#accept_invite', as: 'accept_invite'
  get '/invites/:org_id', to: 'invites#index', as: 'invites'
  post '/invites/:org_id', to: 'invites#create'

  mount Sidekiq::Web => '/async-web'
end
