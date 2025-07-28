class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_service

  def index
    @users = @user_service.list_all
  end

  def show
    @user = @user_service.show(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = @user_service.create(user_params)
    if @user.persisted?
      redirect_to users_path, notice: "Tạo người dùng thành công"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = @user_service.show(params[:id])
  end

  def update
    @user = @user_service.update(params[:id], user_params)
    if @user&.errors.blank?
      redirect_to users_path, notice: "Cập nhật thành công"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user_service.destroy(params[:id])
    redirect_to users_path, notice: "Đã xoá người dùng"
  end

  private

  def set_user_service
    @user_service = UserService.new(current_user)
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
