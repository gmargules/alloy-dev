json.response_code 200
json.response_text "ok"

json.partial! 'api/v1/users/user', user: @user, token: @key.token
