# Class extensions
class Class
  def attr_reader_writer(*keys)
    keys.each do |key|
      add_attr_reader_writer(key)
    end
  end

  def delegate(*methods, to:)
    methods.each { |method| gelegate_one(method, to) }
  end

  protected

  def add_attr_reader_writer(key)
    attr_reader key
    attr_writer key
    protected "#{key}="
  end

  def gelegate_one(method, target)
    var_name = "@#{target}"
    define_method method do |*args|
      var = instance_variable_get(var_name)
      var.send(method, *args)
    end
  end
end
