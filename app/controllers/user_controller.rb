class UserController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
  	@users = User.all
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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
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
  	if(User.find_by_firstN(params[:firstN]))
  		@user = User.find_by_firstN(params[:firstN])
  	elsif(User.find_by_id(params[:id]))
      @user = User.find_by_id(params[:id])
    else
  		render :file => 'public/404.html', :status => :not_found, :layout => false
  	end
  end

  private
    def user_params
      params.require(:user).permit(:firstN, :lastN, :email, :password, :password_confirmation, :mobile_phone, :dob)
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
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
