require 'spec_helper'

describe Instrument do

  include FactoryGirl::Syntax::Methods

  describe "All instruments" do

    before do
      @user = create(:user)
      @instrument = Instrument.new(
        name: 'Alto saxophone', 
        other_names: 'Alto Sax', 
        performer_title: 'Saxist', 
        category: 0,
        subcategory: 0,
        origin_period: '1600',
        approval_status: 0,
        rejection_reason: 0,
        created_by_id: @user)
    end

    subject { @instrument }

    it { should respond_to(:name) }
    it { should respond_to(:other_names) }
    it { should respond_to(:performer_title) }
    it { should respond_to(:category) }
    it { should respond_to(:subcategory) }
    it { should respond_to(:origin_period) }
    it { should respond_to(:approval_status) }
    it { should respond_to(:rejection_reason) }
    it { should respond_to(:created_by_id) }

    it "must be valid" do
      expect(@instrument).to be_valid
    end

    it "must have a valid factory" do
      instrument_fact = build(:instrument, name: 'Nice instrument', created_by_id: @user)
      expect(instrument_fact).to be_valid
    end

  end
end