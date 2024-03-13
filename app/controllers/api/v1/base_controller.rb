module Api
  module V1
    class BaseController < ::ApplicationController
      skip_forgery_protection
      rescue_from Exception, with: :catch_exceptions
      before_action :set_default_response_format

      private

      def set_default_response_format
        request.format = :json unless params[:format]
      end

      def catch_exceptions(exception)
        case exception.class
        when ActiveRecord::RecordNotFound
          render json: { errors: [exception.message] }, status: :not_found
        else
          render json: { errors: [exception.message] }, status: :bad_request
        end
      end
    end
  end
end
