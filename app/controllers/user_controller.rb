class UserController < ApplicationController
  def index
  	@users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
      #redirect_to action: "index"
    else
      render 'new'
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
end
