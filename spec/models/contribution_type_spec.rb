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
  it { should respond_to(:name) }

  it "must be valid" do
    expect(@contribution_type).to be_valid
  end

  it "must validate the definition" do
    @contribution_type.definition = 'D' * 9
    expect(@contribution_type).not_to be_valid
  end

  it "must ensure two contribution_types are unique" do
    @contribution_type.save
    contribution_type2 = @contribution_type.dup
    contribution_type2.definition = "Another definition"
    expect { contribution_type2.save! }.to raise_error
  end

  it "cannot provide a voice type with a group" do
    @contribution_type.classification = 'group_of_musicians'
    @contribution_type.voice_type = 'soprano'
    expect { @contribution_type.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "the group type of a vocalist is automatically set to 'individual'" do
    @contribution_type.classification = 'vocalist'
    @contribution_type.voice_type = 'bass'
    @contribution_type.group_type = 'band'
    @contribution_type.save!
    expect( @contribution_type.group_type ).to eq('individual')
  end

  it "the voice_type of a group is automatically set to 'not_applicable'" do
    @contribution_type.classification = 'group_of_musicians'
    @contribution_type.voice_type = 'bass'
    @contribution_type.group_type = 'band'
    @contribution_type.save!
    expect( @contribution_type.voice_type ).to eq('not_applicable')
  end

  it "generates the correct voice type" do 
    ct_params = [ {classification: :conductor, definition: 'Definition of conductor'},
               {classification: :group_of_musicians, group_type: :orchestra, definition: 'Definition of orchestra'},
               {classification: :vocalist, voice_type: :countertenor, definition: 'Definition of countertenor'}
             ]
    names =  [ 'Conductor', 'Orchestra', 'Countertenor voice']         
    ct_params.each_with_index do |params, inx|
      cttype = ContributionType.new(params)
      cttype.save!
      expect( cttype.name ).to eq names[inx]
    end     
  end

end