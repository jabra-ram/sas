Rails.application.routes.draw do
  resources :admins, only:[:index]
  resources :invitations, only:[:new, :create]
  resources :sections, :class_categories, :fee_structures,:age_criteria

  get '/', to:"sessions#new"
  get 'login',  to:"sessions#new", as: "login"
  get 'logout', to:"sessions#destroy", as: "logout"
  post 'login', to:"sessions#create"
  post '/', to:"sessions#create"

  get '/admins/invite/:token', to: "admins#invite", as: "invite_admin"
  post '/admins/invite/:token', to: "admins#process_invite"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
