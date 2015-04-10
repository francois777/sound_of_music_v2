class InstrumentsController < ApplicationController

  before_filter :authenticate_user!, only: [:create, :edit, :update, :submit]
  before_action :set_instrument, except: [:new, :create, :index, :update_subcategories]

  def show
    set_articles
    #authorize @instrument
  end

  def new
    @instrument = Instrument.new
    set_default_categories
  end

  def edit
    @categories = Category.all
    @subcategories = Subcategory.where("category_id = ?", Category.first.id)
    set_instrument_categories
    authorize @instrument
  end

  def create
    @instrument = Instrument.new(instrument_params_formatted)

    @instrument.created_by = current_user

    if @instrument.save
      flash[:notice] = t(:instrument_created, scope: [:success])
      redirect_to @instrument
    else
      flash[:alert] = t(:instrument_create_failed, scope: [:failure])
      set_default_categories
      render :new
    end
  end

  def update
    if @instrument.update_attributes(instrument_params_formatted)
      flash[:success] = t(:instrument_updated, scope: [:success])
      redirect_to @instrument
    else
      flash[:alert] = t(:instrument_update_failed, scope: [:failure])
      set_instrument_categories
      render :edit, instrument: @instrument
    end
  end

  def update_subcategories
    @subcategories = Subcategory.where("category_id = ?", params[:category_id].to_i)
    puts "Inside InstrumentsController#update_subcategories"

    respond_to do |format|
      format.js
    end
  end

  def index
    @context = "Instruments"
    case params['filter'] 
    when 'submitted'
      @instruments = policy_scope(Instrument).submitted.paginate(page: params[:page])
    when 'under-revision'
      @instruments = policy_scope(Instrument).to_be_revised.paginate(page: params[:page])  
    else
      @instruments = policy_scope(Instrument).paginate(page: params[:page])
    end
    
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

    def set_default_categories
      @categories = Category.all
      @subcategories = Subcategory.where("category_id = ?", Category.first.id)
    end

    def set_instrument_categories
      @categories = Category.all
      @subcategories = Subcategory.where("category_id = ?", @instrument.category_id)
    end

    def instrument_params
      params['instrument']
      params.require(:instrument).permit(:name, :other_names, 
        :performer_title, :category_id, :subcategory_id, :tuned, :origin_period)
    end

    def instrument_params_formatted
      new_params = instrument_params
      new_params["category_id"] = instrument_params["category_id"].to_i
      new_params["subcategory_id"] = instrument_params["subcategory_id"].to_i
      new_params
    end 

    def set_articles
      # puts "Executing set_articles"
      # if current_user.nil? 
      #   instrument_articles = @instrument.articles.approved
      #   puts "No current user, approved articles = #{instrument_articles.count}"
      # elsif current_user.user?
      #   instrument_articles = @instrument.articles.own_and_other_articles(current_user.id)
      #   puts "normal user, own and other articles = #{instrument_articles.count}"
      # else
      #   instrument_articles = @instrument.articles
      #   puts "Senior users, all articles = #{instrument_articles.count}"
      # end  
      scoped_articles = ArticlePolicy::Scope.new(current_user, @instrument).resolve
      if scoped_articles
        @articles = scoped_articles.collect { |art| { art_id: art.id, title: art.title, author_name: art.author.name, email: art.author.email, approval_status: art.approval_status, submitted_on: art.created_at }}
      else
        @articles = []
      end
    end

end