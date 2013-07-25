require "#{File.dirname(__FILE__)}/../fixtures/publish"
require "#{File.dirname(__FILE__)}/../fixtures/subscribe"

describe Observable do

  before :each do
    @publish = Publish.new
    @subscribe = Subscribe.new
    @observers = @publish.add_observer(@subscribe)
  end

  context "observable should can be add observers" do
    it "the number of observers add 1" do
      @observers.count.should ==  1
    end

    it "which one of what is instance of Subscribe" do
      @observers.map{|o| o.should be_instance_of Subscribe}
    end

    it "is instance of Array " do
      @observers.should be_instance_of Array
    end
  end

  context "observable should can be remove observers" do
    before :each do
      @remove_observer = @publish.remove_observer(@subscribe)
    end

    it "the number of observers should - 1" do
      @remove_observer.should be_instance_of Subscribe
      # access +observers+ perssion 
      @publish.observers.should be_empty
    end

    it "return nil when oberser does not exist" do
      @publish.remove_observer(@subscribe).should be_nil
    end
  end
end
