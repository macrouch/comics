class UsersController < ApplicationController
  protect_from_forgery except: [:add_issue, :add_subscription, :remove_subscription, :volume_subscribed]
  skip_before_filter :is_logged_in, only: [:get_number_of_issues, :get_username,
                                            :add_issue, :add_variant,
                                            :add_subscription, :remove_subscription, :volume_subscribed]
  before_action :set_user, only: [:get_number_of_issues, :get_username,
                                            :add_issue, :add_variant,
                                            :add_subscription, :remove_subscription, :volume_subscribed]

  def show
    @user = User.where(id: params[:id]).first
    # @recent_issues = @user.issues.order(created_at: :desc).limit(10)
    @recent_collections = @user.collections.order(created_at: :desc).limit(10)
    @publishers = @user.publishers.sort{|a,b| a.name.downcase <=> b.name.downcase }
    @top_volumes = @user.top_volumes
    @total_volumes = @publishers.map{ |p| p.volumes.size }.inject(:+)
  end

  def token
    @user = @current_user
  end

  def get_new_token
    @user = @current_user
    @user.new_token

    respond_to do |format|
      format.json { render json: { token: @user.token } }
    end
  end

  def get_username
    if @user
      respond_to do |format|
        format.json { render json: { username: @user.name } }
      end
    else
      respond_to do |format|
        format.json { render json: { error: 'User not found.' } }
      end
    end
  end

  def get_number_of_issues
    num_issues = @user.issues.where(cv_id: params[:issue_id]).size

    respond_to do |format|
      format.json { render json: { number: num_issues } }
    end

  end

  def volume_subscribed
    result = @user.is_subscribed?(params[:volume_id])

    respond_to do |format|
      format.json { render json: { result: result } }
    end
  end

  def add_existing_issue
    user = User.where(id: params[:user_id]).first
    issue = Issue.where(id: params[:id]).first

    respond_to do |format|
      if user.issues << issue
        format.html { redirect_to user_issue_path(user, issue), notice: 'Issue added to your collection' }
      else
        format.html { redirect_to user_issue_path(user, issue), error: 'Issue could not be added to your collection' }
      end
    end
  end

  def add_issue
    if @user
      issue_id = params[:id]

      issue = @user.add_issue(issue_id)

      respond_to do |format|
        format.json { render json: { num_issues: @user.issues.where(id: issue.id).size } }
      end
    else
      respond_to do |format|
        format.json { render json: { error: "User does not exist" }, status: 404 }
      end
    end
  end

  def add_variant
    if @user
      issue_id = params[:id]
      image_url = params[:image]
      name = params[:name]

      collection = @user.add_variant(issue_id, image_url, name)

      respond_to do |format|
        format.json { render json: { num_issues: @user.collections.where(issue_id: collection.issue_id).size } }
      end
    else
      respond_to do |format|
        format.json { render json: { error: "User does not exist" }, status: 404 }
      end
    end
  end

  def add_subscription
    if @user
      volume_id = params[:id]

      status = @user.add_subscription(volume_id)

      respond_to do |format|
        if status
          format.json { render json: { result: "Success" }, status: :ok }
        else
          format.json { render json: { result: "Failed" }, status: :internal_server_error }
        end
      end
    else
      respond_to do |format|
        format.json { render json: { error: "User does not exist" }, status: 404 }
      end
    end
  end

  def remove_subscription
    if @user
      volume_id = params[:id]

      status = @user.remove_subscription(volume_id)

      respond_to do |format|
        if status
          format.json { render json: { result: "Success" }, status: :ok }
        else
          format.json { render json: { result: "Failed" }, status: :internal_server_error }
        end
      end
    else
      respond_to do |format|
        format.json { render json: { error: "User does not exist" }, status: 404 }
      end
    end

  end

  private

  def set_user
    @user = User.where(token: params[:token]).first
  end
end
