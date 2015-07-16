class CollectedEditionsController < ApplicationController
  def show
    @user = User.where(id: params[:user_id]).first
    @collected_edition = CollectedEdition.where(id: params[:id]).first
  end

  def update
    @user = User.where(id: params[:user_id]).first
    @collected_edition = CollectedEdition.where(id: params[:id]).first

    @collected_edition.cv_update

    respond_to do |format|
      format.html { redirect_to user_collected_edition_path(@user, @collected_edition), notice: 'Issue updated' }
    end
  end

  def add_collected_edition
    user = User.where(token: params[:token]).first
    redirect_to new_user_collected_edition_id_path(user, params[:id])
  end

  def new
    @user = User.where(id: params[:user_id]).first
    @temp_collected_edition = ComicVine.find_issue(params[:id]) if params[:id]
    @cv_id = params[:id]
    @collected_edition = CollectedEdition.new
  end

  def create
    @user = User.where(id: params[:user_id]).first
    volume_id = params[:collected_edition][:volume_id_select].empty? ? params[:collected_edition][:volume_id] : params[:collected_edition][:volume_id_select]

    @collected_edition = CollectedEdition.cv_find_or_create(params[:collected_edition][:cv_id], volume_id)

    respond_to do |format|
      if @user.collected_editions << @collected_edition
        format.html { redirect_to user_collected_edition_path(@user, @collected_edition), notice: 'Collected Edition Added' }
      else
        format.html { render action: 'new' }
      end
    end
  end
end
