require 'rails_helper'


describe "To get help on answering the problems, user" do
    
    it 'can click the button (Tutorial)' do
        visit '/'
        expect(page).to have_link('Tutorial')
        click_link('Tutorial')
    end    
       
    it 'will be showed information on curation skills' do
        visit '/tutorial'
        expect(page).to have_content('Data Curation Manual')
    end
    
    it 'can be redirected back to either profile page or login page' do
        #debugger
        visit '/signup'
        fill_in('Email', :with => 'sample1@gmail.com')
        fill_in('Name', :with => 'sample1')
        fill_in('Password', :with => 'sample123')
        fill_in('Confirmation', :with => 'sample123')
        click_button('Create my account')
        find_link('Tutorial').click
        expect(page).to have_link('Back to profile...')
        
        find_link('Log out',:visible => false).click
        find_link('Tutorial').click
        expect(page).to have_link('Back to Login page...')

    end
    

    it 'can click the Download link to download manual as pdf' do
        #debugger
        visit '/tutorial'
        expect(page).to have_link('Download this tutorial as pdf')
        click_link('Download this tutorial as pdf')
        #response_headers["Content-Type"].should == "application/pdf"
        #response_headers["Content-Disposition"].should == "attachment; filename=\"Manual_on_Selection.pdf\""
        expect(response_headers["Content-Type"]).to eq("application/pdf")
        expect(response_headers["Content-Disposition"]).to eq("attachment; filename=\"Manual_on_Selection.pdf\"")
    end
end
