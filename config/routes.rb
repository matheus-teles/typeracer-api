Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'lerolero', to: 'lero_lero#index'

  resources :leaderboards
end
