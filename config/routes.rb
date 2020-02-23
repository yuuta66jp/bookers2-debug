Rails.application.routes.draw do
  # ルーティングはファイルの上から記載順にマッチする。
  devise_for :users

  # menberメッソドによりユーザーidが含まれるURLを作成
  resources :users,only: [:show,:index,:edit,:update] do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  root 'home#top'

  get 'home/about', to: 'home#about'

end
