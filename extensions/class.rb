# Class extensions
class Class
  def attr_reader_writer(*keys)
    keys.each { |key| add_attr_reader_writer(key) }
  end

  protected

  def add_attr_reader_writer(key)
    get = key
    set = "#{key}="
    var = "@#{key}"

    define_method(get) do
      instance_variable_get(var)
    end

    define_method(set) do |value|
      instance_variable_set(var, value)
    end

    protected set
  end
end
