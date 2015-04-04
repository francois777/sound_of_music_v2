Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'registrations', :confirmations => 'confirmations' },
                     except: [:index, :destroy]

  resources :users, only: :show 

  resources :instruments do
    member do
      post :submit
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

  root to: 'static_pages#home'
  match '/home',  to: 'static_pages#home',  via: 'get'

end
