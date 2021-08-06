class GroupsController < ApplicationController
   def new
     @group = Group.new
   end
  def edit

  end

  def index
      @group = Group.find_by(id: params[:id])
      @user = User.find_by(params[:id])
      @book = Book.find_by(params[:id])
      @groups = Group.all
  end

  def create
      @group = Group.new(group_params)
      @group.owner_id = current_user.id
      @group.save
      redirect_to(groups_path)
  end

  def update
  end

  def destroy
  end

  def show
      @group = Group.find_by(id: params[:id])
      @book = Book.find_by(params[:id])
      @user = User.find_by(id: params[:id])
      
  end

  private

  def group_params
    params.require(:group).permit(:image,:introduction,:name)
  end

end
