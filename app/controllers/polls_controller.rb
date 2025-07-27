class PollsController < AdminController
  before_action :set_poll, only: %i[ edit update destroy ]

  def index
    @polls = Poll.includes(:options).all
      .yield_self do |relation|
        params[:title].present? ? relation.where("title LIKE ?", "%#{params[:title]}%") : relation
      end
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
        format.html { redirect_to polls_path, notice: "Success." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
    
  def edit
  end

  def update
    if @poll.update(poll_params)
      redirect_to polls_path, notice: "Success."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @poll.destroy!

    respond_to do |format|
      format.html { redirect_to polls_path, notice: "Success." }
      format.json { head :no_content }
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
      options_attributes: [:id, :content, :_destroy]
    )

    if permitted[:image].blank?
      permitted.delete(:image)
    end

    permitted
  end
end
