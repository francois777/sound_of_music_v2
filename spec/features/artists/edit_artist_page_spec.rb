require 'spec_helper'
include ApplicationHelper

feature 'Edit Artist page' do

  context 'Incomplete Artists' do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @approver = FactoryGirl.create(:approver)
      @artist = Artist.create(born_on: Date.today - 38.years, 
        born_country_code: 'za',
        submitted_by: @user,
        gender: Artist.genders[:male],
        artist_names_attributes: [ { name: 'John', name_type: 0}, 
                                   { name: 'Cornelius', name_type: 1},
                                   { name: 'Peterson', name_type: 2}])
      approval_params = Approval::INCOMPLETE.merge( {approvable: @artist} )
      approval = Approval.create( approval_params )

      visit root_path
      signin(@user.email, 'password')
      visit edit_artist_path(@artist)
    end

    scenario 'signed-in user edits their own artist' do    
      expect(page).to have_title('Update Artist')
      expect( find(:css, "input#artist_artist_names_attributes_0_name").value ).to eq('John')
      expect( find(:css, "select#artist_artist_names_attributes_0_name_type").value ).to eq('0')
      expect( find(:css, "input#artist_artist_names_attributes_1_name").value ).to eq('Cornelius')
      expect( find(:css, "select#artist_artist_names_attributes_1_name_type").value ).to eq('1')
      expect( find(:css, "input#artist_artist_names_attributes_2_name").value ).to eq('Peterson')
      expect( find(:css, "select#artist_artist_names_attributes_2_name_type").value ).to eq('2')
      expect( find(:css, "input#born-on").value ).to eq(display_date(@artist.born_on))

      within("#names-group .name-1") do
        fill_in 'Name', with: 'Julian'
        select 'First name', from: 'Name type'
      end
      within("#names-group .name-2") do
        fill_in 'Name', with: 'Gregory'
        select 'Middle name', from: 'Name type'
      end
      within("#names-group .name-3") do
        fill_in 'Name', with: 'Ecclesias'
        select 'Last name', from: 'Name type'
      end
      # find(:css, "input#artist_gender_female").set(true)
      fill_in 'born-on', with: '31-12-1999'
      fill_in 'died-on', with: '28-02-2014'
      select 'Spain', from: 'Born in country'
      click_button 'Save changes'

      expect(page).to have_content('Artist has been updated')
      @artist.reload
      expect(@artist.artist_names[0].name).to eq('Julian')
      expect(@artist.artist_names[0].name_type).to eq("first_name")
      expect(@artist.artist_names[1].name).to eq('Gregory')
      expect(@artist.artist_names[1].name_type).to eq("middle_name")
      expect(@artist.artist_names[2].name).to eq('Ecclesias')
      expect(@artist.artist_names[2].name_type).to eq("last_name")
      expect(@artist.born_on).to eq(Date.new(1999, 12, 31))
      expect(@artist.died_on).to eq(Date.new(2014, 02, 28))
      expect(@artist.born_country_code).to eq('es')

    end    
  end
end