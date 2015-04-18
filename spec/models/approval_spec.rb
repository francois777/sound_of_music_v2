require 'spec_helper'

describe Approval do

  include FactoryGirl::Syntax::Methods

  before do
    @user1 = create(:user)
    @user2 = create(:user)
    @approver = create(:approver)
    @artist = Artist.create(born_on: Date.today - 38.years, 
      born_country_code: 'za',
      submitted_by: @user1,
      artist_names_attributes: [ { name: 'John', name_type: 0}, 
                                 { name: 'Cornelius', name_type: 1},
                                 { name: 'Peterson', name_type: 2}])
    approval_params = Approval::INCOMPLETE.merge( {approvable: @artist} )
    @approval = Approval.new( approval_params )
  end

  subject { @approval }

  it { should respond_to(:approver_id) }
  it { should respond_to(:approval_status) }
  it { should respond_to(:rejection_reason) }
  it { should respond_to(:approvable) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }

  it "should be valid" do
    expect(@approval).to be_valid
  end

  it "must require a rejection_reason when requesting a review" do
    @approval.approval_status = :to_be_revised
    expect(@approval).not_to be_valid
  end

  it "cannot have a rejection_reason when not requesting a review" do
    @approval.approval_status = :incomplete
    @approval.rejection_reason = :grammar_and_spelling
    expect { @approval.save! }.to raise_error
  end

  it "must validate the approver" do
    @approval.approval_status = :approved
    expect(@approval).not_to be_valid
  end

end
