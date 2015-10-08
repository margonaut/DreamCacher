module Api
  module V1
    class DreamsController < ApiController
      def index
        @dreams = Dream.all
        render json: @dreams
      end

      def show
        @dream = Dream.find(params["id"])
        render json: @dream
      end
    end
  end
end
