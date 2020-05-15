FactoryBot.define do
  factory :user do
    id { 1 }
    name { 'sample' }
    email { "sample@example.com" }
    password { '00000000' }
    admin { false }
  end
  factory :admin_user, class: User do
    id { 2 }
    name { 'admin' }
    email { 'admin@example.com' }
    password { '00000000' }
    admin { true }
  end
  factory :second_user, class: User do
    id { 3 }
    name { 'sample2' }
    email { 'sample2@example.com' }
    password { '00000000' }
    admin { false }
  end
end
