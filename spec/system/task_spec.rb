require 'rails_helper'
require 'date'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    # task = FactoryBot.create(:task, title: 'task')
    # 「タスク一覧画面」や「タスク詳細画面」などそれぞれのテストケースで、before内のコードが実行される
    # 各テストで使用するタスクを1件作成する
    # 作成したタスクオブジェクトを各テストケースで呼び出せるようにインスタンス変数に代入
    @date = Date.new(2019, 9, 29)
    @second_date = Date.new(2019, 10, 10)
    FactoryBot.create(:task, dead_line: @date)
    FactoryBot.create(:second_task, dead_line: @second_date)
  end
  # describe 'タスク一覧画面' do
  #   context 'タスクを作成した場合' do
  #     it '作成済みのタスクが表示される' do
  #     visit tasks_path
  #     expect(page).to have_content 'task'
  #     end
  #   end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in 'title_new', with: 'task'
        fill_in 'content_new', with: 'content'
        fill_in 'date_new', with: @date
        click_on '登録する'
        expect(page).to have_content @date
      end
    end
  end
  # describe 'タスク詳細画面' do
  #    context '任意のタスク詳細画面に遷移した場合' do
  #      it '該当タスクの内容が表示されたページに遷移する' do
  #       visit tasks_path
  #       click_on "show_link"
  #       expect(page).to have_content 'test_content'
  #      end
  #    end
  # end
  describe 'タスク一覧画面' do
    context '複数のタスクを作成した場合' do
      it 'タスク一覧が表示される' do
        # new_task = FactoryBot.create(:task, title: 'new_task')
        visit tasks_path
        task_list = all('.title_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        # binding.irb
        expect(task_list[0]).to have_content 'task'
        expect(task_list[1]).to have_content 'second_title'
      end
    end
  end
  describe 'タスク一覧画面' do
    context '終了期限順にソートする場合' do
      it '日時が降順で表示される' do
        visit tasks_path
        click_on 'sort'
        task_list = all('.date_row')
        expect(task_list[0]).to have_content @second_date
        expect(task_list[1]).to have_content @date
      end
    end
  end
end