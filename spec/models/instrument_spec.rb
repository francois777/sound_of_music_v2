require 'spec_helper'

describe Instrument do

  include FactoryGirl::Syntax::Methods

  describe "All instruments" do

    before do
      @user = create(:user)
      @category = create(:strings)
      @subcategory = create(:bowed)
      @instrument = Instrument.new(
        name: 'Alto saxophone', 
        other_names: 'Alto Sax', 
        performer_title: 'Saxist', 
        category: @category,
        subcategory: @subcategory,
        origin_period: '1600',
        approval_status: 0,
        rejection_reason: 0,
        created_by: @user)
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
    it { should respond_to(:approver_id) }

    it "must be valid" do
      expect(@user).to be_valid
      expect(@instrument).to be_valid
    end

    it "must have a valid factory" do
      instrument_fact = FactoryGirl.build(:instrument, name: 'Nice instrument', created_by: @user)
      expect(instrument_fact).to be_valid
    end

    it "must find the user who created the instrument" do
      expect(@instrument.created_by).to eq(@user)
    end

    it "must find the instrument's category" do
      expect(@instrument.category).to eq(@category)
    end

    it "must find the instrument's subcategory" do
      expect(@instrument.subcategory).to eq(@subcategory)
    end

    it "must require an approver when instrument is being approved" do
      @instrument.approval_status = :approved
      expect { @instrument.save! }.to raise_error
    end

    it "must require an approver when instrument is being rejected" do
      @instrument.approval_status = :to_be_revised
      @instrument.rejection_reason = :incorrect_facts
      expect { @instrument.save! }.to raise_error
    end

    it "must permit an approver when instrument is being approved" do
      approver = create(:approver)
      @instrument.approver = approver
      @instrument.approval_status = :approved
      expect { @instrument.save! }.not_to raise_error
    end

    it "must permit an approver when instrument is being rejected" do
      approver = create(:approver)
      @instrument.approver = approver
      @instrument.approval_status = :to_be_revised
      @instrument.rejection_reason = :incorrect_facts
      expect { @instrument.save! }.not_to raise_error
    end
  end
end