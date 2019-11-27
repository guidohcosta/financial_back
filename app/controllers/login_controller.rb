class LoginController < ApplicationController
  before_action :authentication, only: :create

  def create
    @token = JsonWebToken.encode(user_data)
    log_data

    render json: { token: @token }
  end

  private

  def log_data
    Log.create(document: user_data.merge(params.permit).to_json)
  end

  def user_data
    { username: params.require(:user), groups: @auth['group'] }
  end

  def authentication
    @auth = AdService.authenticate(params.require(:user))
  end
end
