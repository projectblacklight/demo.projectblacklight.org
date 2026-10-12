# Rejects searches that stack an implausible number of facet values.
#
# Crawlers follow every facet link on a results page, producing an endless space
# of URLs like ?f[subject_ssim][]=A&f[subject_ssim][]=B&f[subject_geo_ssim][]=C...
# Real users rarely apply more than a handful of filters, so we turn these away
# before they reach Rails routing or Solr.
class FacetLimit
  FACET_PARAMS = %w(f f_inclusive).freeze

  def initialize(app, max_values: Integer(ENV.fetch("MAX_FACET_VALUES", 4)))
    @app = app
    @max_values = max_values
  end

  def call(env)
    if facet_value_count(env["QUERY_STRING"]) > @max_values
      [400, { "content-type" => "text/plain", "cache-control" => "no-store" },
       ["Too many filters applied. Please remove some and try again.\n"]]
    else
      @app.call(env)
    end
  end

  private

  def facet_value_count(query_string)
    return 0 if query_string.nil? || !query_string.include?("f")

    params = Rack::Utils.parse_nested_query(query_string)
    FACET_PARAMS.sum do |key|
      facets = params[key]
      facets.is_a?(Hash) ? facets.values.sum { |values| Array(values).size } : 0
    end
  rescue Rack::Utils::ParameterTypeError, Rack::Utils::InvalidParameterError
    # Let Rails produce its usual error response for malformed queries.
    0
  end
end
