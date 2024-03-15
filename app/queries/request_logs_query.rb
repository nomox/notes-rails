class RequestLogsQuery
  attr_reader :params, :relation

  def initialize(params = {}, relation = RequestLog.all)
    @params   = params
    @relation = relation
  end

  def call
    @relation = @relation.where(method: params[:method])                    if params[:method].present?
    @relation = @relation.where(response_status: params[:response_status])  if params[:response_status].present?
    @relation = @relation.where('error.class_name' => params[:error_class]) if params[:error_class].present?
    @relation
  end
end
