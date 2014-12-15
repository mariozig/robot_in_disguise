module RobotInDisguise
  module ViewHelpers
    def tfx_post_for(post, _parse_link = nil, &block)
      block.call(post) if block_given?
    end
  end
end


search_options = {
  primary_ds: 'STSV2',
  secondary_ds: 'InQuira'
}
