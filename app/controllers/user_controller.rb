class UserController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
  	@user = current_user if logged_in?
    @events = @user.events.reorder('time_of_event ASC') if logged_in?
    @event = current_user.events.build if logged_in?
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
      #redirect_to action: "index"
    else
      render 'new'
    end
  end

  def edit
    @user = User.friendly.find(params[:id])
  end

  def update
    @user = User.friendly.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "User has successfully been updated."
      redirect_to @user 
      # Handle a successful update.
    else
      flash[:danger] = "Error on Updating Profile! Please ensure passwords match and are correct."
      render 'edit'
    end
  end

  def show
    @user = User.friendly.find(params[:id])
    @events = @user.events
  end

  def feed
    @user = current_user
    #Show events that friends created
    if logged_in?
      @events = @user.events
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :firstN, :lastN, :email, :password, :password_confirmation, :mobile_phone, :dob)
    end

    # Before Filters

    #Confirms logged in user
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.friendly.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
