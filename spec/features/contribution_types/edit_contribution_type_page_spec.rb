require 'spec_helper'
include ApplicationHelper

feature 'Edit ContributionType page' do

  before(:each) do
    @owner = FactoryGirl.create(:owner)
    @contribution_type = FactoryGirl.create(:tenor)
    visit root_path
    signin(@owner.email, 'password')
    visit edit_contribution_type_path(@contribution_type)
  end

  scenario 'signed-in user updates contribution type with valid details' do 
    expect(page).to have_title('Update Contribution Type')
    expect(page).to have_selector('h1', text: "Update Contribution Type")
    expect(page).to have_content('Classification')
    expect(page).to have_content('Group type')
    expect(page).to have_content('Voice type ')
    expect(page).to have_content('Definition')
    expect( find(:css, "select#classification").value ).to eq(ContributionType.classifications[@contribution_type.classification].to_s)
    expect( find(:css, "select#contribution_type_group_type").value ).to eq(ContributionType.group_types[@contribution_type.group_type].to_s)
    expect( find(:css, "textarea#contribution_type_definition").value ).to match('The tenor is the highest male voice')

    select 'Group of musicians', from: 'classification'
    select 'Choir', from: 'Group type'
    fill_in 'Definition', :with => "They sing together in beautiful harmony"
    click_button 'Save changes'

    expect(page).to have_content 'Contribution Type has been updated'
    expect( find(:css, "input#contribution_type_name").value ).to eq('Choir')
    expect( find(:css, "input#contribution_type_classification").value ).to eq('Group of musicians')
    expect( find(:css, "textarea#contribution_type_definition").value ).to match('They sing together')
  end

  scenario 'signed-in user updates contribution type with invalid details' do 
    expect(page).to have_title('Update Contribution Type')
    select 'Group of musicians', from: 'classification'
    select 'Choir', from: 'Group type'
    fill_in 'Definition', :with => "They"
    click_button 'Save changes'
    expect(page).to have_title('Update Contribution Type')
    expect(page).to have_content 'Contribution Type could not be updated'
  end

end