Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'join', to: 'devise/registrations#new'
    get 'forgotten_password', to: 'devise/passwords#new'
  end

  get 'members_area' => "members_area#show"
end
