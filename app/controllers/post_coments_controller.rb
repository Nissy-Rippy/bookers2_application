class PostComentsController < ApplicationController

  def create
      book = Book.find(params[:book_id])
      comment = current_user.post_coments.new(params_post_coment)
      comment.book_id = book.id
      comment.save
      redirect_back(fallback_location: root_path)
  end

  def destroy
      book = Book.find(params[:book_id])
      comment = current_user.post_coments.find_by(book_id: book.id)
      comment.destroy
      redirect_back(fallback_location: root_path)
  end

private

   def params_post_coment
       params.require(:post_coment).permit(:comment,)
   end

end
