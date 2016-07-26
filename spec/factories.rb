FactoryGirl.define do
  factory :invite do
    
  end

  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
  end

  factory :game do
    name "Testgame"
    association :white_player, factory: :user
  end
end