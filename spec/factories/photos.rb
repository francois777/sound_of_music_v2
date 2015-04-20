FactoryGirl.define do
  factory :photo do
    sequence(:title) { |n| "Photo #{n} on article" }
    submitted_by { User.user.take || create(:user) }
    imageable { Article.take || create(:instrument_article) }
    image 'my-photo.jpg'
  end
end  