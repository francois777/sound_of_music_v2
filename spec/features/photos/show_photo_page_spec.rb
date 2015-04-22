require 'spec_helper'

feature 'Show Photo page' do

  context 'Submitted photos' do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @other_user = FactoryGirl.create(:user)
      @approver = FactoryGirl.create(:approver)
      @instrument = FactoryGirl.create(:triangle, created_by: @user)
      @history_theme = Theme.create(subject: :instruments, name: 'History')
      @construction_theme = Theme.create(subject: :instruments, name: 'Construction')
      @approved_article = FactoryGirl.create(:approved_instrument_article, 
                  publishable: @instrument, author: @user)
      @submitted_photo = FactoryGirl.create(:submitted_article_photo, 
                  imageable: @approved_article,
                  title: "My beautiful photo",
                  image: "my_beautiful_photo.jpg",
                  submitted_by: @user
                  )
      visit root_path
    end

    scenario 'submitted user may view their own submitted photo' do
      signin(@user.email, 'password')
      visit article_photo_path(@approved_article, @submitted_photo)
      expect(page).to have_title('Photo')
      expect(page).to have_selector('h1', text: "#{@instrument.name} picture")
      expect(page).to have_selector('h3', text: "Theme: #{@approved_article.title}")
      expect(page).to have_content('My beautiful photo')
    end

    scenario 'user may view submitted photo of another user' do
      signin(@other_user.email, 'password')
      visit article_photo_path(@approved_article, @submitted_photo)
      expect(page).to have_content "This photo is not yet approved. You may not perform this action"
    end

    scenario 'approver may view any submitted photo' do
      signin(@approver.email, 'password')
      visit article_photo_path(@approved_article, @submitted_photo)
      expect(page).to have_title('Photo')
      expect(page).to have_selector('h1', text: "#{@instrument.name} picture")
      expect(page).to have_selector('h3', text: "Theme: #{@approved_article.title}")
      expect(page).to have_content('My beautiful photo')
    end

    scenario "signed-in approver may approve submitted photos" do    
      signin(@approver.email, 'password')
      visit article_photo_path(@approved_article, @submitted_photo)
      click_button 'Approve'
      expect(page).to have_content('Photo has been approved')
      expect(page).to have_title('Photo') 
    end

    scenario "signed-in approver may reject submitted photos" do    
      # skip "Debugging required"
      signin(@approver.email, 'password')
      visit article_photo_path(@approved_article, @submitted_photo)
      select "Inferior quality", from: "Rejection reason"
      click_button 'Request revision'
      expect(page).to have_content('The author is requested to revise this photo')
      expect(page).to have_title('Photo') 
    end

  end

  context 'Approved photos' do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @other_user = FactoryGirl.create(:user)
      @approver = FactoryGirl.create(:approver)
      @instrument = FactoryGirl.create(:triangle, created_by: @user)
      @history_theme = Theme.create(subject: :instruments, name: 'History')
      @construction_theme = Theme.create(subject: :instruments, name: 'Construction')
      @approved_article = FactoryGirl.create(:approved_instrument_article, 
                  publishable: @instrument, author: @user )
      @approved_photo = FactoryGirl.create(:approved_article_photo, 
                  imageable: @approved_article,
                  title: "My beautiful photo",
                  image: "my_beautiful_photo.jpg",
                  submitted_by: @user
                  )
      approval_params = Approval::APPROVED.merge( {approvable: @approved_photo, approver: @approver} )
      @approval = Approval.create( approval_params )

      visit root_path
    end

    scenario 'any user may see a submitted photo' do
      signin(@other_user.email, 'password')
      visit article_photo_path(@approved_article, @approved_photo)
      expect(page).to have_title('Photo')
      expect(page).to have_selector('h1', text: "#{@instrument.name} picture")
      expect(page).to have_selector('h3', text: "Theme: #{@approved_article.title}")
      expect(page).to have_content('My beautiful photo')
    end
  end
end  