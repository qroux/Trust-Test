Rails.application.routes.draw do
  get 'employments/index'
  root to: 'employments#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
