class StaticPagesController < ApplicationController
	def home
		# if(logged_in?)
		# 	redirect_to controller:"user", action:"index"
		# 	#Schedule Update
		# end
		@users = User.search(params[:search])
	end

	def help
	end

	def about
	end
	
	def contact
	end
end
