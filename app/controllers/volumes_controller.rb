class VolumesController < ApplicationController
  def show
    @user = User.where(id: params[:user_id]).first
    @volume = Volume.where(id: params[:id]).first
    @issues = @user.issues_by_volume(@volume)
  end
end
