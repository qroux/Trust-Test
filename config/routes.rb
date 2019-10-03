Rails.application.routes.draw do
  root to: 'employments#index'

  resources :employments, only: [:index, :show, :update] do
    collection do
      post 'import'
      patch 'general_update'
    end
  end
end
