class PulsesController < ApplicationController
  before_action :set_pulse, only: [:show, :edit, :update, :destroy]

  # GET /pulses
  # GET /pulses.json
  def index
    @pulses = Pulse.all
  end

  # GET /pulses/1
  # GET /pulses/1.json
  def show
  end

  # GET /pulses/new
  def new
    @pulse = Pulse.new
  end

  # GET /pulses/1/edit
  def edit
  end

  # POST /pulses
  # POST /pulses.json
  def create
    @pulse = Pulse.new(pulse_params)

    respond_to do |format|
      if @pulse.save
        format.html { redirect_to @pulse, notice: 'Pulse was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pulse }
      else
        format.html { render action: 'new' }
        format.json { render json: @pulse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pulses/1
  # PATCH/PUT /pulses/1.json
  def update
    respond_to do |format|
      if @pulse.update(pulse_params)
        format.html { redirect_to @pulse, notice: 'Pulse was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pulse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pulses/1
  # DELETE /pulses/1.json
  def destroy
    @pulse.destroy
    respond_to do |format|
      format.html { redirect_to pulses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pulse
      @pulse = Pulse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pulse_params
      params.require(:pulse).permit(:user_id, :url)
    end
end
