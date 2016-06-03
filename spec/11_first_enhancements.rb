require_relative 'spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
  end

  # New #heal! method
  describe "#heal!" do
    it "should heal the robot" do
      @robot.wound(30)
      @robot.heal!(20)
      expect(@robot.health).to eq(90)
    end

    it "should not make the robot's health more than 100" do
      @robot.wound(30)
      @robot.heal!(40)
      expect(@robot.health).to eq(100)
    end

    it "should raise exception if robot is dead" do
      @robot.wound(120)
      expect{ @robot.heal!(50) }.to raise_error
    end
  end

  # New #attack! method

  describe "#attack!" do
    it "should attack robots" do
      foe = Robot.new
      expect(foe).to receive(:wound).with(5)
      @robot.attack!(foe)
    end

    it "should raise exception it target is not a Robot" do
      not_foe = Object.new
      expect{ @robot.attack!(not_foe) }.to raise_error
    end
  end

end
