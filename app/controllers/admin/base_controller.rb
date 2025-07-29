require 'csv'

module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :required_admin!

    private

    def required_admin!
      unless current_user&.admin?
        redirect_to root_path, alert: "Bạn không có quyền truy cập"
      end
    end
  end
end