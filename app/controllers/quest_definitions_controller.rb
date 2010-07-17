class QuestDefinitionsController < ApplicationController

  def new
    @quest = QuestDefinition.new
  end

  def create
    require 'ap'
    ap params[:quest]
    @quest = QuestDefinition.new(params[:quest])
    @quest.user = current_user
    @quest.parse_objective
    if @quest.save 
      flash[:notice] = "Quest Created!"
      redirect_to user_show_path(curren<D-1>t_user)
    else
      render "new"
    end
  end

  def show
    @quest = QuestDefinition.find(params[:id])
  end

end
