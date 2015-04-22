require 'spec_helper'

feature 'Show Article page' do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:user)
    @approver = FactoryGirl.create(:approver)
    @instrument = FactoryGirl.create(:triangle, created_by: @user)
    @history_theme = Theme.create(subject: :instruments, name: 'History')
    @construction_theme = Theme.create(subject: :instruments, name: 'Construction')
    @submitted_article = FactoryGirl.create(:submitted_instrument_article)
    @approved_article = FactoryGirl.create(:approved_instrument_article)
    visit root_path
  end

  scenario 'web site visitor may view submitted article' do
    visit instrument_article_path(@instrument, @submitted_article)
    expect(page).to have_title('Instruments')
    expect(page).to have_content('This article is protected. You may not perform this action..')
  end

  scenario 'web site visitor may view approved article' do
    visit instrument_article_path(@instrument, @approved_article)
    expect(page).to have_title('Article')
    expect(page).to have_selector('h1', text: "Subject: #{@instrument.name}")
    expect(page).to have_selector('h3', text: @approved_article.title)
    expect(page).to have_content(@approved_article.body)
    expect(page).not_to have_link('Edit')
  end

  scenario 'signed-in user may view their own submitted article' do    
    signin(@user.email, 'password')
    visit instrument_article_path(@instrument, @submitted_article)

    expect(page).to have_title('Article')
    expect(page).to have_selector('h1', text: "Subject: #{@instrument.name}")
    expect(page).to have_selector('h3', text: @submitted_article.title)
    expect(page).to have_content(@submitted_article.body)
    expect(page).to have_link('Edit')
  end

  scenario "other user may not view user's submitted article" do    
    signin(@other_user.email, 'password')
    visit instrument_article_path(@instrument, @submitted_article)

    expect(page).to have_title('Instruments')
    expect(page).to have_content('This article is protected. You may not perform this action..')
  end

  scenario "signed-in approver may view submitted articles" do    
    signin(@approver.email, 'password')
    visit instrument_article_path(@instrument, @submitted_article)
    expect(page).to have_title('Article')
    expect(page).to have_selector('h1', text: "Subject: #{@instrument.name}")
    expect(page).to have_selector('h3', text: @submitted_article.title)
    expect(page).to have_content(@submitted_article.body)
    expect(page).to have_link('Edit')
    expect(page).to have_selector("input[type=submit][value='Approve']")
    expect(page).to have_selector("input[type=submit][value='Request revision']")
  end

  scenario "signed-in approver may approve submitted articles" do    
    signin(@approver.email, 'password')
    visit instrument_article_path(@instrument, @submitted_article)
    click_button 'Approve'
    expect(page).to have_content('Article has been approved')
    expect(page).to have_title('Article') 
  end

  scenario "signed-in approver may reject submitted articles" do    
    signin(@approver.email, 'password')
    visit instrument_article_path(@instrument, @submitted_article)
    select "Incorrect facts", from: "Rejection reason"
    click_button 'Request revision'
    expect(page).to have_content('The author is requested to revise this article')
    expect(page).to have_title('Article') 
  end

  scenario "signed-in approver may view approved articles" do    
    visit instrument_article_path(@instrument, @approved_article)
    expect(page).to have_title('Article')
    expect(page).to have_selector('h1', text: "Subject: #{@instrument.name}")
    expect(page).to have_selector('h3', text: @approved_article.title)
    expect(page).to have_content(@approved_article.body)
    #expect(page).to have_link('Edit')
    expect(page).not_to have_link('Approve')
    expect(page).not_to have_link('Request Revision')
  end
end