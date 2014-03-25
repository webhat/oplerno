Oplerno::Application.routes.draw do
  root :to => redirect('/courses')

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, :path_names => {
      :verify_authy => '/verify-token',
      :enable_authy => '/enable-two-factor',
      :verify_authy_installation => '/verify-installation'
  }

  devise_scope :user do
    resources :courses
    resources :teachers
    resources :users, only: [:edit, :show, :update]
		resources :subjects, only: [:index, :show]
    resources :carts
    resources :orders, except: [:edit, :destroy, :show, :update, :index]
		resources :searches, only: [:index, :create]

    get '/orders/confirm', 'orders#confirm'
    get '/orders/ipn', 'orders#paypal_ipn'
    get '/orders/cancel', 'orders#confirm'

    post '/carts/:cart/:course', to: 'carts#remove_course_from_cart'

    get '/saml/auth' => 'saml_idp#new'
    post '/saml/auth' => 'saml_idp#create'
  end

	mount Paperclip::Storage::Redis::App.new => "/dynamic"
end
