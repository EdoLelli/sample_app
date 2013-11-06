FactoryGirl.define do
  factory :user do
    name     "Luca"
    email    "picci@example.it"
    password "pazzini"
    password_confirmation "pazzini"
  end
end