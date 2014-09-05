Rails.application.routes.draw do

  scope "(:locale)" do
    resources :cities
    resources :events
    resources :players
    resources :regions

    devise_for :users
    resources :users
    get '/users/:id/restore', :to => 'users#restore', :id => /\d+/, :as => 'restore_user'
  end

  root 'users#index'
  get '/:locale' => 'users#index'
end
