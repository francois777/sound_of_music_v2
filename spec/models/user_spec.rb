describe User do

  before(:each) { @user = User.new(
    first_name: 'Bobby', 
    last_name: 'Fischer',
    email: 'bobby.fisher@chess.com',
    role: User.roles[:approver],
    admin: true) }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:role) }
  it { should respond_to(:admin) }

  it "presents User properties" do
    expect(@user.first_name).to match 'Bobby'
    expect(@user.last_name).to match 'Fischer'
    expect(@user.email).to match 'bobby.fisher@chess.com'
    expect(@user.role).to match 'approver'
    expect(@user.admin).to match true
  end

  it "must have a valid factory" do
    user_fact = build(:user)
    expect(user_fact).to be_valid
  end

  it "presents the correct full name" do
    expect(@user.name).to eq('Bobby Fischer')
  end

end
