require 'machinist/active_record'

User.blueprint do 
  username                   { "Galvatron"         }
  email                      { "megatron1@bot.com" }
  password                   { "testing123" }
  password_confirmation      { "testing123" }
end
