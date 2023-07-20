# frozen_string_literal: true

Rails.application.routes.draw do
  resources :admins, only: [:index]
  resources :invitations, only: %i[new create]
  resources :sections, :class_categories, :fee_structures, :age_criteria, :payments
  resources :students do
    collection do
      get :search
    end
  end

  get '/', to: 'sessions#new'
  get 'login',  to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  post 'login', to: 'sessions#create'
  post '/', to: 'sessions#create'
  get '/payments/download/:id', to: 'payments#generate_invoice', as: 'generate_invoice'
  get '/payments/email/:id', to: 'payments#email_invoice', as: 'email_invoice'

  get '/admins/invite/:token', to: 'admins#invite', as: 'invite_admin'
  post '/admins/invite/:token', to: 'admins#process_invite'
  post '/markread', to: 'admins#mark_read', as: 'mark_read'
  get '/paymentstatus', to: 'students#payment_status', as: 'payment_status'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
