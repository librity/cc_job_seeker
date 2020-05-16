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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'home#index'

  namespace :head_hunters do
    get '', to: 'dashboard#index', as: :root
    get '/dashboard', to: 'dashboard#index', as: :dashboard

    resources :jobs, only: :index
  end

  namespace :job_seekers do
    get '', to: 'dashboard#index', as: :root
    get '/dashboard', to: 'dashboard#index', as: :dashboard
  end
end
