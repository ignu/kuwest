require 'machinist/active_record'

User.blueprint do
  username               { "Galvatron"         }
  email                  { "megatron1@bot.com" }
  password               { "testing123"        }
  password_confirmation  { "testing123"        }
end

Quest.blueprint do
  quest.why        { "because i want to"     }
end

Objective.blueprint do
  objective.name   { "run 1000 miles"  }
  objective.amount { 2                 }
  objective.verb   { "run"             }
  objective.noun   { "miles"           }
end

