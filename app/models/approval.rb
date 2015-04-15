class Approval < ActiveRecord::Base
  
  belongs_to :approvable, polymorphic: true
  belongs_to :approver, class_name: 'User'

  enum approval_status: [:incomplete, :submitted, :to_be_revised, :approved]
  enum rejection_reason: [:not_rejected, :grammar_and_spelling, :incorrect_facts, :irrelevant_material, :not_acceptable]

end  