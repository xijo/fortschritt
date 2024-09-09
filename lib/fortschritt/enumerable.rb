module Enumerable
  def with_fortschritt(**opts)
    Fortschritt.init(size, **opts)
    self
  end
end

class Object
  def fortschritt
    Fortschritt.increment
    self
  end
end

if defined?(Rails)
  module Fortschritt::ActiveRecordExtension
    def with_fortschritt(**opts)
      Fortschritt.init(size, **opts)
      self
    end
  end

  ActiveRecord::Relation.include Fortschritt::ActiveRecordExtension
  ActiveRecord::Base.singleton_class.delegate :with_fortschritt, to: :all
end

