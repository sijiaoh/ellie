class MarkdownInput < SimpleForm::Inputs::Base
  # input_html[:toggle_mode]:
  #   - "": disable toggle mode.
  #   - "editor": [default] enable toggle mode and set default mode to editor.
  #   - "viewer": enable toggle mode and set default mode to viewer.
  # input_html[:responsive_mode]:
  #   If responsive mode is enabled, the toggle mode will disable on desktop.
  #   - true: [default] enable responsive mode.
  #   - false: disable responsive mode.
  # input_html[:toggle_button]:
  #   Show or hide toggle button.
  #   - true: [default] show toggle button.
  #   - false: hide toggle button.
  def input(_wrapper_options) # rubocop:disable Metrics/MethodLength
    return @builder.text_area(attribute_name) if Rails.env.test?

    content_tag(
      :div,
      "data-controller": "markdown-editor",
      "data-action": "code-editor:update->markdown-editor#updateViewerContent",
      "data-markdown-editor-toggle-mode-value": toggle_mode,
      **input_html_options,
      class: class_names("flex flex-col", input_html_options[:class])
    ) do
      [editor_viewer, toggle_button].sum
    end
  end

  private

  delegate :content_tag, :class_names, :button_primary_tag, :markdown_viewer, to: :helpers

  def editor_viewer # rubocop:disable Metrics/MethodLength
    content_tag(:div, class: "flex flex-1") do
      [
        @builder.input(
          attribute_name,
          as: :code_editor,
          label: false,
          wrapper: false,
          input_html: {
            "data-markdown-editor-target": "editor",
            class: class_names("flex-1", "md:flex": responsive_mode)
          }
        ),
        markdown_viewer(
          object[attribute_name],
          "data-markdown-editor-target": "viewer",
          class: class_names("flex-1", "md:flex": responsive_mode)
        )
      ].sum
    end
  end

  def toggle_button # rubocop:disable Metrics/MethodLength
    toggle_button_enable = input_html_options.fetch(:toggle_button, true)

    content_tag(
      :div,
      class: class_names(
        "flex flex-row-reverse",
        "md:hidden": responsive_mode,
        hidden: !toggle_button_enable
      )
    ) do
      button_primary_tag(
        t("inputs.markdown_input.toggle"),
        type: :button,
        "data-markdown-editor-target": "toggleButton",
        "data-action": "markdown-editor#toggle"
      )
    end
  end

  def toggle_mode
    input_html_options.fetch(:toggle_mode, "editor")
  end

  def responsive_mode
    input_html_options.fetch(:responsive_mode, true)
  end

  def helpers
    ApplicationController.helpers
  end
end
