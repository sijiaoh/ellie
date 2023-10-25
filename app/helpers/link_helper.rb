module LinkHelper
  def external_link_to(*, **, &)
    options = { target: "_blank", rel: "noopener noreferrer", ** }
    link_to(*, **options, &)
  end
end
