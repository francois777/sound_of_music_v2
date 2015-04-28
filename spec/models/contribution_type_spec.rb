require 'spec_helper'

describe ContributionType do

  before do
    @contribution_type = FactoryGirl.create(:tenor)
  end

  subject { @contribution_type }

  it { should respond_to(:definition) }
  it { should respond_to(:classification) }
  it { should respond_to(:group_type) }
  it { should respond_to(:voice_type) }

  it "must be valid" do
    expect(@contribution_type).to be_valid
  end

  it "must validate the definition" do
    @contribution_type.definition = 'D' * 9
    expect(@contribution_type).not_to be_valid
    @contribution_type.definition = "A" * 81
    expect(@contribution_type).not_to be_valid
  end

  it "must ensure two contribution_types are unique" do
    @contribution_type.save
    contribution_type2 = @contribution_type.dup
    contribution_type2.definition = "Another definition"
    expect { contribution_type2.save! }.to raise_error
  end

  it "must ensure group type is required for groups" do
    #ctype = ContributionType.create
  end
  
end