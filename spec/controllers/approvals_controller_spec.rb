# http://everydayrails.com/2012/04/07/testing-series-rspec-controllers.html

require 'spec_helper'

describe ApprovalsController do

  context "Non-logged-in user" do

    describe "POST submit by non-logged-in user" do
      before :each do
        @user = FactoryGirl.create(:user)
        @approver = FactoryGirl.create(:approver)
        @incomplete_instrument_article = FactoryGirl.create(:incomplete_instrument_article)
        @approval = @incomplete_instrument_article.approval
      end

      it "redirects a non-logged-in user" do
        post :submit, { :approval => { :approval_id => @approval.id }, 
                        :id => @incomplete_instrument_article.id,
                        :commit => 'Submit' 
                      }
        expect( response ).to redirect_to(new_user_session_path)
      end
    end  

    describe "POST approve by non-logged-in user" do
      before :each do
        @user = FactoryGirl.create(:user)
        @approver = FactoryGirl.create(:approver)
        @submitted_instrument_article = FactoryGirl.create(:submitted_instrument_article)
        @approval = @submitted_instrument_article.approval
      end

      it "redirects a non-logged-in user" do
        post :submit, { :approval => { :approval_id => @approval.id }, 
                        :id => @submitted_instrument_article.id,
                        :commit => 'Submit' 
                      }
        expect( response ).to redirect_to(new_user_session_path)
      end
    end  

  end

  context "Logged-in user" do

    describe "POST submit" do

      before :each do
        @user = FactoryGirl.create(:user)
        @approver = FactoryGirl.create(:approver)
        @instrument = FactoryGirl.create(:approved_instrument)
        @incomplete_instrument_article = FactoryGirl.create(:incomplete_instrument_article, publishable: @instrument)
        @approval = @incomplete_instrument_article.approval
        @rejection_reason_id = Approval.rejection_reasons[:irrelevant_material]
        signin(@user)
      end

      context "with valid attributes" do

        it "located the requested @approval" do
          post :submit, { approval: { approval_id: @approval.id }, 
                          id: @incomplete_instrument_article.id,
                          :commit => 'Submit' 
                        }
          expect( assigns(:approval) ).to eq(@approval)
        end

        it "changes the instrument's approval details to submitted" do
          post :submit, { approval: { approval_id: @approval.id }, 
                          id: @incomplete_instrument_article.id,
                          commit: 'Submit' 
                        }
          @approval.reload
          expect( @approval.submitted? ).to eq(true)
          expect( @approval.approver).to eq(nil)         
        end

        it "redirects when user tries to reject the article" do
          post :approve, { approval: { approval_id: @approval.id, rejection_reason: @rejection_reason_id.to_s}, 
                          id: @incomplete_instrument_article.id,
                          commit: 'Request revision' 
                        }
          expect( response ).to redirect_to(root_path)
          expect( @approval.incomplete? ).to eq(true)
          expect( @approval.updated_at ).to eq(@approval.reload.updated_at)
        end
      end
    end
  end

  context "Logged-in approver" do

    describe "POST approve" do
      before :each do
        @user = FactoryGirl.create(:user)
        @approver = FactoryGirl.create(:approver)
        @instrument = FactoryGirl.create(:approved_instrument)
        @submitted_instrument_article = FactoryGirl.create(:submitted_instrument_article, publishable: @instrument)
        @submitted_approval = @submitted_instrument_article.approval
        @approved_instrument_article = FactoryGirl.create(:approved_instrument_article, publishable: @instrument)
        @approved_approval = @approved_instrument_article.approval
        signin(@approver)
      end

      context "with valid attributes" do
        it "changes the instrument's approval details to approved" do
          post :approve, { approval: { approval_id: @submitted_approval.id, rejection_reason: ""}, 
                          :id => @submitted_instrument_article.id,
                          :commit => 'Approve' 
                        }
          expect( assigns(:approval) ).to eq(@submitted_approval)
          @approved_approval.reload
          expect( @approved_approval.approved? ).to eq(true)
          expect( @approved_approval.approver).to eq(@approver)         
        end
      end                

      context "with invalid precondition" do
        it "redirects when the instrument has already been approved" do
          puts "Submitted article: #{@submitted_instrument_article.id}"
          puts "Approved article: #{@approved_instrument_article.id}"
          post :approve, { approval: { approval_id: @approved_approval.id, rejection_reason: ""}, 
                          :id => @approved_instrument_article.id,
                          :commit => 'Approve' 
                        }
          expect( response ).to redirect_to(root_path)
          expect( @approved_approval.updated_at ).to eq(@approved_approval.reload.updated_at)
        end
      end                
    end  

    describe "POST reject" do

      before :each do
        @user = FactoryGirl.create(:user)
        @approver = FactoryGirl.create(:approver)
        @submitted_instrument_article = FactoryGirl.create(:submitted_instrument_article)
        @approval = @submitted_instrument_article.approval
        @rejection_reason_id = Approval.rejection_reasons[:irrelevant_material]
        signin(@approver)
      end

      context "with valid attributes" do
        it "changes the instrument's approval details to to_be_revised" do
          post :approve, { approval: { approval_id: @approval.id, rejection_reason: @rejection_reason_id.to_s}, 
                          :id => @submitted_instrument_article.id,
                          :commit => 'Request revision' 
                        }
          expect( assigns(:approval) ).to eq(@approval)
          @approval.reload
          expect( @approval.to_be_revised? ).to eq(true)
          expect( @approval.approver).to eq(@approver)         
        end
      end                
    end  

  end
end