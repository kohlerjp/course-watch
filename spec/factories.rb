FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name "Kohler"
    email "kohler.j@husky.neu.edu"
    password "testing"
    password_confirmation "testing"
  end
end