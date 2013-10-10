class UsersController < ApplicationController
  protect_from_forgery except: :add_issue

  def show
    @user = User.where(id: params[:id]).first
    @recent_issues = @user.issues.order(created_at: :desc).limit(10)
  end

  def add_issue
    user = User.where(token: params[:token]).first

    if user
      issue_id = params[:id]

      issue = Issue.cv_find_or_create(issue_id)

      user.issues << issue

      respond_to do |format|
        format.json { render json: { num_issues: user.issues.where(id: issue.id).size } }
      end
    else
      respond_to do |format|
        format.json { render json: { error: "User does not exist" }, status: 404 }
      end
    end
  end
end
