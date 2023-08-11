json.array! @my_characters, partial: "characters/character", as: :character unless @my_characters.nil?
json.array! @team_characters, partial: "characters/character", as: :character unless @team_characters.nil?
