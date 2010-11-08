class QuestDefinitionsController < ApplicationController

  def new
    @quest_definition = QuestDefinition.new
  end

  def create
    @quest_definition = QuestDefinition.new(params[:quest_definition])
    @quest_definition.user = current_user
    if @quest_definition.save
      @quest_definition.start_quest(current_user, params[:why]).save
      flash[:notice] = "Quest Created!"
      redirect_to "/users/#{current_user.username}"
    else
      render "new"
    end
  end

  def show
    @quest = QuestDefinition.find(params[:id])
  end

end
