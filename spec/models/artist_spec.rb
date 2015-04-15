require 'spec_helper'

describe Artist do

  include FactoryGirl::Syntax::Methods

  before do
      @user = create(:user)
      @approver = create(:approver)
      @countries = {}
      I18n.t('countries').each.map { |k,v| @countries[k] =  v }
      @artist = Artist.create(born_on: Date.today - 38.years, 
        born_country_code: 'za',
        artist_names_attributes: [ { name: 'John', name_type: 0}, 
                                   { name: 'Cornelius', name_type: 1},
                                   { name: 'Peterson', name_type: 2}])
      @approval = Approval.create(approvable: @artist,
                                 approval_status: :submitted,
                                 rejection_reason: :not_rejected)
  end

  subject { @artist }

  it { should respond_to(:born_on) }
  it { should respond_to(:died_on) }
  it { should respond_to(:born_country_code) }
  it { should respond_to(:historical_period_id) }
  it { should respond_to(:gender) }
  it { should respond_to(:assigned_name) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:artist_names) }

  it "must be valid" do
    expect(@artist).to be_valid
  end

  it "cannot die before birth" do
    @artist.died_on = Date.today - 42.years
    expect { @artist.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "needs a valid country code" do
    @artist.born_country_code = 'zz'
    expect { @artist.save! }.to raise_error
  end

  it "needs a valid gender code" do
    expect { @artist.gender = 2 }.to raise_error
  end

  it "must provide a name" do
    expect( @artist.name ).to eq('John Cornelius Peterson')
  end

end
