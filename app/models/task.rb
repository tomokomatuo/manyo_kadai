class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  
  
  scope :title_search, -> (search){where('title LIKE ?', "%#{search}%")}
  scope :condition_search, -> (search){where(condition: search)}
  scope :both_search, ->(search, second_search) { where('title LIKE ?', "%#{search}%").where(condition: second_search)}
  
end
 