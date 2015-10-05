class DreamsController < ApplicationController

  def new
    @dream = Dream.new
  end

  def create
    @dream = Dream.new(dream_params)
    binding.pry
    if @dream.save
      flash[:notice] = "Dream saved"
      redirect_to dreams_path
    else
      flash[:errors] = @dream.errors.full_messages.join(" - ")
      redirect_to :back
    end
  end

  private

  def dream_params
    dream_params = params.require(:dream).permit(:title, :text, :date).merge(
      user: current_user
      )
    date = Date.strptime(dream_params["date"], '%m/%d/%Y')
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
