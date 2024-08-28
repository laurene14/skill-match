Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  resources :users, only: %i[index show]

  resources :likes, only: %i[index create destroy]
  resources :bookmarks, only: %i[create destroy]
  resources :categories, only: %i[index]
  resources :matchs, only: %i[index show] do
    resources :messages, only: :create
  end
  resources :notifications, only: %i[index]

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :user_profile do
    get 'profile/show'
    resources :user_descriptions, only: %i[new create edit update]
    resources :user_skill_categories, only: %i[new create edit update]
    resources :user_skills, only: %i[new create edit update]
    resources :user_distance_preferences, only: %i[new create edit update]
    resources :user_congrats, only: %i[show]
    resources :form_skills, only: %i[new create edit update]
    resources :wanted_form_skills, only: %i[new create edit update]
    resources :user_wanted_skill_categories, only: %i[new create edit update]
    resources :user_distance_preferences, only: %i[new create edit update]
    resources :profile, only: %i[show] do
      patch :update_photos, on: :member
      delete :destroy_photo, on: :member
    end
  end
end
