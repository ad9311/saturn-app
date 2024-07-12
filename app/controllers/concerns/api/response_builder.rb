module Api::ResponseBuilder
  def build_response(data, status: nil, errors: nil)
    return { status:, data: } if errors.nil?

    { status:, data:, errors: }
  end

  def order_data(records, by: nil, direction: nil)
    return records if by.nil? || direction.nil?

    records.order("#{by}": direction.to_sym)
  end

  def limit_data(records, limit: nil)
    records if limit.nil?

    records.limit(limit)
  end
end
