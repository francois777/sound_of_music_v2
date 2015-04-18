class Approval < ActiveRecord::Base
  
  belongs_to :approvable, polymorphic: true
  belongs_to :approver, class_name: 'User'

  INCOMPLETE = { approval_status: :incomplete, rejection_reason: :not_rejected }
  SUBMITTED  = { approval_status: :submitted, rejection_reason: :not_rejected }
  APPROVED   = { approval_status: :approved, rejection_reason: :not_rejected }

  enum approval_status: [:incomplete, :submitted, :to_be_revised, :approved]
  enum rejection_reason: [:not_rejected, :grammar_and_spelling, :incorrect_facts, :irrelevant_material, :not_acceptable]

end  