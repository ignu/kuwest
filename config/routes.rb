ActionController::Routing::Routes.draw do |map|
  map.devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout', :sign_up => "new"}
  map.resource :users
  map.profile 'users/new', :controller=>"users", :action=>"new"      
  map.profile 'users/create', :controller=>"users", :action=>"create"        
  map.profile 'users/:id', :controller=>"users", :action=>"show"    
  map.root :controller=>"actions", :action=>"index" 
  map.resource :actions
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
