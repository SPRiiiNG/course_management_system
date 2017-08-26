Rails.application.routes.draw do
  root to: "courses#index"
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resource :profile, controller: 'profile', only: [:show, :edit, :update]
  resources :courses do
    collection do
      get    :my_courses
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
