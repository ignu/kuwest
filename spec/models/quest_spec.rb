require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe  "Quest" do 
  let (:quest) { Quest.new({
    :name => "Quest", 
    :description => "Pretty cool quest"
  })}

  it "can save a valid quest" do 
    quest.save
    quest.id.should > 0
  end

end



