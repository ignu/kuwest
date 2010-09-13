require 'factory_girl'

Factory.define :user do |ba|
  ba.add_attribute :username, "galvatron"
  ba.add_attribute :email, "megatron1@bot.com"
  ba.add_attribute :password, "testing123"
  ba.add_attribute :password_confirmation, "testing123"
end

