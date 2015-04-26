require 'file_size_validator'

class Photo < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  belongs_to :submitted_by, class_name: 'User'
  has_one :approval, as: :approvable, dependent: :destroy

  REJECTION_REASONS = [:not_rejected, :not_related_to_theme, :inferior_quality, :unsuitable_size]

  mount_uploader :image, ImageUploader
  before_save :increase_image_id,
              :assign_image_name

  validates :title, presence: true,
                    length: { minimum: 10, maximum: 255 }
  validates :image, :file_size => { :maximum => 0.5.megabytes.to_i }       
  validates :submitted_by, :imageable, presence: true

  def approval_status
    approval.approval_status.humanize if approval
  end

  def rejection_reason
    approval.rejection_reason.humanize if approval
  end

  private
    def increase_image_id
      publ = self.imageable.publishable
      publ.last_image_id += 1
      publ.save
    end

    def assign_image_name
      subject = self.imageable.publishable
      self.image_name = "#{subject.name.parameterize}-#{subject.last_image_id}"
    end

end