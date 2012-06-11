SetupMeetup::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: "landing#index"
  resources :events, only: [:index, :show, :new, :edit, :create, :update] do
    member { put :join }
  end
  resource :profile, as: 'user_profile', only: [:show, :edit, :update], controller: :profile
  namespace :users do 
    resources :authorizations, only: [:destroy]
  end
end
