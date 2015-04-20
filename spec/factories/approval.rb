FactoryGirl.define do

  factory :incomplete_approval, class: Approval do
    approval_status :incomplete
    rejection_reason :not_rejected
    approvable { Artist.first || create(:artist) }
  end
  
  factory :submitted_approval, class: Approval do
    approval_status :submitted
    rejection_reason :not_rejected
    approvable { Artist.first || create(:artist) }
  end
  
  factory :approved_approval, class: Approval do
    approval_status :approved
    rejection_reason :not_rejected
    approvable { Artist.first || create(:artist) }
    approver { User.approver.first || create(:approver) }
  end
  
  factory :rejected_approval, class: Approval do
    approval_status :to_be_revised
    rejection_reason :incorrect_facts
    approvable { Artist.first || create(:artist) }
    approver { User.approver.first || create(:approver) }
  end
  
end
