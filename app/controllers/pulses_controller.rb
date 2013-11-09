class PulsesController < ApplicationController
  skip_before_filter :authenticate_user!, only: :show

  before_action :set_pulse, only: [:edit, :update]

  def show
    @pulse = Pulse.find(params[:id])
  end

  def edit
  end

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

  private
    def set_pulse
      @pulse = current_user.pulse
    end

    def pulse_params
      params.require(:pulse).permit(:url, :tagline)
    end
end
