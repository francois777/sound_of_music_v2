require 'rails_helper'

RSpec.describe 'instruments/new' do

  context "with 2 instruments" do
    before do 
      assign(:users, [
        User.create!(first_name: 'John', last_name: 'Williams', email: 'john@example.com', confirmed_at: Time.now, password: 'password', role: User.roles[:user], admin: false)
      ])
      assign(:categories, [
        Category.create!(name: 'Strings')
        ])
      assign(:subcategories, [
        Subcategory.create!(name: 'Bowed', category: Category.first)
        ])
    end

    it "infers the controller action" do
      expect(controller.request.path_parameters[:action]).to eq("new")
    end    

  end
end