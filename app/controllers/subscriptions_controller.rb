class SubscriptionsController < ApplicationController
  def index
    @user = User.where(id: params[:user_id]).first
    @issues = @user.pull_box
  end
end
