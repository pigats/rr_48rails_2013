json.array!(@teams) do |team|
  json.extract! team, :name, :colour, :order, :prize_id
  json.url team_url(team, format: :json)
end
