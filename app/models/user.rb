# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  rolify

  has_many :social_profiles, dependent: :destroy

  validates :terms_of_service, acceptance: true

  def self.from_omniauth(access_token)
    social_profile = SocialProfile.find_by provider: access_token.provider, uid: access_token.uid
    social_profile&.user
  end

  def self.build_with_social_profile(user_params, omniauth_data)
    user = User.new(user_params)
    user.social_profiles.new(
      provider: omniauth_data["provider"],
      uid: omniauth_data["uid"],
      email: omniauth_data["info"]["email"]
    )
    user
  end
end
