class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :dead_line, presence: true
  validates :condition, presence: true
  validates :priority, presence: true
  
  scope :title_search, -> (search){where('title LIKE ?', "%#{search}%")}
  scope :condition_search, -> (search){where(condition: search)}
  scope :both_search, ->(search, second_search) { where('title LIKE ?', "%#{search}%").where(condition: second_search)}
  
  enum priority:{
    高: 0, 
    中: 1, 
    低: 2, 
  }
end
 