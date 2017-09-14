Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'join', to: 'devise/registrations#new'
    get 'forgotten_password', to: 'devise/passwords#new'
    get 'my_account', to: 'registrations#edit'
  end

  get 'about' => 'about#show'
  get 'tags' => 'tags#index'
  get 'members_area' => 'members_area#show'
  get 'video/:id' => 'videos#show', as: 'video'
  get 'videos' => 'videos#index'
  get 'magazines' => 'magazines#index'
  get 'classes' => 'classes#index'
  get 'classes/markers' => 'classes#markers'
  post 'classes/markers' => 'classes#markers'
  get 'class/:id' => 'classes#show'

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
    resources :users, except: [:show] do
      resources :dance_classes, except: [:show]
    end
  end
end
