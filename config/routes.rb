Rails.application.routes.draw do


  scope "/:locale" do
    resources :events
    resources :players
    resources :regions
    resources :cities
    resources :users
  end

  devise_for :users

  root 'users#index'

  get '/:locale' => 'users#index'

end
