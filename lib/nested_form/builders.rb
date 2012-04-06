require 'nested_form/builder_mixin'

module NestedForm
  class Builder < ::ActionView::Helpers::FormBuilder
    include ::NestedForm::BuilderMixin
  end

  begin
    require 'simple_form'
    class SimpleBuilder < ::SimpleForm::FormBuilder
      include ::NestedForm::BuilderMixin
    end
  rescue LoadError
  end

  begin
    require 'formtastic'
    parent_klass =
      if defined?(::FormtasticBootstrap)
        FormtasticBootstrap::FormBuilder
      elsif defined?(::Formtastic::FormBuilder)
        Formtastic::FormBuilder
      else
        ::Formtastic::SemanticFormBuilder
      end

    class FormtasticBuilder < parent_klass
      include ::NestedForm::BuilderMixin
    end
  rescue LoadError
  end
end
