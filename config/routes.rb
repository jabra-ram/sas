Rails.application.routes.draw do
  resources :admins, only:[:index]
  resources :invitations, only:[:new, :create]
  resources :sections, :class_categories, :fee_structures,:age_criteria, :students, :payments

  get '/', to:"sessions#new"
  get 'login',  to:"sessions#new", as: "login"
  get 'logout', to:"sessions#destroy", as: "logout"
  post 'login', to:"sessions#create"
  post '/', to:"sessions#create"
  get '/payments/download/:id', to:"payments#generate_invoice", as:"generate_invoice"
  get '/payments/email/:id', to:"payments#email_invoice", as:"email_invoice"

  get '/admins/invite/:token', to: "admins#invite", as: "invite_admin"
  post '/admins/invite/:token', to: "admins#process_invite"
  get '/markread', to: "admins#mark_read", as:"mark_read"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
