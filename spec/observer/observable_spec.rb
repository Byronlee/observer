require 'spec_helper'
require "#{File.dirname(__FILE__)}/../fixtures/publish"
require "#{File.dirname(__FILE__)}/../fixtures/subscribe"
require "#{File.dirname(__FILE__)}/../fixtures/subscribe_no_update"

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
      @publish.instance_variable_get(:@observers).should be_empty
    end

    it "return nil when oberser does not exist" do
      @publish.remove_observer(@subscribe).should be_nil
    end
  end

  context "observable can notify observers when observale changed" do
    before :each do
      @publish.changed   
      @publish.notify_observers('publish have changed !')
    end

    it "observer should receive notify message" do
      @subscribe.msg.should == 'publish have changed !'
    end

    it "observer should receive instance of Observable" do
      @subscribe.publish.should be_instance_of Publish
    end

    it "status of observable should be false" do
      @publish.instance_variable_get(:@status).should == false
    end
  end

  context "status of observable changes" do
    
    it "default status is false" do
      @publish.instance_variable_get(:@status).should == nil
    end

    it "true after set observable changed" do
      @publish.changed
      @publish.instance_variable_get(:@status).should == true 
    end
  end

  context "observer should have update method" do
    it "respond_to :update" do
      @subscribe.should respond_to :update
    end

    it "have no update method should raise error" do
      @publish.add_observer SubscribeNoUpdate.new
      @publish.changed   
      expect{ @publish.notify_observers('publish have changed !')}.to raise_error
    end
  end
end
