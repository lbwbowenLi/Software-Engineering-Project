require 'rails_helper'

describe Group do
    #Test associations and validations
    describe "Associations + Validations" do
        it "associations" do
          assc1 = Group.reflect_on_association(:users) 
          expect(assc1.macro).to eq :has_and_belongs_to_many 
        end
        it "validations" do
          grp1 = Group.new(name: nil)
          expect(grp1).to_not be_valid
          grp2 = Group.new(name: 'grp2')
          expect(grp2).to_not be_valid
          grp3 = Group.new(name: 'grp3', admin_uid: 1)
          expect(grp3).to be_valid          
        end       
    end

    #Test function .get_users    
    describe "finding users of the group" do 
        fixtures :users
        fixtures :groups
        before(:each) do
          User.find_by_id(1).groups << Group.find_by_id(1)
          User.find_by_id(2).groups << Group.find_by_id(2)
          User.find_by_id(3).groups << Group.find_by_id(3)
        end
        #Happy Path
        it "returns the group users if there are users found." do
            @grp1=Group.find_by_id(1)
            @has_user = false
            @grp1.get_users.each do |user|
            #ActiveRecord::Associations::CollectionProxy
                user.groups.to_a.each do |grp|
                    #Test if all the returned user's group name is "G1"
                    #which is desired.
                    if(grp.name == "G1")
                        @has_user = true
                    else
                        @has_user = false
                    end
                end
                expect(@has_user).to eq(true)
            end
        end
        #Sad Path
        it "returns empty collection set if no user in the group" do
            @grp4=Group.find_by_id(4) 
            expect(@grp4.get_users.count).to eq(0)   
        end
    end
    #Test function .get_admins    
    describe "finding admins of the group" do
        fixtures :users
        fixtures :groups
        before(:each) do
          User.find_by_id(1).groups << Group.find_by_id(1)
          User.find_by_id(2).groups << Group.find_by_id(2)
          User.find_by_id(3).groups << Group.find_by_id(3)
        end        
        #Happy Path
        it "returns the group admins if there are such admins. For now,
        we assume there's only one group_admin in each group." do        
            @grp1=Group.find_by_id(1)
            @has_user = false
            expect(@grp1.get_admins.count).to eq(1)
            expect(@grp1.get_admins.first).to eq(User.find_by_id(@grp1.admin_uid).name)
            #ActiveRecord::Associations::CollectionProxy
        end
        #Sad Path
        it "returns empty collection set if no such admin in the group" do
            @grp4=Group.find_by_id(4) 
            expect(@grp4.get_admins.count).to eq(0)   
        end        
    end
end   