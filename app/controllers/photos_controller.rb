require 'digest/sha1'
class PhotosController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_photo, only: [:show, :edit, :update]
  before_action :set_photo_parents, only: [:show, :new, :create, :edit, :update]

  def show
    @submitted_by = @photo.submitted_by.name
    @approval = @photo.approval
    authorize @photo
  end

  def new
    @photo = @collection.photos.build
    @photo.image_name = "#{@subject.name.parameterize}-#{@subject.last_image_id + 1}"
  end

  def create
    @photo = @collection.photos.new(photo_params)
    @photo.submitted_by = current_user
    if @photo.save
      @photo.update_attributes(:bytes  => @photo.image.metadata['bytes'],
                               :width  => @photo.image.metadata['width'],
                               :height => @photo.image.metadata['height'],
                               :format => @photo.image.metadata['format']
      )
      create_approval(@photo.reload)
      flash[:notice] = t(:photo_stored_successfully, scope: [:success])
      redirect_to [@collection, @photo]
    else
      flash[:error] = t(:photo_not_uploaded, scope: [:failure])
      render :new
    end
  end

  def edit
  end

  def update
    if @photo.update_attributes(photo_params)
      flash[:notice] = t(:photo_updated_successfully, scope: [:success])
      redirect_to [@collection, @photo]
    else
      flash[:alert] = t(:photo_update_failed, scope: [:failure])
      set_collection
      set_subject
      render :action => 'edit', :photo => @photo
    end
  end

  def user_not_authorized
    flash[:alert] = "This photo is not yet approved. You may not perform this action."
    redirect_to (request.referrer || root_path)
  end

  private

    def create_approval(approvable)
      approval_params = Approval::SUBMITTED.merge( {approvable: @photo} )
      Approval.create( approval_params )
    end

    def set_photo_parents
      set_collection
      set_subject
    end

    def photo_params
      params.require(:photo).permit(:title, :name, :image_name, :image, :bytes, :width, :height, :format, :remote_image_url, :approval_status, :rejection_reason, assets_attributes: [:asset])
    end

    def set_photo
      @photo = Photo.find(params[:id].to_i)
    rescue
      flash[:alert] = t(:photo_not_found, scope: [:failure]) 
      redirect_to [@subject, @collection]
    end

    def set_collection
      @collection = nil
      @collection = Article.find(params[:article_id].to_i) if params[:article_id]
    end

    def set_subject
      @subject = @collection.publishable
    end

end  