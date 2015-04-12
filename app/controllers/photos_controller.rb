require 'digest/sha1'
class PhotosController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :submit, :approve]
  before_action :set_photo, only: [:show, :edit, :update]
  before_action :set_photo_parents, only: [:show, :new, :create, :edit, :update]

  def show
    @photo = Photo.find(params[:id].to_i)
  end

  def new
    @photo = @collection.photos.build
    @photo.image_name = "#{@subject.name.parameterize}-#{@subject.last_image_id + 1}"
  end

  def create
    @photo = @collection.photos.new(photo_params)
    @photo.submitted_by = current_user
    @photo.approval_status = :submitted
    @photo.rejection_reason = :not_rejected
    if @photo.save
      @photo.update_attributes(:bytes  => @photo.image.metadata['bytes'],
                               :width  => @photo.image.metadata['width'],
                               :height => @photo.image.metadata['height'],
                               :format => @photo.image.metadata['format']
      )
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

  private

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
      @collection = Article.find(params[:article_id].to_i) if params[:article_id]
    end

    def set_subject
      @subject = @collection.publishable
    end

end  