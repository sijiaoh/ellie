# == Schema Information
#
# Table name: social_profiles
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  provider   :integer          not null
#  uid        :string           not null
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :social_profile do
    transient do
      google { Faker::Omniauth.unique.google }
    end

    provider { google[:provider] }
    uid { google[:uid] }
    email { google[:info][:email] }

    user
  end
end
