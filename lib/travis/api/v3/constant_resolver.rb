require 'tool/thread_local'

module Travis::API::V3
  module ConstantResolver
    def self.extended(base)
      base.resolver_cache = Tool::ThreadLocal.new
      super
    end

    attr_accessor :resolver_cache

    def [](key)
      return key unless key.is_a? Symbol
      resolver_cache[key] ||= const_get(key.to_s.camelize, false)
    end

    def extended(base)
      base.extend(ConstantResolver)
      super
    end
  end
end
