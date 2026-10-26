module Enumerable
  def with_fortschritt(**opts, &block)
    Fortschritt.init(count, **opts)
    block ? each(&block) : self
  end
end

class Object
  def fortschritt(n = 1)
    Fortschritt.increment(n)
    self
  end
end

if defined?(Rails)
  module Fortschritt::ActiveRecordExtension
    def with_fortschritt(**opts, &block)
      Fortschritt.init(count, **opts)
      block ? find_each(&block) : self
    end
  end

  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Relation.include Fortschritt::ActiveRecordExtension
    singleton_class.delegate :with_fortschritt, to: :all
  end
end

