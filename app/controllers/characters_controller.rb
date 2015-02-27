class CharactersController < ApplicationController
  def index
  end

  def show
    @user = User.where(id: params[:user_id]).first
    @character = Character.where(id: params[:id]).first
    @issues = @user.character_appearances(@character)
  end
end
