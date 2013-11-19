class PulsesController < ApplicationController
  skip_before_filter :authenticate_user!, only: :show

  before_action :set_pulse, only: [:edit, :update]

  def show
    @pulse = Pulse.find(params[:id])
  end

  def edit
  end

  def update
    params[:pulse][:social_accounts_attributes].each do |profile_name, value|
      profile = SocialProfile.find_by(name: profile_name)
      @pulse.social_accounts.find_or_create_by(social_profile: profile).update_attributes!(handle: value[:handle])
    end
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
      params.require(:pulse).permit(:tagline, :username, :dev_title, :design_title)
    end
end
