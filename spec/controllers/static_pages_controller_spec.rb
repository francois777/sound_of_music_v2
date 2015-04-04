require 'rails_helper'

describe StaticPagesController do

  describe "GET #home" do
    before do
      get :home
    end

    it { should respond_with 200 }
  end

  describe "Root path" do
    it "should respond to root path" do
      visit root_path
      expect(response.status).to eq(200)
    end
  end
end
