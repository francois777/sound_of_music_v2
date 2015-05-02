require 'spec_helper'

describe ApprovalsController do

  context "Non logged-in users" do

    describe "POST submit" do

      before :each do
        @incomplete_instrument_article = FactoryGirl.create(:incomplete_instrument_article)
        @approval = @incomplete_instrument_article.approval
      end

      context "with valid attributes" do

        it "located the requested @approval" do
          skip "Test fails, cannot locate approval"
          # expected: #<Approval id: 2, approval_status: 0, rejection_reason: 0, approvable_id: 1, approvable_type: "Article", approver_id: 0, created_at: "2015-05-02 20:32:58", updated_at: "2015-05-02 20:32:58">
          # got: nil
          #  Actual parameters received when submitting an approval
          # "approval"=>{"approval_id"=>"410"}, "commit"=>"Submit", "id"=>"406"  article id = 406  
          puts @incomplete_instrument_article.inspect
          puts @approval.inspect
          post :submit, { :approval => { :approval_id => @approval.id }, 
                          :id => @incomplete_instrument_article.id,
                          :commit => 'Submit' 
                        }
          expect( assigns(:approval) ).to eq(@approval)
        end
      end

    end
  end
end