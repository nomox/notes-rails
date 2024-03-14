module Api
  module V1
    class BaseController < ::ApplicationController
      include RequestLogging

      skip_forgery_protection
      rescue_from StandardError, with: :catch_exceptions
      before_action :set_default_response_format

      private

      def set_default_response_format
        request.format = :json unless params[:format]
      end

      def catch_exceptions(exception)
        log_request_exception(exception)
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
