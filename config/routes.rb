Rails.application.routes.draw do
  get 'searchs/search'
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
  get '/search', to: 'searchs#search', as: 'search' # 名前検索機能
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
