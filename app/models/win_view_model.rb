class WinViewModel
  attr_accessor :username, :body

  def initialize(hash)
     hash.each do |k,v|
       self.instance_variable_set("@#{k}", v)  ## create and initialize an instance variable for this key/value pair
     end
   end
    
  def to_win
    @user = User.find_by_username @username
    raise "Could not find user #{@username}" if @user.nil?
    return Win.new(:amount=>get_amount(body), :noun=>get_noun(body), 
      :verb=>get_verb(body), :user=>@user)
  end
  
  def get_verb(message)
    message.first_match(/(\w+)/)
  end
  
  def get_noun(message)
    units = message.first_match(/\d\s(.+)\(?/)    
    
    unless (units.nil? || units.index("(").nil?) 
      units = units[0..units.index("(") - 1].strip
    end
    units
  end
  
  def get_amount(message)
    message.first_match(/(\d+.?\d?\d?)/)
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