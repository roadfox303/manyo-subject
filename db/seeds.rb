states = [
  { progress:'未着手'},
  { progress:'着手中'},
  { progress:'完了'}
]
State.create! states
users = [{ name: 'Admin', email: 'admin@gmail.com', password: 'superadmin'},
  { name: 'テストユーザー', email: 'test@gmail.com', password: 'password333'}
]
User.create! users
admin = { user_id: 1}
Admin.create! admin
