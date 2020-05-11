require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do
    describe 'ユーザ登録のテスト' do
     context 'ユーザのデータがなくログインしていない場合' do
        it 'ユーザ新規登録のテスト' do
          visit new_user_path
          fill_in 'user[name]', with: 'sample'
          fill_in 'user[email]', with: 'sample@example.com'
          fill_in 'user[password]', with: '00000000'
          fill_in 'user[password_confirmation]', with: '00000000'
          click_on 'create_new'
          expect(page).to have_content "sampleのページ"
        end
        it 'ログインしていない時はログイン画面に飛ぶテスト' do
          visit tasks_path
          expect(current_path).to eq new_session_path
        end
      end
    end
    describe 'セッション機能のテスト' do
      before do
    
    FactoryBot.create(:user)
    FactoryBot.create(:admin_user)
        # user = create(:user)
        # allow(User).to receive(:find_by).and_return(user)
    #   get(:show, session: {'user_id' => 1})
      end
      context 'ログインしていない場合' do
        it 'ログインできるテスト' do
        #   post :create, session: { id: '1', password: '00000000', email: 'sample@example.com' }
          visit new_session_path
          fill_in 'session_email', with: 'sample@example.com'
          fill_in 'session_password', with: '00000000'
          click_on 'commit_new'
        #   binding.irb
          expect(current_path).to eq user_path(id: 1)
        end
      end
     
      context 'ログインしている場合' do
        before do
            visit new_session_path
              fill_in 'session_email', with: 'sample@example.com'
              fill_in 'session_password', with: '00000000'
              click_on 'commit_new'
        end
        it '自分の詳細画面(マイページ)に飛べる' do
          # binding.irb
          expect(page).to have_content "sampleのページ"
        end
        it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移するテスト' do
            visit user_path(id: 2)
            expect(current_path).to eq tasks_path
        end
        it 'ログアウトができるテスト' do
             click_on 'logout'
             expect(current_path).to eq new_session_path
        end
      end
    end
    describe '管理画面のテスト' do
      before do

        @user = FactoryBot.create(:user)
        FactoryBot.create(:admin_user)
        # visit new_session_path
        # fill_in 'session_email', with: 'admin@example.com'
        # fill_in 'session_password', with: '00000000'
        # click_on 'commit'
      end
      context '管理画面にログインしていない場合' do
        it '管理者は管理画面にアクセスできるテスト' do
          visit new_session_path
          fill_in 'session_email', with: 'admin@example.com'
          fill_in 'session_password', with: '00000000'
          click_on 'commit_new'
          click_on 'admin_access'
          expect(current_path).to eq admin_user_path(id: 2)
        end
        it '一般ユーザは管理画面にアクセスできないテスト' do
            visit new_session_path
            fill_in 'session_email', with: 'sample@example.com'
            fill_in 'session_password', with: '00000000'
            click_on 'commit_new'
            visit 'admin/users'
            expect(current_path).to eq tasks_path
        end
      end
      context '管理画面にログインしている場合' do
        before do
          # FactoryBot.create(:admin_user)
          visit new_session_path
          fill_in 'session_email', with: 'admin@example.com'
          fill_in 'session_password', with: '00000000'
          click_on 'commit_new'
          visit user_path(id: 2)
          click_on 'admin_access'
        end
        it '管理者はユーザを新規登録できるテスト' do
          visit new_admin_user_path
          fill_in 'user_name', with: 'second_sample'
          fill_in 'user_email', with: 'second_sample@example.com'
          fill_in 'user_password', with: '00000001'
          fill_in 'user_password_confirmation', with: '00000001'
          click_on 'commit'
          expect(current_path).to eq admin_users_path
           
        end
        it '管理者はユーザの詳細画面にアクセスできるテスト' do
          visit admin_users_path
          visit admin_user_path(@user)
          expect(page).to have_content "sample"
        end
        it '管理者はユーザの編集画面からユーザを編集できるテスト' do
           visit admin_users_path
           visit edit_admin_user_path(@user)
           fill_in 'name_value', with: 'third_sample'
           fill_in 'email_value', with: 'third_sample@example.com'
           fill_in 'password_value', with: '00000002'
           fill_in 'password_confirmation_value', with: '00000002'
           click_on 'commit'
           expect(current_path).to eq admin_users_path
        end
        it '管理者はユーザの削除をできるテスト' do
          visit admin_users_path
          visit admin_user_path(@user)
          expect(@user.destroy).not_to have_content "sample"
        end
      end
    end
  end