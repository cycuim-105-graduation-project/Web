FactoryGirl.define do
  factory :event do
    name "MyString"
    description "MyText"
    feature_img "MyString"
    start_at "2016-12-09 10:30:05"
    end_at "2016-12-09 10:30:05"
    registration_start_at "2016-12-09 10:30:05"
    registration_end_at "2016-12-09 10:30:05"
    quantity 1
    vacancy 1
    place nil
  end
end
