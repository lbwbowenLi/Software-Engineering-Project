module GroupsHelper
    
  def admins?
    #debugger
    user = User.find_by_id(session[:user_id])
    if !user || !user.admin?
      flash[:warning] = "Permission denied!"
      redirect_to root_path
      return
    end
  end    

#  def groupadmins?
#    user = User.find_by_id(session[:user_id])
#    if !user || !user.admin? || !user.group_admin
 #       return false
#    else
#        return true
#    end
#  end
    
end