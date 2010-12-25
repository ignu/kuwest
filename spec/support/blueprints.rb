require 'machinist/active_record'

class Object
  def self.build(hash=nil)
    self.make_unsaved hash
  end
end

User.blueprint do
  username               { "Galvatron"         }
  email                  { "megatron1@bot.com" }
  password               { "testing123"        }
  password_confirmation  { "testing123"        }
end

Quest.blueprint do
  why        { "because i want to"     }
end

Objective.blueprint do
  name   { "run 1000 miles"  }
  amount { 2                 }
  verb   { "run"             }
  noun   { "miles"           }
end

QuestObjective.blueprint do
  amount    { 9                 }
  completed { 2                 }
  verb      { "run"             }
  noun      { "miles"           }
end

QuestDefinition.blueprint do
  user
  name          { "Kill 100 Autbots" }
  description   { "For Megatron"     }
end

Win.blueprint do
  amount      { 1          }
  noun        { "things"   }
  verb        { "actioned" }
  created_at  { Time.new   }
end
