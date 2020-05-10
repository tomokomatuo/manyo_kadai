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
          click_on '登録する'
          expect(current_path).to eq user_path(id: 1)
        end
        it 'ログインしていない時はログイン画面に飛ぶテスト' do
          visit tasks_path
          expect(current_path).to eq new_session_path
        end
      end
    end
    describe 'セッション機能のテスト' do
      context 'ログインしていない場合' do
        it 'ログインできるテスト' do
           
        end
      end
      context 'ログインしている場合' do
        it '自分の詳細画面(マイページ)に飛べる' do
             
        end
        it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移するテスト' do
             
        end
        it 'ログアウトができるテスト' do
             
        end
      end
    end
    describe '管理画面のテスト' do
      context '管理画面にログインしていない場合' do
        it '管理者は管理画面にアクセスできるテスト' do
           
        end
        it '一般ユーザは管理画面にアクセスできないテスト' do
           
        end
      end
      context '管理画面にログインしている場合' do
        it '管理者はユーザを新規登録できるテスト' do
           
        end
        it '管理者はユーザの詳細画面にアクセスできるテスト' do
           
        end
        it '管理者はユーザの編集画面からユーザを編集できるテスト' do
           
        end
        it '管理者はユーザの削除をできるテスト' do
           
        end
      end
    end
  end