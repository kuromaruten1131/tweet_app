Rails.application.routes.draw do
  root 'tweets#index'
  
  devise_for :users, :skip => [:registrations]
  devise_scope :user do
    get "user/sign_up", to: "users/registrations#new", as: :new_user_registration
    post "user/sign_up", to: "users/registrations#create", as: :user_registration
  end
  resources :users
  resources :tweets do
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
