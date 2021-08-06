class BooksController < ApplicationController

  def index
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
    sort {|a,b| 
        b.favorited_users.includes(:favorites).where(created_at: from...to).size <=> 
        a.favorited_users.includes(:favorites).where(created_at: from...to).size
         }
    @book = Book.new
    @book.user_id = current_user
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      redirect_to(book_path(@book.id))
      flash[:notice] = "Book was successfully created."
    else
      @books = Book.all
      render :index
    end
  end

  def show
      @book_new = Book.new
      @book = Book.find(params[:id])
      @user = @book.user
      @post_coment = PostComent.new
  end


  def edit
      @book = Book.find(params[:id])
      if @book.user != current_user
            redirect_to books_path
      end
  end

  def update
       @book = Book.find(params[:id])
    if @book.update(book_params)
       redirect_to(book_path(@book.id))
       flash[:notice] = "Book was successfully updated."
    else
       render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to(books_path)
    flash[:notice] = "Book was successfully destroyed."
  end

private

  def book_params
  params.require(:book).permit(:title,:body)
  end


end
