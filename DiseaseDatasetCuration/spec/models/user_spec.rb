require 'rails_helper'
require 'date'
describe User do
    
    #test User.new_token
    describe ".new_token" do
       it '' do
          allow(SecureRandom).to receive(:urlsafe_base64).and_return(1)
           
          expect(User.new_token).to eq(1)
       end
    end
    
    
    #test .remember
    describe ".remember" do
        fixtures :users
       it '' do
           
           allow(User).to receive(:new_token).and_return(1)
           allow(User).to receive(:digest).and_return(10)

           User.find_by_id(4).remember
           #debugger
           expect(User.find_by_id(4).remember_digest).to eq(User.digest(10).to_s)
       end
    end
    
    #test .authenticated?
    describe ".authenticated?" do
        fixtures :users
       it 'sad path' do
           expect(User.find_by_id(1).authenticated?(111)).to eq(false)
       end
       it 'happy path' do
           allow(User).to receive(:new_token).and_return(1)
           allow(User).to receive(:digest).and_return(10)

           User.find_by_id(4).remember
           
            dbcp = double("BCrypt::Password")
            allow(BCrypt::Password).to receive(:new).and_return(dbcp)
            allow(dbcp).to receive(:is_password?).and_return(true)           
           
           #debugger
           expect(User.find_by_id(4).authenticated?(1)).to eq(true)
           p  ' '
       end
       
       
       
    end    
    #test .forget
    describe ".forget" do
       fixtures :users
       it ' ' do
           #debugger
           allow(User).to receive(:new_token).and_return(1)
           allow(User).to receive(:digest).and_return(10)
           
           User.find_by_id(4).remember
           User.find_by_id(4).forget

           expect(User.find_by_id(4).remember_digest).to be_nil
           
       end
    end     
    
    #test User.get_member_outside_the_group(grp)
    describe ".get_member_outside_the_group" do
        fixtures :users
        fixtures :groups
        before(:each) do
          User.find_by_id(1).groups << Group.find_by_id(1)
          User.find_by_id(2).groups << Group.find_by_id(2)
          User.find_by_id(3).groups << Group.find_by_id(3)
        end        
        it ' ' do
        #debugger
           grp = Group.find_by_id(1)
           expect(User.get_member_outside_the_group(grp).count).to eq(4)
        end
    end
    
    #test .get_submission_info
    describe ".get_submission_info" do
        fixtures :users
        fixtures :groups
        fixtures :fullquestions
        include SessionsHelper
        before(:each) do
          #Group operations    
          User.find_by_id(1).groups << Group.find_by_id(1)
          User.find_by_id(2).groups << Group.find_by_id(2)
          User.find_by_id(3).groups << Group.find_by_id(3)
          #Question distributions 
          User.find_by_id(1).fullquestions << Fullquestion.find_by_id(4)
          User.find_by_id(1).fullquestions << Fullquestion.find_by_id(3)
          User.find_by_id(1).fullquestions << Fullquestion.find_by_id(2)
          User.find_by_id(1).fullquestions << Fullquestion.find_by_id(1)
          User.find_by_id(2).fullquestions << Fullquestion.find_by_id(3)
          User.find_by_id(3).fullquestions << Fullquestion.find_by_id(3)
        end    
        it 'statistics User submissions ' do

            User.find_by_id(1).fullsubmissions.each do |submit|
               if submit.fullquestion_id == 1
                   submit.update_attribute(:choice,'1')
                   elsif submit.fullquestion_id == 2
                   submit.update_attribute(:choice,'1')    
               end
            end
            result = User.find_by_id(1).get_submission_info
            #debugger            
            expect(result["user_id"]).to eq(1)
            expect(result["user_email"]).to eq("test1@gmail.com")
            expect(result["user_name"]).to eq("u1")
            expect(result["submission"]).to eq(2)
            expect(result["correct"]).to eq(2)
            expect(result["accuracy"]).to eq(1.0)
        end
       
    end
    
    


    #test User.from_omniauth(auth)
    describe "#from_omniauth" do
          auth_hash = OmniAuth::AuthHash.new({
          'provider' => 'facebook',
          'uid' => '123545',
          'info' => {
            'name' => 'mockuser',
            #'image' => 'mock_user_thumbnail_url',
            'email' => 'mock_user_email@google.com'
          },
          'credentials' => {
            'token' => 'mock_token',
            'secret' => 'mock_secret',
            'expires_at' => DateTime.new(2018,2,3,4,5,6)
          }
        })   
        
       it "retrieves an existing user" do
            #debugger
            user = User.new(
                :provider => "facebook", 
                :uid => '123545',
                :email => "mock_user_email@google.com",
                :password => 'test123123', 
                :password_confirmation => 'test123123',
                :name => 'mockuser',
                :oauth_token => 'mock_token',
                :oauth_expires_at => DateTime.new(2018,2,3,4,5,6)
                )
            user.save
            omniauth_user = User.from_omniauth(auth_hash)
            expect(user).to eq(omniauth_user)
      end
      it "creates a new user if one doesn't already exist" do
        expect(User.count).to eq(5)
        User.from_omniauth(auth_hash)
        expect(User.count).to eq(6)
      end
    end        
        
        
        

    
    
    
    
    
end