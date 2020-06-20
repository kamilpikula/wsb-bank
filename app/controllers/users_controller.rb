class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Konto zostało zaktualizowane!"
      redirect_to root_path
    else
      flash[:alert] = "Pojawił się problem!"
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.balance > 0.00
      redirect_to user_path(@user.id)
    else
      @user.destroy
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name)
  end
end