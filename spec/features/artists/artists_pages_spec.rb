require 'spec_helper'

feature 'New Artist page' do

  before(:each) do
    @user = FactoryGirl.create(:user)

    visit root_path
    signin(@user.email, 'password')
    visit new_artist_path
  end

  scenario 'signed-in user creates a valid artist' do    
    expect(page).to have_title('New artist')
    # fill_in 'Performer title', :with => 'Drummer'
    # fill_in 'Name', :with => 'Drums'
    # click_button 'Create new artist'
    # expect(page).to have_content 'Musical instrument has been created'
    # expect(page).to have_content 'Drums'
    # expect(page).to have_link 'Edit'
  end
end  