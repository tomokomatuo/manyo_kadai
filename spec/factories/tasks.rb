FactoryBot.define do
  # factory :task do
  #   title { 'test_title' }
  #   content { 'test_content' }  
  # end
  factory :task do
    title { 'title' }
    content { 'content' }
    user
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    title { "second_title" }
    content { "second_content" }
    user
  end
end
