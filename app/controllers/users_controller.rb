class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :destroy]
  # Check whether user has logged in before going to 
  # the edit page, login or destroying user
  before_action :check_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.tag_list.add(params[:tag_list], parse: true)

  	respond_to do |format|
      if @user.save
        log_in @user
        format.html { redirect_to articles_path, notice: 'User was successfully saved.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  # PATCH/PUT /user/1
  # PATCH/PUT /user/1.json
  def update
    # Should be able to remove and add interests
    @user.tag_list = params[:tag_list]

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to articles_url, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def emailMyself
    Emailer.sendEmail.deliver

    redirect_to home_path
  end

  # Destroy user and go back to home page
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to home_path, notice: 'User was successfully destroyed!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Check whether user has loged in and has the right to access resources
    # if not, return a 403 code
    def check_user
      unless @user == current_user
        redirect_to home_path, status: 403
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :bio, 
      :username, :password, :password_confirmation, :tag_list)
    end
end
