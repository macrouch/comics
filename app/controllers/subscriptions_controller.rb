class SubscriptionsController < ApplicationController
  before_action :set_user
  before_action :set_volume, only: [:create, :destroy]

  def index
    @issues = @user.pull_box
  end

  def create
    @user.add_subscription(@volume.cv_id)
    respond_to do |format|
      format.html { redirect_to user_volume_path(@user, @volume) }
    end
  end

  def destroy
    @user.remove_subscription(@volume.cv_id)
    respond_to do |format|
      format.html { redirect_to user_volume_path(@user, @volume) }
    end
  end

  private

  def set_user
    @user = User.where(id: params[:user_id]).first
  end

  def set_volume
    @volume = Volume.where(id: params[:id]).first
  end
end
