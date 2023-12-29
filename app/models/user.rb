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

  has_one :setting, class_name: "Users::Setting", dependent: :destroy
  has_many :social_profiles, dependent: :destroy
  has_many :posts, inverse_of: :author, dependent: :destroy

  validates :terms_of_service, acceptance: true

  after_create :create_setting

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

  private

  def create_setting
    Users::Setting.create user: self
  end
end
