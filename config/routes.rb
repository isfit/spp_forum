SppForum::Application.routes.draw do

  # replace devise_for :users with:
  #devise_for :users,  :controllers => { :registrations => "users/registrations"}
  #namespace :user do
  #   :to => "users#index"
  #end

  devise_for :users,  :controllers => { :registrations => :users}
  
  resources :users

  resources :forums do 
    resources :forum_threads
  end


  resources :forum_posts
  resources :forum_threads do
    resources :forum_posts
  end
  root :to => "forums#index"

end
