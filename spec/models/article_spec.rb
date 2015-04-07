require 'spec_helper'

describe Article do

  include FactoryGirl::Syntax::Methods

  before do
    @user1 = create(:user)
    @user2 = create(:user)
    @category = create(:strings)
    @subcategory = create(:bowed)
    @theme = create(:instrument_theme)
    @instrument = create(:instrument, created_by: @user1, category: @category, subcategory: @subcategory)
    @article = create(:instrument_article, publishable: @instrument, author: @user2, theme: @theme)
  end

  subject { @article }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:publishable) }
  it { should respond_to(:author) }
  it { should respond_to(:theme) }
  it { should respond_to(:approval_status) }
  it { should respond_to(:rejection_reason) }

  it "must be valid" do
    expect(@article).to be_valid
  end

  it "must have a valid factory" do
    article_fact = build(:instrument_article)
    expect(article_fact).to be_valid
  end

  it "could belong to an instrument" do
    expect(@article.publishable).to eq(@instrument)
    expect(@article.publishable.class).to eq(Instrument)
  end

  it "must validate the article's author" do
    expect(@article.author).to eq(@user2)
    @article.author = nil
    expect(@article).not_to be_valid
  end

  it "must validate the article's approval status" do
    expect(@article.submitted?).to eq(true)
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