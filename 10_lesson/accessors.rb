module Accessors
  def attr_accesor_with_history(*vars)
    vars.each do |var|
      var_name = "@#{var}".to_sym
      define_method(var) { instance_variable_get(var_name) }
      define_method("#{var}=".to_sym) do |value|
        @var_history ||= {}
        @var_history[var_name] = [] if @var_history[var_name].nil?
        prev_value = instance_variable_get(var_name)
        @var_history[var_name].push(prev_value) if prev_value != value
        instance_variable_set(var_name, value)
      end
      define_method("#{var}_history".to_sym) { @var_history[var_name] if @var_history }
    end
  end

  def strong_attr_accessor(var, var_class)
    var_name = "@#{var}".to_sym
    define_method(var) { instance_variable_get(var_name) }
    define_method("#{var}=".to_sym) do |value|
      raise 'Wrong class of value' unless value.instance_of?(var_class)

      instance_variable_set(var_name, value)
    end
  end
end
