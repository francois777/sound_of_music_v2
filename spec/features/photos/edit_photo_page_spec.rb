require 'spec_helper'

feature 'Edit Photo page' do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @approver = FactoryGirl.create(:approver)
    @subject = FactoryGirl.create(:triangle, created_by: @user)
    @collection = create(:approved_instrument_article, publishable: @subject, 
      author: @user)
    visit root_path
  end

  scenario "logged-in user uploads photo" do
    # skip 'passing slow test: upload photo'
    signin(@user.email, 'password')
    visit new_article_photo_path(@collection)
    fill_in "Title", with: "My beautiful photo"
    attach_file "Photo name", Rails.root.join("spec/fixtures/tree_on_the_bank.jpg")
    click_button 'Submit photo'
    expect(page).to have_content('Photo stored successfully')

    visit edit_article_photo_path(@collection, Photo.first)
    expect(page).to have_title('Edit photo')
    fill_in "Title", with: "My beautiful photo v2"
    click_button 'Save changes'
    expect(page).to have_content('Photo updated successfully')
  end
end  
