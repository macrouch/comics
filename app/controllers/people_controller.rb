class PeopleController < ApplicationController
  def index
  end

  def show
    @user = User.where(id: params[:user_id]).first
    @person = Person.where(id: params[:id]).first
    @issues = @user.person_appearances(@person)
  end
end
