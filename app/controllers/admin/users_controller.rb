require 'csv'

module Admin
  class UsersController < BaseController
    before_action :set_user, only: %i[ edit update destroy ]
    DEFAULT_PAGE_SIZE = 5

    def index
      users = User.normal_users
      users = users.where("user_name LIKE ?", "%#{params[:key_work]}%") if params[:key_work].present?

      respond_to do |format|
        format.html do
          @users = users.page(params[:page]).per(DEFAULT_PAGE_SIZE)
        end
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
          format.html { redirect_to admin_users_path, notice: "Tạo mới người dùng thành công." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end

    def update
      if params[:user][:remove_avatar] == "true"
        @user.avatar.purge if @user.avatar.attached?
      end

      if @user.update(user_params)
        redirect_to admin_users_path, notice: "Cập nhật người dùng thành công."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy!
      respond_to do |format|
      format.html { redirect_to admin_users_path, notice: "Xóa người dùng thành công." }
      format.json { head :no_content }
    end
    end

    def import
      if params[:file].present?
        imported = 0
        skipped_emails = []

        CSV.foreach(params[:file].path, headers: true) do |row|
          email = row['Email'].to_s.strip.downcase

          if User.exists?(email: email)
            skipped_emails << email
            next
          end

          user = User.new(
            email: email,
            user_name: row['User Name'],
            role: row['Role']
          )
          user.password = row['Password'].presence || SecureRandom.hex(8)

          if user.save
            imported += 1
          else
            skipped_emails << email #
          end
        end

        message = "Import thành công #{imported} người dùng."
        if skipped_emails.any?
          message += " Các email bị trùng và không được import: #{skipped_emails.uniq.join(', ')}"
        end

        redirect_to admin_users_path, notice: message
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