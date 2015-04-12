class Admin::PhotosController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_photo

  def approve
    approve_params = photo_params
    if authorize @photo
      params[:commit] == "Approve" ? process_approval(approve_params) : process_rejection(approve_params)
    else
      flash[:error] = t(:approval_not_allowed, scope: [:failure])
    end  
    redirect_to [@collection, @photo]
  end

  private

    def process_approval(approve_params)
      @photo.approval_status = :approved
      @photo.rejection_reason = :not_rejected
      @photo.approved_by = current_user
      if @photo.save
        flash[:notice] = t(:photo_approved, scope: [:success])
      else
        puts "What is wrong with this photo?: #{@photo.inspect}"
        flash[:error] = t(:photo_not_approved, scope: [:failure])
      end
    end

    def process_rejection(approve_params)
      @photo.approval_status = :to_be_revised
      @photo.rejection_reason = params["photo"]["rejection_reason"].to_i
      @photo.approved_by = current_user
      if @photo.save
        flash[:notice] = t(:photo_to_be_revised, scope: [:success])
      else
        puts "What is wrong with this photo?: #{@photo.inspect}"
        flash[:error] = t(:article_not_approved, scope: [:failure])
      end
    end

    def set_photo
      @photo = Photo.find(params[:id].to_i)
      @collection = @photo.imageable
      @subject = @collection.publishable
    rescue
      flash[:alert] = t(:photo_not_found, scope: [:failure]) 
      redirect_to [@subject, @collection]
    end

    def photo_params
      params.require(:photo).permit(:rejection_reason )
    end

end