Rails.application.routes.draw do

  scope "(:locale)" do
    resources :cities
    get '/cities/:id/cities', :to => 'cities#restore', :id => /\d+/, :as => 'restore_city'

    resources :regions
    get '/regions/:id/regions', :to => 'regions#restore', :id => /\d+/, :as => 'restore_region'

    devise_for :users
    resources :users
    get '/users/:id/restore', :to => 'users#restore', :id => /\d+/, :as => 'restore_user'
  end

  root 'users#index'
  get '/:locale' => 'users#index'
end
