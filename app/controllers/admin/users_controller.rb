require 'csv'

module Admin
  class UsersController < BaseController
    before_action :set_user, only: %i[ edit update destroy ]
    def index
      @users = User.normal_users.page(params[:page]).per(5)

      respond_to do |format|
        format.html
        format.csv do
          users = User.normal_users
          send_data generate_csv(users), filename: "users-#{Date.today}.csv"
        end
      end
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      @user.role = 0

      respond_to do |format|
        if @user.save
          format.html { redirect_to admin_users_path, notice: "Success." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end

    def update
      if @user.update(user_params)
        redirect_to admin_users_path, notice: "Success."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy!
      respond_to do |format|
      format.html { redirect_to admin_users_path, notice: "Success." }
      format.json { head :no_content }
    end
    end

    def import
      if params[:file].present?
        CSV.foreach(params[:file].path, headers: true) do |row|
          user = User.find_or_initialize_by(email: row['Email'])
          user.user_name = row['User Name']
          user.password = row['Password'] if row['Password'].present?
          user.role = row['Role']
          user.save!
        end
        redirect_to admin_users_path, notice: "Import thành công!"
      else
        redirect_to admin_users_path, alert: "Vui lòng chọn file CSV."
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      permitted = params.require(:user).permit(:email, :password, :user_name, :avatar)
      if permitted[:password].blank?
        permitted.delete(:password)
      end
      
      if permitted[:avatar].blank?
        permitted.delete(:avatar)
      end
      
      permitted
    end

    def generate_csv(users)
      CSV.generate(headers: true) do |csv|
        csv << ['ID', 'User Name', 'Email', 'Role']
        users.each do |user|
          csv << [user.id, user.user_name, user.email, user.role]
        end
      end
    end
  end
end