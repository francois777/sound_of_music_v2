class InstrumentsController < ApplicationController

  before_filter :authenticate_user!, only: [:create, :edit, :update, :submit]
  before_action :set_instrument, except: [:new, :create, :index, :update_subcategories]

  def show
    authorize @instrument
  end

  def new
    @instrument = Instrument.new
    @categories = Category.all
    @subcategories = Subcategory.where("category_id = ?", Category.first.id)
  end

  def edit
    @categories = Category.all
    @subcategories = Subcategory.where("category_id = ?", Category.first.id)
    authorize @instrument
  end

  def create
    @instrument = Instrument.new(instrument_params)
    @instrument.created_by = current_user

    if @instrument.save
      flash[:notice] = t(:instrument_created, scope: [:success])
      redirect_to @instrument
    else
      flash[:alert] = t(:instrument_create_failed, scope: [:failure])
      render :new
    end
  end

  def update
    authorize @instrument
  end

  def update_subcategories
    @subcategories = Subcategory.where("category_id = ?", params[:category].to_i)
    puts "Inside InstrumentsController#update_subcategories"

    respond_to do |format|
      format.js
    end
  end

  def index
    @instruments = Instrument.paginate(page: params[:page])
    puts "Instrument count = #{Instrument.count}"
  end

  def destroy
    authorize @instrument
  end

  def submit
    authorize @instrument
  end

  private

    def set_instrument
      @instrument = Instrument.find(params[:id].to_i)
    rescue
      flash[:alert] = t(:instrument_not_found, scope: [:failure]) 
      redirect_to instruments_path
    end

    def instrument_params
      params.require(:instrument).permit(:name, :other_names, 
        :performer_title, :category, :subcategory, :tuned, :origin_period)
    end
end