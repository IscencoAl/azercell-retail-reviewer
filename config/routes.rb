Rails.application.routes.draw do

  scope "(:locale)" do
    resources :cities
    get '/cities/:id/cities', :to => 'cities#restore', :id => /\d+/, :as => 'restore_city'

    resources :dealers
    get '/dealers/:id/dealers', :to => 'dealers#restore', :id => /\d+/, :as => 'restore_dealer'
    
    resources :regions
    get '/regions/:id/regions', :to => 'regions#restore', :id => /\d+/, :as => 'restore_region'

    resources :report_structure_categories
    resources :report_structure_elements
    get '/report_structure', :to => 'report_structure_categories#index', :as => 'report_structure'

    resources :shops
    get '/shops/:id/restore', :to => 'shops#restore', :id => /\d+/, :as => 'restore_shop'

    resources :shop_photos
    resources :shop_types
    get '/shop_types/:id/restore', :to => 'shop_types#restore', :id => /\d+/, :as => 'restore_shop_type'

    devise_for :users
    resources :users
    get '/users/:id/restore', :to => 'users#restore', :id => /\d+/, :as => 'restore_user'
  end

  root 'users#index'
  get '/:locale' => 'users#index'
end
