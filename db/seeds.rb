states = [
  { progress:'未着手'},
  { progress:'着手中'},
  { progress:'完了'}
]
State.create! states
users = { name: 'テストユーザー', email: 'test@gmail.com', password: 'password333'}
User.create! users
