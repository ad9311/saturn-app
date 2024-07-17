module Api::ResponseBuilder
  def build_response(data, status: nil, options: {})
    camelize = options.fetch(:camelize, true)
    response = { data:, status: }
    return response unless camelize

    response.transform_keys { |key| key.to_s.camelize(:lower) }
  end

  def build_error_response(errors, status: nil, options: {})
    camelize = options.fetch(:camelize, true)
    response = { errors:, status: }
    return response unless camelize

    response.transform_keys { |key| key.to_s.camelize(:lower) }
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
