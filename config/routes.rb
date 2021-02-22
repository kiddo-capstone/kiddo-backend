Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, except: :update
      resources :tasks
      resources :missions
      get 'missions/:id/tasks', to: 'mission_tasks#index'
    end
  end
end
