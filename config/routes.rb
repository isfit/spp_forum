SppForum::Application.routes.draw do

  

  devise_for :users,  :controllers => { :registrations => :users}
  
  resources :users
  resources :articles

  resources :forums do 
    resources :forum_threads
  end


  resources :forum_posts
  resources :forum_threads do
    resources :forum_posts
  end
  root :to => "articles#index"

end
