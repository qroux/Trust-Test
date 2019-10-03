Rails.application.routes.draw do
  root to: 'employments#index'

  resources :employments, only: [:index] do
    collection do
      post 'import'
      delete 'destroy_all'
      patch 'enrichement'
    end
  end
end
