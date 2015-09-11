class UsersController < ApplicationController
  before_action :require_user
  def index
    # TODO pagination
    @users = User.order('role DESC, created_at').all
    authorize @users
  end

  def update_roles
    authorize :users, :index?
    if params[:roles_for]
      params[:roles_for].each do |user_id, role|
        User.find(user_id).update_attribute :role, role
      end
    end
    flash[:success] = "Roles updated."
    redirect_to action: 'index'
  end

  def edit
    check_user
    authorize @user
  end

  def update
    check_user
    if @user.update_attributes user_params
      flash[:success] = "Changes saved!"
    else
      flash[:error] = "Error: #{@user.errors.full_messages.to_sentence}"
    end
    redirect_to edit_user_path(@user == current_user ? :current : @user)
  end

  private
  def user_params
    params.require(:user).permit(:fname, :lname, :college, :class_year, :email, :lookup_by_email, :phone, :role)
  end

  def check_user
    if params[:id] == 'current'
      @user = current_user
    else
      @user = User.find params[:id]
    end
  end
end
