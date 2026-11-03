module SimpleFormAutoCollection
  def input(attribute_name, options = {}, &block)
    if !options.key?(:collection) && object.respond_to?("#{attribute_name}_options")
      options[:collection] = object.send("#{attribute_name}_options")
      if !options.key?(:include_blank) && !options.key?(:prompt)
        option_include_blank = options[:collection].any? { |k, v| v.blank? }
        if option_include_blank
          options[:include_blank] = false
        else
          options[:include_blank] = " "
        end
      end
    end

    super(attribute_name, options, &block)
  end
end

SimpleForm::FormBuilder.prepend(SimpleFormAutoCollection)
