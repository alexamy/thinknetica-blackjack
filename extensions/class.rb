# Class extensions
class Class
  def attr_reader_writer(*keys)
    keys.each do |key|
      add_attr_reader_writer(key)
    end
  end

  protected

  def add_attr_reader_writer(key)
    attr_reader key
    attr_writer key
    protected "#{key}="
  end
end
