class Api::UsersController < ApplicationController
  include Api::ResponseBuilder

  def me
    data = { user: current_user.serialized_hash }
    render json: build_response(data, status: :SUCCESS)
  end
end
