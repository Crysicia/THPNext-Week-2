# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#landing_page'
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations',
    confirmations: 'admins/confirmations'
  }

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  namespace 'administration' do
    get '/', to: 'items#index'
    resources :items
  end
end
