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
require "rails_helper"

describe SocialProfile do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end
end
