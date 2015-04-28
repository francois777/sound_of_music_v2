require 'spec_helper'
 
feature 'Show Instrument page' do

  context 'Submitted instruments' do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @approver = FactoryGirl.create(:approver)
      @category1 = FactoryGirl.create(:percussion)
      @category2 = FactoryGirl.create(:strings)
      @subcategory1 = FactoryGirl.create(:idiophone)
      @membranophone = FactoryGirl.create(:membranophone, category: @category1)
      @bowed_instrument = FactoryGirl.create(:bowed, category: @category2)
      @submitted_instrument = FactoryGirl.create(:submitted_instrument, 
        name: 'Traditional Drum',
        other_names: 'Beat box',
        performer_title: 'Drummer',
        category: @category1, 
        subcategory: @subcategory1, 
        created_by: @user)
      @approved_instrument = FactoryGirl.create(:approved_instrument, 
        name: 'Symbols',
        other_names: 'Loud symbols',
        performer_title: 'Percussionist',
        category: @category1, 
        subcategory: @subcategory1, 
        created_by: @user)

      visit root_path
    end

    scenario 'signed-in user may view their own submitted instrument' do    
      signin(@user.email, 'password')
      visit instrument_path(@submitted_instrument)

      expect(page).to have_title(@submitted_instrument.name)
      expect(page).to have_link('Edit')
      expect(page).not_to have_selector("input[type=submit][value='Approve']")
      expect(page).not_to have_selector("input[type=submit][value='Request revision']")
    end

    scenario 'signed-in approver may approve any submitted instrument' do    
      signin(@approver.email, 'password')
      visit instrument_path(@submitted_instrument)
      
      expect(page).to have_title(@submitted_instrument.name)
      expect(page).to have_link('Edit')
      expect(page).to have_selector("input[type=submit][value='Approve']")
      expect(page).to have_selector("input[type=submit][value='Request revision']")

      click_button 'Approve'
      expect(page).to have_content('Instrument has been approved')
      expect(page).to have_title(@submitted_instrument.name)
    end

    scenario 'signed-in approver may reject any submitted instrument' do    
      signin(@approver.email, 'password')
      visit instrument_path(@submitted_instrument)

      select "Incorrect facts", from: "Rejection reason"
      click_button 'Request revision'
      expect(page).to have_content('The author is requested to revise this instrument')
      expect(page).to have_title(@submitted_instrument.name)
    end

  end

  context 'Rejected instruments' do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @approver1 = FactoryGirl.create(:approver)
      @approver2 = FactoryGirl.create(:approver)
      @category1 = FactoryGirl.create(:percussion)
      @category2 = FactoryGirl.create(:strings)
      @subcategory1 = FactoryGirl.create(:membranophone, category: @category1)
      @subcategory2 = FactoryGirl.create(:bowed, category: @category2)
      @instrument = FactoryGirl.create(:rejected_instrument, 
        name: 'Traditional Drum',
        other_names: 'Beat box',
        performer_title: 'Drummer',
        category: @category1, 
        subcategory: @subcategory1, 
        created_by: @user)
      visit root_path
    end

    scenario 'signed-in user may view their own rejected instrument' do    
      signin(@user.email, 'password')
      visit instrument_path(@instrument)

      expect(page).to have_title(@instrument.name)
      expect(page).to have_link('Edit')
      expect(page).to have_selector("input[type=submit][value='Submit']")
      expect(page).not_to have_selector("input[type=submit][value='Approve']")
      expect(page).not_to have_selector("input[type=submit][value='Request revision']")
    end

    scenario 'signed-in approver may view any rejected instrument' do    
      signin(@approver2.email, 'password')
      visit instrument_path(@instrument)
      
      expect(page).to have_title(@instrument.name)
      expect(page).to have_link('Edit')
      expect(page).to have_selector("input[type=submit][value='Approve']")
      expect(page).to have_selector("input[type=submit][value='Request revision']")
    end

  end

  context 'Approved instruments' do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @approver1 = FactoryGirl.create(:approver)
      @approver2 = FactoryGirl.create(:approver)
      @category1 = FactoryGirl.create(:percussion)
      @category2 = FactoryGirl.create(:strings)
      @subcategory1 = FactoryGirl.create(:membranophone, category: @category1)
      @subcategory2 = FactoryGirl.create(:bowed, category: @category2)
      @instrument = FactoryGirl.create(:approved_instrument, 
        name: 'Traditional Drum',
        other_names: 'Beat box',
        performer_title: 'Drummer',
        category: @category1, 
        subcategory: @subcategory1, 
        created_by: @user)
      visit root_path
    end

    scenario 'signed-in user may view or edit their own approved instrument' do    
      signin(@user.email, 'password')
      visit instrument_path(@instrument)

      expect(page).to have_title(@instrument.name)
      expect(page).to have_link('Edit')
      expect(page).not_to have_link('Approve')
      expect(page).not_to have_link('Request revision')
    end

    scenario 'signed-in approver may edit an approved instrument' do    
      signin(@approver1.email, 'password')
      visit instrument_path(@instrument)
      
      expect(page).to have_title(@instrument.name)
      expect(page).to have_link('Edit')
      expect(page).not_to have_selector("input[type=submit][value='Approve']")
      expect(page).not_to have_selector("input[type=submit][value='Request revision']")
    end

  end

end
