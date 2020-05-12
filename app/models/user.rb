class User < ApplicationRecord
    has_many :tasks, dependent: :destroy
    validates :email, uniqueness: true
    before_validation :ensure_admin_has_a_value
    private
    def ensure_admin_has_a_value
        if admin.blank?
            self.admin = "true" 
        end
    end
    has_secure_password
end
