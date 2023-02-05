# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  hashid     :string(255)
#
require "rails_helper"

describe User do
  describe "associations" do
    it { is_expected.to have_one(:setting).class_name("Users::Setting").dependent(:destroy) }
    it { is_expected.to have_many(:social_profiles).dependent(:destroy) }
    it { is_expected.to have_many(:posts).inverse_of(:author).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_acceptance_of(:terms_of_service) }
  end

  describe "#hashid" do
    it "generates after save automatically" do
      user = create(:user)
      expect(user.hashid).to be_truthy
    end
  end

  describe "#terms_of_service" do
    subject(:user) { build(:user) }

    context "when checked" do
      it "creates user" do
        user.terms_of_service = "1"
        expect { user.save! }.to change(User, :count).by(1)
      end
    end

    context "when unchecked" do
      it "faileds" do
        user.terms_of_service = "0"
        expect { user.save }.not_to change(User, :count)
      end
    end
  end

  describe ".from_omniauth" do
    subject!(:user) { User.build_with_social_profile({}, omniauth_data).tap(&:save) }

    let(:omniauth_data) { Faker::Omniauth.google.with_indifferent_access }
    let(:access_token) { ActiveSupport::InheritableOptions.new omniauth_data }

    it "returns correct user" do
      expect(User.from_omniauth(access_token)).to eq user
    end
  end

  describe ".build_with_social_profile" do
    subject(:user) { User.build_with_social_profile({}, omniauth_data) }

    let(:omniauth_data) { Faker::Omniauth.google.with_indifferent_access }

    it "creates user and social_profile" do
      expect { user.save! }
        .to change(User, :count).by(1).and change(SocialProfile, :count).by(1)
    end
  end

  describe "#create_setting" do
    subject(:user) { build(:user) }

    it "creates setting" do
      user.save!
      expect(user.setting).to be_truthy
    end
  end
end
