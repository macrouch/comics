class IssuesController < ApplicationController
  def show
    @user = User.where(id: params[:user_id]).first
    @issue = Issue.where(id: params[:id]).first
    @variant = Collection.where(id: params[:variant_id]).first if params[:variant_id]
  end

  def update
    @user = User.where(id: params[:user_id]).first
    @issue = Issue.where(id: params[:id]).first

    @issue.cv_update

    respond_to do |format|
      format.html { redirect_to user_issue_url(@user, @issue), notice: 'Issue updated' }
    end
  end

  def update_all
    Issue.delay.update_all
    respond_to do |format|
      format.html { redirect_to root_url, notice: "Issues updating."}
    end
  end

end
