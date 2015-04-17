FactoryGirl.define do
  factory :photo do
    sequence(:title) { |n| "Photo #{n} on article" }
    submitted_by { User.user.take || create(:user) }
    approved_by { User.approver.take || create(:approver) }
    imageable { Article.take || create(:instrument_article) }
    approval_status :submitted
    rejection_reason :not_rejected
    image 'my-photo.jpg'
  end
end  