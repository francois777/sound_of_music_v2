require 'spec_helper'

feature 'Edit Instrument page' do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @category1 = FactoryGirl.create(:percussion)
    @category2 = FactoryGirl.create(:strings)
    @subcategory1 = FactoryGirl.create(:membranophone, category: @category1)
    @subcategory2 = FactoryGirl.create(:bowed, category: @category2)
    @instrument = FactoryGirl.create(:instrument, 
      name: 'Traditional Drum',
      other_names: 'Beat box',
      performer_title: 'Drummer',
      category: @category1, 
      subcategory: @subcategory1, 
      created_by: @user)

    visit root_path
    signin(@user.email, 'password')
    visit edit_instrument_path(@instrument)
  end

  # Scenario: User who created musical instrument changes all properties
  #   Given user signs in
  #   When created_by user visits edit instrument page 
  #   Then user can update the instrument
  scenario 'signed-in user edits their own instrument' do    
    expect(page).to have_title('Update instrument')

    expect( find(:css, "input#instrument_name").value ).to eq('Traditional Drum')
    expect( find(:css, "input#instrument_other_names").value ).to eq('Beat box')
    expect( find(:css, "input#instrument_performer_title").value ).to eq('Drummer')
    expect( find(:css, "select#category_select").value ).to eq(@instrument.category_id.to_s)
    expect( find(:css, "select#subcategory_select").value ).to eq(@instrument.subcategory_id.to_s)
    
    fill_in 'Name', :with => 'Piano'
    fill_in 'Other names', :with => 'Piano-Forte'
    fill_in 'Performer title', :with => 'Pianist'
    find(:css, "#category_select").set(@category2.id.to_s)
    find(:css, "#subcategory_select").set(@subcategory2.id.to_s) 
    click_button 'Save changes'
    
    expect(page).to have_content 'Musical instrument has been updated'
  end

  scenario 'signed-in user edits their own instrument incorrectly' do    
    fill_in 'Name', :with => 'Clarinet ' * 5
    click_button 'Save changes'

    expect(page).to have_content 'The musical instrument could not be updated.'
    expect(page).to have_content 'Name is too long (maximum is 40 characters)'
  end

end