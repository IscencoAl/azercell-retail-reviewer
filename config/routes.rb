Rails.application.routes.draw do

  namespace 'api' do
    get '/mobile_app', :to => 'mobile_app#index', :as => 'mobile_app'

    post '/reports', :to => 'reports#create', :as => 'reports'
    get '/reports/structure', :to => 'reports#structure', :as => 'reports_structure'
    post '/reports/:id/photo', :to => 'reports#photo', :as => 'reports_photo'

    get '/shops', :to => 'shops#index', :as => 'shops'

    get '/settings/versions', :to => 'settings#versions', :as => 'settings_versions'

    post '/users/sign_in', :to => 'users#sign_in', :as => 'sign_in'
  end

  scope '(:locale)' do
    get '/charts/reports_score', :to => 'charts#reports_score', :as => 'reports_score_chart'
    get '/charts/reports_count', :to => 'charts#reports_count', :as => 'reports_count_chart'

    resources :cities do
      member do
        get 'restore'
        patch 'restore_info'
      end
    end

    resources :dealers do
      member do
        get 'restore'
      end
    end

    resources :employees do
      member do
        get 'restore'
      end
    end

    resources :employee_workpositions do
      member do
        get 'restore'
      end
    end

    resources :items

    resources :regions do
      member do
        get 'restore'
      end
    end

    resources :reports, :only => [:index, :show]

    resources :report_structure_categories
    resources :report_structure_elements
    get '/report_structure', :to => 'report_structure_categories#index', :as => 'report_structure'

    get '/settings/:name', :to => 'settings#show'
    put '/settings/:name', :to => 'settings#update'

    resources :shops do
      collection do
        get 'map_info'
      end

      member do
        get 'info'
        get 'restore'
        patch 'restore_info'
      end

      resources :employees do
        member do
          get 'restore'
        end
      end

      resources :shop_items, :only => [:index, :new, :create, :destroy]
    end

    resources :shop_items
   
    resources :shop_photos

    resources :shop_types do
      member do
        get 'restore'
      end
    end

    devise_for :users
    resources :users do
      member do
        get 'restore'
      end
    end
  end

  root 'dashboard#index'
  get '/:locale' => 'dashboard#index'

end
