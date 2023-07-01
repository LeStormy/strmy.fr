class Url < ApplicationRecord
  has_many :uses, dependent: :destroy
end