require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
describe UsersController do

  describe "getting a non existant user" do
    
    before(:each) do
      get(:show, {:id=>"notauser"})
    end
    
    it { should respond_with(:not_found) }
    
  end
  describe "routing" do
    it "should route /users/ignu to ignu's profile" do
      params_from(:post, '/users/ignu').should == {:controller => 'users', :action => 'show', :id=>'ignu'}  
    end
  end
end
