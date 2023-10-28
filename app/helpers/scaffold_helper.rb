module ScaffoldHelper
  def index_lnk_to(name, model = nil, **, &)
    if model.nil?
      model = name
      name = t("#{i18n_key_from_model(model)}.index.title")
    end

    return unless policy_from_model(model).index?

    route_key = model.model_name.route_key
    index_path = send("#{route_key}_path")

    lnk_to(name, index_path, **, &)
  end

  def back_to_index_lnk_to(name, model = nil, **, &)
    if model.nil?
      model = name
      name = t("back_to_index")
    end

    return unless policy_from_model(model).index?

    index_lnk_to(name, model, color: :secondary, **, &)
  end

  def show_lnk_to(name, record = nil, **, &)
    if record.nil?
      record = name
      name = t("detail")
    end

    return unless policy(record).show?

    lnk_to(name, record, **, &)
  end

  def new_lnk_to(name, model = nil, **, &)
    if model.nil?
      model = name
      name = t("#{i18n_key_from_model(model)}.new.title")
    end

    return unless policy_from_model(model).new?

    route_key = model.model_name.singular_route_key
    new_path = send("new_#{route_key}_path")

    lnk_to(name, new_path, type: :link, **, &)
  end

  def edit_lnk_to(name, record = nil, **, &)
    if record.nil?
      record = name
      name = t("edit")
    end

    return unless policy(record).edit?

    lnk_to(name, [:edit, record], **, &)
  end

  def destroy_btn_to(name, record = nil, **, &)
    if record.nil?
      record = name
      name = t("destroy")
    end

    return unless policy(record).destroy?

    btn_to(
      name,
      record,
      method: :delete,
      form: { data: { turbo_confirm: t("destroy_confirm") } },
      color: :danger,
      **,
      &
    )
  end

  private

  def i18n_key_from_model(model)
    model_name = model.model_name
    [
      model_name.i18n_key.to_s.split("/")[0..-2].join("."),
      model_name.element.pluralize
    ].select(&:present?).join(".")
  end

  def policy_from_model(model)
    policy_token = model.model_name.singular.to_sym
    policy(policy_token)
  end
end
