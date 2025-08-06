json.extract! trip, :id, :name, :start_date, :end_date, :user_id, :created_at, :updated_at
json.url trip_url(trip, format: :json)
