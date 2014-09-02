Rails.application.routes.draw do

  scope "(:locale)" do
    resources :cities
    resources :events
    resources :players
    resources :regions
    devise_for :users
    resources :users
  end

  root 'users#index'
  get '/:locale' => 'users#index'
end
