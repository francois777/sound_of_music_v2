require 'spec_helper'

describe Article do

  include FactoryGirl::Syntax::Methods

  before do
    @user1 = create(:user)
    @user2 = create(:user)
    @approver = create(:approver)
    @category = create(:strings)
    @subcategory = create(:bowed)
    @theme = create(:instrument_theme)
    @instrument = create(:approved_instrument, created_by: @user1, category: @category, subcategory: @subcategory)
    @article = Article.create( title: 'The history of the harp', 
                            publishable: @instrument, 
                            body: 'This is what happened in the 16th century..',
                            author: @user1, 
                            approver: @approver,
                            approval_status: :approved,
                            rejection_reason: :not_rejected,
                            theme: @theme)
  end

  subject { @article }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:publishable) }
  it { should respond_to(:author) }
  it { should respond_to(:approver) }
  it { should respond_to(:theme) }
  it { should respond_to(:approval_status) }
  it { should respond_to(:rejection_reason) }

  it "must be valid" do
    expect(@article).to be_valid
  end

  it "must have a valid factory" do
    article_fact = FactoryGirl.build(:instrument_article)
    article_fact.approver = @approver
    expect(article_fact).to be_valid
  end

  it "could belong to an instrument" do
    expect(@article.publishable).to eq(@instrument)
    expect(@article.publishable.class).to eq(Instrument)
  end

  it "must validate the article's author" do
    expect(@article.author).to eq(@user1)
    @article.author = nil
    expect(@article).not_to be_valid
  end

  it "must validate the article's approver" do
    expect(@article.approver).to eq(@approver)
    @article.approver = nil
    expect(@article).not_to be_valid
  end

  it "must validate the article's approval status" do
    expect(@article.approved?).to eq(true)
    expect { @article.approval_status = :unexpected }.to raise_error(ArgumentError)
  end

  it "must require a rejection_reason when requesting a review" do
    @article.approval_status = :to_be_revised
    expect(@article).not_to be_valid
  end

  it "cannot have a rejection_reason when not requesting a review" do
    @article.approval_status = :incomplete
    @article.rejection_reason = :grammar_and_spelling
    expect { @article.save! }.to raise_error
  end


end