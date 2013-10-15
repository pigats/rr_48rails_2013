json.array!(@teams) do |team|
  json.extract! team, :name, :colour, :sort, :prize_id
  json.url team_url(team, format: :json)
end
