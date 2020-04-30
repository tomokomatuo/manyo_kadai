class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  # VALID_SORT_COLUMNS = %w(dead_line)
  #   def index
  #   sort_expired = params[:sort_expired] if VALID_SORT_COLUMNS.include?(params[:sort_expired])
  #   @tasks = Task.order(sort_expired)
  #   end
end
 