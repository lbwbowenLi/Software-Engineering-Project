require 'rails_helper'

describe FullquestionsHelper do
    
    
    it 'happy path' do
       #Test search_from_arrayexpress(keywords)
       
       dresponse = double("response")
       ddatahash = {"experiments" => {"experiment" =>[{"id" => 534369, "accession" => "DS1", "name" => "DS_name1"},{"id" => 543120, "accession" => "DS2", "name" => "DS_name2"}]  , "time" => '20160601'},"layouts" => "top"}
       
       
       #Stub 2 levels
       allow(Net::HTTP).to receive(:get).and_return(dresponse)
       allow(JSON).to receive(:parse).and_return(ddatahash)
            
       ideal_result = {"DS1"=>"DS_name1", "DS2"=>"DS_name2"}
       expect(helper.search_from_arrayexpress('ear')).to eql(ideal_result)
       #debugger  
    end
    it 'sad path' do
       dresponse = double("response")
       ddatahash = {"experiments" => {"total" =>0  , "time" => '20160601'},"layouts" => "top"}
       
       
       #Stub 2 levels
       allow(Net::HTTP).to receive(:get).and_return(dresponse)
       allow(JSON).to receive(:parse).and_return(ddatahash)        
       expect(helper.search_from_arrayexpress('ear')).to be_nil
        
    end
    
    
    
end