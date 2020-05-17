FactoryBot.define do
  factory :task do
    title { 'task' }
    content { 'content' }
    user
  end
 
  factory :second_task, class: Task do
    title { "second_title" }
    content { "second_content" }
    user
  end
end
