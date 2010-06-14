class WinViewModel
  attr_accessor :username, :body

  def initialize(hash)
     hash.each do |k,v|
       self.instance_variable_set("@#{k}", v)  ## create and initialize an instance variable for this key/value pair
     end
   end
    
  def to_win
    @user = User.find_or_create_by_username @username
    raise "Could not find user #{@username}" if @user.nil?
    amount = get_amount body
    noun = get_noun(body, amount.to_s == "1") 
    return Win.new(:amount=>amount, :noun=>noun, 
      :verb=>get_verb(body), :user=>@user)
  end
  
  def get_verb(message)
    message.first_match(/(\w+)/)
  end
  
  def get_number_string(message)
    number = message.first_match(/\w\s(one|two|three|four|five|six|seven|eight|nine|ten)/)
    case number 
      when "one" then 1
      when "two" then 2
      when "three" then 3
      when "four" then 4
      when "five" then 5
      when "six" then 6
      when "seven" then 7
      when "eight" then 8
      when "nine" then 9
      when "ten" then 10
    end
  end

  def get_noun(message, pluralize)
    units = message.first_match(/\d\s(.+)/)    
    units = message.first_match(/(?:a|one|two|three|four|five|six|seven|eight|nine|ten)\s(.+)/) if units.nil? 
    units = get_number_string(message) if units.nil?
    unless (units.nil? || units.index("(").nil?) 
      units = units[0..units.index("(") - 1].strip
    end
    return units.pluralize if pluralize
    units
  end
  
  def get_amount(message)
    return 1 unless message.match(/(\w+\sa)/).nil?
    rv = message.first_match(/(\d+.?\d?\d?)/)
    rv = get_number_string(message) if rv.nil?
    rv.to_s.rstrip
  end  
end 

class String
  def first_match regex
    result = scan regex
    if result.length > 0
      return result[0][0]
    end
    nil
  end
end
