FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    email    "michael@example.com"
    aka 	 "trips"
    password "foobar"
    password_confirmation "foobar"
  end
end