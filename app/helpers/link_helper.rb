module LinkHelper
  def lnk_to(name, options = {}, type: :link, external: false, **html_options, &)
    html_options = { target: "_blank", rel: "noopener noreferrer", **html_options } if external

    case type
    when :link
      link_to(name, options, **html_options, &)
    when :button
      btn_to(name, options, **html_options, type: :link, &)
    end
  end
end
