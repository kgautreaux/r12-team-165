class Passbook::PassesController < ApplicationController
  respond_to :json

  def log
    Rails.logger.info(params.to_yaml)
    render nothing: true, status: 200
  end

  def show
    @pass = Passbook::Pass.where(serial_number: params[:serial_number]).first

    if @pass.nil?
      respond_with status: 404
    else
      render pkpass: @pass, status: 200 if stale?(last_modified: @pass.updated_at.utc)
    end
  end
end
