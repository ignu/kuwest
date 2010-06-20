require 'factory_girl'

Factory.define :win do |win|
  win.add_attribute :amount, 1
  win.add_attribute :noun, "things"
  win.add_attribute :verb, "actioned"
  win.add_attribute :created_at, Time.new
end
