require 'spec_helper'

describe HistoricalPeriod do

  describe "HistoricalPeriod" do

    before(:each) { @histprd = HistoricalPeriod.new(
      name: 'Baroque Period',
      period_from: Date.new(1600,1,1), 
      period_end: Date.new(1749,12,31),
      overview: 'Something about the Baroque period'
    )}

    subject { @histprd }

    it { should respond_to(:name) }
    it { should respond_to(:period_from) }
    it { should respond_to(:period_end) }
    it { should respond_to(:overview) }

    it "must produce a valid object" do
      expect(subject).to be_valid
    end

    it "must have a valid factory" do
      factory_period = FactoryGirl.create(:baroque_period)
      expect(factory_period).to be_valid
    end

    it "must validate the name" do
      @histprd.name = 'Hist'
      expect(@histprd).not_to be_valid
      @histprd.name = "A" * 31
      expect(@histprd).not_to be_valid
    end

    it "must have the and date after after the start date" do
      @histprd.period_end = Date.new(1599,12,31)
      expect(@histprd).not_to be_valid
    end  

    it "cannot result in overlapping dates" do
      @histprd.save
      new_period = FactoryGirl.build(:baroque_period, period_from: Date.new(1699,12,31), period_end: Date.new(1701,1,1))
      expect { new_period.save! }.to raise_error
    end

    it "must respond to a name scope" do
       @histprd.save
       baroque_period = HistoricalPeriod.baroque
       expect( baroque_period.period_from ).to eq(Date.new(1600,1,1))
       expect( baroque_period.period_end ).to eq(Date.new(1749,12,31))
    end
  end
end
