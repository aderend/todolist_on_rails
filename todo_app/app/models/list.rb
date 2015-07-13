class List < ActiveRecord::Base
  has_many :tasks
  validates :category, uniqueness: true, presence: true
  validates :created_by, presence: true
end
