Rails.application.routes.draw do

  root 'election#index'

  resources :elections

end
