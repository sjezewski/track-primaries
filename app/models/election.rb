class Election < ActiveRecord::Base
  validates :state, presence: true
  validates :kind, presence: true
  validates :date, presence: true
end
