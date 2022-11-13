Rails.application.routes.draw do
  # get 'users/new'
  # get 'users/create'
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/edit'
  # get 'sessions/update'
  # get 'sessions/destroy'
  # get 'posts/new'
  # get 'posts/show'
  # get 'posts/index'
  # get 'posts/update'
  # get 'posts/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resource :session, only:[:new, :create, :edit, :update, :destroy]

  resource :users, only:[:new, :create, :edit, :update ]

  get 'users/password', :to => 'users#password_show'
  patch 'users/password', :to => 'users#password_update'

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  # Defines the root path route ("/")
  root "posts#index"
end
