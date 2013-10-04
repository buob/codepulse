Codepulse::Application.routes.draw do
  resources :pulses

  get "marketing/index"
  devise_for :users

  authenticated :user do
    root to: 'pulses#index', as: :authenticated_root
  end

  unauthenticated do
    root to: 'marketing#index'
  end
end
