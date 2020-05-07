class User < ApplicationRecord
    has_many :tasks
    validates :email, uniqueness: true
end
