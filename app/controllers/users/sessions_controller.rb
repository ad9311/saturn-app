class Users::SessionsController < Devise::SessionsController
  include Api::ResponseBuilder

  private

  def respond_with(resource, _options)
    status = :SUCCESS
    data = { authToken: request.env['warden-jwt_auth.token'], user: resource.serialized_hash }
    response = build_response(data, status:)
    render json: response, status: :created
  end

  def respond_to_on_destroy
    head :no_content
  end
end
