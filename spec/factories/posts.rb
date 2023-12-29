# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  content     :text             not null
#  published   :boolean          default(FALSE), not null
#  author_id   :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  editor_type :integer          not null
#
FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    published { false }

    author factory: :user

    trait :published do
      published { true }
    end
  end
end
