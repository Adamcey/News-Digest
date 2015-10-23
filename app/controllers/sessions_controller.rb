class SessionsController < ApplicationController
  
  before_action :check_params, only: [:login]
  before_action :authenticate_user, only: [:logout]

  def home
  end

  def login
  	user = User.authenticate(@credentials[:username], @credentials[:password])

    # If user does not log in, redirect to the home page
  	if user
  	  log_in user
  	  redirect_to articles_path
  	else
      redirect_to home_path, status: 403
  	end
  end

  def logout
  	log_out
  	redirect_to home_path
  end

  private
  def check_params
  	params.require(:credentials).permit(:username, :password)
  	@credentials = params[:credentials]
  end
end
