module AdminHelper
  def admin_menu_items
    YAML.load_file(Rails.root.join("config", "sidebar.yml"))["admin_menu"]
  end
end
