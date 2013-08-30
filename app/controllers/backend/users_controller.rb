class Backend::UsersController < Backend::ApplicationController
	def index
		@user = User.all
	end

	def show
		@user = User.find(params[:id])
	end

  def privileges
    @user = User.find(params[:user_id])
    @roles = Role.all
  end
end