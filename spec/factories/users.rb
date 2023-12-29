# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :user do
    trait :admin do
      after :create do |user|
        user.add_role :admin
      end
    end
  end
end
