require 'spec_helper'

# Resources: https://www.relishapp.com/rspec/rspec-rails/docs/matchers/redirect-to-matcher
describe ArtistsController do

  context "Non logged-in users" do

    describe "No artists exist" do
      before do
        get :index
      end

      it { should respond_with 200 }
    end

    describe "Only approved artists are displayed to visitors" do
      before do
        @artist1 = FactoryGirl.create(:approved_artist)
        @artist2 = FactoryGirl.create(:approved_artist)
        @artist3 = FactoryGirl.create(:submitted_artist)
        @artist4 = FactoryGirl.create(:rejected_artist)
      end

      it "populates an array of artists" do
        get :index
        expect( assigns(:artists) ).to include(@artist1)
        expect( assigns(:artists) ).to include(@artist2)
        expect( assigns(:artists).count ).to eq(2)
      end  
    end

    describe "No artists have been approved yet" do
      before do
        FactoryGirl.create(:submitted_artist)
      end

      it "sends an empty array to the view" do
        get :index
        expect( assigns(:artists).count ).to eq(0)
      end
    end

    describe "artists#new should be redirected" do
      before do
        get :new
      end

      it { should respond_with 302 }
    end

    describe "artists#edit should be redirected" do
      before do
        artist = FactoryGirl.create(:approved_artist)
        get :edit, id: artist
      end

      it { should respond_with 302 }
    end
  end

  context "Logged-in users" do

    before do
      @user = FactoryGirl.create(:user)
      @other_user = FactoryGirl.create(:user)
    end  

    describe "No artists exist" do
      before do
        visit new_user_session_path
        signin(@user)
        get :index
      end

      it { should respond_with 200 }
    end

    describe "index action: Logged-in users may see approved, as well as their own artists" do
      before do
        @artist1 = FactoryGirl.create(:approved_artist, submitted_by: @other_user)
        @artist2 = FactoryGirl.create(:approved_artist, submitted_by: @other_user)
        @artist3 = FactoryGirl.create(:submitted_artist, submitted_by: @other_user)
        @artist4 = FactoryGirl.create(:rejected_artist, submitted_by: @other_user)
        @artist5 = FactoryGirl.create(:submitted_artist, submitted_by: @user)
        @artist6 = FactoryGirl.create(:rejected_artist, submitted_by: @user)
        signin(@user)
        get :index
      end

      it { should respond_with 200 }

      it "populates an array of artists" do
        expect( assigns(:artists) ).to include(@artist1)
        expect( assigns(:artists) ).to include(@artist2)
        expect( assigns(:artists) ).to include(@artist5)
        expect( assigns(:artists) ).to include(@artist6)
        expect( assigns(:artists).count ).to eq(4)
      end  
    end

    describe "redirects user when viewing another's submitted artist" do
      before do
        @artist = FactoryGirl.create(:submitted_artist, submitted_by: @other_user)
        signin(@user)
        get :show, id: @artist
      end  

      it { should respond_with 302 }
    end

    describe "redirects user when viewing another's rejected artist" do
      before do
        @artist = FactoryGirl.create(:rejected_artist, submitted_by: @other_user)
        signin(@user)
        get :show, id: @artist
      end  

      it { should respond_with 302 }
    end

    describe "Logged-in users may view their own artists" do
      before do
        @artist1 = FactoryGirl.create(:approved_artist, submitted_by: @user)
        @artist2 = FactoryGirl.create(:submitted_artist, submitted_by: @user)
        @artist3 = FactoryGirl.create(:rejected_artist, submitted_by: @user)
        signin(@user)
      end

      it "allows a logged-in user to view their own approved artist" do
        get :show, id: @artist1
        expect( assigns(:artist) ).to eq(@artist1)
      end  

      it "allows a logged-in user to view their own submitted artist" do
        get :show, id: @artist2
        expect( assigns(:artist) ).to eq(@artist2)
      end  

      it "allows a logged-in user to view their own rejected artist" do
        get :show, id: @artist3
        expect( assigns(:artist) ).to eq(@artist3)
      end  
    end

    describe "Logged-in users may not edit another's submitted artist" do
      before do
        @artist = FactoryGirl.create(:submitted_artist, submitted_by: @other_user)
        signin(@user)
        get :edit, id: @artist
      end

      it { should respond_with 302 }
    end

    describe "Logged-in users may not edit another's rejected artist" do
      before do
        @artist = FactoryGirl.create(:rejected_artist, submitted_by: @other_user)
        signin(@user)
        get :edit, id: @artist
      end

      it { should respond_with 302 }
    end

    describe "Logged-in users may edit their own submitted artist" do
      before do
        @artist = FactoryGirl.create(:submitted_artist, submitted_by: @user)
        signin(@user)
        get :edit, id: @artist
      end
      
      it "allows a logged-in user to edit their own artist" do
        expect( assigns(:artist) ).to eq(@artist)
      end  
    end

    describe "Logged-in users may edit their own approved artist" do
      before do
        @artist = FactoryGirl.create(:approved_artist, submitted_by: @user)
        signin(@user)
        get :edit, id: @artist
      end
      
      it "allows a logged-in user to edit their own artist" do
        expect( assigns(:artist) ).to eq(@artist)
      end  
    end
  end

  context "Logged-in approvers" do

    before do
      @user = FactoryGirl.create(:user)
      @approver1 = FactoryGirl.create(:approver)
      @approver2 = FactoryGirl.create(:approver)
    end  

    describe "No artists exist" do
      before do
        visit new_user_session_path
        signin(@approver1)
        get :index
      end

      it { should respond_with 200 }
    end

    describe "index action: Logged-in approvers may see all artists" do
      before do
        @artist1 = FactoryGirl.create(:approved_artist, submitted_by: @user)
        @artist2 = FactoryGirl.create(:approved_artist, submitted_by: @approver1)
        @artist3 = FactoryGirl.create(:approved_artist, submitted_by: @approver2)
        @artist4 = FactoryGirl.create(:submitted_artist, submitted_by: @user)
        @artist5 = FactoryGirl.create(:submitted_artist, submitted_by: @approver1)
        @artist6 = FactoryGirl.create(:submitted_artist, submitted_by: @approver2)
        @artist7 = FactoryGirl.create(:rejected_artist, submitted_by: @user)
        @artist8 = FactoryGirl.create(:rejected_artist, submitted_by: @approver1)
        @artist9 = FactoryGirl.create(:rejected_artist, submitted_by: @approver2)
        signin(@approver1)
        get :index
      end

      it { should respond_with 200 }

      it "populates an array of artists" do
        expect( assigns(:artists).count ).to eq(9)
      end  
    end

    describe "index action: Logged-in approved sees appropriate filtered results" do
      before do
        @artist1 = FactoryGirl.create(:approved_artist, submitted_by: @user)
        @artist2 = FactoryGirl.create(:approved_artist, submitted_by: @approver1)
        @artist3 = FactoryGirl.create(:approved_artist, submitted_by: @approver2)
        @artist4 = FactoryGirl.create(:submitted_artist, submitted_by: @user)
        @artist5 = FactoryGirl.create(:submitted_artist, submitted_by: @approver1)
        @artist6 = FactoryGirl.create(:submitted_artist, submitted_by: @approver2)
        @artist7 = FactoryGirl.create(:rejected_artist, submitted_by: @user)
        @artist8 = FactoryGirl.create(:rejected_artist, submitted_by: @approver1)
        @artist9 = FactoryGirl.create(:rejected_artist, submitted_by: @approver2)
        signin(@approver1)
      end

      it "requests approved artists" do
        get :index, "filter" => "approved"
        expect( assigns(:artists).count ).to eq(3)
        expect( assigns(:artists) ).to include(@artist1)
        expect( assigns(:artists) ).to include(@artist2)
        expect( assigns(:artists) ).to include(@artist3)
      end

      it "requests submitted artists" do
        get :index, "filter" => "submitted"
        expect( assigns(:artists).count ).to eq(3)
        expect( assigns(:artists) ).to include(@artist4)
        expect( assigns(:artists) ).to include(@artist5)
        expect( assigns(:artists) ).to include(@artist6)
      end

      it "requests rejected artists" do
        get :index, "filter" => "under_revision"
        expect( assigns(:artists).count ).to eq(3)
        expect( assigns(:artists) ).to include(@artist7)
        expect( assigns(:artists) ).to include(@artist8)
        expect( assigns(:artists) ).to include(@artist9)
      end
    end
  end
end
