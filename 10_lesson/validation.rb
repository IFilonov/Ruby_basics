module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :arr_args

    def validate(*args)
      @arr_args ||= []
      arg_hash = { name: args[0], handler: args[1], attr: args[2] }
      @arr_args.push(arg_hash)
    end
  end

  module InstanceMethods
    VAL_HANDLER = {
      presence:
        { handler: :proc_presence, err_text: 'Var cannot be nil or empty str' },
      format:
        { handler: :proc_format, err_text: 'Incorrect format' },
      type:
        { handler: :proc_type, err_text: 'Incorrect type' }
    }.freeze

    def validate!
      self.class.arr_args.each do |args|
        handler = args[:handler]
        var_name = "@#{args[:name]}".to_sym
        @var = instance_variable_get(var_name)
        send(VAL_HANDLER[handler][:handler], args)
      end
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    private

    def proc_presence(*_args)
      raise VAL_HANDLER[:presence][:err_text] if @var.nil? || @var.to_s.empty?
    end

    def proc_format(*args)
      var_format = args.first[:attr]
      raise VAL_HANDLER[:format][:err_text] unless @var =~ var_format
    end

    def proc_type(*args)
      var_class = args.first[:attr]
      raise VAL_HANDLER[:format][:err_text] unless @var.instance_of?(var_class)
    end
  end
end
