class UsersController < ApplicationController
  def confirm_destroy; end

  def destroy
    current_user.destroy!

    redirect_to new_user_session
  end
end
