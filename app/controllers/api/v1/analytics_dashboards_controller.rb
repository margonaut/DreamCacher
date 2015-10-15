module Api
  module V1
    class AnalyticsDashboardsController < ApiController
      def show
        @dreams = Dream.where(user: current_user)
        @organizer = AnalyticsDashboardOrganizer.new(@dreams)
        render json: @organizer, serializer: AnalyticsDashboardOrganizerSerializer
      end

      private

      # def dashboard
      #   @_dashboard ||= AnalyticsDashboardOrganizer.new(@dreams)
      # end
    end
  end
end
