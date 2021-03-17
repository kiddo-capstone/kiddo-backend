Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, except: :update
      resources :tasks
      resources :missions
      resources :mission_tasks
      resources :parents

      get 'users/:id/stats', to: 'users#stats'
      get 'missions/:id/tasks', to: 'mission_tasks#index'
    end
  end
end
