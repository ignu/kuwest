class QuestDefinitionsController < ApplicationController

  def new
    @quest_definition = QuestDefinition.new
  end

  def create
    @quest_definition = QuestDefinition.new(params[:quest_definition])
    @quest_definition.user = current_user
    @quest_definition.parse_objective
    @quest_definition.start_quest(current_user, params[:why])
    if @quest_definition.save 
      flash[:notice] = "Quest Created!"
      redirect_to user_show_path(current_user)
    else
      render "new"
    end
  end

  def show
    @quest = QuestDefinition.find(params[:id])
  end

end
