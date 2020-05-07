require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :model do
  context 'scopeメソッドで検索をした場合' do
    before do
      @date = Date.new(2019, 9, 29)
      @second_date = Date.new(2019, 10, 10)
      Task.create(title: "task", content: "sample_task", condition:"未着手", dead_line: @date, priority: "高")
      Task.create(title: "sample", content: "sample_sample", condition:"完了", dead_line: @second_date, priority: "低")
    end
    it "scopeメソッドでタイトル検索ができる" do
      expect(Task.title_search('task').count).to eq 1
    end
    it "scopeメソッドでステータス検索ができる" do
      expect(Task.condition_search('未着手').count).to eq 1
    end
    it "scopeメソッドでタイトルとステータスの両方が検索できる" do
      expect(Task.both_search('task','未着手').count).to eq 1
    end
  end

  pending "add some examples to (or delete) #{__FILE__}"
  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(title: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end
  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', content: '')
    expect(task).not_to be_valid
  end
  # it 'titleとcontentに内容が記載されていればバリデーションが通る' do
  #   task = Task.new(title: '成功テスト', content: '成功テスト')
  #   expect(task).to be_valid
  # end
  it '終了期限が空ならバリデーションが通らない' do
    task = Task.new(dead_line: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end
  it '状態が空ならバリデーションが通らない' do
    task = Task.new(condition: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end
  it '優先順位が空ならバリデーションが通らない' do
    task = Task.new(priority: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end
end
