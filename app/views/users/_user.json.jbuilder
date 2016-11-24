json.extract! user, :id, :name, :content, :appointment, :created_at, :updated_at
json.url user_url(user, format: :json)
