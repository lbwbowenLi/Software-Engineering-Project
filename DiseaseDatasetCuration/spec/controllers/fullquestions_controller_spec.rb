require 'rails_helper'

describe FullquestionsController do
    
    describe " take control of user's identity" do
        fixtures :users
        fixtures :groups
        fixtures :fullquestions
        include SessionsHelper
        it "has a 200 response status code if user is admin" do
            #Mock the verifing process
            
            log_in(User.find_by_id(4))
            get :index
            expect(response.status).to eq(200)            
        end        
        it "rejects and redirect to the root page if user isn't admin" do
            log_in(User.find_by_id(5))
            get :index
            expect(response.status).to eq(302)              
            expect(response).to redirect_to(root_path)

        end
        it "responses to html format" do 
            #Mock the verifing process
            log_in(User.find_by_id(4))
            get :index        
            expect(response.content_type).to eq "text/html"
        end       
    end
    
    
    #Test .index
    describe "Index page will show all the questions that the current admin can
    manage corresponding to his/her identity." do
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
          User.find_by_id(1).fullquestions << Fullquestion.find_by_id(3)
          User.find_by_id(2).fullquestions << Fullquestion.find_by_id(3)
          User.find_by_id(3).fullquestions << Fullquestion.find_by_id(3)
        end        
        it "will show all the questions about a certain Dataset Accession" do
            log_in(User.find_by_id(4))           
            get :index, {:accession => 'E-MTAB-3175'} 
            #debugger
            expect(assigns(:accession)).to eql('E-MTAB-3175')
            expect(assigns(:name)).to eql(Fullquestion.find_by_id(3).ds_name)
            expect(assigns(:fullquestions).count).to eql(4)
        end

    end
    
    #Test .search
    describe "Admin can search website for inforamtion to add questions" do
        fixtures :users
        fixtures :groups
        fixtures :fullquestions
        include SessionsHelper
        it "offer the admin a form to fill in " do
            #Mock the verifing process
            #debugger
            log_in(User.find_by_id(4))
            get :search
            expect(assigns(:poweradmin)).to eq(User.find_by_id(4))
            expect(response.status).to eq(200)            
        end        
        it "responses to html format" do 
            #Mock the verifing process
            log_in(User.find_by_id(4))
            get :search
            expect(response).to render_template(:search)
        end       
    end    
    
    #Test .performsearch
    describe "Admin select needed Datasets on search page to move on to add 
    questions or save the selected dataset and add questions later." do
        fixtures :users
        fixtures :groups
        fixtures :fullquestions
        include SessionsHelper    
    
    
    
    
    end
    
end