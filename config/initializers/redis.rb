# config = Rails.application.config_for('redis')
#
# pool = config.delete('pool') || {}
# namespace = config.delete('namespace')
#
# REDIS_POOL = ConnectionPool.new(pool.symbolize_keys) do
#   client = Redis.new(config)
#   Redis::Namespace.new(namespace, redis: client)
# end
