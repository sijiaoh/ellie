module ButtonHelper
  def button_base_style
    "block w-fit font-medium py-2 px-4 rounded"
  end

  # Do not use `class_names` in style helpers. Because it will be used in config/initializers/simple_form.rb.
  def button_primary_style
    "#{button_base_style} text-white bg-primary-500 hover:bg-primary-600"
  end

  def button_secondary_style
    "#{button_base_style} text-white bg-secondary-500 hover:bg-secondary-600"
  end

  def button_danger_style
    "#{button_base_style} text-white bg-danger-500 hover:bg-danger-600"
  end

  %i[base primary secondary danger].each do |color|
    define_method "button_#{color}_tag" do |*args, **options, &block|
      button_tag(*args, **options, class: public_send("button_#{color}_style"), &block)
    end

    define_method "button_#{color}" do |*args, &block|
      type = args.last[:type] if args.last.is_a? Hash

      # Fill with nil until the length is at least 3.
      args.fill(nil, args.size, 3 - args.size)

      args[-1] ||= {}
      klass = class_names public_send("button_#{color}_style"), args[-1][:class]
      args[-1][:class] = klass

      args[-1][:type] = type

      button_or_link_to(*args, &block)
    end

    define_method "button_link_#{color}" do |*args, &block|
      public_send("button_#{color}", *args, type: :link, &block)
    end
  end

  private

  def button_or_link_to(*args, &)
    return link_to(*args, &) if args.last[:type] == :link

    button_to(*args, &)
  end
end
