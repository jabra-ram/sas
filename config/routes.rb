# frozen_string_literal: true

# rubocop: disable Metrics/BlockLength
Rails.application.routes.draw do
  resources :admins, only: [:index]
  resources :invitations, only: %i[new create]
  resources :sections, except: [:show]
  resources :class_categories, except: [:show]
  resources :fee_structures, except: [:show]
  resources :age_criteria, except: [:show]
  resources :payments, except: [:show]
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
  get '/class_categories/:id/sections', to: 'sections#dropdown_sections'
  get '/student_data/:id', to: 'students#student_data'
  delete '/purge_document/:id', to: 'students#purge_document', as: 'purge_document'
  match '*unmatched', to: 'application#render_not_found', via: :all, constraints: lambda { |req|
    !req.path.match(%r{\A/rails/active_storage/})
  }
end
# rubocop: enable Metrics/BlockLength
