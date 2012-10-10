SetupMeetup::Application.routes.draw do

  root to: "landing#index"

  # authentication
  post '/login'   => 'persona#login'
  post '/logout'  => 'persona#logout'

  resources :events, only: [:index, :show, :new, :edit, :create, :update] do
    member { put :join }
    resources :comments, shallow: true, only: [ :create, :destroy ]
  end

end
