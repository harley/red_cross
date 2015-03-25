class UsersController < ApplicationController
  def index
    # TODO restrict to admin only
    @users = User.all
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes user_params
      flash[:success] = "Changes saved!"
    else
      flash[:error] = "Not all changes were saved"
    end
    redirect_to edit_user_path(:current)
  end

  private
  def user_params
    params.require(:user).permit(:fname, :lname, :college, :class_year, :email, :lookup_by_email)
  end
end
