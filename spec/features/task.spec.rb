require 'rails_helper'

RSpec.feature "タスク管理", type: :feature do
  background do
    @user = FactoryBot.create(:user)
  end

  def create_task
    visit tasks_path

    click_link "タスク作成"

    fill_in "form_title", with: "テストタイトル"
    fill_in "form_comment", with: "テストコメント"
    click_button "登録"
    visit tasks_path
  end

  scenario "タスク作成" do
    create_task
    expect(page).to have_link("テストタイトル")
  end

  scenario "タスク削除" do
    create_task
    click_link "テストタイトル"
    click_link "削除"

    expect(page).to have_no_link("テストタイトル")
    # save_and_open_page
  end

  scenario "タスク編集" do
    create_task
    click_link "テストタイトル"
    click_link "編集"

    fill_in "form_title", with: "テストタイトルedit"
    fill_in "form_comment", with: "テストコメントedit"
    click_button "登録"
    visit tasks_path

    expect(page).to have_link("テストタイトルedit")
  end
end
