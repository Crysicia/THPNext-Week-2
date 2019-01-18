# frozen_string_literal: true

Rails.application.routes.draw do
  require "sidekiq/web"
  if Rails.env.production?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
        ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
    end
  end
  mount Sidekiq::Web, at: "/sidekiq"

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
    get '/backoffice', to: 'back_office#index'
    get '/backoffice/new/:id/', to: 'back_office#new', as: 'backoffice_new'
    post '/backoffice/send/:id/', to: 'back_office#create', as: 'send'
  end
end
