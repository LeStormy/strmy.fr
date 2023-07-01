class Use < ApplicationRecord
  belongs_to :url

  counter_culture :url
end