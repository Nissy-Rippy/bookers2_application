class UsersController < ApplicationController

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def index
      @users = User.all
      @user = current_user
      @book = Book.new
  end

  def update
      @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to(user_path(@user.id))
      flash[:notice] = "User info was successfully updated."
    else
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
  end

private

  def user_params
     params.require(:user).permit(:profile_image,:introduction,:name)
  end

end
