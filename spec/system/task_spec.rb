require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    # 「タスク一覧画面」や「タスク詳細画面」などそれぞれのテストケースで、before内のコードが実行される
    # 各テストで使用するタスクを1件作成する
    # 作成したタスクオブジェクトを各テストケースで呼び出せるようにインスタンス変数に代入
    @task = FactoryBot.create(:task, title: 'task')
  end
  background do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
      visit tasks_path
      expect(page).to have_content 'task'
      end
    end
  end
  # describe 'タスク登録画面' do
  #   context '必要項目を入力して、createボタンを押した場合' do
  #     it 'データが保存される' do
  #       visit new_task_path
  #       fill_in 'title_new', with: 'task'
  #       fill_in 'content_new', with: 'content'
  #       click_on '登録する'
  #       expect(page).to have_content 'task', 'content'
  #     end
  #   end
  # end
  # describe 'タスク詳細画面' do
  #    context '任意のタスク詳細画面に遷移した場合' do
  #      it '該当タスクの内容が表示されたページに遷移する' do
  #       visit tasks_path
  #       click_on "show_link"
  #       expect(page).to have_content 'test_content'
  #      end
  #    end
  # end
  context '複数のタスクを作成した場合' do
    it 'タスクが作成日時の降順に並んでいる' do
      new_task = FactoryBot.create(:task, title: 'new_task')
        visit tasks_path
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'new_task'
        expect(task_list[1]).to have_content 'task'
    end
  end
end