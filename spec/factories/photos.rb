FactoryGirl.define do
  factory :submitted_article_photo, class: Photo do
    sequence(:title) { |n| "Photo #{n} on article" }
    submitted_by { User.user.take || create(:user) }
    imageable { Article.all.sample || create(:approved_instrument_article) }
    image 'my-photo.jpg'
    after(:create) { |photo| create(:submitted_approval, approvable: photo) }
  end

  factory :approved_article_photo, class: Photo do
    sequence(:title) { |n| "Photo #{n} on article" }
    submitted_by { User.user.take || create(:user) }
    imageable { Article.all.sample || create(:approved_instrument_article) }
    image 'my-photo.jpg'
    after(:create) { |photo| create(:approved_approval, approvable: photo) }
  end
end  