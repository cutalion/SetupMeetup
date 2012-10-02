SetupMeetup::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: "landing#index"
  resources :events, only: [:index, :show, :new, :edit, :create, :update] do
    member { put :join }
    resources :comments, shallow: true, only: [ :create, :destroy ]
  end

end
