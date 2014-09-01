Rails.application.routes.draw do

  scope "/:locale" do
    resources :events
    resources :players
    resources :users
    get '/events/:id/add_player' => 'events#add_player'
    delete '/events/:id/remove_player' => 'events#remove_player'
  end

  devise_for :users

  root 'users#index'

  get '/:locale' => 'users#index'

end
