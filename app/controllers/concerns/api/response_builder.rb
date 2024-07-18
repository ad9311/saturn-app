module Api::ResponseBuilder
  def build_response(data, status: nil, options: {})
    camelize = options.fetch(:camelize, true)
    return { data:, status: } unless camelize

    data = data.transform_keys { |key| key.to_s.camelize(:lower) }
    { data:, status: }
  end

  def build_error_response(messages, status: nil)
    { messages:, status: }
  end

  def order_data(records, by: nil, direction: nil)
    return records if by.nil? || direction.nil?

    records.order("#{by}": direction.to_sym)
  end

  def limit_data(records, limit: nil)
    return records if limit.nil?

    records.limit(limit)
  end
end
