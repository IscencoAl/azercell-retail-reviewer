Rails.application.routes.draw do

  scope "(:locale)" do
    get '/charts/:id/reports_score', :to => 'charts#reports_score', :id => /\d+/, :as => 'reports_score_chart'

    resources :cities
    get '/cities/:id/restore', :to => 'cities#restore', :id => /\d+/, :as => 'restore_city'
    patch '/cities/:id/restore_info', :to => 'cities#restore_info', :id => /\d+/, :as => 'restore_info_city'

    resources :dealers
    get '/dealers/:id/restore', :to => 'dealers#restore', :id => /\d+/, :as => 'restore_dealer'
    
    resources :regions
    get '/regions/:id/restore', :to => 'regions#restore', :id => /\d+/, :as => 'restore_region'

    get '/reports', to: 'reports#index', as: 'reports'
    get '/reports/:id', to: 'reports#show', :id => /\d+/, as: 'report'

    resources :report_structure_categories
    resources :report_structure_elements
    get '/report_structure', :to => 'report_structure_categories#index', :as => 'report_structure'

    resources :shops
    get '/shops/:id/restore', :to => 'shops#restore', :id => /\d+/, :as => 'restore_shop'
    patch '/shops/:id/restore_info', :to => 'shops#restore_info', :id => /\d+/, :as => 'restore_info_shop'
    get '/shops/:id/info', :to => 'shops#info', :id => /\d+/, :as => 'info_shop'

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
