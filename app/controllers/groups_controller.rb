class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = current_user.groups
  end

  def create
    group = current_user.groups.new(groups_params)
    respond_to do |format|
      format.html do
        if group.save
          redirect_to groups_path, notice: 'Category added!'
        else
          redirect_to new_group_path, alert: 'Please, fill all fields'
        end
      end
    end
  end

  private

  def groups_params
    params.require(:group).permit(:name, :icon)
  end
end
