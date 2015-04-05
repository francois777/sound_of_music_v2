require 'spec_helper'

describe Subcategory do

  include FactoryGirl::Syntax::Methods

  describe "Subcategories" do

    before do
      @category = create(:percussion)
      @subcategory = create(:idiophone, category: @category)
    end

    subject { @subcategory }

    it { should respond_to(:name) }

    it "must know it parent category" do
      expect(@subcategory.category).to eq(@category)
    end
  end
end
