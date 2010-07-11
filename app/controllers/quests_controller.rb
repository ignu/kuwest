class QuestsController < ApplicationController

  def new
    @quest = Quest.new
  end

  def create
    require 'ap'
    ap params[:quest]
    @quest = Quest.new(params[:quest])
    @quest.user = current_user
    @quest.parse_objective
    if @quest.save 
      flash[:notice] = "Quest Created!"
      redirect_to user_show_path(current_user)
    else
      render "new"
    end
  end

  def show
    @quest = Quest.find(params[:id])
  end

end
