SetupMeetup::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: "landing#index"

  resources :events do
    member { put :join }
  end
end
