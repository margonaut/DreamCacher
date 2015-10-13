module Api
  module V1
    class DreamsController < ApiController
      def index
        @dreams = Dream.where(user: current_user)
        if params["chart"] == "pie"
          render json: @dreams.pie_data
        else
          render json: @dreams
        end
      end

      def show
        @dream = Dream.find(params["id"])
        render json: @dream
      end
    end
  end
end
