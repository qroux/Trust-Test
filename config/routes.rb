Rails.application.routes.draw do
  root to: 'employments#index'

  resources :employments, only: [:index, :show] do
    collection do
      post 'import'
      delete 'destroy_all'
      patch 'enrich_all'
    end
    member do
      patch 'enrichment'
    end
  end
end
