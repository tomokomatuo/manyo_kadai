class User < ApplicationRecord
    include SessionsHelper
    has_many :tasks, dependent: :destroy
    validates :email, uniqueness: true
    has_secure_password
    before_destroy :ensure_has_admin
    private
    
    def ensure_has_admin
      if self.admin?
        if User.count == 1
          throw(:abort) 
        end
      end
    end
end
