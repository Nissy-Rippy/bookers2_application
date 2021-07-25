Rails.application.routes.draw do

  devise_for :users  #一番上に置いておくのがよい、混ざると大変繰り返しバグの発生原因
  root :to => "homes#top"#ホーム画面

  get "/home/about" => "homes#about"

   resources :books,only:[:new,:index,:edit,:show,:destroy,:update,:create] do
    resources :post_coments,only:[:create,:destroy]
        resource :favorites,only:[:create,:destroy]

    end
    #ブックスに必要なルーティン
   resources :users,only:[:index,:show,:edit,:update]#新しくつくないといけないルーティン

end
