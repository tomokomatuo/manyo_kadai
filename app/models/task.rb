class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  # VALID_SORT_COLUMNS = %w(dead_line)
  #   def index
  #   sort_expired = params[:sort_expired] if VALID_SORT_COLUMNS.include?(params[:sort_expired])
  #   @tasks = Task.order(sort_expired)
  #   end
  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      Task.where(['title LIKE ?', "%#{search}%"])
    else
      Task.all #全て表示。
    end
  end
end
 