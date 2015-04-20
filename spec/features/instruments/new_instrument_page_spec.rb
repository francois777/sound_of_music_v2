require 'spec_helper'

feature 'New Instrument page' do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @category = FactoryGirl.create(:percussion)
    @subcategory = FactoryGirl.create(:membranophone, category: @category)

    visit root_path
    signin(@user.email, 'password')
    visit new_instrument_path
  end

  scenario 'signed-in user creates a valid instrument' do    
    expect(page).to have_title('New instrument')
    fill_in 'Performer title', :with => 'Drummer'
    fill_in 'Name', :with => 'Drums'
    click_button 'Create new instrument'
    expect(page).to have_content 'Musical instrument has been created'
    expect(page).to have_content 'Drums'
    expect(page).to have_link 'Edit'
  end

  # scenario 'signed-in user provides incomplete instrument details' do    
  #   expect(page).to have_title('New instrument')
  #   click_button 'Create new instrument'
  #   expect(page).to have_content 'The musical instrument could not be created.'
  #   expect(page).to have_content 'Name is too short (minimum is 3 characters)'
  #   expect(page).to have_content "Performer title can't be blank"
  # end
end