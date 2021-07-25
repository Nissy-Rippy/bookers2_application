class BooksController < ApplicationController

  def index
    @book = Book.new#からのインスタンスをcreateに渡すためのもの
    @books = Book.all#すべてのブックスをデータから抜き取る
    @book.user_id = current_user#ほんのユーザーはログインしている人のユーザーとなる
    @user = current_user#今のユーザーはログインしているユーザー
  end

  def create
    @book = Book.new(book_params)#インデックスより送られてきsた空のインスタンスに変数を加える
    @book.user_id = current_user.id#これにより、bookモデルとユーザーモデルをアソシエイトしてから投稿する
    @user = current_user#ここでのユーザーとはログイン中のユーザー
    if @book.save#本のデータ作成に成功したならば
      redirect_to(book_path(@book.id))#本の詳細ページに移動します
      flash[:notice] = "Book was successfully created."#フラッシュ表示のためのコード
    else
      @books = Book.all #render先に用意してないerror用のインスタンス変数を用意する必要がある。
      render :index#レンダーにより直接インデックスアクションにアクセスする。そのままの状態でそのためrender先に足りないインスタンス変数はつけた咲いて書かないといけなくなる
    end
  end

  def show
      @book_new = Book.new# 部分テンプレートのcreate機能を利用するため
      @book = Book.find(params[:id])#データベースよ取り込む
      @user = @book.user#ここでのユーザーとは、本のタイトル感想を投稿したユーザということ
      @post_coment = Post_coment.new
  end
  

  def edit
      @book = Book.find(params[:id])#データベースよりどの本なのかを特定する、インスタンス変数
      if @book.user != current_user
            redirect_to books_path
      end
  end


  def update
      @book = Book.find(params[:id])
    if @book.update(book_params)#条件分岐により成功した場合と違う場合に条件を変える
       redirect_to(book_path(@book.id))#成功したら本の一覧ページに戻るはず
       flash[:notice] = "Book was successfully updated."#成功メッセージの際に表示
    else
       render :edit#アクションエディットにレンダーする
    end
  end

  def destroy
    book = Book.find(params[:id])#消すための本をデータベースから照合する
    book.destroy#本のデータ削除昨日
    redirect_to(books_path)#消した後の移動先
    flash[:notice] = "Book was successfully destroyed."#フラッシュ表示のためのコード
  end

private

  def book_params          #strongぱらーめたー外部よりいじられないようにする
  params.require(:book).permit(:title,:body)  #データベースにデータを書き込む
  end
  

end
