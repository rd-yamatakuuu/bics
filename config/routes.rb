Rails.application.routes.draw do

  devise_for :admins
  devise_for :users

  root 'homes#top'

  get 'home/about' => 'homes#about'
  get 'home/start' => 'homes#start'
  get 'chat/:id' => 'public/chats#show', as: 'chat'
  get '/congratulations' => 'homes#congratulations'

  scope module: :public do
    resources :users, only: [:index, :show, :edit, :create, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :ideas, only: [:index, :show, :new, :edit, :create, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resources :favorites, only: [:create, :destroy]
    end
    resources :chats, only: [:create]
    resources :tags, only: [:index]
    resources :contacts, only: [:new, :create]
    resources :rooms, only: [:create, :update, :destroy]
  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :ideas, only: [:index, :show]
    resources :specialities, only: [:index, :edit, :create, :update, :destroy]
    resources :tags, only: [:index, :edit, :create, :update, :destroy]
  end

end
