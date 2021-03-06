class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the AlphaBlog #{@user.username}"
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def index
    @users = User.all
  end

  def show
      @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and thier articles deleted"
    redirect_to users_path
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account was successfully updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_admin
      if logged_in? && !current_user.admin?
        flash[:danger] = 'Only admins can deleted users and their atciles'
        redirect_to root_path
      end
    end

    def require_same_user
      if logged_in? && current_user != @user && !current_user.admin?
        flash[:danger] = 'You can only edit your own profile'
        redirect_to root_path
      end
    end
end
