require 'spec_helper'
include ApplicationHelper

feature 'New HistoricalPeriod page' do

  before(:each) do
    @owner = FactoryGirl.create(:owner)
    visit root_path
    signin(@owner.email, 'password')
    visit new_historical_period_path
  end

  scenario 'signed-in user creates a valid historical period' do    
    expect(page).to have_title('New Historical Period')
    expect(page).to have_selector('h1', text: "New Historical Period")
    expect(page).to have_content('Name')
    expect(page).to have_content('From')
    expect(page).to have_content('Until')

    fill_in 'Name', :with => 'Baroque Period'
    fill_in 'period-from', :with => Date.new(2000,01,01)
    fill_in 'period-end', :with => Date.new(2000,12,31)
    fill_in 'historical_period_overview', :with => 'This is an overview'
    click_button 'Create new Historical Period'

    expect(page).to have_content 'Historical Period has been created'
    expect(page).to have_content 'Baroque Period'
    expect(page).to have_link 'Edit'
  end

  scenario 'signed-in user creates invalid historical period' do  
    fill_in 'Name', :with => 'Baroque Period'
    fill_in 'period-from', :with => Date.new(2002,01,01)
    fill_in 'period-end', :with => Date.new(2000,12,31)
    fill_in 'historical_period_overview', :with => 'This is an overview'
    click_button 'Create new Historical Period'

    expect(page).to have_content 'The Historical Period could not be created'
    expect(page).to have_title('New Historical Period')
  end  

end    

