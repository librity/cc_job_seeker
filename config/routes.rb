# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :head_hunters, path: 'head_hunter_accounts', controllers: {
    registrations: 'hunter/registrations',
    sessions: 'hunter/sessions'
  }
  devise_for :job_seekers, path: 'job_seeker_accounts', controllers: {
    registrations: 'seeker/registrations',
    sessions: 'seeker/sessions'
  }

  root 'home#index'

  namespace :hunter do
    root 'dashboard#index'
    get '/dashboard', to: 'dashboard#index', as: :dashboard

    resources :jobs, only: %i[index show new create] do
      patch :retire
    end

    resources :applications, only: %i[index show] do
      patch :standout
      get   :rejection
      patch :reject

      resources :offers, only: %i[new create]
    end

    resources :applicants, only: %i[index show] do
      post :comment
    end

    resources :offers, only: %i[index show]
  end

  namespace :seeker do
    root 'dashboard#index'
    get '/dashboard', to: 'dashboard#index', as: :dashboard

    resources :profiles, only: %i[new create]
    get '/profile', to: 'profiles#show', as: :show_profile
    get '/profile/edit', to: 'profiles#edit', as: :edit_profile
    patch '/profile', to: 'profiles#update', as: :update_profile

    resources :jobs, only: %i[index show] do
      resources :applications, only: %i[new create]
    end

    resources :applications, only: %i[index show]
    resources :offers, only: %i[index show] do
      patch :accept
      patch :reject
    end
  end
end
