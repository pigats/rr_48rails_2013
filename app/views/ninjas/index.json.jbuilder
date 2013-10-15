json.array!(@ninjas) do |ninja|
  json.extract! ninja, :name, :twitter, :facebook, :team_id, :prize_id
  json.url ninja_url(ninja, format: :json)
end
