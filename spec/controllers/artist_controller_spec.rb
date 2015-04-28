require 'spec_helper'

describe ArtistsController do
  include Features::SessionHelpers

  context "Non logged-in users" do

    describe "No artists exist" do
      before do
        get :index
      end

      it { should respond_with 200 }
    end

    describe "Only approved artists exist" do
      before do
        2.times { FactoryGirl.create(:approved_artist) }
        get :index
      end

      it { should respond_with 200 }
    end

    describe "No artists have been approved yet" do
      before do
        FactoryGirl.create(:submitted_artist)
        get :index
      end

      it { should respond_with 200 }
    end
  end

  context "Logged-in users" do

    before do
      @user = FactoryGirl.create(:user)
    end  

    describe "No artists exist" do
      before do
        visit new_user_session_path
        signin(@user.email, 'password')
        get :index
      end

      it { should respond_with 200 }
    end

    describe "Only approved artists exist" do
      before do
        2.times { FactoryGirl.create(:approved_artist) }
        visit new_user_session_path
        signin(@user.email, 'password')
        get :index
      end

      it { should respond_with 200 }
    end

    describe "No artists have been approved yet" do
      before do
        FactoryGirl.create(:submitted_artist)
        visit new_user_session_path
        signin(@user.email, 'password')
        get :index
      end

      it { should respond_with 200 }
    end
  end

  context "Logged-in approvers" do

    before do
      @user = FactoryGirl.create(:approver)
    end  

    describe "No artists exist" do
      before do
        visit new_user_session_path
        signin(@user.email, 'password')
        get :index
      end

      it { should respond_with 200 }
    end

    describe "Only approved artists exist" do
      before do
        2.times { FactoryGirl.create(:approved_artist) }
        visit new_user_session_path
        signin(@user.email, 'password')
        get :index
      end

      it { should respond_with 200 }
    end

    describe "No artists have been approved yet" do
      before do
        FactoryGirl.create(:submitted_artist)
        visit new_user_session_path
        signin(@user.email, 'password')
        get :index
      end

      it { should respond_with 200 }
    end
  end
end
