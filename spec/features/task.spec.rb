require 'rails_helper'

RSpec.feature "タスク管理", type: :feature do
  class_variable_set(:@@last, 1)
  background do
    @user = FactoryBot.create(:user)
    FactoryBot.create(:state)
    FactoryBot.create(:state_2)
    FactoryBot.create(:state_3)
    FactoryBot.create(:task, title: "アソシエーション作成用", comment: "テストタスク", created_at: "#{Time.current - 2.days}", deadline: "#{Time.current + 6.days}")
  end

  def sort_test(item)
    find("option[value='#{item}']").select_option
    choose('desc')
    click_button "検索"
    tasks = all(".#{item}")
  end

  def set_form(type: nil ,item: nil ,value: nil, text:nil, mode:"and")
    case type
    when "select" then
      select text, :from => item
    when "check" then
      check item
      # find("#{item}").click
    when "radio" then
      choose(item)
    when "text_field" then
    end

    case mode
    when "and" then
      choose("and")
    when "or" then
      choose("or")
    end
  end

  def creatre_task(tasks)
    progress = ["未着手","着手中","完了"]
    tasks.times{|num|
      visit tasks_path
      click_link "新規作成"
      fill_in "form_title", with: "テストタイトル#{num}"
      fill_in "form_deadline", with: "2019/09/#{num} 014:30"
      fill_in "form_comment", with: "テストコメント#{num}"
      select progress[rand(0..2)], from: "task[statuses_attributes][0][state_id]"
      click_button "登録"
      visit tasks_path
    }
  end

  def record_id
    @@last = Task.last.id + 1
  end

  scenario "タスク作成" do
    creatre_task(5)
    expect(page).to have_link("テストタイトル")
    record_id
  end

  scenario "タスク削除" do
    creatre_task(5)
    click_link "テストタイトル2"
    click_link "削除"
    record_id
    expect(page).to have_no_link("テストタイトル2")
  end

  scenario "タスク編集" do
    creatre_task(5)
    click_link "テストタイトル3"
    click_link "編集"
    fill_in "form_title", with: "テストタイトルedit"
    fill_in "form_comment", with: "テストコメントedit"
    click_button "登録"
    record_id
    visit tasks_path
    expect(page).to have_link("テストタイトルedit")
  end

  scenario "タスクが作成日時の降順に並んでいる" do
    creatre_task(5)
    FactoryBot.create(:task, title: "99年", comment: "ああああ", created_at: "2019/09/24 01:30", deadline: "2099/09/28 01:30")
    record_id
    tasks = sort_test("created_at")
    expect(Date.strptime(tasks[0].text)).to be > Date.strptime(tasks[1].text)
  end

  scenario "タイトルが空ならバリデーションを通らない" do
    creatre_task(5)
    task = Task.new(title: "",deadline:"2019/09/20 01:30", comment: "失敗")
    record_id
    expect(task).not_to be_valid
  end

  scenario "コメントが空ならバリデーションを通らない" do
    creatre_task(5)
    task = Task.new(title: "コメントなし",deadline:"2019/09/26 01:30", comment: "")
    record_id
    expect(task).not_to be_valid
  end

  scenario "タイトル、コメントが記入されている" do
    creatre_task(5)
    task = Task.new(title: "テスト",deadline:"2019/09/28 01:30", comment: "成功")
    record_id
    expect(task).to be_valid
  end

  scenario "タスクが終了期日の降順に並んでいる" do
    creatre_task(5)
    record_id
    tasks = sort_test("deadline")
    expect(Date.strptime(tasks[0].text)).to be > Date.strptime(tasks[1].text)
  end

  scenario "タスクをステータス(進行状況)で絞り込み" do
    creatre_task(5)
    record_id
    set_form(type:"check", item:"_search_flag")
    set_form(type:"select", item:"_search_progress_type", text: "完了")
    click_button "検索"
    expect(all('.task_item').size).to be < 6
  end

end
