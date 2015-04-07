require 'rails_helper'

RSpec.describe 'instruments/index' do

  context "with 2 instruments" do
    before(:each) do 
      assign(:users, [
        User.create!(first_name: 'John', last_name: 'Williams', email: 'john@example.com', confirmed_at: Time.now, password: 'password', role: User.roles[:user], admin: false)
      ])
      assign(:categories, [
        Category.create!(name: 'Strings')
        ])
      assign(:subcategories, [
        Subcategory.create!(name: 'Bowed', category: Category.first)
        ])
      assign(:instruments, [
        Instrument.create!(name: 'Guitar', category: Category.where("name = ?", 'Strings').first,
         subcategory: Subcategory.where("name = ?", 'Bowed').first, performer_title: 'Harpist', created_by: User.first),
        Instrument.create!(name: 'Banjo', category: Category.where("name = ?", 'Strings').first,
         subcategory: Subcategory.where("name = ?", 'Bowed').first, performer_title: 'Harpist', created_by: User.first)
      ])
    end

    it "displays both instruments" do
      allow(view).to receive_messages(:will_paginate => nil)
      render
      page = Capybara::Node::Simple.new(rendered)

      expect(rendered).to match /Instruments/
      expect(rendered).to match /Guitar/
      expect(rendered).to match /Banjo/
    end
  end

end