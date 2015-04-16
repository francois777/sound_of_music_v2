require 'spec_helper'

describe Artist do

  include FactoryGirl::Syntax::Methods

  describe "with valid data" do

    before do
      @user = create(:user)
      @approver = create(:approver)
      @countries = {}
      I18n.t('countries').each.map { |k,v| @countries[k] =  v }
      @artist = Artist.create(born_on: Date.today - 38.years, 
        born_country_code: 'za',
        submitted_by: @user,
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

    it "must be valid" do
      expect(@artist).to be_valid
    end

    it "must reflect the derived assigned_name correctly" do
      expect( @artist.assigned_name ).to eq('John Cornelius Peterson')
    end

    it "must reflect the derived official name correctly" do
      expect( @artist.official_name).to eq('John Cornelius Peterson')
    end

  end

  describe "with invalid data" do

    before do
      @user = create(:user)
      @approver = create(:approver)
      @countries = {}
      I18n.t('countries').each.map { |k,v| @countries[k] =  v }
      @artist = Artist.new(born_on: Date.today - 38.years, 
        born_country_code: 'za',
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

    it "cannot have two first names" do
      @artist.artist_names_attributes = [ { name: 'John', name_type: 0}, 
                                 { name: 'Cornelius', name_type: 0},
                                 { name: 'Peterson', name_type: 2}]
      expect { @artist.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Assigned name Only one name is allowed for first name, last name, public name or maiden name")
    end  

    it "cannot have two last names" do
      @artist.artist_names_attributes = [ { name: 'John', name_type: 0}, 
                                 { name: 'Cornelius', name_type: 2},
                                 { name: 'Peterson', name_type: 2}]
      expect { @artist.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Assigned name Only one name is allowed for first name, last name, public name or maiden name")
    end  

    it "cannot have two maiden names" do
      @artist.artist_names_attributes = [ { name: 'Sally', name_type: 0}, 
                                 { name: 'Samantha', name_type: 1},
                                 { name: 'Peterson', name_type: 2},
                                 { name: 'Sollimon', name_type: 4},
                                 { name: 'Sanderson', name_type: 4}]
      expect { @artist.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Assigned name Only one name is allowed for first name, last name, public name or maiden name")
    end  

    it "cannot have two public names" do
      @artist.artist_names_attributes = [ { name: 'Sally', name_type: 0}, 
                                 { name: 'Samantha', name_type: 1},
                                 { name: 'Peterson', name_type: 2},
                                 { name: 'Sally Sanderson', name_type: 3},
                                 { name: 'Sally Sonderson', name_type: 3}]
      expect { @artist.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Assigned name Only one name is allowed for first name, last name, public name or maiden name")
    end  

    it "must have at least a first name and surname" do
      @artist.artist_names_attributes = [ { name: 'Sally', name_type: 0}, 
                                          { name: 'Samantha', name_type: 1}]
      expect { @artist.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Assigned name First and last name are required")
    end
  end

  describe "include approval details when creating an artist" do
    before do
      @user = create(:user)
      @approver = create(:approver)
      @countries = {}
      I18n.t('countries').each.map { |k,v| @countries[k] =  v }
      @artist = Artist.new(born_on: Date.today - 38.years, 
        born_country_code: 'za',
        submitted_by: @user,
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
