class UsersController < ApplicationController
  def show
    @user = User.find_by_login params[:id]
    @totals = Win.totals_for(@user)
  end
end
