# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :job_seekers
  devise_for :head_hunters
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'home#index'

  namespace :head_hunters do
    get '/dashboard', to: 'dashboard#index', as: :dashboard
  end

  namespace :job_seekers do
    get '/dashboard', to: 'dashboard#index', as: :dashboard
  end
end
