Rails.application.routes.draw do
    mount ActionCable.server => '/cable'

    devise_for :users  #一番上に置いておくのがよい、混ざると大変繰り返しバグの発生原因
    root :to => "homes#top"#ホーム画面
    resources :messages, only: [:show]
    get "/home/about" => "homes#about"
    get "search" => "searches#search"
    get 'rooms/show'
     resources :groups,only:[:index,:show,:edit,:update,:create,:new,:destroy] do
      resources :group_users,only:[:create,:destroy]
     end

    resources :books,only:[:new,:index,:edit,:show,:destroy,:update,:create] do
     resources :post_coments,only:[:create,:destroy]
      resource :favorites,only:[:create,:destroy]
       end

    resources :users,only:[:index,:show,:edit,:update] do
     resource :relationships, only: [:create, :destroy]
        get 'followings' => 'relationships#followings', as: 'followings'
         get 'followers' => 'relationships#followers', as: 'followers'
          end

end
