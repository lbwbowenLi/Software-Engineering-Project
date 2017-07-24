class Fullquestion < ActiveRecord::Base
  require 'yaml'
  require 'csv'
  
  has_many :fullsubmissions
  has_many :users, :through => :fullsubmissions





  def Fullquestion.convert_ans(answer)
    
    ans = ['Yes','No','Not Given']
    
    ret = ans[answer.to_f-1]
    
    return ret

  end

  def get_answer
    t_answer=self.qanswer
    if t_answer=='3'
      all_sub_of_t_ques=self.fullsubmissions
      yes_choice=0
      all_sub_of_t_ques.each do |sub_of_t_ques|
        if sub_of_t_ques.choice=='1'
           yes_choice+=1
        else
           yes_choice-=1         
        end
      end
      if yes_choice>0
        t_answer='1'
      else
        t_answer='2'
      end
    end
    return t_answer
  end


end
