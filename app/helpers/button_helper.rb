module ButtonHelper
  def btn_base_style
    "block w-fit font-medium py-2 px-4 rounded"
  end

  # Do not use `class_names` in style helpers. Because it will be used in config/initializers/simple_form.rb.
  def btn_primary_style
    "#{btn_base_style} text-white bg-primary-500 hover:bg-primary-600"
  end

  def btn_secondary_style
    "#{btn_base_style} text-white bg-secondary-500 hover:bg-secondary-600"
  end

  def btn_danger_style
    "#{btn_base_style} text-white bg-danger-500 hover:bg-danger-600"
  end

  def btn_tag(*, color: :primary, **, &)
    button_tag(*, **, class: public_send("btn_#{color}_style"), &)
  end

  def btn_to(name, options = {}, type: :button, color: :primary, **html_options, &)
    klass = class_names public_send("btn_#{color}_style"), html_options[:class]
    html_options[:class] = klass

    button_or_link_to(name, options, **html_options, type:, &)
  end

  private

  def button_or_link_to(*args, &)
    return link_to(*args, &) if args.last[:type] == :link

    button_to(*args, &)
  end
end
