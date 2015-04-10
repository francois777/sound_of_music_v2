require 'spec_helper'

feature 'Show Article page' do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:user)
    @approver = FactoryGirl.create(:approver)
    @instrument = FactoryGirl.create(:triangle, created_by: @user)
    @history_theme = Theme.create(subject: :instruments, name: 'History')
    @construction_theme = Theme.create(subject: :instruments, name: 'Construction')
    @submitted_article = FactoryGirl.create(:instrument_article, 
                publishable: @instrument, author: @user, approver: nil,
                approval_status: :submitted,
                rejection_reason: :not_rejected
                )
    @approved_article = FactoryGirl.create(:instrument_article, 
                publishable: @instrument, author: @user, approver: @approver,
                approval_status: :approved,
                rejection_reason: :not_rejected
                )
    visit root_path
  end

  scenario 'web site visitor may view submitted article' do
    visit instrument_article_path(@instrument, @submitted_article)
    expect(page).to have_title('Instruments')
    expect(page).to have_content('You are not allowed to view this article.')
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
    expect(page).to have_content('You are not allowed to view this article.')
  end

  scenario "signed-in approver may view all articles" do    
    signin(@approver.email, 'password')
    visit instrument_article_path(@instrument, @submitted_article)
    expect(page).to have_title('Article')
    expect(page).to have_selector('h1', text: "Subject: #{@instrument.name}")
    expect(page).to have_selector('h3', text: @submitted_article.title)
    expect(page).to have_content(@submitted_article.body)
    expect(page).to have_link('Edit')
    #puts "Approval status of this article is #{@submitted_article.approval_status}"
    expect(page).to have_selector("input[type=submit][value='Approve']")
    expect(page).to have_selector("input[type=submit][value='Request revision']")

    visit instrument_article_path(@instrument, @approved_article)
    expect(page).to have_title('Article')
    expect(page).to have_selector('h1', text: "Subject: #{@instrument.name}")
    expect(page).to have_selector('h3', text: @approved_article.title)
    expect(page).to have_content(@approved_article.body)
    expect(page).to have_link('Edit')
    expect(page).not_to have_link('Approve')
    expect(page).not_to have_link('Request Revision')
  end
end