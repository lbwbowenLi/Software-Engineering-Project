class Dataset < ActiveRecord::Base
  serialize :Data_set, Hash
  
  validates :name,  presence: true, length: { maximum: 50 }
  
end