module Observable

  def add_observer observer
    @observers = [] unless defined? @observers
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

  def changed?
    (defined? @status && @status) ? true : false
  end
end
