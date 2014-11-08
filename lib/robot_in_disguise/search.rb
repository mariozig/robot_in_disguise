require 'robot_in_disguise/request'
require 'robot_in_disguise/search_results'

module RobotInDisguise
  module Search
    MAX_RESULTS_PER_REQUEST = 100

    # Returns articles of content that match a specified query.
    #
    # @see TODO: When TFX gets official documentation up, link to it.
    # @note None.
    # @param q [String] A query/search string.
    # @param options [Hash] A customizable set of options.
    # @option options [Boolean] :answered Return only answered posts from community.
    # @option options [String] :callback A JSONP callback.
    # @option options [String] :locale A locale.
    # @option options [Integer] :page The current starting page.
    # @option options [Integer] :pagesize The number of content iterms to return per page.
    # @option options [String] :primary_ds The primary data source.
    # @option options [String] :product_edition The production edition.
    # @option options [String] :product_platform The product platform.
    # @option options [String] :product_name The product name.
    # @option options [String] :product_sku The product SKU.
    # @option options [String] :product_version The product version.
    # @option options [String] :secondary_ds The secondary data source.
    # @return [RobotInDisguise::SearchResults] Return articles of content that match a specified query with search metadata
    def search(q, options = {})
      options[:pagesize] ||= MAX_RESULTS_PER_REQUEST
      options.merge!(q: q)

      request = RobotInDisguise::Request.new(self, :get, '/v2/search/posts', options)
      response = get(request.path, request.options).body
      RobotInDisguise::SearchResults.new(response, request)
    end
  end
end
