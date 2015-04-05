class InstrumentsController < ApplicationController

  before_filter :authenticate_user!, only: [:create, :edit, :update, :submit]
  before_action :set_instrument, only: [:show, :edit, :update, :submit]
  before_action :set_user  


  def show
  end

  def new
    @instrument = Instrument.new
    @categories = Category.all
    @subcategories = Subcategory.where("category_id = ?", Category.first.id)

    puts "Categories: #{@categories.inspect}"
    puts "Subcategories: #{@subcategories.inspect}"
  end

  def edit
  end

  def create
  end

  def update
  end

  def update_subcategories
    puts "Inside InstrumentsController#update_subcategories"
    @subcategories = Subcategory.where("category_id = ?", params[:category].to_i)
    puts "@subcategories = #{@subcategories.inspect}"

    respond_to do |format|
      format.js
    end
  end


  def index
    @instruments = Instrument.paginate(page: params[:page])
  end

  def submit
  end

  private

    def set_user
      @user = current_user
    end

    def set_instrument
      @instrument = Instrument.find(params[:id].to_i)
    rescue
      @instrument = nil
    end

    def instrument_params
      params.require(:instrument).permit(:name, :other_names, 
        :performer_title, :category, :subcategory, :tuned, :origin_period)
    end
end