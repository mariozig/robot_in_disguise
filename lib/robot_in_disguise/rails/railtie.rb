require 'robot_in_disguise/rails/view_helpers'

module RobotInDisguise
  class Railtie < Rails::Railtie
    initializer 'robot_in_disguise.view_helpers' do |_app|
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
