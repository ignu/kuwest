class Float
  def pretty
    #return ("%.1f" % self).gsub(/(\d)(?=\d{3}+(\.\d*)?$)/, '\1,') if modulo(1) > 0
    self.to_i.to_s
  end
end