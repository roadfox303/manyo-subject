require 'rails_helper'

RSpec.feature "タスク管理", type: :feature do
  background do
    @user = FactoryBot.create(:user)
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    visit tasks_path
    click_link "新規作成"

    fill_in "form_title", with: "テストタイトル"
    fill_in "form_comment", with: "テストコメント"
    click_button "登録"
    visit tasks_path

  end

  scenario "タスク作成" do
    expect(page).to have_link("テストタイトル")
  end

  scenario "タスク削除" do
    click_link "テストタイトル"
    click_link "削除"
    expect(page).to have_no_link("テストタイトル")
  end

  scenario "タスク編集" do
    click_link "テストタイトル"
    click_link "編集"
    fill_in "form_title", with: "テストタイトルedit"
    fill_in "form_comment", with: "テストコメントedit"
    click_button "登録"
    visit tasks_path
    expect(page).to have_link("テストタイトルedit")
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    find("option[value='created_at']").select_option
    choose('desc')
    click_button "ソート"
    tasks = all('.task_item')
    expect(Date.strptime(tasks[0].text)).to be > Date.strptime(tasks[1].text)
  end
  scenario "タイトルが空ならバリデーションを通らない" do
    task = Task.new(title: "", comment: "失敗")
    expect(task).not_to be_valid
  end
  scenario "コメントが空でもバリデーション通る" do
    task = Task.new(title: "コメントなし", comment: "")
    expect(task).to be_valid
  end
end
