require 'rails_helper'
# require 'spec_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do

    @date = Date.new(2020, 06, 20)
    @second_date = Date.new(2020, 10, 10)
    @label = FactoryBot.create(:label)
    # @second_label = FactoryBot.create(:second_label)
    @user = FactoryBot.create(:user)
    @task = FactoryBot.create(:task, user: @user, dead_line: @date, priority: '低', condition: '完了')
    @second_task = FactoryBot.create(:second_task, user: @user, dead_line: @second_date, priority: '高', condition: '未着手')
    # @labelling = FactoryBot.create(:labelling, task: @task, label: @label)
    
    visit new_session_path
    fill_in 'session_email', with: 'sample@example.com'
    fill_in 'session_password', with: '00000000'

    click_on 'commit_new'
    visit tasks_path
   end
  
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
      expect(page).to have_content 'task'
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in 'title_new', with: 'task'
        fill_in 'content_new', with: 'content'
        select("2020", :from => 'task[dead_line(1i)]')
        select("6月", :from => 'task[dead_line(2i)]')
        select("20", :from => 'task[dead_line(3i)]')
        # fill_in 'date_new', with: '6月'
        # fill_in 'date_new', with: '20日'
        select('未着手', :from => 'task_condition')
        select('高', :from => 'task_priority')
        click_on '登録する'
        save_and_open_page
        expect(page).to have_content @date
      end

      it 'ラベル機能が保存される' do
        visit new_task_path
        fill_in 'title_new', with: 'task'
        fill_in 'content_new', with: 'content'
        select("2020", :from => 'task[dead_line(1i)]')
        select("6月", :from => 'task[dead_line(2i)]')
        select("20", :from => 'task[dead_line(3i)]')
        select('未着手', :from => 'task_condition')
        select('高', :from => 'task_priority')
        check 'sample0'
        click_on '登録する'
        save_and_open_page
        expect(page).to have_content 'sample0'
      end
    end
  end
  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移する' do
       
        page.all(".show_link")[1].click
        # visit task_path(@task)
        expect(page).to have_content 'content'
       end
       it 'タスクに紐づいたラベルが表示される' do
       
        page.all(".show_link")[1].click
        expect(page).to have_content "sample0"
       end
     end
  end
  describe 'タスク編集画面' do
    context '任意のタスク編集画面に遷移した場合' do
      it 'タスクが更新できる' do
        visit edit_task_path(@task)
        fill_in 'title_new', with: 'task'
        fill_in 'content_new', with: 'content'
        select("2020", :from => 'task[dead_line(1i)]')
        select("6月", :from => 'task[dead_line(2i)]')
        select("20", :from => 'task[dead_line(3i)]')
        select('未着手', :from => 'task_condition')
        select('高', :from => 'task_priority')
        check 'sample0'
        click_on '更新する'
        save_and_open_page
        expect(page).to have_content 'sample0'
      end
    end
  end
  describe 'タスク一覧画面' do

    describe 'タスク一覧画面' do

     context '検索をした場合' do
      it "タイトルで検索できる" do
        fill_in 'title_search', with: 'task'
        click_on 'submit'
        expect(page).to have_content 'task'
      end
      it "ステータスで検索できる" do
        select('未着手', :from => 'task_condition')
        click_on 'submit'
        expect(page).to have_content '未着手'
      end
      it "タイトルとステータスの両方で検索できる" do
        fill_in 'title_search', with: 'task'
        select('未着手', :from => 'task_condition')
        click_on 'submit'
        expect(page).to have_content 'task', '未着手'
      end
      it "ラベルで検索できる" do
        select('sample0', :from => 'label_id')
        click_on 'label_submit'
        expect(page).to have_content 'sample0'
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスク一覧が表示される' do
        task_list = all('.title_row') 
        expect(task_list[0]).to have_content 'task'
        expect(task_list[1]).to have_content 'second_title'
      end
    end
  end
  describe 'タスク一覧画面' do
    context '終了期限順にソートする場合' do
      it '日時が降順で表示される' do
        click_on 'sort'
        sleep(3)
        task_list = all('.date_row')
        expect(task_list[0]).to have_content @second_date
        expect(task_list[1]).to have_content @date
      end
    end
    context '優先順位の高い順にソートする場合' do
      it '優先順位が降順で表示される' do
        click_on 'sort_priority'
        sleep(3)
        task_list = all('.priority_row')
        expect(task_list[0]).to have_content '高'
        expect(task_list[1]).to have_content '低'
      end
    end
  end
  describe 'タスク管理機能' do
    context 'scopeメソッドで検索をした場合' do
      it "scopeメソッドでタイトル検索ができる" do
        expect(Task.title_search('task').count).to eq 1
      end
      it "scopeメソッドでステータス検索ができる" do
        expect(Task.condition_search('未着手').count).to eq 1
      end
      it "scopeメソッドでタイトルとステータスの両方が検索できる" do
        expect(Task.both_search('task','完了').count).to eq 1
      end
    end
  end
end
