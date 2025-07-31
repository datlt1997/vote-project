class PollsController < ApplicationController
  layout :choose_layout
  before_action :set_poll, only: [:show, :vote]
  before_action :require_login_if_needed, only: [:vote]
  before_action :store_user_location!, if: :storable_location?

  def index
    @polls = Poll.includes(:options)
  end

  def show
    if poll_expired?(@poll)
      redirect_to polls_path, alert: "Bình chọn này đã hết hạn."
      return
    end
    if user_voted?(@poll, current_user)
      redirect_to polls_path, alert: "Bạn đã bình chọn rồi."
    end
  end

  def vote
    if @poll.allows_multiple
      option_ids = params[:option_ids]&.reject(&:blank?) || []

      if option_ids.empty?
        redirect_to @poll, alert: "Vui lòng chọn ít nhất một lựa chọn." and return
      end

      option_ids.each do |oid|
        option = @poll.options.find_by(id: oid)
        next unless option

        @poll.votes.create!(
          option: option,
          user_id: current_user&.id ? current_user&.id : nil
        )
      end
    else
      option = @poll.options.find_by(id: params[:option_id])
      unless option
        redirect_to @poll, alert: "Vui lòng chọn một lựa chọn." and return
      end

      @poll.votes.create!(
        option: option,
        user_id: current_user&.id ? current_user&.id : nil
      )
    end

    redirect_to polls_path, notice: "Bình chọn thành công!"
  end

  def storable_location?
    request.get? &&
      is_navigational_format? &&
      !devise_controller? &&
      !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  private

  def set_poll
    @poll = Poll.find(params[:id])
  end

  def require_login_if_needed
    redirect_to new_user_session_path unless @poll.anonymous || user_signed_in?
  end

  def poll_params
    params.require(:poll).permit(:title, :description, :anonymous, options_attributes: [:title])
  end

  def user_voted?(poll, user)
    user && Vote.exists?(poll_id: poll.id, user_id: user.id)
  end

  def poll_expired?(poll)
    poll.expires_at.present? && poll.expires_at < Time.current
  end
  
  def choose_layout
    user_signed_in? ? "application" : "nologin_application"
  end
end
