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

  # Protect SideKiq
  constraint = lambda do |request|
                 request.env['warden'].authenticate!({ scope: :admin_user })
               end

  constraints constraint do
    mount Sidekiq::Web, at: '/admin/sidekiq'
  end
  # Accelerator
  resources :teams, only: [:show, :update] do
    resource :tags, only: [:show]
  end
  resources :mentors, only: [:create, :show, :update] do
    resources :tags, only: [:create, :show, :update, :destroy, :index]
  end
  resources :accelerator_applications, only: [:index, :update, :create]
  resources :tags, only: :show

  devise_scope :user do
    get '/courses/me' => 'courses#me'
    get '/teachers/edit' => 'users#edit'

    namespace :ranking do
      resources :courses, only: [:show]
    end
    resource :invites, only: [:new, :create, :edit, :update]
    resources :courses, except: [:new, :create]
    resources :teachers, only: [:edit, :show, :index]
    resources :users, only: [:edit, :show, :update]
    resources :subjects, only: [:index, :show]
    resources :carts, only: [:index, :show, :create, :destroy]
    resources :orders, except: [:edit, :destroy, :show, :update, :index]
    resources :searches, only: [:index, :create]
    resources :certificates, only: [:show, :index, :create]


    post '/teachers/:id/contact' => 'teachers#contact'
    get '/teachers/:id/contact' => 'teachers#contact'
    post '/courses/:id/image_picker' => 'courses#image_picker'

    get '/orders/confirm' => 'orders#confirm'
    get '/orders/ipn' => 'orders#paypal_ipn'
    get '/orders/cancel' => 'orders#confirm'

    post '/carts/:cart/:course', to: 'carts#remove_course_from_cart'

    get '/saml/auth' => 'saml_idp#new'
    post '/saml/auth' => 'saml_idp#create'

    post 'versions/:id/revert' => 'versions#revert', :as => 'revert_version'
  end

  get '/mentors/' => 'mentors#signup'

  mount Paperclip::Storage::Redis::App.new => '/dynamic'
end
