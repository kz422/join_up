json.extract! meeting, :id, :title, :location, :start_time, :end_time, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)
