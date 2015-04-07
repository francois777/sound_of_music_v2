require 'spec_helper'

describe Theme do

  include FactoryGirl::Syntax::Methods

  before do
    @theme = create(:instrument_theme, subject: :instruments)
  end

  subject { @theme }

  it { should respond_to(:subject) }
  it { should respond_to(:name) }

  it "must be valid" do
    expect(@theme).to be_valid
  end

end
