class StaticPagesController < ApplicationController
  before_action :set_user

  def home
    @images = image_collection
    @artist = Artist.approved.sample
  end

  private

    def set_user
      @user = current_user
    end

    def image_collection
      images = []
      img_count = 0
      cnt = 0
      while img_count < 9 do
        cnt += 1
        break if cnt > 12
        photo = Photo.approved.sample
        unless images.include?(photo)
          images << photo 
          img_count += 1
        end
      end
      
      return images  
    end

end