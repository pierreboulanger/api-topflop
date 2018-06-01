json.extract! game, :id, :team_id, :opponent_name, :date, :score, :top, :flop, :status, :created_at, :updated_at
json.url game_url(game, format: :json)
