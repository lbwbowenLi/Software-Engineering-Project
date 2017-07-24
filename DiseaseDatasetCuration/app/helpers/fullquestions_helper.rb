module FullquestionsHelper

  require 'yaml'
  require 'net/http'
  require 'json'
  
  def search_from_arrayexpress(keywords)
# Use this for formal version

    url = 'https://www.ebi.ac.uk/arrayexpress/json/v3/experiments?keywords='+keywords;
#   p url
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data_hash=JSON.parse(response)
    debugger
    if(data_hash["experiments"]["total"] == 0)
        return nil
    end
    
    data_result=Hash.new
    data_hash["experiments"]["experiment"].each {|value|
    data_result[value["accession"]]=value["name"]
    }

# Use this for debug

#    data_result=Hash.new
#    data_result["E-GEOD-57691"]="Differential gene expression in human abdominal aortic aneurysm and atherosclerosis"
#    data_result["E-MTAB-3175"]="Gene expression study in Positron Emission Tomography (PET) positive abdominal aortic aneurysms"
    return data_result
  end    
    
    
    
    
end