# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  get '/auth/:provider/callback', to: 'sessions#create'

  resource :registration_flow, controller: :registration_flow, only: [:new, :create]
end
