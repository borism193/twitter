class UsersController < ApplicationController
  before_action :set_user,       only: [:show, :edit, :update, :destroy, :following, :followers]
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def feed
    # NOTE: `tweets.or` doesn't work, so use `Tweet.where`
    Tweet.where(user_id: id).or(Tweet.where(user_id: active_relationships.select(:followed_id)))
  end

  def index
    @users = User.all
  end

  def show
    @tweet = current_user.tweets.build if user_signed_in?

    @feed_items = @user.tweets.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = "Welcome to Twitter Clone!"
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Update your profile"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_url
  end

  def following
    @title = "Following"
    @users = @user.following.paginate(page: params[:page])
    render :show_follow
  end

  def followers
    @title = "Followers"
    @users = @user.followers.paginate(page: params[:page])
    render :show_follow
  end

  private
    def set_user
      @user = User.find_by!(id: params[:id])
    end

    def user_params
      params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
    end

    def correct_user
      unless current_user?(@user)
        redirect_to(root_path)
      end
    end
end
