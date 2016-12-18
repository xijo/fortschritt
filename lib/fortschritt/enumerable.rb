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

    # Silence fortschritt in tests and in non-terminal context
    def with_fortschritt(opts = {})
      unless opts.has_key?(:silent)
        opts[:silent] = Rails.env.test? || !STDOUT.tty?
      end
      Fortschritt.init(size, opts)
      self
    end
  end

  ActiveRecord::Relation.send(:include, Fortschritt::ActiveRecordExtension)
end

