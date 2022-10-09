# frozen_string_literal: true

require 'bundler/setup'

Bundler.require

config = {
  'host' => 'localhost',
  'port' => 46379,
  'db' => 4,
  # 'driver' => :hiredis
}

# config = {
#   host: 'localhost',
#   port: 46379,
#   db: 4,
# }

puts "redis-rb version: #{Redis::VERSION}"
puts "driver: #{Redis.new._client.driver}"

class MyClass
  def hoge
  end
end

def set_get(config)
  puts "\n==== #{__method__} ===="
  redis = Redis.new(config)
  key = 'key-set_get-string'
  pp redis.set(key, 'hello world')
  pp "#{key}: #{redis.get(key)}"

  key = 'key-set_get-int'
  pp redis.set(key, 100)
  pp "#{key}: #{redis.get(key)}"

  key = 'key-set_get-bool'
  pp redis.set(key, true)
  pp "#{key}: #{redis.get(key)}"

  key = 'key-set_get-class'
  pp redis.set(key, MyClass)
  pp "#{key}: #{redis.get(key)}"
end

def rpush(config)
  puts "\n==== #{__method__} ===="
  redis = Redis.new(config)

  key = 'key-rpush'
  redis.del(key)
  pp redis.rpush(key, 'hello')
  pp redis.rpush(key, 100)
  pp redis.rpush(key, true)
  pp redis.rpush(key, nil)
  pp redis.rpush(key, MyClass)

  pp l=redis.lrange(key,0,-1)
end

def hset_hget(config)
  puts "\n==== #{__method__} ===="
  redis = Redis.new(config)

  key = 'key-hash'
  values = {
    'field1' => 'string',
    'field2' => 100,
    'field3' => true,
    'field4' => nil,
    'field5' => MyClass,
  }
  pp redis.mapped_hmset(key, values)

  pp redis.mapped_hmget(key, 'field1', 'field2', 'field3')
  pp redis.hgetall(key)
end

set_get(config)
rpush(config)
hset_hget(config)
