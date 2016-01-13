Rails.application.routes.draw do
  resources :things

  root to: "home#index"
end
