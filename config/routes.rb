Rails.application.routes.draw do
  resources :schedules do
    resources :time_slots, only: :create
  end

  root to: 'schedules#index'
end
