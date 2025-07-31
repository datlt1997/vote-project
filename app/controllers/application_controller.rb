class ApplicationController < ActionController::Base
    layout :resolve_layout
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?
    
    before_action :restrict_admin_access


    def restrict_admin_access
      if user_signed_in? && current_user&.admin? && !request.path.start_with?("/admin") && !request.path.start_with?("/user")
        redirect_to admin_users_path, alert: "Tài khoản admin chỉ truy cập khu vực quản trị."
      end
     
    end

    protected

    def configure_permitted_parameters
        added_attrs = [:user_name, :email, :password, :password_confirmation, :remember_me]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end

    def after_sign_in_path_for(resource)
         Rails.logger.debug "PARAMS: #{resource.admin?}"
        if resource.admin?
            admin_users_path
        elsif resource.user?
            stored_location_for(resource) || home_path
        else
            home_path
        end
    end

    def resolve_layout
    if devise_controller? && !user_signed_in?
      'nologin_application'
    else
      'application'
    end
  end

end
