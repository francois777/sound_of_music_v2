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
        created_by: @user)
    end

    subject { @instrument }

    it { should respond_to(:name) }
    it { should respond_to(:other_names) }
    it { should respond_to(:performer_title) }
    it { should respond_to(:category) }
    it { should respond_to(:subcategory) }
    it { should respond_to(:origin_period) }
    it { should respond_to(:created_by_id) }

    it "must be valid" do
      expect(@user).to be_valid
      expect(@instrument).to be_valid
    end

    it "must have a valid factory" do
      instrument_fact = FactoryGirl.build(:submitted_instrument, name: 'Nice instrument', created_by: @user)
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

  end
end