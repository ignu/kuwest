class Quest < ActiveRecord::Base
  belongs_to :quest_definition
  belongs_to :user
  has_many   :quest_objectives
end
