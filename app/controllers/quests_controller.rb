class QuestsController < ApplicationController
  def new
    @quest = Quest.new
  end

  def create
    @quest = Quest.create {params[:quest]}
    if @quest.save 
      redirect_to "/users/#{current_user.username}"
    else
      render "new"
    end
  end

end
