# Hash extensions
class Hash
  def except(*keys)
    result = clone
    keys.each { |key| result.delete(key) }
    result
  end
end
