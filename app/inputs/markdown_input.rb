class MarkdownInput < SimpleForm::Inputs::Base
  def input(_wrapper_options) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    return @builder.text_area(attribute_name) if Rails.env.test?

    helpers.content_tag(
      :div,
      "data-controller": "markdown-editor",
      "data-action": "code-editor:update->markdown-editor#updateViewerContent",
      "data-markdown-editor-toggle-value": input_html_options.fetch(:toggle, ""),
      **input_html_options,
      class: helpers.class_names("flex flex-col", input_html_options[:class])
    ) do
      [
        helpers.content_tag(:div, class: "flex flex-1") do
          [
            @builder.input(
              attribute_name,
              as: :code_editor,
              label: false,
              wrapper: false,
              input_html: { "data-markdown-editor-target": "editor", class: "flex-1" }
            ),
            helpers.markdown_viewer(object[attribute_name], "data-markdown-editor-target": "viewer", class: "flex-1")
          ].sum
        end,
        helpers.content_tag(:div, class: "flex flex-row-reverse") do
          helpers.button_primary_tag(
            t("inputs.markdown_input.toggle"),
            type: :button,
            "data-markdown-editor-target": "toggle",
            "data-action": "markdown-editor#toggle"
          )
        end
      ].sum
    end
  end

  private

  def helpers
    ApplicationController.helpers
  end
end
