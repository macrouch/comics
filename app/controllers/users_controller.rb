class UsersController < ApplicationController
  def show
    @user = User.where(id: params[:id]).first
    @recent_issues = @user.issues.order(created_at: :desc).limit(10)
  end
end
