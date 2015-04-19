require 'spec_helper'

feature 'New Artist page' do

  before(:each) do
    @user = FactoryGirl.create(:user)
    
    visit root_path
    signin(@user.email, 'password')
    visit new_artist_path
  end

  scenario 'signed-in user creates a valid artist' do    
    # skip "cannot select individual names"
    expect(page).to have_title('New artist')
    expect(page).to have_selector('h1', text: "New artist")
    fill_in 'Name (1)', with: 'Julian'
    select 'First name', from: 'Name type (1)'
    fill_in 'Name (2)', with: 'Ecclesias'
    select 'Last name', from: 'Name type (2)'

    click_button 'Create new artist'
    expect(page).to have_content 'Artist has been submitted'
  end
end  
