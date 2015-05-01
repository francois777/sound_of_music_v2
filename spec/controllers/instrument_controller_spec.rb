require 'spec_helper'

describe InstrumentsController do

  context "Non logged-in users" do

    describe "No instruments exist" do
      before do
        get :index
      end

      it { should respond_with 200 }
    end

    describe "Only approved instruments exist" do
      before do
        2.times { FactoryGirl.create(:approved_instrument) }
        get :index
      end

      it { should respond_with 200 }
    end

    describe "No instruments have been approved yet" do
      before do
        FactoryGirl.create(:submitted_instrument)
        get :index
      end

      it { should respond_with 200 }
    end

    describe "Only approved instruments are displayed to visitors" do
      before do
        @instrument1 = FactoryGirl.create(:approved_instrument)
        @instrument2 = FactoryGirl.create(:approved_instrument)
        @instrument3 = FactoryGirl.create(:submitted_instrument)
        @instrument4 = FactoryGirl.create(:rejected_instrument)
      end

      it "populates an array of instruments" do
        get :index
        expect( assigns(:instruments) ).to include(@instrument1)
        expect( assigns(:instruments) ).to include(@instrument2)
        expect( assigns(:instruments).count ).to eq(2)
      end  
    end

    describe "instruments#new should be redirected" do
      before do
        get :new
      end

      it { should respond_with 302 }
    end

    describe "instruments#edit should be redirected" do
      before do
        instrument = FactoryGirl.create(:approved_instrument)
        get :edit, id: instrument
      end

      it { should respond_with 302 }
    end
  end

  context "Logged-in users" do

    before do
      @user = FactoryGirl.create(:user)
      @other_user = FactoryGirl.create(:user)
    end  

    describe "No instruments exist" do
      before do
        visit new_user_session_path
        signin(@user)
        get :index
      end

      it { should respond_with 200 }
    end

    describe "Only approved instruments exist" do
      before do
        2.times { FactoryGirl.create(:approved_instrument) }
        visit new_user_session_path
        signin(@user)
        get :index
      end

      it { should respond_with 200 }
    end

    describe "No instruments have been approved yet" do
      before do
        FactoryGirl.create(:submitted_artist)
        visit new_user_session_path
        signin(@user)
        get :index
      end

      it { should respond_with 200 }
    end

    describe "index action: Logged-in users may see approved, as well as their own instruments" do
      before do
        @instrument1 = FactoryGirl.create(:approved_instrument, created_by: @other_user)
        @instrument2 = FactoryGirl.create(:approved_instrument, created_by: @other_user)
        @instrument3 = FactoryGirl.create(:submitted_instrument, created_by: @other_user)
        @instrument4 = FactoryGirl.create(:rejected_instrument, created_by: @other_user)
        @instrument5 = FactoryGirl.create(:submitted_instrument, created_by: @user)
        @instrument6 = FactoryGirl.create(:rejected_instrument, created_by: @user)
        signin(@user)
        get :index
      end

      it { should respond_with 200 }

      it "populates an array of instruments" do
        expect( assigns(:instruments) ).to include(@instrument1)
        expect( assigns(:instruments) ).to include(@instrument2)
        expect( assigns(:instruments) ).to include(@instrument5)
        expect( assigns(:instruments) ).to include(@instrument6)
        expect( assigns(:instruments).count ).to eq(4)
      end  
    end

    describe "redirects user when viewing another's submitted instrument" do
      before do
        @instrument = FactoryGirl.create(:submitted_instrument, created_by: @other_user)
        signin(@user)
        get :show, id: @instrument
      end  

      it { should respond_with 302 }
    end

    describe "redirects user when viewing another's rejected instrument" do
      before do
        @instrument = FactoryGirl.create(:rejected_instrument, created_by: @other_user)
        signin(@user)
        get :show, id: @instrument
      end  

      it { should respond_with 302 }
    end

    describe "Logged-in users may view their own instruments" do
      before do
        @instrument1 = FactoryGirl.create(:approved_instrument, created_by: @user)
        @instrument2 = FactoryGirl.create(:submitted_instrument, created_by: @user)
        @instrument3 = FactoryGirl.create(:rejected_instrument, created_by: @user)
        signin(@user)
      end

      it "allows a logged-in user to view their own approved instrument" do
        get :show, id: @instrument1
        expect( assigns(:instrument) ).to eq(@instrument1)
      end  

      it "allows a logged-in user to view their own submitted instrument" do
        get :show, id: @instrument2
        expect( assigns(:instrument) ).to eq(@instrument2)
      end  

      it "allows a logged-in user to view their own rejected instrument" do
        get :show, id: @instrument3
        expect( assigns(:instrument) ).to eq(@instrument3)
      end  
    end

    describe "Logged-in users may not edit another's submitted instrument" do
      before do
        @instrument = FactoryGirl.create(:submitted_instrument, created_by: @other_user)
        signin(@user)
        get :edit, id: @instrument
      end

      it { should respond_with 302 }
    end

    describe "Logged-in users may not edit another's rejected instrument" do
      before do
        @instrument = FactoryGirl.create(:rejected_instrument, created_by: @other_user)
        signin(@user)
        get :edit, id: @instrument
      end

      it { should respond_with 302 }
    end

    describe "Logged-in users may edit their own submitted instrument" do
      before do
        @instrument = FactoryGirl.create(:submitted_instrument, created_by: @user)
        signin(@user)
        get :edit, id: @instrument
      end
      
      it "allows a logged-in user to edit their own instrument" do
        expect( assigns(:instrument) ).to eq(@instrument)
      end  
    end

    describe "Logged-in users may edit their own approved instrument" do
      before do
        @instrument = FactoryGirl.create(:approved_instrument, created_by: @user)
        signin(@user)
        get :edit, id: @instrument
      end
      
      it "allows a logged-in user to edit their own instrument" do
        expect( assigns(:instrument) ).to eq(@instrument)
      end  
    end
  end

  context "Logged-in approvers" do

    before do
      @user = FactoryGirl.create(:approver)
      @approver1 = FactoryGirl.create(:approver)
      @approver2 = FactoryGirl.create(:approver)
    end  

    describe "No instruments exist" do
      before do
        visit new_user_session_path
        signin(@approver1)
        get :index
      end

      it { should respond_with 200 }
    end

    describe "index action: Logged-in approvers may see all instruments" do
      before do
        @instrument1 = FactoryGirl.create(:approved_instrument, created_by: @user)
        @instrument2 = FactoryGirl.create(:approved_instrument, created_by: @approver1)
        @instrument3 = FactoryGirl.create(:approved_instrument, created_by: @approver2)
        @instrument4 = FactoryGirl.create(:submitted_instrument, created_by: @user)
        @instrument5 = FactoryGirl.create(:submitted_instrument, created_by: @approver1)
        @instrument6 = FactoryGirl.create(:submitted_instrument, created_by: @approver2)
        @instrument7 = FactoryGirl.create(:rejected_instrument, created_by: @user)
        @instrument8 = FactoryGirl.create(:rejected_instrument, created_by: @approver1)
        @instrument9 = FactoryGirl.create(:rejected_instrument, created_by: @approver2)
        signin(@approver1)
        get :index
      end

      it { should respond_with 200 }

      it "populates an array of instruments" do
        expect( assigns(:instruments).count ).to eq(9)
      end  
    end

    describe "index action: Logged-in approved sees appropriate filtered results" do
      before do
        @instrument1 = FactoryGirl.create(:approved_instrument, created_by: @user)
        @instrument2 = FactoryGirl.create(:approved_instrument, created_by: @approver1)
        @instrument3 = FactoryGirl.create(:approved_instrument, created_by: @approver2)
        @instrument4 = FactoryGirl.create(:submitted_instrument, created_by: @user)
        @instrument5 = FactoryGirl.create(:submitted_instrument, created_by: @approver1)
        @instrument6 = FactoryGirl.create(:submitted_instrument, created_by: @approver2)
        @instrument7 = FactoryGirl.create(:rejected_instrument, created_by: @user)
        @instrument8 = FactoryGirl.create(:rejected_instrument, created_by: @approver1)
        @instrument9 = FactoryGirl.create(:rejected_instrument, created_by: @approver2)
        signin(@approver1)
      end

      it "requests approved instruments" do
        get :index, "filter" => "approved"
        expect( assigns(:instruments).count ).to eq(3)
        expect( assigns(:instruments) ).to include(@instrument1)
        expect( assigns(:instruments) ).to include(@instrument2)
        expect( assigns(:instruments) ).to include(@instrument3)
      end

      it "requests submitted instruments" do
        get :index, "filter" => "submitted"
        expect( assigns(:instruments).count ).to eq(3)
        expect( assigns(:instruments) ).to include(@instrument4)
        expect( assigns(:instruments) ).to include(@instrument5)
        expect( assigns(:instruments) ).to include(@instrument6)
      end

      it "requests rejected instruments" do
        get :index, "filter" => "under_revision"
        expect( assigns(:instruments).count ).to eq(3)
        expect( assigns(:instruments) ).to include(@instrument7)
        expect( assigns(:instruments) ).to include(@instrument8)
        expect( assigns(:instruments) ).to include(@instrument9)
      end
    end
  end
end
