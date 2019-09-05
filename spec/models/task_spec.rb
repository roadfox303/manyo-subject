require 'rails_helper'

feature Task, type: :model do
  background do
    @user = FactoryBot.create(:user)
  end

  it "タスクが作成できるか" do
    Task.create(title: 'あああ', comment: 'あいうえお', user_id: @user.id)
    Task.create(title: 'あああ', comment: 'あいうえお', user_id: nil)
    Task.create(title: 'あああ', comment: 'あいうえお', user_id: nil)
    Task.create(title: '', comment: 'あいうえお', user_id: @user.id)
    expect(Task.all.count).to eq 3
  end
end
