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

  def changed
    @changed = true
  end

  def notify_observers *arg
    if changed? 
      @observers.each do |o|
	begin
	  # maybe have many publishes
	  # observer know which publish by self
	  o.update self, *arg
        rescue NoMethodError
	  raise "#{o.class.to_s} Observer hava no update method"
	end
      end
    end
  end

  private
    def changed?
      @changed == true
    end
end
