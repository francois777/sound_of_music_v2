require 'spec_helper'

describe Category do

  include FactoryGirl::Syntax::Methods

  describe "Categories" do

    before do
      @category = create(:percussion)
      @membranophone = create(:membranophone, category: @category)
      @idiophone = create(:idiophone, category: @category)
    end

    subject { @category }

    it { should respond_to(:name) }

    it "must know it subcategories" do
      expect(@category.subcategories).to include(@membranophone)
      expect(@category.subcategories).to include(@idiophone)
    end
  end
end
