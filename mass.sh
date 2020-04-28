EP="http://34.84.74.173"
NAME="test"
EMAIL="hoge@gmail.com"
PW="1234"

echo "ユーザ生成テスト (admin=1)"
curl -X POST -H "Content-Type: application/json" -d '{"name":$NAME, "email":$EMAIL, "password": $PW, "admin": "1"}' "$EP/api/create"
echo ""

echo "ログイン"
SESSION_ID=`curl -s -X POST -H "Content-Type: application/json" -d '{"name": $NAME, "password": $PW}' "$EP/api/login" | jq .session_id`
echo "SESSION_ID=$SESSION_ID"

echo "adminでないことを確認"
curl -X GET -H "Content-Type: application/json" -d '{"id":"1", "good_id":"2", "count": "0", "discount": "50"}' "$EP/admin" --cookie "session_id=$SESSION_ID"
echo ""
