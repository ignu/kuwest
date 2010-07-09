ActionController::Routing::Routes.draw do |map|
  
  map.devise_for :users, :path_names=>{:sign_in => 'login', :sign_out => 'logout', :sign_up => "new"}
  map.resource :users

  map.profile   'profile',      :controller=>"users", :action =>"edit"
  map.new_user  'users/new',    :controller=>"users", :action =>"new"
  map.update    'users/update', :controller=>"users", :action =>"update", :conditions=>"post"
  map.create    'users/create', :controller=>"users", :action =>"create"
  map.top_users 'top-users',    :controller=>"users", :action =>"top"
  map.user_show 'users/:id',    :controller=>"users", :action =>"show"
  map.tos       'tos',          :controller=>"home",  :action =>"tos"
  map.about     'about',        :controller=>"home",  :action =>"about"
  map.root                      :controller=>"wins", :action=>"index"
  
  
  map.resources :followings, :only => [:create, :destroy]
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
  #map.follow 'follow', :controller => 'followings', :action => 'create'
  #map.unfollow 'unfollow', :controller => 'followings', :action => 'destroy'
end
