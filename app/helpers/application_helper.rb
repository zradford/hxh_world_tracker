module ApplicationHelper

  def accessible?(associated_user_id = nil)
    # if you are an admin, if this is your object, or if this object is not in use you can access
    return current_user.admin? || associated_user_id == current_user.id || associated_user_id.nil?
  end

  def display_boxes_for(record, box_shape = "circles", max = 8, *args)
    options = args.extract_options!
    filled_shape, empty_shape = svg_for(box_shape)
    
    #this relies on the record being in this particular order which isn't good probably
    id, data_value, user_id = record.values
    data_name = record.slice!(:id).keys.first
    
    filled = data_value.times.map { filled_shape.html_safe }
    empty = (max - data_value).times.map { empty_shape.html_safe }

    if options[:with_links] && user_id == current_user.id

      filled[filled.length - 1] = add_link_to(filled.last, record_id: id, data_name: data_name, value: data_value, shape: :filled, is_level_up: options[:is_level_up]) unless filled.empty?
      empty[0] = add_link_to(empty.first, record_id: id, data_name: data_name, value: data_value, shape: :empty, is_level_up: options[:is_level_up]) unless empty.empty?

    end

    (filled + empty).map! { |item| content_tag(:td, item) }.join("").html_safe
  end



  def htmx_tag(name, value, html_args, *htmx_args)
    htmx_options = htmx_args.extract_options!

    attributes = []
    
    htmx_options.each {|key, value| attributes << "hx-#{clean(key)}= '#{value}'"}
    html_args.each {|key, value| attributes << "#{key}= '#{value}'"}

    "<#{name} #{attributes.join(" ")}>#{value}</#{name}>".html_safe
  end

  def clean(htmx_attribute)
    htmx_attribute.to_s.include?("_") ? htmx_attribute.to_s.gsub!("_", "-")  : htmx_attribute
  end


private

  def add_link_to(svg_item, record_id:, data_name:, value:, shape:, is_level_up: false)
    amount = shape == :filled ? value - 1 : value + 1
    
    return link_to(svg_item, character_path(record_id, character: { "#{data_name}": amount }), data: { "turbo-method" => "patch", remote: true }) unless is_level_up
    return link_to(svg_item, level_up_path(id: record_id, character: { "#{data_name}": amount}), data: { "turbo-method" => "patch", remote: true }) if is_level_up
  end

  def svg_for(shape, style: :both)
    shape = shape.to_sym

    svgs = {
      circles: {
        filled: '<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"><path d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512z"/></svg>',
        empty: '<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"><path d="M464 256A208 208 0 1 0 48 256a208 208 0 1 0 416 0zM0 256a256 256 0 1 1 512 0A256 256 0 1 1 0 256z"/></svg>'
      },
      hearts: {
        filled: '<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"><path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/></svg>',
        empty: '<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"><path d="M225.8 468.2l-2.5-2.3L48.1 303.2C17.4 274.7 0 234.7 0 192.8v-3.3c0-70.4 50-130.8 119.2-144C158.6 37.9 198.9 47 231 69.6c9 6.4 17.4 13.8 25 22.3c4.2-4.8 8.7-9.2 13.5-13.3c3.7-3.2 7.5-6.2 11.5-9c0 0 0 0 0 0C313.1 47 353.4 37.9 392.8 45.4C462 58.6 512 119.1 512 189.5v3.3c0 41.9-17.4 81.9-48.1 110.4L288.7 465.9l-2.5 2.3c-8.2 7.6-19 11.9-30.2 11.9s-22-4.2-30.2-11.9zM239.1 145c-.4-.3-.7-.7-1-1.1l-17.8-20c0 0-.1-.1-.1-.1c0 0 0 0 0 0c-23.1-25.9-58-37.7-92-31.2C81.6 101.5 48 142.1 48 189.5v3.3c0 28.5 11.9 55.8 32.8 75.2L256 430.7 431.2 268c20.9-19.4 32.8-46.7 32.8-75.2v-3.3c0-47.3-33.6-88-80.1-96.9c-34-6.5-69 5.4-92 31.2c0 0 0 0-.1 .1s0 0-.1 .1l-17.8 20c-.3 .4-.7 .7-1 1.1c-4.5 4.5-10.6 7-16.9 7s-12.4-2.5-16.9-7z"/></svg>'
      },
      stars: {
        filled: '<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 576 512"><path d="M316.9 18C311.6 7 300.4 0 288.1 0s-23.4 7-28.8 18L195 150.3 51.4 171.5c-12 1.8-22 10.2-25.7 21.7s-.7 24.2 7.9 32.7L137.8 329 113.2 474.7c-2 12 3 24.2 12.9 31.3s23 8 33.8 2.3l128.3-68.5 128.3 68.5c10.8 5.7 23.9 4.9 33.8-2.3s14.9-19.3 12.9-31.3L438.5 329 542.7 225.9c8.6-8.5 11.7-21.2 7.9-32.7s-13.7-19.9-25.7-21.7L381.2 150.3 316.9 18z"/></svg>',
        empty: '<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 576 512"><path d="M287.9 0c9.2 0 17.6 5.2 21.6 13.5l68.6 141.3 153.2 22.6c9 1.3 16.5 7.6 19.3 16.3s.5 18.1-5.9 24.5L433.6 328.4l26.2 155.6c1.5 9-2.2 18.1-9.6 23.5s-17.3 6-25.3 1.7l-137-73.2L151 509.1c-8.1 4.3-17.9 3.7-25.3-1.7s-11.2-14.5-9.7-23.5l26.2-155.6L31.1 218.2c-6.5-6.4-8.7-15.9-5.9-24.5s10.3-14.9 19.3-16.3l153.2-22.6L266.3 13.5C270.4 5.2 278.7 0 287.9 0zm0 79L235.4 187.2c-3.5 7.1-10.2 12.1-18.1 13.3L99 217.9 184.9 303c5.5 5.5 8.1 13.3 6.8 21L171.4 443.7l105.2-56.2c7.1-3.8 15.6-3.8 22.6 0l105.2 56.2L384.2 324.1c-1.3-7.7 1.2-15.5 6.8-21l85.9-85.1L358.6 200.5c-7.8-1.2-14.6-6.1-18.1-13.3L287.9 79z"/></svg>'
      },
      squares: {
        filled: '<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 448 512"><path d="M0 96C0 60.7 28.7 32 64 32H384c35.3 0 64 28.7 64 64V416c0 35.3-28.7 64-64 64H64c-35.3 0-64-28.7-64-64V96z"/></svg>',
        empty:'<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 448 512"><path d="M384 80c8.8 0 16 7.2 16 16V416c0 8.8-7.2 16-16 16H64c-8.8 0-16-7.2-16-16V96c0-8.8 7.2-16 16-16H384zM64 32C28.7 32 0 60.7 0 96V416c0 35.3 28.7 64 64 64H384c35.3 0 64-28.7 64-64V96c0-35.3-28.7-64-64-64H64z"/></svg>'
      }
    }

    return svgs[shape][:filled], svgs[shape][:empty] if style == :both
    return svgs[shape][:filled] if style == :filled
    return svgs[shape][:empty] if style == :empty
  end
end