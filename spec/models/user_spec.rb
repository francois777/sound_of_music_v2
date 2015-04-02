describe User do

  before(:each) { @user = User.new(
    first_name: 'Bobby', 
    last_name: 'Fischer',
    email: 'bobby.fisher@chess.com') }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.first_name).to match 'Bobby'
    expect(@user.last_name).to match 'Fischer'
    expect(@user.email).to match 'bobby.fisher@chess.com'
  end

end
