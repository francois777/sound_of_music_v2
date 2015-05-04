require 'spec_helper'

describe Artist do

  include FactoryGirl::Syntax::Methods

  describe "with valid data" do

    before do
      @user = create(:user)
      @approver = create(:approver)
      @countries = {}
      I18n.t('countries').each.map { |k,v| @countries[k] =  v }
      historical_period = create(:classical_period)
      @artist = Artist.create(born_on: Date.today - 38.years, 
        born_country_code: 'za',
        submitted_by: @user,
        historical_period: historical_period,
        artist_names_attributes: [ { name: 'John', name_type: 0}, 
                                   { name: 'Cornelius', name_type: 1},
                                   { name: 'Peterson', name_type: 2}])
    end

    subject { @artist }

    it { should respond_to(:born_on) }
    it { should respond_to(:died_on) }
    it { should respond_to(:approval) }
    it { should respond_to(:born_country_code) }
    it { should respond_to(:historical_period_id) }
    it { should respond_to(:gender) }
    it { should respond_to(:assigned_name) }
    it { should respond_to(:submitted_by) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
    it { should respond_to(:artist_names) }
    it { should respond_to(:person_or_group) }

    it "must be valid" do
      expect(@artist).to be_valid
    end

    it "should have a valid factory" do
      artist_fact = FactoryGirl.build(:artist)
      expect(artist_fact).to be_valid
      artist_fact.save

      artist_fact.approval = FactoryGirl.build(:approved_approval, approvable: artist_fact, approver: @approver)
      expect(artist_fact.approval).to be_valid
      artist_fact.approval.save
      expect(artist_fact.approval.approvable).to eq(artist_fact)
    end

    it "must reflect the derived assigned_name correctly" do
      expect( @artist.assigned_name ).to eq('John Cornelius Peterson')
    end

  end

  describe "with invalid data" do

    before do
      @user = create(:user)
      @approver = create(:approver)
      @countries = {}
      I18n.t('countries').each.map { |k,v| @countries[k] =  v }
      historical_period = create(:classical_period)
      @artist = Artist.new(born_on: Date.today - 38.years, 
        born_country_code: 'za',
        historical_period: historical_period,
        submitted_by: @user)
    end

    it "cannot die before birth" do
      @artist.artist_names_attributes = [ { name: 'John', name_type: 0}, 
                                 { name: 'Cornelius', name_type: 1},
                                 { name: 'Peterson', name_type: 2}]
      @artist.died_on = Date.today - 42.years
      expect { @artist.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "needs a valid country code" do
      @artist.artist_names_attributes = [ { name: 'John', name_type: 0}, 
                                 { name: 'Cornelius', name_type: 1},
                                 { name: 'Peterson', name_type: 2}]
      @artist.born_country_code = 'zz'
      expect { @artist.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Born country code Invalid country code")
    end

    it "needs a valid gender code" do
      @artist.artist_names_attributes = [ { name: 'John', name_type: 0}, 
                                 { name: 'Cornelius', name_type: 1},
                                 { name: 'Peterson', name_type: 2}]
      expect { @artist.gender = 2 }.to raise_error
    end
  end

  describe "include approval details when creating an artist" do
    before do
      @user = create(:user)
      @approver = create(:approver)
      @countries = {}
      historical_period = create(:classical_period)
      I18n.t('countries').each.map { |k,v| @countries[k] =  v }
      @artist = Artist.new(born_on: Date.today - 38.years, 
        born_country_code: 'za',
        submitted_by: @user,
        historical_period: historical_period,
        artist_names_attributes: [ { name: 'John', name_type: 0}, 
                                   { name: 'Cornelius', name_type: 1},
                                   { name: 'Peterson', name_type: 2}])
    end

    it "can specify that an artist is submitted at the time of creation" do
      @artist.save
      approval = Approval.new(approval_status: 1,
                                rejection_reason: 0,
                                approvable: @artist)
      approval.save
      expect(@artist.approval).to eq(approval)
      expect(@artist.approval.submitted?).to eq(true)
      expect(@artist.approval.not_rejected?).to eq(true)
      expect(approval.approvable).to eq(@artist)
    end
  end
end
