class DreamsController < ApplicationController
  before_action :require_login

  def index
    @dreams = Dream.where(user: current_user).order(:date).reverse_order
    @active_dream = @dreams.first
  end

  def new
    @dream = Dream.new
  end

  def create
    @dream = Dream.new(dream_params)
    # @dream.sentiment = @dream.get_sentiment
    if @dream.save
      # @dream.keyword_analysis
      flash[:notice] = "Dream saved"
      redirect_to dreams_path
    else
      flash[:errors] = @dream.errors.full_messages.join(" - ")
      redirect_to :back
    end
  end

  def edit
    @dream = Dream.find(params[:id])
  end

  def update
    @dream = Dream.find(params[:id])
    @dream.sentiment = @dream.get_sentiment

    if @dream.update(dream_params)
      flash[:notice] = "Dream updated"
      redirect_to dreams_path
    else
      flash[:errors] = @dream.errors.full_messages.join(" - ")
      redirect_to :back
    end
  end

  def destroy
    @dream = Dream.find(params[:id])
    @dream.destroy
    redirect_to root_path
  end

  private

  def dream_params
    dream_params = params.require(:dream).permit(:title, :text, :date).merge(
      user: current_user
      )
    date = Date.strptime(dream_params["date"], '%m/%d/%Y')
    # date = Date.parse(dream_params["date"])
    dream_params["date"] = date
    dream_params
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_user_session_path
    end
  end

end
