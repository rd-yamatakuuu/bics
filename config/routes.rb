Rails.application.routes.draw do
  
  
  namespace :public do
    get 'users/show'
    get 'users/edit'
  end
  devise_for :admins
  devise_for :users
  root 'homes#top'
end
