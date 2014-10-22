json.array!(@events) do |event|
  json.extract! event, :id, :fireteam_leader, :fireteam_group_type, :level, :comments, :video_url, :date_time, :system
  json.url event_url(event, format: :json)
end
