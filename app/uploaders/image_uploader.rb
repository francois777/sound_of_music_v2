# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :s3

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  process :tags => ["image"]

  process :convert => 'jpg'

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_limit => [120, 120]
  end

  version :medium do
    process :resize_to_limit => [250,250]
  end

  version :large do
    process :resize_to_limit => [500,500]
    # cloudinary_transformation radius: 20
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # def filename
  #   "something.jpg" if original_filename
  # end

  def public_id
    env = case Rails.env
    when "development"
      "dev"
    when "production"
      "prod"
    else
      "test"
    end    
    "#{env}-#{model.image_name}"
  end

end
