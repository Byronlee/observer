module Observable

  attr_accessor :observers

#  def self.included(base)
#    base.instance_eval do
#      define_method :initialize do
#        @observers = []
#      end
#    end
#  end

  def initialize
    @observers = []
  end
  
  def add_observer observer
    @observers << observer
  end

  def remove_observer observer
    @observers.delete(observer)
  end

  def notify_observers
  end
end
