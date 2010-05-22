ActionController::Routing::Routes.draw do |map|
  map.devise_for :users
  map.resource :users
  map.profile 'users/new', :controller=>"users", :action=>"new"      
  map.profile 'users/create', :controller=>"users", :action=>"create"        
  map.profile 'users/:id', :controller=>"users", :action=>"show"    
  map.root :controller=>"wins", :action=>"index" 
  map.resource :wins
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
