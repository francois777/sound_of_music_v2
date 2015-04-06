require 'rails_helper'

RSpec.feature 'Instrument pages', :type => :feature do

  scenario "anonymous user browses list of instruments" do
    skip 'Replaced by index.html.slim_spec.rb'
    user = create(:user)
    puts "Before test: #{Instrument.count}"
    puts "User: #{user.name}"
    # 30.times {create(:instrument, created_by: user)}
    instr = FactoryGirl.create(:instrument, name: 'Guitar', created_by: user)
    puts "#{Instrument.count} are loaded"
    visit instruments_path
    expect(page).to have_title('Instruments') 
    # expect(page).to have_selector('h1', text: "Musical Instruments")
    # expect(page).not_to have_link('New instrument', href: new_instrument_path)

    # Instrument.page(1).each do |instrument|
    #   puts instrument.name
    #   # expect(page).to have_content(instrument.name)
    # end

    # signin(user.email, 'password')
    # visit instruments_path
  end
end