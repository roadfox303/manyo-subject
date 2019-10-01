require 'rails_helper'

RSpec.feature "admin機能", type: :feature do
  background do
    @admin_user = FactoryBot.create(:user)
    @admin = FactoryBot.create(:admin, user_id: @admin_user.id )
    log_in(@admin_user)
    create_user
    visit admin_users_path
  end

  def log_in(user)
    visit new_session_path
    fill_in "session_email", with: user.email
    fill_in "session_password", with: user.password
    click_button "Log in"
  end

  def create_user
    visit admin_users_path
    click_link "＋ ユーザー作成"
    fill_in "user_name", with: "テストユーザーA"
    fill_in "user_email", with: "testa@gmail.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "アカウント登録"
  end

  scenario "admin/ユーザー一覧" do
    expect(page.assert_text('ユーザー一覧')).to be true
  end

  scenario "admin/ユーザー作成" do
    expect(page.assert_text('テストユーザーA')).to be true
  end

  scenario "admin/ユーザー詳細" do
    all('.user_link').last.click
    expect(page.assert_text('ユーザー詳細')).to be true
  end

  scenario "admin/ユーザー更新" do
    all('.user_link').last.click
    click_link "ユーザー編集"
    fill_in "user_name", with: "テストユーザーB"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "送信"
    expect(page.assert_text('テストユーザーB')).to be true
  end

  scenario "admin/ユーザー削除" do
    all('.user_link').last.click
    click_link "削除"
    visit admin_users_path
    expect(all('.user_link').size).to be 1
  end

end
