Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'registrations', :confirmations => 'confirmations' },
                     except: [:index, :destroy]

  post "versions/:id/revert" => "versions#revert", :as => "revert_version"
  
  resources :users, only: :show 

  get 'instruments(/:id)/update_subcategories', to: 'instruments#update_subcategories', as: 'update_subcategories'

  resources :approvals, only: [:submit, :approve] do
    member do
      post :submit
      post :approve
    end
  end

  resources :artists do
    resources :articles
  end

  resources :instruments do
    resources :articles
  end

  resources :articles do
    resources :photos
  end

  resources :historical_periods
  resources :contribution_types

  namespace :admin do
    root :to => "base#index"
    resources :users, only: [:index, :destroy]

    resources :artists, only: :approve

    resources :photos do
      member do
        get :review
        post :review
      end
    end
  end  

  root to: 'static_pages#home'
  match '/home',  to: 'static_pages#home',  via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'

end
