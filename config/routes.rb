Oplerno::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, :path_names => {
      :verify_authy => "/verify-token",
      :enable_authy => "/enable-two-factor",
      :verify_authy_installation => "/verify-installation"
  }

  devise_scope :user do
    resources :courses #, except: [:edit, :destroy, :show, :update]
    resources :students
    resources :teachers
  end

  get '/saml/auth' => 'saml_idp#new'
  post '/saml/auth' => 'saml_idp#create'

  root :to => redirect("/courses")
end
