module Api
  module V1
    class DreamsController < ApiController
      def index
        @dreams = Dream.where(user: current_user)
        if params["dashboard"] == "analytics"
          render json: dashboard
        else
          render json: @dreams
        end
      end

      def show
        @dream = Dream.find(params["id"])
        render json: @dream
      end

      private

      def dashboard
        @_dashboard ||= AnalyticsDashboardOrganizer.new(@dreams)
      end
    end
  end
end
