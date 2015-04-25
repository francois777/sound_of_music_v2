require 'spec_helper'

feature 'Edit Article page' do

  context "Editing incomplete article" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @other_user = FactoryGirl.create(:user)
      @approver = FactoryGirl.create(:approver)
      @article = FactoryGirl.create(:incomplete_instrument_article, author: @user)
      @publishable = @article.publishable
      @second_theme = create(:instrument_theme, name: 'Technique')
      visit root_path
    end

    scenario 'signed-in user sees the article details of their own article' do    
      signin(@user.email, 'password')
      visit edit_instrument_article_path(@publishable, @article)
      title = "Edit Article on #{@publishable.name}"
      expect(page).to have_content(title)
      expect(page).to have_selector('h1', text: title)
      expect( find(:css, "select#article_theme_id").value ).to eq(@article.theme.id.to_s)
      expect( find(:css, "textarea#article_body").value ).to eq(@article.body)
    end

    scenario 'signed-in user changes their own article details' do
      signin(@user.email, 'password')
      visit edit_instrument_article_path(@publishable, @article)
      fill_in 'Title', with: 'New Title for article'
      select 'Technique', from: 'Theme'
      fill_in 'Article', with: 'New article body'
      click_button 'Save changes'

      expect(page).to have_content('Article has been updated.')
      @article.reload
      expect(page).to have_content('Article')
      expect(@article.title).to eq('New Title for article')
      expect(@article.theme.name).to eq('Technique')
      expect(@article.body).to eq('New article body')
    end

    scenario 'signed-in user incorrectly changes their own article details' do
      signin(@user.email, 'password')
      visit edit_instrument_article_path(@publishable, @article)
      fill_in 'Title', with: 'Short Ti'
      select 'Technique', from: 'Theme'
      fill_in 'Article', with: 'New article body'
      click_button 'Save changes'

      expect(page).to have_content('Article could not be updated.')
      title = "Edit Article on #{@publishable.name}"
      expect(page).to have_content(title)
    end

  end

  context "Editing a submitted article" do
  end

  context "User edits rejected article" do
  end

  context "Appropriate access to edit article page" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @other_user = FactoryGirl.create(:user)
      @approver = FactoryGirl.create(:approver)
      @instrument = FactoryGirl.create(:triangle, created_by: @user)
      @history_theme = Theme.create(subject: :instruments, name: 'History')
      @construction_theme = Theme.create(subject: :instruments, name: 'Construction')
      @submitted_article = FactoryGirl.create(:submitted_instrument_article, 
          publishable: @instrument, author: @user, theme: @construction_theme)
      @approved_article = FactoryGirl.create(:approved_instrument_article, 
          publishable: @instrument, author: @user, theme: @history_theme)
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

end