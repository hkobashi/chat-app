class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one_attached :image

  validates :content, presence: true, unless: :was_attached?
  #validatesにunlessaオプションを付けることで
  #画像かテキストが入っていればテーブルに登録できるようになる。

  def was_attached?
    self.image.attached?
  end
end
