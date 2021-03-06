require 'spec_helper'

feature 'New Article page' do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @approver = FactoryGirl.create(:approver)
    @instrument = FactoryGirl.create(:triangle, created_by: @user)
    @history_theme = Theme.create(subject: :instruments, name: 'History')
    @construction_theme = Theme.create(subject: :instruments, name: 'Construction')

    visit root_path
  end

  scenario 'signed-in user creates a valid article' do    
    signin(@user.email, 'password')
    visit new_instrument_article_path(@instrument)

    expect(page).to have_title('New article')
    expect(page).to have_content('New article')
    expect(page).to have_content("Article on #{@instrument.name}")

    fill_in 'Title', with: 'History of the triangle'
    select "History", from: "Theme"
    fill_in 'Article', with: 'This is the history...'
    click_button 'Create article'

    expect(page).to have_content('Article has been created')
    expect(page).to have_selector('h1', text: "Subject: Triangle")
    expect(page).to have_selector('h3', text: "History of the triangle")
  end

  scenario 'signed-in user creates article with errors' do    
    signin(@user.email, 'password')
    visit new_instrument_article_path(@instrument)

    fill_in 'Title', with: 'Arti'
    select "Construction", from: "Theme"
    fill_in 'Article', with: 'This is how...'
    click_button 'Create article'
    expect(page).to have_content 'The article could not be created.'
    expect(page).to have_content 'Title is too short (minimum is 5 characters)'
  end

  scenario 'signed-in approver successfully creates article' do 
    signin(@approver.email, 'password')
    visit new_instrument_article_path(@instrument)
    
    fill_in 'Title', with: 'The early history of triangles'
    select "Construction", from: "Theme"
    fill_in 'Article', with: 'This is how...'
    click_button 'Create article'
    expect(page).to have_content('Article has been created')
    expect(page).to have_selector('h1', text: "Subject: Triangle")
    expect(page).to have_selector('h3', text: "The early history of triangles")
  end

end