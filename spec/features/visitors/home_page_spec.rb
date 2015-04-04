require 'spec_helper'

# Feature: Home page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website
feature 'Home page' do

  # Scenario: Visitor visits the home page
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I see "Sign in and Sign up"
  scenario 'visit the home page' do
    visit root_path
    expect(page).to have_link('Sign in', href: new_user_session_path)
    expect(page).to have_link('Sign up', href: new_user_registration_path)
  end

  # Scenario: User visits the home page
  #   Given I am a logged-in user
  #   When I visit the home page
  #   Then I will have links to manage my accounts or sign out
  scenario 'visit the home page' do
    pw = 'password'
    user = FactoryGirl.create(:user, password: pw)
    visit root_path
    signin(user.email, pw)
    expect(page).to have_link('Sign out', href: destroy_user_session_path)
    expect(page).to have_link('Profile', href: user_path(user))
    expect(page).to have_link('Edit account', href: edit_user_registration_path)
    expect(page).not_to have_link('Users', href: admin_users_path)
  end

  # Scenario: Owner visits the home page
  #   Given I am a logged-in owner
  #   When I visit the home page
  #   Then I will have links to manage my accounts, see other users or sign out
  scenario 'visit the home page' do
    pw = 'password'
    owner = FactoryGirl.create(:owner, password: pw)
    visit root_path
    signin(owner.email, pw)
    expect(page).to have_link('Sign out', href: destroy_user_session_path)
    expect(page).to have_link('Profile', href: user_path(owner))
    expect(page).to have_link('Edit account', href: edit_user_registration_path)
    expect(page).to have_link('Users', href: admin_users_path)
  end

end
