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
    @article = Article.new( title: 'The history of the harp', 
                            publishable: @instrument, 
                            body: 'This is what happened in the 16th century..',
                            author: @user1, 
                            theme: @theme)
  end

  subject { @article }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:publishable) }
  it { should respond_to(:author) }
  it { should respond_to(:theme) }

  it "must be valid" do
    expect(@article).to be_valid
  end

  it "must have a valid factory" do
    article_fact = FactoryGirl.build(:approved_instrument_article)
    expect(article_fact).to be_valid
  end

  it "could belong to an instrument" do
    @article.save
    expect(@article.publishable).to eq(@instrument)
    expect(@article.publishable.class).to eq(Instrument)
  end

  it "must validate the article's author" do
    expect(@article.author).to eq(@user1)
    @article.author = nil
    expect(@article).not_to be_valid
  end

  it "must respond correctly to Article.approved(instrument)" do
    art1 = create(:submitted_instrument_article, publishable: @instrument)
    art2 = create(:approved_instrument_article, publishable: @instrument)
    art3 = create(:submitted_instrument_article, publishable: @instrument)
    art4 = create(:approved_instrument_article, publishable: @instrument)

    approved_articles = Article.approved(@instrument)
    expect( approved_articles ).to include(art2)
    expect( approved_articles ).to include(art4)
    expect( approved_articles ).not_to include(art1)
    expect( approved_articles ).not_to include(art3)

    submitted_articles = Article.submitted(@instrument)
    expect( submitted_articles ).to include(art1)
    expect( submitted_articles ).to include(art3)
    expect( submitted_articles ).not_to include(art2)
    expect( submitted_articles ).not_to include(art4)
  end

end