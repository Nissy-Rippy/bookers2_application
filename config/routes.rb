Rails.application.routes.draw do
  root :to => "homes#top"
  get "/homes/about" => "homes#about"
  resources :books,only:[:new,:index,:edit,:show,:destroy,:update]
  resources :users,only:[:new,:index,:edit,:show,:destroy,:update]
  devise_for :users
end
