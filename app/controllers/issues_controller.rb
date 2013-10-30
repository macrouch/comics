class IssuesController < ApplicationController
  def show
    @user = User.where(id: params[:user_id]).first
    @issue = @user.issues.where(id: params[:id]).first
    @collection = Collection.where(id: params[:variant_id]).first if params[:variant_id]
  end
end
