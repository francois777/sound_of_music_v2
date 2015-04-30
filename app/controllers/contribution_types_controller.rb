class ContributionTypesController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_contribution_type, except: [:new, :create, :index]

  def show
  end

  def new
    @contribution_type = ContributionType.new
    authorize @contribution_type
  end

  def index
    @contribution_types = ContributionType.all.paginate(page: params[:page])
  end

  def create
    @contribution_type = ContributionType.new(contribution_type_params_formatted)
    if @contribution_type.save
      flash[:notice] = t(:contribution_type_created, scope: [:success])
      redirect_to @contribution_type
    else
      flash[:alert] = t(:contribution_type_create_failed, scope: [:failure])
      render :new
    end
  end

  def edit
    authorize @contribution_type
  end

  def update
    if @contribution_type.update_attributes(contribution_type_params_formatted)
      flash[:notice] = t(:contribution_type_updated, scope: [:success])
      redirect_to @contribution_type
    else
      flash[:alert] = t(:contribution_type_update_failed, scope: [:failure])
      render :edit
    end
  end

  def user_not_authorized
    flash[:alert] = "You are not authorised to perform this action on Contribution Types."
    redirect_to (request.referrer || contribution_types_path)
  end

  private

    def contribution_type_params
      params.require(:contribution_type).permit(:definition, :classification, :group_type, :voice_type)
    end

    def contribution_type_params_formatted
      new_params = contribution_type_params
      new_params['classification'] = contribution_type_params['classification'].to_i
      new_params['group_type'] = contribution_type_params['group_type'].to_i
      new_params['voice_type'] = contribution_type_params['voice_type'].to_i
      new_params
    end

    def set_contribution_type
      @contribution_type = ContributionType.find(params[:id].to_i)
    rescue
      flash[:alert] = t(:contribution_type_not_found, scope: [:failure]) 
      redirect_to contribution_types_path
    end

end