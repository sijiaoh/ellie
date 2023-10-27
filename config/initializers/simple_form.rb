require Rails.root.join("app/helpers/button_helper")

SimpleForm.setup do |config|
  include ButtonHelper

  message_base_class = "px-3 py-2 rounded-lg"
  error_message_class = "#{message_base_class} font-medium bg-red-50 text-red-500"

  config.wrappers :default, class: "vertical gap-2" do |b|
    b.use :html5
    b.use :placeholder

    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label_input
    b.use :hint, wrap_with: { tag: :span, class: "#{message_base_class} text-sm bg-blue-50 text-blue-500" }
    b.use :full_error, wrap_with: { tag: :span, class: error_message_class }
  end

  config.default_wrapper = :default
  config.boolean_style = :nested
  config.error_notification_tag = :div
  config.browser_validations = false

  config.button_class = btn_primary_style
  config.error_notification_class = error_message_class
  config.default_form_class = "vertical gap-default my-default"
  config.boolean_label_class = "horizontal-center gap-2"
end
