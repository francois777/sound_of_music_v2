FactoryGirl.define do

  factory :incomplete_approval, class: Approval do
    approval_status :incomplete
    rejection_reason :not_rejected
    approvable Artist.first
  end
  
  factory :submitted_approval, class: Approval do
    approval_status :submitted
    rejection_reason :not_rejected
    approvable Artist.first
    approver { User.approver.first || create(:approver) }
  end
  
  factory :approved_approval, class: Approval do
    approval_status :approved
    rejection_reason :not_rejected
    approvable Artist.first
    approver nil
  end
  
  factory :rejected_approval, class: Approval do
    approval_status :to_be_revised
    rejection_reason :incorrect_facts
    approvable Artist.first
    approver { User.approver.first || create(:approver) }
  end
  
end
