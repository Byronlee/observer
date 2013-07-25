module Observable

  attr_accessor :observers
  attr_reader   :status

#  def self.included(base)
#    base.instance_eval do
#      define_method :initialize do
#        @observers = []
#      end
#    end
#  end

  def initialize
    @observers = []
    @status    = false
  end
  
  def add_observer observer
    @observers << observer
  end

  def remove_observer observer
    @observers.delete(observer)
  end

  # mark the status of observable changed
  def changed
    @status = true
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

    @status = false
  end

  private
    def changed?
      @status == true
    end
end
