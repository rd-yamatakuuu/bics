Rails.application.routes.draw do

  devise_for :admins
  devise_for :users

  root 'homes#top'

  get 'home/about' => 'homes#about'
  get 'home/start' => 'homes#start'
  get 'search' => 'public/ideas#search'
  get 'chat/:id' => 'public/chats#show', as: 'chat'
  get '/congratulations' => 'homes#congratulations'
  get 'favorites_index' => 'public/favorites#index'
  get 'rank_fav' => 'public/ideas#rank_fav'
  get 'rank_com' => 'public/ideas#rank_com'
  get 'rank_rev' => 'public/ideas#rank_rev'
  get 'finder' => 'public/finders#finder'

  scope module: :public do
    get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    put 'users/:id/withdraw' => 'users#withdraw', as: 'users_withdraw'
    resources :users, only: [:index, :show, :edit, :create, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      member do
        get :user_info
        get :profile
      end
    end
    resources :ideas, only: [:index, :show, :new, :edit, :create, :update, :destroy] do
      resources :comments, only: [:create, :destroy, :index]
      resource :favorites, only: [:create, :destroy]
    end
    resources :chats, only: [:create]
    resources :tags, only: [:index]
    resources :contacts, only: [:index, :create] do
      collection do
        get :done
      end
    end
    resources :rooms, only: [:create, :update, :destroy]
    resources :notifications, only: [:index] do
      collection do
        delete :destroy_all
      end
    end
  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :ideas, only: [:index, :show]
    resources :specialities, only: [:index, :edit, :create, :update, :destroy]
    resources :tags, only: [:index, :edit, :create, :update, :destroy]
  end

end
