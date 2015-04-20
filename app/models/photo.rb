require 'file_size_validator'
class Photo < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  belongs_to :submitted_by, class_name: 'User'
  has_one :approval, as: :approvable, dependent: :destroy

  REJECTION_REASONS = [:not_rejected, :not_related_to_theme, :inferior_quality, :unsuitable_size]

  mount_uploader :image, ImageUploader
  before_save :assign_image_name, :increase_image_id

  # enum approval_status: [:submitted, :to_be_revised, :approved]
  # enum rejection_reason: [:not_rejected, :not_related_to_theme, :inferior_quality, :unsuitable_size]

  validates :title, presence: true,
                    length: { minimum: 10, maximum: 255 }
  validates :image, :file_size => { :maximum => 0.5.megabytes.to_i }       
  validates :submitted_by, :imageable, presence: true
  # validate :rejected_photo_requires_rejection_reason, if: :to_be_revised?
  # validate :rejection_reason_only_applies_when_requesting_revision
  # validate :validate_approver_required, if: "approval_status == 'approved' or approval_status == 'to_be_revised'"

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

    # def reason_given_for_rejection?
    #   rejection_reason != 'not_rejected'
    # end

    def assign_image_name
      subject = self.imageable.publishable
      self.image_name = "#{subject.name.parameterize}-#{subject.last_image_id + 1}"
    end

    # def validate_approver_required
    #   if approved_by_id == nil
    #     errors.add(:approval_status, "An approver is required for this action")
    #   end
    # end

    # def rejected_photo_requires_rejection_reason
    #   if rejection_reason == 'not_rejected'
    #     errors.add(:approval_status, 'Must specify rejection reason when requesting a revision')
    #   end
    # end

    # def rejection_reason_only_applies_when_requesting_revision
    #   if (submitted? or approved?) and reason_given_for_rejection?
    #     errors.add(:rejection_reason, 'Rejection Reason only applies when requesting a revision')
    #   end
    # end

end