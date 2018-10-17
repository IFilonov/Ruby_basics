module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(*args)
      @validations ||= []
      val_checks = { name: args[0], handler: args[1], attr: args[2] }
      @validations.push(val_checks)
    end
  end

  module InstanceMethods
    VAL_ERRS = {
      presence: 'Var cannot be nil or empty str',
      format: 'Incorrect format',
      type: 'Incorrect type'
    }.freeze

    def validate!
      self.class.validations.each do |args|
        handler = args[:handler]
        name = "@#{args[:name]}".to_sym
        value = instance_variable_get(name)
        send("validate_#{handler}", value, args)
      end
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    private

    def validate_presence(value, *_args)
      raise VAL_ERRS[:presence] if value.nil? || value.to_s.empty?
    end

    def validate_format(value, *args)
      var_format = args.first[:attr]
      raise VAL_ERRS[:format] unless value =~ var_format
    end

    def validate_type(value, *args)
      var_class = args.first[:attr]
      raise VAL_ERRS[:type] unless value.instance_of?(var_class)
    end
  end
end
