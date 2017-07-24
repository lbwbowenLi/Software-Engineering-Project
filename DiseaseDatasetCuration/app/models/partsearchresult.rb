class Partsearchresult < ActiveRecord::Base
    serialize :Data_set_results, Hash
end
