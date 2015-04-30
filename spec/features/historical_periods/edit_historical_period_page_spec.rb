require 'spec_helper'
include ApplicationHelper

feature 'Edit HistoricalPeriod page' do

  before(:each) do
    @owner = FactoryGirl.create(:owner)
    @historical_period = FactoryGirl.create(:baroque_period)
    visit root_path
    signin(@owner.email, 'password')
    visit edit_historical_period_path(@historical_period)
  end

  scenario 'signed-in owner updates historical period with correct details' do    
    expect(page).to have_title('Update Historical Period')
    expect(page).to have_selector('h1', text: "Update Historical Period")
    expect(page).to have_content('Name')
    expect(page).to have_content('From')
    expect(page).to have_content('Until')

    fill_in 'Name', :with => 'Baroque Period extended'
    fill_in 'period-from', :with => Date.new(2000,02,01)
    fill_in 'period-end', :with => Date.new(2001,2,28)
    fill_in 'historical_period_overview', :with => 'This is a longer overview'
    click_button 'Save changes'

    expect(page).to have_content 'Historical Period has been updated'
    expect(page).to have_content(@historical_period.name)
    expect( find(:css, "input#historical_period_name").value ).to eq('Baroque Period extended')

    expect(page).to have_link 'Edit'
  end
  
end    

