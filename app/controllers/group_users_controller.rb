class GroupUsersController < ApplicationController
  
  def create
      @group = Group.find_by(params[:group_id])
      grouping = current_user.group_users.new(group_id: @group.id)
      grouping.save
      redirect_to(groups_path)
  end
  
  def destroy
       @group = Group.find_by(params[:group_id])
       grouping = current_user.group_users.find_by(group_id: @group.id)
       grouping.destroy
       redirect_to(groups_path)
  end
  
end
