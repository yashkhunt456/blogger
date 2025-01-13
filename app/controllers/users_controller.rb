class UsersController < ApplicationController
  before_action :see_admin
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if @user != current_user
        @user.destroy
        redirect_to users_path, notice: "user was successfully deleted."
    else
        redirect_to users_path, notice: "You cannot delete yourself."
    end
  end

  private

  def see_admin
    redirect_to root_path, alert: "You are not authorized to perform this action." unless current_user.has_role?(:admin)
  end

  def require_admin
    unless current_user.has_role?(:admin)
        redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

end
