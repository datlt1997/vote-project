class PagesController < AdminController
  layout :choose_layout
  def home
  end

  def about
  end

  private

  def choose_layout
    user_signed_in? ? "application" : "nologin_application"
  end
end
