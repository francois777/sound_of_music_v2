FactoryGirl.define do
  factory :photo do
    sequence(:title) { |n| "Photo #{n} on article" }
    submitted_by { User.user.take || create(:user) }
    imageable { Article.all.sample || create(:instrument_article) }
    image 'my-photo.jpg'
    after(:create) { |photo| create(:approved_approval, approvable: photo) }
  end
end  