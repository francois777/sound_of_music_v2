require 'spec_helper'

feature 'New Photo page' do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @approver = FactoryGirl.create(:approver)
    @subject = FactoryGirl.create(:triangle, created_by: @user)
    @collection = create(:instrument_article, publishable: @subject, 
      author: @user, approver: @approver, approval_status: :approved)
    visit root_path
  end

  scenario "logged-in user uploads photo" do
    # skip 'Slow test: Logged-in user uploads photo'
    signin(@user.email, 'password')
    visit new_article_photo_path(@collection)

    expect(page).to have_title('New photo')
    expect(page).to have_content("#{@subject.name} picture")
    expect(page).to have_content("Theme: #{@collection.title}")
    expect(page).to have_content('Title')
    expect(page).to have_content('Image name')
    expect( find(:css, "input#photo_image_name").value ).to eq("#{@subject.name.parameterize}-#{@subject.last_image_id + 1}")
    expect(page).to have_content('Photo name')

    fill_in "Title", with: "My beautiful photo"
    attach_file "Photo name", Rails.root.join("spec/fixtures/tree_on_the_bank.jpg")
    click_button 'Submit photo'
    expect(page).to have_content('Photo stored successfully')
    expect(page).to have_selector('h1', text: "#{@subject.name} picture")
    expect(page).to have_selector('h3', text: "Theme: #{@collection.title}")
  end  
end
