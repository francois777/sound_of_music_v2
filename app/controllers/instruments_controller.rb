class InstrumentsController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :submit]
  before_action :set_instrument, except: [:new, :create, :index, :update_subcategories]

  def show
    authorize @instrument
    @context = "Articles"
    @submitted_by = @instrument.created_by.name
    @approval = @instrument.approval
    set_articles
    a = 1
  end

  def index
    @context = "Instruments"
    case params['filter'] 
    when 'approved'
      @instruments = policy_scope(Instrument).approved.paginate(page: params[:page])
    when 'submitted'
      @instruments = policy_scope(Instrument).submitted.paginate(page: params[:page])
    when 'under_revision'
      @instruments = policy_scope(Instrument).to_be_revised.paginate(page: params[:page])  
    else
      @instruments = policy_scope(Instrument).paginate(page: params[:page])
    end
  end

  def new
    authorize Instrument
    @instrument = Instrument.new
  end

  def edit
    authorize @instrument
  end

  def create
    @instrument = Instrument.new(instrument_params_formatted)
    authorize @instrument
    @instrument.created_by = current_user
    if @instrument.save
      create_approval(@instrument.reload)
      flash[:notice] = t(:instrument_created, scope: [:success])
      redirect_to @instrument
    else
      flash[:alert] = t(:instrument_create_failed, scope: [:failure])
      render :new
    end
  end

  def update
    authorize @instrument
    if @instrument.update_attributes(instrument_params_formatted)
      flash[:success] = t(:instrument_updated, scope: [:success])
      redirect_to @instrument
    else
      flash[:alert] = t(:instrument_update_failed, scope: [:failure])
      render :edit, instrument: @instrument
    end
  end

  def update_subcategories
    @subcategories = Subcategory.where("category_id = ?", params[:category_id].to_i)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    authorize @instrument
    @instrument.delete
    flash[:notice] = t(:instrument_deleted, scope: [:success])
    redirect_to instrument_path(@subject)
  end

  def user_not_authorized
    flash[:alert] = "This instrument is not yet approved. You may not perform this action."
    redirect_to (request.referrer || root_path)
  end

  private

    def create_approval(approvable)
      approval_params = Approval::INCOMPLETE.merge( {approvable: @instrument} )
      Approval.create( approval_params )
    end

    def set_instrument
      @subject = @instrument = Instrument.find(params[:id].to_i)
    rescue
      flash[:alert] = t(:instrument_not_found, scope: [:failure]) 
      redirect_to instruments_path
    end

    def instrument_params
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
      scoped_articles = ArticlePolicy::Scope.new(current_user, Article, @instrument).resolve
      if scoped_articles.any?
        filter = params['filter']
        if @context == 'Articles'
          case filter
          when 'all_for_publishable'
            articles = scoped_articles(@instrument)
          when 'incomplete'
            articles = scoped_articles.incomplete(@instrument)
          when 'submitted'
            articles = scoped_articles.submitted(@instrument)
          when 'under_revision'
            articles = scoped_articles.to_be_revised(@instrument)
          else
            articles = scoped_articles
          end  
          @articles = articles.collect { |art| { art_id: art.id, title: art.title, author_name: art.author.name, email: art.author.email, approval_status: art.approval_status_display, submitted_on: art.created_at }}
        end
      else
        @articles = []
      end
    end

end