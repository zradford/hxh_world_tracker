module CharactersHelper
  def display_equipment(equipment_list)
    content_tag :ul do
      equipment_list.split(',').collect do |eq|
        concat(content_tag(:li, eq))
      end
    end
  end
end