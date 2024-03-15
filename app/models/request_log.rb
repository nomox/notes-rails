class RequestLog
  include Mongoid::Document

  field :endpoint, type: String
  field :method, type: String
  field :response_status, type: Integer
  field :error, type: Hash
  field :timestamp, type: DateTime, default: -> { Time.now }

  def self.collect_stats
    {
      total_hits: count,
      error_hits: where(:error.exists => true).count
    }
  end
end
