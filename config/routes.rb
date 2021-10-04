Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'name_guesser', to: 'name_and_countries#guess', as: 'guess'
  get 'calculator', to: 'calculator#calculate', as: 'calculator'
  resources :archives, only: :index
end
