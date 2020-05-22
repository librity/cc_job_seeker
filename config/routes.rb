# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :job_seekers, path: 'job_seeker_accounts', controllers: {
    registrations: 'job_seekers/registrations',
    sessions: 'job_seekers/sessions'
  }
  devise_for :head_hunters, path: 'head_hunter_accounts', controllers: {
    registrations: 'head_hunters/registrations',
    sessions: 'head_hunters/sessions'
  }

  root 'home#index'

  namespace :head_hunters do
    get '', to: 'dashboard#index', as: :root
    get '/dashboard', to: 'dashboard#index', as: :dashboard

    resources :jobs, only: %i[index show new create] do
      resources :applicants, only: %i[show] do
        post 'comment'
      end

      resources :applications, only: %i[show] do
        post 'standout'
        get 'rejection'
        patch 'reject'

        resources :offers, only: %i[new create]
      end
    end
  end

  namespace :job_seekers do
    get '', to: 'dashboard#index', as: :root
    get '/dashboard', to: 'dashboard#index', as: :dashboard

    resources :profiles, only: %i[new create]
    get '/profile', to: 'profiles#show', as: :show_profile
    get '/profile/edit', to: 'profiles#edit', as: :edit_profile
    patch '/profile', to: 'profiles#update', as: :update_profile

    resources :jobs, only: %i[index show] do
      resources :applications, only: %i[new create]
    end

    resources :applications, only: %i[index show]
  end
end
