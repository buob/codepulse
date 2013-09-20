Codepulse::Application.routes.draw do
  resources :pulses

  get "marketing/index"
  devise_for :users

  root 'pulses#index'
end
