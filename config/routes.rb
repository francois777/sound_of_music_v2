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

  root to: 'instruments#index'
  match '/home',  to: 'static_pages#home',  via: 'get'

end
