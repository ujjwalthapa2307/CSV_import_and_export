class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def import
    User.import(params[:file])
    redirect_to users_url
  end
end
