module UsersHelper
  def badge_class_for(role)
    case role.to_s
    when "admin"
      "bg-warning text-dark"
    when "user"
      "bg-secondary"
    else
      "bg-light text-dark" # mặc định
    end
  end

  def avatar_url_for(user)
    user.persisted? && user.avatar.attached? ? url_for(user.avatar) : ""
  end
end
