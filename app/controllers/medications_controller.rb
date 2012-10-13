class MedicationsController < ApplicationController
  before_filter :authenticate_user!

  # GET /medications
  # GET /medications.json
  def index
    @medications = current_user.medications.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @medications }
    end
  end

  # GET /medications/1
  # GET /medications/1.json
  def show
    @pass = Passbook::Pass.where(medication_id: Medication.find(params[:id])).first

    render :pkpass => @pass if @pass
  end

  # GET /medications/new
  # GET /medications/new.json
  def new
    @medication = Medication.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @medication }
    end
  end

  # GET /medications/1/edit
  def edit
    @medication = Medication.find(params[:id])
  end

  # POST /medications
  # POST /medications.json
  def create
    @medication = Medication.new(params[:medication])
    @medication.user_id = current_user.id
    @medication.pass = @medication.build_pass(pass_type_identifier: @medication.pass_type_identifier,
                                              serial_number: SerialNumberGenerator.generate,
                                              auth_token: AuthTokenGenerator.token)

    respond_to do |format|
      if @medication.save!
        format.html { redirect_to @medication, notice: 'Medication was successfully created.' }
        format.json { render json: @medication, status: :created, location: @medication }
      else
        format.html { render action: "new" }
        format.json { render json: @medication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /medications/1
  # PUT /medications/1.json
  def update
    @medication = Medication.find(params[:id])

    respond_to do |format|
      if @medication.update_attributes(params[:medication])
        format.html { redirect_to @medication, notice: 'Medication was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @medication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medications/1
  # DELETE /medications/1.json
  def destroy
    @medication = Medication.find(params[:id])
    @medication.destroy

    respond_to do |format|
      format.html { redirect_to medications_url }
      format.json { head :no_content }
    end
  end
end
