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
      UserMailer.signup_confirmation(@user).deliver
      sign_in @user
      @user.activities.create(title: "Signed up! Awesome!", 
        path: user_path(@user), category: "Account")
      flash[:success] = "Welcome to Happs! If you haven't already, we suggest taking the tour."
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      @user.activities.create(title: "Account information updated",
        path: user_path(@user), category: "Account")
      flash[:success] = "Profile updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def show
    if @user
      @pafd = @user.pafd.present?
      @ohq = @user.ohqs.any?
      @activities = @user.activities.paginate(page: params[:page], per_page: 5)
      @happiness_activity_count = @user.activities.happiness_activity_count
    end
  end

  def destroy
    @user = User.find(params[:id])
    unless current_user.admin? && @user == current_user
      @user.destroy
    end
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def ohq_data
    @user = User.find(params[:user_id])
    ohq_data = []
    @user.ohqs.reverse.each do |ohq|
      @created_at = ohq.created_at
      ohq_data << [@created_at.year, @created_at.month, @created_at.day, ohq.score]
    end
    respond_to do |format|
      format.json { render json: ohq_data }
    end
  end

  def pafd_data
    @user = User.find(params[:user_id])
    unless @user.pafd.nil?
      pafd_data = @user.pafd.results_for_diagram
    else
      pafd_data = []
    end
    respond_to do |format|
      format.json { render json: pafd_data }
    end
  end

  def breakdown_data
    @user = User.find(params[:user_id])
    @breakdown = @user.activities.results_for_diagram
    respond_to do |format|
      format.json { render json: @breakdown}
    end
  end

  private

  	def user_params
  		params.require(:user).permit(:first_name, :last_name, :email,
  			:password, :password_confirmation)
  	end

    def correct_user
      @user = params[:id] ? User.find(params[:id]) : current_user
      redirect_to(root_url) unless current_user?(@user) || current_user.try(:admin)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def redirect_if_signed_in
      redirect_to(root_url) if signed_in?
    end
end
