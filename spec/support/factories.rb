require 'factory_girl'

Factory.define :user do |user|
  user.username              { "galvatron"             }
  user.email                 { "megatron1@bot.com"     }
  user.password              { "testing123"            }
  user.password_confirmation { "testing123"            }
end

Factory.define :quest do |quest|
  quest.why        { "because i want to"     }
end

Factory.define :objective do |objective|
  objective.name   { "run 1000 miles"  }
  objective.amount { 2                 }
  objective.verb   { "run"             }
  objective.noun   { "miles"           }
end

Factory.define :quest_definition do |q|
  q.name          { "Kill 100 Autbots" }
  q.description   { "For Megatron"     }
  q.user do
    Factory.build(:user)
  end
end

Factory.define :quest_definition_with_objective, :parent => :quest_definition do |q|
  q.objectives do
    [Factory.build(:objective)]
  end
end

Factory.define :quest_objective do |q|
  q.noun    { "miles" }
  q.verb    { "ran"   }
  q.amount  { 100     }
end

Factory.define :win do |win|
  win.add_attribute :amount, 1
  win.add_attribute :noun, "things"
  win.add_attribute :verb, "actioned"
  win.add_attribute :created_at, Time.new
end

