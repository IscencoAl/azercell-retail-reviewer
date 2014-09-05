Rails.application.routes.draw do

  scope "(:locale)" do
    resources :cities
    resources :events
    resources :players
    resources :regions

    devise_for :users
    resources :users
    get '/users/:id/restore', :to => 'users#restore', :id => /\d+/, :as => 'restore_user'
    get '/cities/:id/cities', :to => 'cities#restore', :id => /\d+/, :as => 'restore_city'
    get '/regions/:id/regions', :to => 'regions#restore', :id => /\d+/, :as => 'restore_region'
  end

  root 'users#index'
  get '/:locale' => 'users#index'
end
