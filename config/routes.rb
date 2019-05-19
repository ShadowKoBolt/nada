Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'join', to: 'registrations#new'
    get 'forgotten_password', to: 'devise/passwords#new'
    get 'my_account', to: 'registrations#edit'
  end

  get 'alba-orientale' => 'application#alba'

  get 'about' => 'about#show'
  get 'tags' => 'tags#index'
  get 'members_area' => 'members_area#show'
  get 'video/:id' => 'videos#show', as: 'video'
  get 'videos' => 'videos#index'
  get 'magazines' => 'magazines#index'
  get 'classes' => 'classes#index'
  get 'classes/markers' => 'classes#markers'
  post 'classes/markers' => 'classes#markers'
  get 'class/:id' => 'classes#show', as: 'class'
  get 'events' => 'events#index'
  get 'event/:id' => 'events#show', as: 'event'
  resources :dance_classes, except: [:show]

  get 'subscription/one_off' => 'subscriptions#one_off', as: 'one_off_subscription'
  get 'subscription/new' => 'subscriptions#new', as: 'new_subscription'

  get 'subscription/confirm' => 'subscriptions#show_confirm', as: 'show_confirmation_subscription'
  post 'subscription/confirm' => 'subscriptions#show_confirm'

  post 'subscription/create' => 'subscriptions#create', as: 'create_subscription'

  post 'subscription/one_off/add_promo' => 'subscriptions#find_promo', as: 'find_promo'

  namespace :admin do
    resources :videos, except: [:show] do
      collection do
        post :reorder
      end
    end
    resources :magazines, except: [:show] do
      collection do
        post :reorder
      end
    end
    resources :team_members, except: [:show] do
      collection do
        post :reorder
      end
    end
    resources :teams, except: [:show] do
      collection do
        post :reorder
      end
    end
    resources :discounts, except: [:show]
    resources :users, except: [:show] do
      resources :dance_classes, except: [:show]
      collection do
        get :download
      end
      member do
        post :renew_success
      end
    end
    resources :events, except: [:show] do
      collection do
        post :reorder
      end
      member do
        post :feature
      end
    end
    resource :setting, only: [:edit, :update]
  end
end
