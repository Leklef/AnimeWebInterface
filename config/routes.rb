Rails.application.routes.draw do
  resources :anime, only: [:index]
end
