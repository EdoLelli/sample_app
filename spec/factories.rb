FactoryGirl.define do
 factory :user do
    sequence(:name) {|n| "Person #{n}"}
    sequence(:email) {|n| "person_#{n}@example.it"}
    password "pazzini"
    password_confirmation "pazzini"
    
    factory :admin do
      after(:create) {|user| user.toggle!(:admin)}
    end
  end
end