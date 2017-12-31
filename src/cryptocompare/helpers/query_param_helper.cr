# require 'yaml'

# Helper module for setting query params.
module Cryptocompare
  module QueryParamHelper
    QUERY_PARAM_MAPPING = {
      "agg": "aggregate",
      "all_data": "allData",
      "e": "e",
      "from_sym": "fsym",
      "from_syms": "fsyms",
      "limit": "limit",
      "markets": "markets",
      "tc": "tryConversion",
      "to_sym": "tsym",
      "to_syms": "tsyms",
      "to_ts": "toTs",
      "ts": "ts",
      "utc_offset": "UTCHourDiff"
    }

    # Appends query parameters to path
    def self.set_query_params(path, params, opts)
      path + "?#{to_query(params, opts)}"
    end

    # Helper method to parse parameters and build query parameters
    def self.to_query(params, opts)
      [params, opts].map do |hash|
        hash.map do |k, v|
          "#{QUERY_PARAM_MAPPING[k.to_s]}=#{v.to_s}"
        end.join("&")
      end.join("&")
    end

    def self.build_params(from_syms, to_syms, e = nil)
      from_str = from_syms.is_a?(String) ? from_syms : from_syms.join(",")
      to_str = to_syms.is_a?(String) ? to_syms : to_syms.join(",")
      hash = {
        "from_syms": from_str,
        "to_syms":   to_str
      }

      unless e.nil?
        e_str = e.is_a?(String) ? e : e.join(",")
        hash["e"] = e_str
      end
      hash
    end

    def self.build_find_params(from_sym, to_syms)
      to_str = to_syms.is_a?(String) ? to_syms : to_syms.join(",")
      {
        "from_sym": from_sym,
        "to_syms":  to_str
      }
    end
  end
end
