Rails.application.routes.draw do
  resources :schedules do
    resources :time_slots, only: %i[create update destroy], shallow: true
  end

  resources :appointments, only: %i[create update destroy show]

  root to: 'schedules#index'
end
