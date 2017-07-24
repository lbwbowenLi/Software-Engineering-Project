require 'rails_helper'

describe Fullquestion do
    
    #Test Associations and Validations
    describe "Associations + Validations" do
        it "associations" do
          assc1 = Fullquestion.reflect_on_association(:fullsubmissions)
          assc2 = Fullquestion.reflect_on_association(:users)
          #debugger
          expect(assc1.macro).to eq :has_many 
          expect(assc2.macro).to eq :has_many
          expect(assc2.through_reflection.name).to eq :fullsubmissions
        end

        it "validations" do
        end

    end
    
    #Test Fullquestion.convert_ans
    describe "Convert DB answer string to meaningful 'Yes/No/Not Given' options" do
        it "should return correct results depending on input integers" do
           i='1'; j='2'; k='3';
           expect(Fullquestion.convert_ans(i)).to eq('Yes')   
           expect(Fullquestion.convert_ans(j)).to eq('No')
           expect(Fullquestion.convert_ans(k)).to eq('Not Given')  
           expect(Fullquestion.convert_ans('4')).to be_nil
        end
    end
    
    #Test .get_answer
    #Due to different mechanisms, the answer is given in two ways:
    #Direct way or Indirect way
    #Direct way is that the qanswer field in DB equals to '1' or '2'
    #Indirect way is that the qanswer field in DB equals to '3'
    #Each time when an answer-fetching is requested, this function will be called
    #For Direct way just convert it, for indirect way, calculate from all the
    #submissions and find out the answer.
    describe "Get answer of the fullquestion" do
        fixtures :users
        fixtures :groups
        fixtures :fullquestions
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
          
        it "Total submissions should equal to 3 at the beginning" do
            expect(Fullsubmission.all.count).to eq(3)
        end
        it "#get_answer should return corresponding answer string" do
            expect(Fullquestion.find_by_id(1).get_answer).to eq('1')            
            expect(Fullquestion.find_by_id(2).get_answer).to eq('1')
            #User operate submissions
            User.find_by_id(1).fullsubmissions.each do |submit|
               if(submit.fullquestion_id == 3) 
                   submit.update_attribute(:choice , '2')
                   submit.update_attribute(:reason , 'Not Connected')
               end
            end
            User.find_by_id(2).fullsubmissions.each do |submit|
               if(submit.fullquestion_id == 3) 
                   submit.update_attribute(:choice , '2')
                   submit.update_attribute(:reason , 'Not Connected')
               end
            end            
            User.find_by_id(3).fullsubmissions.each do |submit|
               if(submit.fullquestion_id == 3) 
                   submit.update_attribute(:choice , '2')
                   submit.update_attribute(:reason , 'Not Connected')
               end
            end                
            #Now call get_ans should return '2'---'No'
            @not_given_answer_question = Fullquestion.find_by_id(3)
            expect(Fullquestion.find_by_id(3).get_answer).to eq('2')
            
            
            #User operate submissions again
            User.find_by_id(1).fullsubmissions.each do |submit|
               if(submit.fullquestion_id == 3) 
                   submit.update_attribute(:choice , '1')
                   submit.update_attribute(:reason , 'Not Connected')
               end
            end
            User.find_by_id(2).fullsubmissions.each do |submit|
               if(submit.fullquestion_id == 3) 
                   submit.update_attribute(:choice , '1')
                   submit.update_attribute(:reason , 'Not Connected')
               end
            end            
            User.find_by_id(3).fullsubmissions.each do |submit|
               if(submit.fullquestion_id == 3) 
                   submit.update_attribute(:choice , '1')
                   submit.update_attribute(:reason , 'Not Connected')
               end
            end            
            @not_given_answer_question = Fullquestion.find_by_id(3)
            #debugger
            expect(Fullquestion.find_by_id(3).get_answer).to eq('1')           
            
            
            
            
        end
    end
end