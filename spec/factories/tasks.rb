FactoryBot.define do
  factory :task do
    title { 'task' }
    content { 'content' }
    association :user
  end
 
  factory :second_task, class: Task do
    title { "second_title" }
    content { "second_content" }
    association :user
  end
end
