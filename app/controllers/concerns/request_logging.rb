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
