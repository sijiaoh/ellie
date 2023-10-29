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
#  hashid      :string
#  editor_type :integer          not null
#
class Post < ApplicationRecord
  include HashidSluggable
  include EditorTypeEnum
  include HasContent

  belongs_to :author, class_name: "User"

  validates :title, presence: true

  before_create :set_editor_type_from_author

  scope :published, -> { where(published: true) }

  private

  def set_editor_type_from_author
    self.editor_type = author.setting.editor_type
  end
end
