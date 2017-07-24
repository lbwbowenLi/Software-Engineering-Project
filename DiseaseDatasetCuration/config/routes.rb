Rails.application.routes.draw do
  
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  
  root 'sessions#new'

  # Diseases
  get 'diseases' => 'diseases#index'
  post 'diseases/import'
  # resources :diseases do
  #   collection {post :import}
  # end

  # Users
  get 'signup'  => 'users#new'
  get 'profile' => 'users#show'
  post 'profile', to: 'users#show'
  resources :users

  # Admin
  get   'admin' => 'admins#show'
  post  'admin', to: 'admins#show', as: "admins_show"
  get   'config' => 'admins#configuration'
  post  'config', to: 'admins#config_update', as: "config_update"
  get   'admin/dsstatistics' => 'admins#dsstatistics'
  get   'admin/allusers' => 'admins#allusers'
  post  'admin/allusers', to: 'admins#allusers', as: "admin_all"
  get   'admin/getcsv' => 'admins#getcsv'
  
  get   'admin/promote' => 'admins#promote'
  post  'admin/promote', to: 'admins#promote', as: "admin_pro"
  get   'admin/promotewithgroup' => 'admins#promotewithgroup'
  post  'admin/assign_admins_to_group/:id', to: 'admins#performassigngroup', as:"assign_group"  
  get   'admin/manage_group_admins_groups' => 'admins#managegrps'
  post  'admin/manage_group_admins_groups/:id', to: 'admins#rearrange', as: "rearrange_grpadmin"
  get   'admin/statistics' => 'admins#statistics'
  post  'admin/statistics', to: 'admins#statistics'
  get   'admin/managedata' => 'admins#managedata'
  post  'admin/managedata', to: 'admins#managedata'
  get   'admin/delete_in_managedata' => 'admins#delete_in_managedata'
  post  'admin/delete_in_managedata', to: 'admins#delete_in_managedata'
  # Admin Group Operations
  #get   '/admin/showgroups' => 'admins#showgroups'
  resources :groups, path: '/admin/groups'
  
  get   'groups/adduser/:id' => 'groups#adduser'
  post  'groups/adduser/:id', to: 'groups#adduser', as: "group_add"
  get   '/admin/groups/:id/quickadduser' => 'groups#quickadduser'
  post  '/admin/groups/:id/quickadduser', to: 'groups#performadd', as: "quick_group_add"  
  
  
  # Sessions
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  # Dummies
  # get    'dummie'  => 'dummie#index'
  #get 'auth/google_oauth2/callback' =>'sessions#create'
  get    'download_help'  => 'sessions#download_help'
  get    'tutorial' => 'sessions#tutorial'
  
  
  
  
  #New Stuff
  #Integrated questions
  resources :fullquestions, path: '/admin/fullquestions'
  #Integrated submissions
  resources :fullsubmissions, path: '/admin/fullsubmissions'
  
  #Search
  get   'admin/fullquestion_addquestion_s' => 'fullquestions#search'
  post  'admin/fullquestion_addquestion_s', to: 'fullquestions#performsearch', as: 'full_search'  
  get  'admin/fullquestion_addquestion_grpselect' => 'fullquestions#groupselect'
  post  'admin/fullquestion_addquestion_grpselect', to: 'fullquestions#groupselect', as: 'full_group'
  get   'fullquestion/modifyquestion' => 'fullquestions#modifyquestion'
  post  'fullquestion/modifyquestion', to: 'fullquestions#modifyquestion'
  
  
  
  
end