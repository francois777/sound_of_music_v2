require 'spec_helper'
 
feature 'Show HistoricalPeriod page' do
  include ApplicationHelper

  context "Non logged-in users" do

    before(:each) do
      @baroque_period = FactoryGirl.create(:baroque_period)
      @classical_period = FactoryGirl.create(:classical_period)
    end

    scenario 'website visitor may view all historical periods' do
      visit historical_periods_path
      expect(page).to have_title('Historical Periods')
      expect(page).to have_selector('h1', text: 'Historical Periods')
      expect(page).to have_content(@baroque_period.name)
      expect(page).to have_content(@classical_period.name)
    end

    scenario 'website visitor may view the details of a historical period' do
      visit historical_period_path(@baroque_period)
      expect(page).to have_title('Historical Period')
      expect(page).to have_selector('h1', text: @baroque_period.name)
      expect( find(:css, "input#period_from").value ).to eq(display_date(@baroque_period.period_from))
      expect( find(:css, "input#period_end").value ).to eq(display_date(@baroque_period.period_end))
    end

    scenario 'website visitor tries to view invalid historical period' do
      visit historical_period_path(99)
      expect(page).to have_title('Historical Periods')
      expect(page).to have_content('Historical Period not found')
      expect(page).to have_selector('h1', text: 'Historical Periods')
    end

    scenario 'website visitor tries to edit an existing historical period' do
      visit edit_historical_period_path(@baroque_period)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
      expect(page).to have_content('Sign in')
    end

    scenario 'website visitor tries to create a new historical period' do
      visit new_historical_period_path
      expect(page).to have_content('You need to sign in or sign up before continuing.')
      expect(page).to have_content('Sign in')
    end
  end

  context "Logged-in users" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @baroque_period = FactoryGirl.create(:baroque_period)
      @classical_period = FactoryGirl.create(:classical_period)
      visit new_user_session_path
      signin(@user.email, 'password')
    end

    scenario 'Logged-in user may view all historical periods' do
      visit historical_periods_path
      expect(page).to have_title('Historical Periods')
      expect(page).to have_selector('h1', text: 'Historical Periods')
      expect(page).to have_content(@baroque_period.name)
      expect(page).to have_content(@classical_period.name)
    end

    scenario 'Logged-in user may view the details of a historical period' do
      visit historical_period_path(@baroque_period)
      expect(page).to have_title('Historical Period')
      expect(page).to have_selector('h1', text: @baroque_period.name)
      expect( find(:css, "input#period_from").value ).to eq(display_date(@baroque_period.period_from))
      expect( find(:css, "input#period_end").value ).to eq(display_date(@baroque_period.period_end))
    end

    scenario 'Logged-in user tries to view invalid historical period' do
      visit historical_period_path(99)
      expect(page).to have_title('Historical Periods')
      expect(page).to have_content('Historical Period not found')
      expect(page).to have_selector('h1', text: 'Historical Periods')
    end

    scenario 'Logged-in user tries to edit an existing historical period' do
      visit edit_historical_period_path(@baroque_period)
      expect(page).to have_title('Historical Periods')
      expect(page).to have_content('You are not authorised to perform this action on Historical Periods.')
      expect(page).to have_selector('h1', text: 'Historical Periods')
    end

    scenario 'Logged-in user tries to create a new historical period' do
      visit new_historical_period_path
      expect(page).to have_title('Historical Periods')
      expect(page).to have_content('You are not authorised to perform this action on Historical Periods.')
      expect(page).to have_selector('h1', text: 'Historical Periods')
    end
  end

  context "Logged-in owner" do
    before(:each) do
      @owner = FactoryGirl.create(:owner)
      @baroque_period = FactoryGirl.create(:baroque_period)
      visit new_user_session_path
      signin(@owner.email, 'password')
    end

    scenario 'Logged-in owner may edit an existing historical period' do
      visit edit_historical_period_path(@baroque_period)
      expect(page).to have_title('Update Historical Period')
      expect(page).to have_selector('h1', text: 'Update Historical Period')
    end

    scenario 'Logged-in user may create a new historical period' do
      visit new_historical_period_path
      expect(page).to have_title('New Historical Period')
      expect(page).to have_selector('h1', text: 'New Historical Period')
    end
  end

end
