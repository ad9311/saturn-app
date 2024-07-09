class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token

  private

  def respond_with(resource, _options)
    respond_to do |format|
      format.html do
        super
      end
      format.json do
        render json: { data: { token: request.env['warden-jwt_auth.token'], user: resource } }, status: :created
      end
    end
  end

  def respond_to_on_destroy
    respond_to do |format|
      format.html do
        redirect_to new_user_session_path
      end
      format.json do
        head :no_content
      end
    end
  end
end
