# Class extensions
class Class
  def attr_reader_writer(*keys)
    keys.each do |key|
      add_attr_reader(key)
      add_attr_writer(key)
    end
  end

  protected

  def add_attr_reader(key)
    var = "@#{key}"
    get = key

    define_method(get) do
      instance_variable_get(var)
    end
  end

  def add_attr_writer(key)
    var = "@#{key}"
    set = "#{key}="

    define_method(set) do |value|
      instance_variable_set(var, value)
    end

    protected set
  end
end
