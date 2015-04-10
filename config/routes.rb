Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'registrations', :confirmations => 'confirmations' },
                     except: [:index, :destroy]

  resources :users, only: :show 

  get 'instruments(/:id)/update_subcategories', to: 'instruments#update_subcategories', as: 'update_subcategories'

  resources :instruments do
    member do
      post :submit
    end
    resources :articles do 
      member do
        post :submit
      end
    end
  end

  namespace :admin do
    root :to => "base#index"
    resources :users, only: [:index, :destroy]
    resources :articles, except: :submit do
      member do
        post :approve
      end
    end
    resources :instruments, only: :destroy do
      member do
        post :approve
      end
    end
  end  

  root to: 'instruments#index'
  match '/home',  to: 'static_pages#home',  via: 'get'

end
