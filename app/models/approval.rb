class Approval < ActiveRecord::Base
  
  belongs_to :approvable, polymorphic: true
  belongs_to :approver, class_name: 'User'

  INCOMPLETE = { approval_status: :incomplete, rejection_reason: :not_rejected }
  SUBMITTED  = { approval_status: :submitted, rejection_reason: :not_rejected }
  APPROVED   = { approval_status: :approved, rejection_reason: :not_rejected }

  enum approval_status: [:incomplete, :submitted, :to_be_revised, :approved]
  enum rejection_reason: [:not_rejected, :grammar_and_spelling, :incorrect_facts, :irrelevant_material, :not_acceptable]

  validate :rejection_requires_rejection_reason, if: :to_be_revised?
  validate :rejection_reason_only_when_appropriate
  validate :validate_approver_required, if: "approval_status == 'approved' or approval_status == 'to_be_revised'"

  def not_yet_approved?
    (approval_status == 'incomplete') or (approval_status == 'submitted')
  end

  def reason_given_for_rejection?
    self.not_rejected? ? false : true
  end

  private

    def validate_approver_required
      errors.add(:approval_status, "An approver is required for this action") unless approver
    end

    def rejection_requires_rejection_reason
      if rejection_reason == 'not_rejected'
        errors.add(:approval_status, 'Must specify rejection reason when requesting a revision')
      end
    end

    def rejection_reason_only_when_appropriate
      if not_yet_approved? and reason_given_for_rejection?
        errors.add(:rejection_reason, 'Rejection Reason only applies when requesting a revision')
      end
    end

end  