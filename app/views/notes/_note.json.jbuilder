json.extract! note, :id, :title, :body, :private, :created_at, :updated_at
json.url note_url(note, format: :json)
