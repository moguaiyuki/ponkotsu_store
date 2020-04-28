# ちゃんと更新されたか確認するためのコード
# メイン
EP="http://34.84.74.173/api"
# ローカル
# EP="http://localhost/api"

echo "ログイン"
SESSION_ID=`curl -s -X POST -H "Content-Type: application/json" -d '{"name": "kurenaif", "password": "password"}' "$EP/login" | jq .session_id`
echo "SESSION_ID=$SESSION_ID"

echo "普通に購入するケース (成功)"
curl -X POST -H "Content-Type: application/json" -d '{"id":"1", "good_id":"2", "count": "1", "discount": "0"}' "$EP/buy" --cookie "session_id=$SESSION_ID"
echo "" 

echo "カウントをマイナスにして購入するケース(エラー)"
curl -X POST -H "Content-Type: application/json" -d '{"id":"1", "good_id":"2", "count": "-1", "discount": "0"}' "$EP/buy" --cookie "session_id=$SESSION_ID"
echo ""

echo "カウントをfloatにして購入するケース(エラー)"
curl -X POST -H "Content-Type: application/json" -d '{"id":"1", "good_id":"2", "count": "1.5", "discount": "0"}' "$EP/buy" --cookie "session_id=$SESSION_ID"
echo ""

echo "カウントを0にして購入するケース(エラー)"
curl -X POST -H "Content-Type: application/json" -d '{"id":"1", "good_id":"2", "count": "0", "discount": "0"}' "$EP/buy" --cookie "session_id=$SESSION_ID"
echo ""

echo "異なるユーザidの購入を試すケース (1のユーザで購入される)"
curl -X POST -H "Content-Type: application/json" -d '{"id":"2", "good_id":"2", "count": "1", "discount": "0"}' "$EP/buy" --cookie "session_id=$SESSION_ID"
echo ""

echo "sessionが切れている場合 (リダイレクト)"
curl -X POST -H "Content-Type: application/json" -d '{"id":"2", "good_id":"2", "count": "1", "discount": "0"}' "$EP/buy"
echo ""

echo "有効なクーポンを使って見る (成功)"
curl -X POST -H "Content-Type: application/json" -d '{"id":"1", "good_id":"2", "count": "1", "discount": "10"}' "$EP/buy" --cookie "session_id=$SESSION_ID"
echo ""

echo "クーポンが不正 (不正)"
curl -X POST -H "Content-Type: application/json" -d '{"id":"1", "good_id":"2", "count": "0", "discount": "50"}' "$EP/buy" --cookie "session_id=$SESSION_ID"
echo ""
