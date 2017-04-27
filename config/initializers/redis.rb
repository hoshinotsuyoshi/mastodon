# frozen_string_literal: true

redis = Redis.new(
  host: ENV.fetch('REDIS_HOST') { 'localhost' },
  port: ENV.fetch('REDIS_PORT') { 6379 },
  password: ENV.fetch('REDIS_PASSWORD') { false },
  driver: :hiredis
)

namespace = ENV.fetch('REDIS_NAMESPACE'){ 'ns' }.to_sym

namespaced_redis = Redis::Namespace.new(namespace, redis: redis)

Redis.current = namespaced_redis
