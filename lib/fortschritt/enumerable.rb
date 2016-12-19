module Enumerable
  def with_fortschritt(opts = {})
    Fortschritt.init(size, opts)
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

    def with_fortschritt(opts = {})
      Fortschritt.init(size, opts)
      self
    end
  end

  ActiveRecord::Relation.send(:include, Fortschritt::ActiveRecordExtension)
end

