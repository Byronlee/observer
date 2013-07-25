class Subscribe

  attr_accessor :publish, :msg

  def update publish, msg
    @publish = publish
    @msg    = msg
  end
end
