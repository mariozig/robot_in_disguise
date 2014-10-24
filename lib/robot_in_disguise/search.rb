require 'robot_in_disguise/request'
require 'robot_in_disguise/search_results'

module RobotInDisguise
  module Search
    MAX_RESULTS_PER_REQUEST = 100

    # Returns articles of content that match a specified query.
    #
    # @see https://transformation-production.ush.a.intuit.com/ OR SOME URL FOR TFX THAT ACTUALLY WORKS
    # @note None.
    # @rate_limited No
    # @param q [String] A search term.
    # @param options [Hash] A customizable set of options.
    # @option options [String] :primary_ds The primary data source.
    # @option options [String] :secondary_ds The secondary data source.
    # @option options [Integer] :pagesize The number of content pieces to return per page.
    # @option options [String] :product The product identifier.
    # @option options [String] :product_edition The specific edition of product.
    # @option options [String] :product_sku The product SKU.
    # @option options [Integer] :product_version The numerical product version.
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
