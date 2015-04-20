require 'spec_helper'

feature 'Edit Article page' do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:user)
    @approver = FactoryGirl.create(:approver)
    @instrument = FactoryGirl.create(:triangle, created_by: @user)
    approval_params = Approval::APPROVED.merge( {approvable: @instrument, approver: @approver} )
    Approval.create( approval_params )

    @history_theme = Theme.create(subject: :instruments, name: 'History')
    @construction_theme = Theme.create(subject: :instruments, name: 'Construction')
    @submitted_article = FactoryGirl.create(:instrument_article, 
                publishable: @instrument, author: @user, approver: nil,
                approval_status: :submitted,
                rejection_reason: :not_rejected,
                theme: @construction_theme
                )
    @approved_article = FactoryGirl.create(:instrument_article, 
                publishable: @instrument, author: @user, approver: @approver,
                approval_status: :approved,
                rejection_reason: :not_rejected,
                theme: @history_theme
                )
    visit root_path
  end

  scenario 'web site visitor may not edit a submitted article' do
    visit edit_instrument_article_path(@instrument, @submitted_article)
    expect(page).to have_content('You need to sign in or sign up before continuing')
  end

  scenario 'signed-in user may not edit a submitted article of another user' do
    signin(@other_user.email, 'password')
    visit edit_instrument_article_path(@instrument, @submitted_article)
    expect(page).to have_content('This article is protected. You may not perform this action..')
  end

  scenario 'signed-in user may edit their own submitted article' do
    signin(@user.email, 'password')
    visit edit_instrument_article_path(@instrument, @submitted_article)
    expect(page).to have_title('Edit article')
    expect(page).to have_selector('h1', text: "Edit Article on #{@instrument.name}")
    expect( find(:css, "select#article_theme_id").value ).to eq(@construction_theme.id.to_s)
    expect( find(:css, "textarea#article_body").value).to eq(@submitted_article.body)

    fill_in 'Title', with: 'Modified Article'
    select "History", from: "Theme"
    fill_in 'Article', with: 'The following has changed..'
    click_button 'Save changes'
    expect(page).to have_content('Article has been updated')
  end

  scenario 'web site visitor may not edit an approved article' do
    visit edit_instrument_article_path(@instrument, @approved_article)
    expect(page).to have_content('You need to sign in or sign up before continuing')
  end

  scenario 'signed-in user may not edit a approved article of another user' do
    signin(@other_user.email, 'password')
    visit edit_instrument_article_path(@instrument, @approved_article)
    expect(page).to have_content('This article is protected. You may not perform this action..')
  end

  scenario 'signed-in user may edit their own approved article' do
    signin(@user.email, 'password')
    visit edit_instrument_article_path(@instrument, @approved_article)
    expect(page).to have_title('Edit article')
  end
end