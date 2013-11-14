FactoryGirl.define do
  factory :user do
    name     "Matteo"
    email    "matteo@example.it"
    password "pazzini"
    password_confirmation "pazzini"
  end
end