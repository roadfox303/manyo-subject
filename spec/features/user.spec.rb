require 'rails_helper'

RSpec.feature "ユーザー機能", type: :feature do
  background do
    @other_user = FactoryBot.create(:user)
    visit new_user_path
    fill_in "user_name", with: "テストユーザーA"
    fill_in "user_email", with: "testa@gmail.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "アカウント登録"
  end

  scenario "ユーザー登録" do
    expect(page.assert_text('testa@gmail.com')).to be true
  end

  scenario "ログイン中はユーザー登録画面に行けない" do
    visit new_user_path
    expect(page.assert_text('テストユーザーAのページ')).to be true
  end

  scenario "他人のマイページにはいけない" do
    visit user_path(@other_user.id)
    expect(page.assert_text('テストユーザーA')).to be true
  end

end
