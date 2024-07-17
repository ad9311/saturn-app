module Api::ResponseBuilder
  def build_response(data, status: nil, errors: nil)
    return { data:, status: } if errors.nil?

    { data:, status:, errors: }
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
