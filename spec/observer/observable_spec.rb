require "#{File.dirname(__FILE__)}/../fixtures/publish"
require "#{File.dirname(__FILE__)}/../fixtures/subscribe"

describe Observable do

  before :each do
    @publish = Publish.new
    @subscribe = Subscribe.new
  end

  it "observable should can be add observer" do
    @publish.add_observer(@subscribe).count.should == 1
  end

  it "observer added should be instance of Observer" do
    @publish.add_observer(@subscribe).map{|o| o.should be_instance_of Subscribe}
  end

  it "observable has many observers instance of Array " do
    @publish.add_observer(@subscribe).should be_instance_of Array
  end
end
