require 'rails_helper'

RSpec.feature "タスク管理", type: :feature do
  background do
    @user = FactoryBot.create(:user)
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    visit tasks_path
    click_link "新規作成"

    fill_in "form_title", with: "テストタイトル"
    fill_in "form_deadline", with: "2019/09/20 014:30"
    fill_in "form_comment", with: "テストコメント"
    click_button "登録"
    visit tasks_path

  end

  def sort_test(item)
    find("option[value='#{item}']").select_option
    choose('desc')
    click_button "ソート"
    tasks = all('.created_at')
    expect(Date.strptime(tasks[0].text)).to be > Date.strptime(tasks[1].text)
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

  scenario "タスクが作成日時の降順に並んでいたら成功" do
    sort_test("created_at")
  end
  scenario "タイトルが空ならバリデーションを通らない" do
    task = Task.new(title: "",deadline:"2019/09/20 01:30", comment: "失敗")
    expect(task).not_to be_valid
  end
  scenario "コメントが空ならバリデーションを通らない" do
    task = Task.new(title: "コメントなし",deadline:"2019/09/26 01:30", comment: "")
    expect(task).not_to be_valid
  end
  scenario "タイトル、コメントが記入されていたら成功" do
    task = Task.new(title: "テスト",deadline:"2019/09/28 01:30", comment: "成功")
    expect(task).to be_valid
  end
  scenario "タスクが終了期日の降順に並んでいたら成功" do
    sort_test("deadline")
  end
end
