Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'join', to: 'devise/registrations#new'
    get 'forgotten_password', to: 'devise/passwords#new'
  end

  get 'about' => 'about#show'
  get 'tags' => 'tags#index'
  get 'members_area' => 'members_area#show'
  get 'video/:id' => 'videos#show', as: 'video'
  get 'videos' => 'videos#index'
  get 'magazines' => 'magazines#index'

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
    resources :users, except: [:show]
  end
end
