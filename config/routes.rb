Rails.application.routes.draw do
  resources :schedules

  root to: 'schedules#index'
end
