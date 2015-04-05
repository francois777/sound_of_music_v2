require 'spec_helper'

feature 'Instrument pages' do

  include FactoryGirl::Syntax::Methods  

  context "Anonomous user visits instruments" do

    scenario "anonymous user browses list of instruments" do
      user = create(:user)
      30.times {create(:instrument, created_by: user)}
      visit instruments_path
      expect(page).to have_title('Instruments') 
      expect(page).to have_selector('h1', text: "Musical Instruments")
      expect(Instrument.all.count).to eq(30)
      expect(page).not_to have_link('New instrument', href: new_instrument_path)
      signin(user.email, 'password')
      visit instruments_path
      expect(page).to have_link('New instrument', href: new_instrument_path)
    end
  end
end