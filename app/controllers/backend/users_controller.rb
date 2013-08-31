class Backend::UsersController < Backend::ApplicationController

  before_filter(only: [:show, :privileges, :edit, :update, :destroy]) { |m| m.get_user_by_id(params[:id].nil? ? params[:user_id] : params[:id]) }

	def index
		@user = User.all
	end

	def show
	end

  def privileges
    @roles = Role.all
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to backend_users_path, notice: "Данные пользователя '#{@user.name}' обновленны."
    else
      flash[:error] = "Данные пользователя не обновленны."
      render "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to backend_users_path, notice: "Пользователь удален!"
  end

  protected

    def get_user_by_id user_id
      @user = User.find(user_id)
    end
end