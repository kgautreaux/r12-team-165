class SplashController < ApplicationController
  def index
    @user = User.new
  end

  def create
    @user = User.create(params[:user])

    if @user.save
      redirect_to root_path, notice: "Thanks for signing up!"
    else
      redirect_to root_path
    end
  end
end
