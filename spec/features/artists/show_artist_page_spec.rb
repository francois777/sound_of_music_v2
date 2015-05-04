require 'spec_helper'

feature 'Show Artist page' do

  context 'Incomplete Artists' do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @approver = FactoryGirl.create(:approver)
      historical_period = create(:classical_period)
      @artist = Artist.create(born_on: Date.today - 38.years, 
        born_country_code: 'za',
        submitted_by: @user,
        historical_period: historical_period,
        artist_names_attributes: [ { name: 'John', name_type: 0}, 
                                   { name: 'Cornelius', name_type: 1},
                                   { name: 'Peterson', name_type: 2}])
      visit root_path
    end

    scenario 'non-signed-in user may not view artists with an incomplete status' do
      approval_params = Approval::INCOMPLETE.merge( {approvable: @artist} )
      Approval.create( approval_params )
      visit artist_path(@artist)
      expect(page).to have_content('This artist is not yet approved. You may not perform this action.')
    end

    scenario 'signed-in other user may not view artists with an incomplete status' do
      approval_params = Approval::INCOMPLETE.merge( {approvable: @artist} )
      Approval.create( approval_params )
      @other_user = FactoryGirl.create(:user)
      signin(@other_user.email, 'password')
      visit artist_path(@artist)
      expect(page).to have_content('This artist is not yet approved. You may not perform this action.')
    end

    scenario 'signed-in approver may view any submitted artist' do    
      approval_params = Approval::SUBMITTED.merge( {approvable: @artist} )
      approval = Approval.create( approval_params )

      signin(@approver.email, 'password')
      visit artist_path(@artist)
      expect(page).to have_title('Artist details')
      expect(page).to have_content(@artist.assigned_name)
      expect(page).to have_selector("input[type=submit][value='Approve']")
      expect(page).to have_selector("input[type=submit][value='Request revision']")
    end
  end

  context 'Submitted Artists' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @approver = FactoryGirl.create(:approver)
      historical_period = create(:classical_period)
      @artist = Artist.create(born_on: Date.today - 38.years, 
        born_country_code: 'za',
        submitted_by: @user,
        historical_period: historical_period,
        artist_names_attributes: [ { name: 'John', name_type: 0}, 
                                   { name: 'Cornelius', name_type: 1},
                                   { name: 'Peterson', name_type: 2}])
      approval_params = Approval::SUBMITTED.merge( {approvable: @artist} )
      @approval = Approval.create( approval_params )
      visit root_path
    end

    scenario 'signed-in user may view their own submitted artist' do    
      signin(@user.email, 'password')
      visit artist_path(@artist)

      expect(page).to have_title('Artist details')
      expect(page).to have_content(@artist.assigned_name)
      expect(page).to have_link('Edit')

      expect(page).not_to have_selector("input[type=submit][value='Approve']")
      expect(page).not_to have_selector("input[type=submit][value='Request revision']")
    end

    scenario 'signed-in other user may not view artists with a submitted status' do
      @other_user = FactoryGirl.create(:user)
      signin(@other_user.email, 'password')
      visit artist_path(@artist)
      expect(page).to have_content('This artist is not yet approved. You may not perform this action.')
    end

    scenario 'signed-in approver may view and approve any submitted artist' do    
      signin(@approver.email, 'password')
      visit artist_path(@artist)
      expect(page).to have_title('Artist details')
      expect(page).to have_content(@artist.assigned_name)
      expect(page).to have_selector("input[type=submit][value='Approve']")
      expect(page).to have_selector("input[type=submit][value='Request revision']")

      click_button 'Approve'
      expect(page).to have_content('Artist has been approved')
      expect(page).to have_title('Artist details') 
    end

    scenario 'signed-in approver may view and reject any submitted artist' do    
      signin(@approver.email, 'password')
      visit artist_path(@artist)
      expect(page).to have_title('Artist details')
      expect(page).to have_content(@artist.assigned_name)
      expect(page).to have_selector("input[type=submit][value='Approve']")
      expect(page).to have_selector("input[type=submit][value='Request revision']")

      select "Irrelevant material", from: "Rejection reason"
      click_button 'Request revision'
      expect(page).to have_content('The author is requested to revise this artist')
      expect(page).to have_title('Artist details') 
    end
  end

  context 'Rejected Artists' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @approver = FactoryGirl.create(:approver)
      historical_period = create(:classical_period)
      @artist = Artist.create(born_on: Date.today - 38.years, 
        born_country_code: 'za',
        submitted_by: @user,
        historical_period: historical_period,
        artist_names_attributes: [ { name: 'John', name_type: 0}, 
                                   { name: 'Cornelius', name_type: 1},
                                   { name: 'Peterson', name_type: 2}])
      approval_params = Approval::REJECTED.merge( {approvable: @artist, approver: @approver, rejection_reason: :incorrect_facts} )
      @approval = Approval.create( approval_params )
      visit root_path
    end

    scenario 'signed-in user may view their own rejected artist' do    
      signin(@user.email, 'password')
      visit artist_path(@artist)

      expect(page).to have_title('Artist details')
      expect(page).to have_content(@artist.assigned_name)
      expect(page).to have_link('Edit')
      expect(page).to have_selector("input[type=submit][value='Submit']")
      expect(page).not_to have_selector("input[type=submit][value='Approve']")
      expect(page).not_to have_selector("input[type=submit][value='Request revision']")
    end
  end
end  