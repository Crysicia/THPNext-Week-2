# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#landing_page'
  devise_for :admins
  devise_for :users
  namespace 'administration' do
    get '/', to: 'items#index'
    resources :items
  end
end
