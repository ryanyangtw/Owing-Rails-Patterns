class String
  def underscore
    gsub(/(.)([A-Z])/, '\1_\2').downcase
  end
end