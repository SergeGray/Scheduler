Rails.application.routes.draw do
  resources :schedules do
    resources :time_slots, only: %i[create update destroy], shallow: true
  end

  root to: 'schedules#index'
end
