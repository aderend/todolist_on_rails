class List < ActiveRecord::Base
  has_many :tasks
  validates :category, presence: true
  validates :created_by, presence: true
end
