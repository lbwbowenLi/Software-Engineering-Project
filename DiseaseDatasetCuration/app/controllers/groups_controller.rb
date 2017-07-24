class GroupsController < ApplicationController
    include GroupsHelper
    include AdminsHelper
    before_action :admins?
    
    def new
        @group=Group.new
    end
    
    def create
        #debugger
        @group=Group.new(group_params)
        if @group.save
            @group.users << User.find_by_id(group_params.fetch(:admin_uid))
            flash[:success] = "#{@group.name} was successfully created."
            redirect_to groups_path
        else
            render 'new'
        end
    end
    
    
    
    def index
        update_session(:page, :query, :order)
        
        
        
        if current_user.admin? 
                
            if !current_user.group_admin?      #main admin
                @all_groups = Group.all
            else 
                @all_groups = Group.where("admin_uid = ?", current_user.id)
            end
        end
        
        @all_groups = @all_groups.paginate(per_page: 2, page: params[:page])
        
        
    end
    
    def edit
        @group=Group.find(params[:id])
    end
    
    def update
        
        @group=Group.find params[:id]
        if @group.update_attributes(group_params)
            flash[:success]="#{@group.name} was successfully updated."
            redirect_to(groups_path)
        else
            render 'edit'
        end
        
    end
      
    def destroy
        #For has_and_belongs_to_many, 
        #delete and destroy are the same:
        #they cause the records in the join table to be removed.
        @group = Group.find(params[:id])
        @group.destroy
        flash[:success] = "Group '#{@group.name}' deleted."
        redirect_to(groups_path)
    end  
      
      
    def adduser
        @group=Group.find(params[:id])
        @group_users = @group.get_users
        
        if params.has_key?(:operate)
          user = User.find_by_id(params[:operate])
          if @group_users.include?(user)
            @group.users.delete(user)
            flash[:success] = "#{user.name} was successfully deleted."
          else 
            @group.users << user
            flash[:success] = "#{user.name} was successfully added."
          end
          params.delete :operate
        end
        
        @group_users = @group.get_users
        
        update_session(:page, :query, :order)
        
        @users = find_conditional_users
    
        # update user accuracy fields

        # byebug
    
        if @users == nil
          flash[:warning] = "No Results!"
        else
          # byebug
          @users = @users.paginate(per_page: 15, page: params[:page])
        end
        
    end
    
    def quickadduser
        #update_session(:page, :query, :order)
        
        
        
        @group=Group.find(params[:id])
        @group_users = @group.get_users.where.not(:id => @group.admin_uid)    
        @not_group_users = User.get_member_outside_the_group(@group)
        
        
        
        @not_group_users = @not_group_users.paginate(per_page: 40, page: params[:page])
        
    end
    def performadd

        @group=Group.find(params[:id])
        @group_users=@group.get_users.where.not(:id => @group.admin_uid)
        #debugger

        if(params.has_key?(:role_ids))
            ids=params.require(:role_ids)    
        elsif params.has_key?(:n_role_ids)
            ids=params.require(:n_role_ids)
        else
            redirect_to quick_group_add_path
            return
        end
        deleting = false
        ids.each do |id|
            user = User.find_by_id(id)
            if @group_users.include?(user)
                @group.users.delete(user)
                deleting = true
            else
                @group.users << user
            end
        end
        
        if(deleting)
            flash[:success] = "Successfully deleted #{ids.count} users from Group #{@group.name}!"
        else
            flash[:success] = "Successfully added #{ids.count} users to Group #{@group.name}!"
        end
        redirect_to quick_group_add_path(@group)
        
    end
    
    
    
       
    public
    
    def group_params
        params.require(:group).permit(:name,:description,:group_level,:admin_uid)
    end
    

end