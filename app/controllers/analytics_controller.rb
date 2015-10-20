class AnalyticsController < ApplicationController
  before_action :require_login
  
  def index
    @dreams = Dream.where(user: current_user).order(:date).reverse_order
  end

  private

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_user_session_path
    end
  end
end
