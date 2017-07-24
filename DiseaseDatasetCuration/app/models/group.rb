class Group < ActiveRecord::Base
  serialize:data_set,Array
  has_and_belongs_to_many :users
  
  
  validates :name,  presence: true, length: { maximum: 50 }
  validates :admin_uid,  presence: true
  
  def get_users
  	groupusers=self.users
  	return groupusers
  end
  
  def get_admins
  	groupadmin=self.users.where(group_admin: true).pluck(:name)
  	
  	return groupadmin    if groupadmin
  end
   
    
    
    
end
