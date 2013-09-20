json.array!(@pulses) do |pulse|
  json.extract! pulse, :user_id, :url
  json.url pulse_url(pulse, format: :json)
end
