Rails.application.routes.draw do
  root to: "courses#index"
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :courses
  resource :profile, controller: 'profile', only: [:show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
