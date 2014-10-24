Rails.application.routes.draw do

  scope "(:locale)" do
    get '/charts/reports_score', :to => 'charts#reports_score', :as => 'reports_score_chart'
    get '/charts/reports_count', :to => 'charts#reports_count', :as => 'reports_count_chart'

    get '/cities/:id/restore', :to => 'cities#restore', :id => /\d+/, :as => 'restore_city'
    patch '/cities/:id/restore_info', :to => 'cities#restore_info', :id => /\d+/, :as => 'restore_info_city'
    resources :cities

    get '/dealers/:id/restore', :to => 'dealers#restore', :id => /\d+/, :as => 'restore_dealer'
    resources :dealers

    get '/employees/:id/restore', :to => 'employees#restore', :id => /\d+/, :as => 'restore_employee'
    resources :employees

    get '/employee_workpositions/:id/restore', :to => 'employee_workpositions#restore', :id => /\d+/, :as => 'restore_employee_workposition'
    resources :employee_workpositions

    get '/items/:id/restore', :to => 'items#restore', :id => /\d+/, :as => 'restore_item'
    resources :items

    get '/regions/:id/restore', :to => 'regions#restore', :id => /\d+/, :as => 'restore_region'
    resources :regions
    
    get '/reports', to: 'reports#index', as: 'reports'
    get '/reports/:id', to: 'reports#show', :id => /\d+/, as: 'report'

    resources :report_structure_categories
    resources :report_structure_elements
    get '/report_structure', :to => 'report_structure_categories#index', :as => 'report_structure'

    get '/shops/map_info', :to => 'shops#map_info', :as => 'shop_map_info'
    get '/shops/:id/restore', :to => 'shops#restore', :id => /\d+/, :as => 'restore_shop'
    patch '/shops/:id/restore_info', :to => 'shops#restore_info', :id => /\d+/, :as => 'restore_info_shop'
    get '/shops/:id/info', :to => 'shops#info', :id => /\d+/, :as => 'info_shop'
    get '/shops/:id/items', :to => 'shops#items', :id => /\d+/, :as => 'items_from_shop'
    get '/shops/:id/items/new', :to =>'shops#new_item', :id => /\d+/, :as => 'new_item_for_shop'
    post '/shops/:id/items/create', :to => 'shops#create_item', :id => /\d+/, :as => 'create_item_for_shop'
    delete '/shops/items/:item_id', :to => 'shops#destroy_item', :item_id => /\d+/, :as => 'destroy_item_from_shop'
    get '/shops/:id/employees', :to => 'shops#employees', :id => /\d+/, :as => 'employees_from_shop'
    get '/shops/:id/employees/new', :to => 'shops#new_employee', :id => /\d+/, :as => 'new_employee_for_shop'
    post '/shops/:id/employees/create', :to => 'shops#create_employee', :id => /\d+/, :as => 'create_employee_for_shop'
    get '/shops/employees/:employee_id/edit', :to => 'shops#edit_employee', :employee_id => /\d+/, :as => 'edit_employee_for_shop'
    put '/shops/employees/:employee_id', :to => 'shops#update_employee', :employee_id => /\d+/, :as => 'update_employee_for_shop'
    delete '/shops/employees/:employee_id', :to => 'shops#destroy_employee', :employee_id => /\d+/, :as => 'destroy_employee_from_shop'
    resources :shops
    resources :shop_items
   
    resources :shop_photos
    
    get '/shop_types/:id/restore', :to => 'shop_types#restore', :id => /\d+/, :as => 'restore_shop_type'
    resources :shop_types

    devise_for :users
    resources :users
    get '/users/:id/restore', :to => 'users#restore', :id => /\d+/, :as => 'restore_user'
  end

  root 'dashboard#index'
  get '/:locale' => 'dashboard#index'

end
