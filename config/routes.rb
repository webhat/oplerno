require 'sidekiq/web'

Oplerno::Application.routes.draw do
  root :to => 'courses#index'
  #root :to => proc { [404, {}, ['']] }

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, :path_names => {
    :verify_authy => '/verify-token',
    :enable_authy => '/enable-two-factor',
    :verify_authy_installation => '/verify-installation'
  }

  devise_scope :admin_users do
    match 'admin/mailer(/:mailer(/:method(.:format)))' => 'mailpreview#show'
  end


  devise_scope :user do
    get '/courses/me' => 'courses#me'
    get '/teachers/edit' => 'users#edit'

    namespace :ranking do
      resources :courses, only: [:show]
    end
    resource :invites, only: [:new, :create, :edit, :update]
    resources :courses, except: [:new]
    resources :teachers, only: [:edit, :show, :index]
    resources :users, only: [:edit, :show, :update]
    resources :subjects, only: [:index, :show]
    resources :carts, only: [:index, :show, :create, :destroy]
    resources :orders, except: [:edit, :destroy, :show, :update, :index]
    resources :searches, only: [:index, :create]
    resources :certificates, only: [:show, :index, :create]
    resource :payments, only: [:new]

    post '/teachers/:id/contact' => 'teachers#contact'
    get '/teachers/:id/contact' => 'teachers#contact'
    post '/courses/:id/image_picker' => 'courses#image_picker'

    match '/orders/:id/confirm' => 'orders#confirm'
    match '/orders/:id/ipn' => 'orders#paypal_ipn'
    match '/orders/:id/cancel' => 'orders#confirm'

    post '/carts/:cart/:course', to: 'carts#remove_course_from_cart'

    get '/saml/auth' => 'saml_idp#new'
    post '/saml/auth' => 'saml_idp#create'

    post 'versions/:id/revert' => 'versions#revert', :as => 'revert_version'
  end

  mount Paperclip::Storage::Redis::App.new => '/dynamic'
  mount Sidekiq::Web, at: '/admin/sidekiq' if Rails.env.development? 
end
