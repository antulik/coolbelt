module ObjectNest
  def nest(name = nil)
    yield
  end
end

Object.include(ObjectNest)
