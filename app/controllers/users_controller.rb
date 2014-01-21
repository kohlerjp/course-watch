class UsersController < ApplicationController

  before_action :signed_in_user, only:[:edit, :update, :show, :index,:delete]
  before_action :correct_user, only:[:edit, :update]
  before_action :admin_user, only:[:destroy]

  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end
  def create
    @user = User.new(user_params())
    if @user.save
      sign_in(@user)
      flash[:success] = "Your account has been created"
      redirect_to @user
    else 
      render 'new'
    end
  end
  def destroy
    User.find(params[:id]).destroy
    redirect_to root_url
  end

  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end


  private

    def user_params
      return params.require(:user).permit(:first_name,:last_name,:email,:password,:password_confirmation)
    end

      ### Before Filters




end
