class TransfersController < ApplicationController
  before_action :set_groups, only: :create

  def create
    log_data
    unless @groups == 'financial'
      render json: { error: 'Unauthorized' }, status: 401
    else
      @transfer = LegacyService.transfer(transfer_params)
      render json: @transfer
    end
  end

  private

  def transfer_params
    { account_id: params.require(:account_id), amount: params.require(:amount) }
  end

  def log_data
    Log.create(document: params.permit.to_json)
  end

  def set_groups
    @groups = JsonWebToken.decode(params.require(:token))[:groups]
  rescue ActionController::ParameterMissing
    render json: { error: 'Token is missing' }, status: 401
  end
end
