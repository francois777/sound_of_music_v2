require 'spec_helper'
include ApplicationHelper

feature 'New ContributionType page' do

  before(:each) do
    @owner = FactoryGirl.create(:owner)
    visit root_path
    signin(@owner.email, 'password')
    visit new_contribution_type_path
  end

  scenario 'signed-in user creates a valid historical period' do    
    expect(page).to have_title('New Contribution Type')
    expect(page).to have_selector('h1', text: "New Contribution Type")
    expect(page).to have_content('Classification')
    expect(page).to have_content('Group type')
    expect(page).to have_content('Voice type')

    select 'Vocalist', from: 'classification'
    select 'Alto', from: 'Voice type'
    fill_in 'Definition', :with => 'This is what Alto means'
    click_button 'Create new Contribution Type'

    expect(page).to have_content 'Contribution Type has been created'
    expect( find(:css, "input#contribution_type_name").value ).to eq('Alto voice')
    expect( find(:css, "input#contribution_type_classification").value ).to eq('Vocalist')
    expect( find(:css, "textarea#contribution_type_definition").value ).to eq('This is what Alto means')
  end

  scenario 'signed-in user creates an invalid historical period' do
    expect(page).to have_title('New Contribution Type')
    select 'Composer', from: 'classification'
    click_button 'Create new Contribution Type'
    expect(page).to have_content 'Contribution Type could not be created'
    expect(page).to have_title('New Contribution Type')
  end 

end