class RequestLogsController < ApplicationController
  before_action :set_filter_data, only: %i[index]

  def index
    @request_logs = RequestLog.all.order(timestamp: :desc)
    @request_logs = RequestLogsQuery.new(search_params, @request_logs).call
    @hit_stats    = @request_logs.collect_stats
  end

  private

  def search_params
    params.permit(:method, :response_status, :error_class)
  end

  def set_filter_data
    @methods         = RequestLog.distinct(:method)
    @response_status = RequestLog.distinct(:response_status)
    @error_classes   = RequestLog.distinct('error.class_name')
  end
end
