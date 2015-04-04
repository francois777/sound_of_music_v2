require 'rails_helper'

feature 'User pages' do

  include FactoryGirl::Syntax::Methods  

  context "authorised admin users" do
    before do
      admin = create(:admin)
      signin(admin.email, 'password')
    end 

    scenario "admin user views list of users" do
      10.times {create(:user)}
      visit admin_users_path
      expect(page).to have_title('All users')
      expect(page).to have_selector('h1', text: "All users")
      expect(page).to have_content(User.first.name)
      expect(User.all.count).to eq(11)
      User.delete_all
    end

  end

  context "unauthorised users" do

    scenario "non-admin user tries to view list of users" do
      user1 = create(:user, first_name: 'Firstname1', last_name: 'Lastname1', email: 'user1@example.com')
      user2 = create(:user, first_name: 'Firstname2', last_name: 'Lastname2', email: 'user2@example.com')
      visit admin_users_path
      # expect(page).to have_content("You need to sign in or sign up before continuing.")
      # sign_in user1
      # expect(page).to have_text(user1.full_name)
    end
  end
end
