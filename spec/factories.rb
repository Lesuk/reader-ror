FactoryGirl.define do
  factory :user do
    name     "Alexandr Osetskiy"
    email    "some@example.com"
    password "foobar1"
    password_confirmation "foobar1"
  end
end