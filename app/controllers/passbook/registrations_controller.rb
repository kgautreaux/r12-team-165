class Passbook::RegistrationsController < ApplicationController
  respond_to :json

  def index
    # This action gets a list of passes despite its location
    @passes = Passbook::Pass.joins(:registrations)
                            .where(:registrations => {:device_library_identifier => params[:device_library_identifier]})
    @passes = @passes.where(["passes.updated_at > ?", params[:passes_updated_since]]) if params[:passes_updated_since]

    if @passes.any?
      respond_with({lastUpdated: @passes.maximum(:updated_at), serialNumbers: @passes.collect(&:serial_number)})
    else
      render nothing: true, status: 204
    end
  end

  def create
    @pass = Passbook::Pass.where(serial_number: params[:serial_number]).first
    render nothing: true, status: 404 and return if @pass.nil?

    @registration = @pass.registrations.first_or_initialize(device_library_identifier: params[:device_library_identifier])
    @registration.push_token = params[:pushToken]

    status = @registration.new_record? ? 201 : 200

    @registration.save

    render nothing: true, status: status
  end

  def destroy
    @pass = Passbook::Pass.where(serial_number: params[:serial_number]).first
    render nothing: true, status: 404 and return if @pass.nil?

    @registration = @pass.registrations.where(device_library_identifier: params[:device_library_identifier]).first
    render nothing: true, status: 404 and return if @registration.nil?

    @registration.destroy

    render nothing: true, status: 200
  end
end