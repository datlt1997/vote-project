module Admin
  class PollsController < BaseController
    before_action :set_poll, only: %i[ edit update destroy analytic ]

    DEFAULT_PAGE_SIZE = 5

    def index
      @polls = Poll
        .yield_self do |relation|
          params[:title].present? ? relation.where("title LIKE ?", "%#{params[:title]}%") : relation
        end
        .page(params[:page])
        .per(DEFAULT_PAGE_SIZE)
        .includes(:options)
    end

    def new
      @poll = Poll.new
      @poll.options.build
    end

    def create
      @poll = Poll.new(poll_params)
      @poll.user_id = 1

      respond_to do |format|
        if @poll.save
          format.html { redirect_to admin_polls_path, notice: "Success." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end
      
    def edit
    end

    def update
      if @poll.update(poll_params)
        redirect_to admin_polls_path, notice: "Success."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @poll.destroy!

      respond_to do |format|
        format.html { redirect_to admin_polls_path, notice: "Success." }
        format.json { head :no_content }
      end
    end

    def analytic
      @poll = Poll.includes(options: :votes).find(params[:id])
      #tính tổng số vote
      total_votes = @poll.options.sum { |option| option.votes.size }
      #them properties vào poll
      @total = total_votes
      @statistics = @poll.options.map do |option|
        vote_count = option.votes.size
        percent = total_votes > 0 ? ((vote_count.to_f / total_votes) * 100).round(2) : 0
        {
          option: option.content,
          votes_count: vote_count,
          percent: percent,
        }
      end
      if (params[:option_id].present?)
        option = Option.includes(votes: :user).find(params[:option_id])
        @voted_users = format_vote_data(option)
      else
        @voted_users = @poll.options.flat_map do |option|
          format_vote_data(option)
        end.uniq
      end

    end

    private

    def set_poll
      @poll = Poll.find(params[:id])
    end

    def poll_params
      permitted = params.require(:poll).permit(
        :title,
        :description,
        :allows_multiple,
        :anonymous,
        :image,
        :expires_at,
        options_attributes: [:id, :content, :_destroy]
      )

      if permitted[:image].blank?
        permitted.delete(:image)
      end

      permitted
    end

    def format_vote_data(option)
      option.votes.map do |vote|
        {
          id: vote.user.present? ? vote.user.id : nil,
          user_name: vote.user.present? ? vote.user.user_name : 'ẩn danh',
          option_content: option.content,
          voted_at: vote.created_at
        }
      end
    end
  end
end
