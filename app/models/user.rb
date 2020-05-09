class User < ApplicationRecord
    has_many :tasks, dependent: :destroy
    validates :email, uniqueness: true
    has_secure_password
end
