class IssuesController < ApplicationController
  def index
  end

  def show
    @user = User.where(id: params[:user_id]).first
    @issue = @user.issues.where(id: params[:id]).first
  end
end
