module Api::ResponseBuilder
  def build_response(status, data = nil, errors = nil)
    return { status:, data: } if errors.nil?

    { status:, data:, errors: }
  end
end
