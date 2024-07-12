class Api::UsersController < ApplicationController
  include Api::ResponseBuilder

  def me
    status = :OK
    data = { user: current_user.serialized_hash }
    response = build_response(data, status:)
    render json: response, status: :ok
  end
end
