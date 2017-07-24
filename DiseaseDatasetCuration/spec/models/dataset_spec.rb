require 'rails_helper'
describe Dataset do
    #Test associations and validations
    describe "Associations + Validations" do
        it "associations" do
        end
        it "validations" do
          dataset1 = Dataset.new(name: nil)
          expect(dataset1).to_not be_valid
          dataset2 = Dataset.new(name: 'E-MTAB-3425')
          expect(dataset2).to be_valid          
        end       
    end    
    #Test serialize
    describe "Serialize" do
        it '' do
           #debugger
           h = { a: 1, b: 2, c: 3 }
           @pres = Dataset.new(:name => 'E-MTAB-3425',:Data_set => h)
           @pres.save
           expect(@pres.reload.Data_set).to eql(h)
        end    
    end
end