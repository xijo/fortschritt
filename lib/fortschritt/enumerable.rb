module Enumerable
  def with_fortschritt
    Fortschritt.init(size)
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

    extend ActiveSupport::Concern

    def with_fortschritt
      Fortschritt.init(count)
      self
    end
  end

  ActiveRecord::Relation.send(:include, Fortschritt::ActiveRecordExtension)
end

