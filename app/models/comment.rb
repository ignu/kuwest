require 'rubygems'

class Comment < ActiveRecord::Base
	belongs_to :win

	validates_presence_of :body
end
