Rails.application.routes.draw do
  root to: 'application#index'

  resources :urls do 
    post :api_create, on: :collection
  end

  get ':code', to: "urls#redirect"
end
