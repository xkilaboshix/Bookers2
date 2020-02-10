Rails.application.routes.draw do
  devise_for :users
  root 'users#top'
  get '/home/about' => 'users#about'
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users
  resources :relationships, only: [:create, :destroy]
  get '/relationships/followings', to: 'relationships#following_index', as: 'followings'
  get '/relationships/followers', to: 'relationships#follower_index', as: 'followers'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
