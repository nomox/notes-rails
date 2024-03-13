class Note < ApplicationRecord
  validates :title, presence: true, length: { in: 3..120 }
  validates :content, presence: true
end
