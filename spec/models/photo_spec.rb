require 'spec_helper'

describe Photo do

  include FactoryGirl::Syntax::Methods

  before do
    @user = create(:user)
    @approver = create(:approver)
    @category = create(:strings)
    @subcategory = create(:bowed)
    @instrument = create(:approved_instrument, name: 'Alto saxophone', created_by: @user, category: @category, subcategory: @subcategory)
    @theme = create(:instrument_theme)
    @article = create(:approved_instrument_article, author: @user, publishable: @instrument, theme: @theme)
    @photo = Photo.new(
      title: "An old violin",
      submitted_by: @user,
      image_name: 'photo-1',
      image: 'old_violin.png',
      imageable: @article )
  end

  subject { @photo }

  it { should respond_to(:title) }
  it { should respond_to(:submitted_by) }
  it { should respond_to(:imageable) }
  it { should respond_to(:image) }

  it "must be valid" do
    expect(@photo).to be_valid
    @photo.save
    expect(@photo.image_name).to eq("alto-saxophone-#{@instrument.last_image_id}")
    expect(@photo.image).not_to be_nil
  end

  it "must have a valid factory" do
    photo_factory = build(:approved_article_photo)
    expect(photo_factory).to be_valid
  end

  it "must belong to an imageable collection" do
    expect(@photo.imageable).to eq(@article)
    @photo.imageable = nil
    expect(@photo).not_to be_valid
  end

  it "will belong to a subject" do
    expect(@photo.imageable.publishable).to eq(@instrument)
  end

  it "is submitted by a user" do
    expect(@photo.submitted_by).to eq(@user)
    @photo.submitted_by = nil
    expect(@photo).not_to be_valid
  end

  it "must validate the photo's title" do
    expect(@photo.title).to eq("An old violin")
    @photo.title = ""
    expect(@photo).not_to be_valid
    @photo.title = "Short"
    expect(@photo).not_to be_valid
    @photo.title = "L" * 256
    expect(@photo).not_to be_valid
  end

  it "must validate the photo's approval_status" do
    @photo.save
    approval_params = Approval::SUBMITTED.merge( {approvable: @photo} )
    @approval = Approval.create( approval_params )
    expect(@photo.approval.submitted?).to eq(true)
    expect(@photo).to be_valid
    expect { @photo.approval.approval_status = 'wrong' }.to raise_error(ArgumentError)
  end
end