require 'robot_in_disguise/posts'
require 'robot_in_disguise/search'

module RobotInDisguise
  module API
    include RobotInDisguise::Search
    include RobotInDisguise::Posts
  end
end
