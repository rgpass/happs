class UsersController < ApplicationController
  before_action :signed_in_user,  only: [:index, :edit, :update, :destroy]
  before_action :correct_user,    only: [:edit, :update, :show, :destroy]
  before_action :admin_user,      only: [:index]
  before_action :redirect_if_signed_in, only: [:new, :create]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      @user.activities.create(title: "Signed up! Awesome!", 
        path: user_path(@user), category: "Account")
      flash[:success] = "Welcome to Happs! If you haven't already, we suggest taking the tour."
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      @user.activities.create!(title: "Account information updated", 
        path: user_path(@user), category: "Account")
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @activities = @user.activities
    @activities = @user.activities.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user = User.find(params[:id])
    unless current_user.admin? && @user == current_user
      @user.destroy
    end
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

  	def user_params
  		params.require(:user).permit(:first_name, :last_name, :email,
  			:password, :password_confirmation)
  	end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || current_user.try(:admin)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def redirect_if_signed_in
      redirect_to(root_url) if signed_in?
    end
end
