class BooksController < ApplicationController

  def index
    @book = Book.new#からのインスタンスをcreateに渡すためのもの
    @books = Book.all#すべてのブックスをデータから抜き取る
    @book.user_id = current_user
    @user = current_user
  end

  def create
    @book = Book.new(book_params)#インデックスより送られてきsた空のインスタンスに変数を加える
    @book.user_id = current_user.id
    if @book.save
      redirect_to(book_path(@book.id))
      flash[:notice] = "Book was successfully created."#フラッシュ表示のためのコード
    else
      render :index#レンダーにより直接インデックスアクションにアクセスする。そのままの状態で
    end
  end

  def show
      @book_new = Book.new
      @book = Book.find(params[:id])#データベースよ取り込む
      @user = current_user
  end

  def edit
      @book = Book.find(params[:id])#データベースよりどの本なのかを特定する、インスタンス変数
  end

  def update
      @book = Book.find(params[:id])
    if @book.update(book_params)#条件分岐により成功した場合と違う場合に条件を変える
       redirect_to(book_path(@book.id))#成功したら本の一覧ページに戻るはず
       flash[:notice] = "Book was successfully updated."
    else
       render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to(books_path)
    flash[:notice] = "Book was successfully destroyed."#フラッシュ表示のためのコード
  end

private

  def book_params          #strongぱらーめたー外部よりいじられないようにする
  params.require(:book).permit(:title,:body)  #データベースにデータを書き込む
  end

end
