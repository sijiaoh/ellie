module FormHelper
  class FormBuilder < SimpleForm::FormBuilder
    def base_errors
      res = error_notification
      res << error_notification(message: object.errors[:base].to_sentence) if object.errors[:base].present?
      res
    end
  end

  def custom_form_for(object, *args, **options, &)
    simple_form_for(object, *args, **options, builder: FormBuilder, &)
  end
end
