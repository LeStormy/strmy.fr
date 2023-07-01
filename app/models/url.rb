class Url < ApplicationRecord
  has_many :uses, dependent: :destroy

  validates :code, presence: true, uniqueness: true
end