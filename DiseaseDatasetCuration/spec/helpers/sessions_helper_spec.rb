require 'rails_helper'

describe SessionsHelper do
   
   #Test .remember
   it '' do
   
   #Stub the created remember_token to be 1
    allow(User).to receive(:new_token).and_return(1)
    allow(User).to receive(:digest).and_return(10)
   helper.remember(User.find_by_id(4))   
    #debugger
   #Now test the cookies relevant elements
   expect(cookies.permanent.signed[:user_id]).to eq(4)
   expect(cookies.permanent[:remember_token]).to eq(1)
  end    
  
  #Test .current_user
  it ' ' do
     #authenticate by session
     session[:user_id] = 4
     helper.log_in(User.find_by_id(4))
     #debugger
     expect(helper.current_user).to eq(User.find_by_id(4))
     
     
     #authenticate by remember_token
    session[:user_id] = nil
    allow(User).to receive(:new_token).and_return(1)
    allow(User).to receive(:digest).and_return(10)
    helper.remember(User.find_by_id(4))
    dbcp = double("BCrypt::Password")
    #This one is really great, it's a two level stub
    allow(BCrypt::Password).to receive(:new).and_return(dbcp)
    allow(dbcp).to receive(:is_password?).and_return(true)
    
    expect(helper.current_user).to eq(User.find_by_id(4))
    #debugger
      
  end
    
    
end


