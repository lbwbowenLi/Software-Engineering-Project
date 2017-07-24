require 'rails_helper'

describe ApplicationHelper do
    #Test full_title
    it 'full_title' do
       expect(helper.full_title("")).to eq("Disease Dataset Curation")
    end
end