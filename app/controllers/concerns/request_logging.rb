# Concern RequestLogging implements a track method which is called after every action by callback after_action
# and logs data such as: endpoint, request method, response status code, and error type.
# This module can be included in any controller or group of controllers that needs to be monitored.
# Call `log_request_exception` to track any specific error.
module RequestLogging
  extend ActiveSupport::Concern

  included do
    after_action :log_request
  end

  def log_request_exception(exception)
    RequestLog.create(
      endpoint: request.path,
      method: request.method,
      error: { class_name: exception.class.name, message: exception.message },
      timestamp: Time.now
    )
  end

  def log_request
    RequestLog.create(
      endpoint: request.path,
      method: request.method,
      response_status: response.status,
      timestamp: Time.now
    )
  end
end
