require 'csv'

module Admin
  class BaseController < ApplicationController
    before_action :authenticate_admin!
    before_action :custom_authenticate_user!

    private

    def authenticate_admin!
      if !user_signed_in?
        redirect_to new_user_session_path, alert: "Bạn cần đăng nhập trước"
      elsif !current_user&.admin?
        redirect_to root_path, alert: "Bạn không có quyền truy cập"
      end
    end

    def custom_authenticate_user!
      if !user_signed_in? || current_user.admin?
        authenticate_user!
      end
    end
  end
end