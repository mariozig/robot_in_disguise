require 'robot_in_disguise/search'

module RobotInDisguise
  module API
    include RobotInDisguise::Posts
    include RobotInDisguise::Search
  end
end
