class PublishersController < ApplicationController
  def index
    @user = User.where(params[:user_id]).first
    @publishers = @user.publishers.sort{|a,b| a.name.downcase <=> b.name.downcase }
  end

  def show
    @user = User.where(params[:user_id]).first
    @publisher = @user.publishers.select{|publisher| publisher.id.to_s == params[:id]}.first
    @volumes = @publisher.volumes
  end
end
