require 'rails_helper'
require 'date'



describe "On the homepage, users" do
  before(:each) do
    #Create users first
    visit '/signup'
    fill_in('Email', :with => 'googlesample1@gmail.com')
    fill_in('Name', :with => 'sample1')
    fill_in('Password', :with => 'sample123')
    fill_in('Confirmation', :with => 'sample123')
    click_button('Create my account')
    #debugger
    find_link('Log out',:visible => false).click
  
  end
  it 'can sign in with correct Email and Password' do
    
    #Test Login 
    visit login_path
    fill_in :Email, :with => 'googlesample1@gmail.com'
    fill_in :Password, :with => 'sample123'
    click_button 'Log in'
    expect(page).to have_text("Hello, sample1")
  end
  
  it 'can be rejected if provide invalid credentials' do
    visit login_path
    fill_in('Email', :with => 'googlesample1@gmail.com')
    fill_in('Password', :with => 'sample321')
    click_button 'Log in'
    #debugger
    expect(page).to have_text("Invalid email/password combination")
    expect(page).to have_text("Log in")
  end
   
  it "can sign in with their Facebook Accounts" do
    #Step1: Check the login procedure
    visit '/'
    expect(page).to have_content("Sign in with Facebook")
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      'provider' => 'facebook',
      'uid' => '123545',
      'info' => {
        'name' => 'mockuser',
        #'image' => 'mock_user_thumbnail_url',
        'email' => 'mock_user_email@google.com'
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret',
        'expires_at' => DateTime.new(2018,2,3,4,5,6)
      }
    })
    click_link "Sign in with Facebook"
    #Step 2: Check the response and the User's info
    expect(page).to have_content("mockuser")  # user name
    expect(page).to have_content("Profile")
    expect(page).to have_content("Submissions")
    #Step 3: Check if the User's info is correct
    expect(User.find_by_name('mockuser').uid).to eq('123545')
    expect(User.find_by_name('mockuser').email).to eq('mock_user_email@google.com')
    expect(User.find_by_name('mockuser').provider).to eq('facebook')
    expect(User.find_by_name('mockuser').oauth_expires_at).
      to eq(DateTime.new(2018,2,3,4,5,6))
  end

  it "can be redirected to the Log in page if Facebook authenticated failed" do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    visit '/'
    expect(page).to have_content("Sign in with Facebook")
    click_link "Sign in with Facebook"
    #Failure should redirect the user to the Login page
    expect(page).to have_content('Log in')
  end

  it "can sign with their Google Accounts" do
    #Step1: Check the login procedure
    visit '/'
    expect(page).to have_content("Sign in with Google")
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      'provider' => 'google_oauth2',
      'uid' => '123545',
      'info' => {
        'name' => 'mockuser',
        #'image' => 'mock_user_thumbnail_url',
        'email' => 'mock_user_email@google.com'
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret',
        'expires_at' => DateTime.new(2017,2,3,4,5,6)
      }
    })
    click_link "Sign in with Google"
    #Step 2: Check the response and the User's info
    expect(page).to have_content("mockuser")  # user name
    expect(page).to have_content("Profile")
    expect(page).to have_content("Submissions")
    #Step 3: Check if the User's info is correct
    expect(User.find_by_name('mockuser').uid).to eq('123545')
    expect(User.find_by_name('mockuser').email).to eq('mock_user_email@google.com')
    expect(User.find_by_name('mockuser').provider).to eq('google_oauth2')
    expect(User.find_by_name('mockuser').oauth_expires_at).
      to eq(DateTime.new(2017,2,3,4,5,6))
  end

  it "can be redirected to the Log in page if Google authenticated failed" do
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
    visit '/'
    expect(page).to have_content("Sign in with Google")
    click_link "Sign in with Google"
    #Failure should redirect the user to the Login page
    expect(page).to have_content('Log in')
  end

end