class User < ApplicationRecord
    has_many :tasks, dependent: :destroy
    validates :email, uniqueness: true
    has_secure_password
    before_destroy :ensure_has_admin
    private
    def ensure_has_admin
      throw(:abort) if self.admin
    end
end
