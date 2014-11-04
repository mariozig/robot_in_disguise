module RobotInDisguise
  module Enumerable
    include ::Enumerable

    # @return [Enumerator]
    def each(&block)
      return to_enum(:each) unless block_given? # Sparkling magic!
      Array(@collection).each { |member| block.call(member) }
    end
  end
end
