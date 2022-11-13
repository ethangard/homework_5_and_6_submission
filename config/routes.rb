Rails.application.routes.draw do
  # get 'posts/new'
  # get 'posts/show'
  # get 'posts/index'
  # get 'posts/update'
  # get 'posts/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  # Defines the root path route ("/")
  root "posts#index"
end
