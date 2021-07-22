require 'singleton'

class Argyle::Publisher
  include Singleton

  # @!attribute [r] instance
  #   @return [Argyle::Publisher]
  #
  class << self
  end

  def initialize
    @subscriptions = {}
  end

  # @param event [Symbol]
  # @param params
  #
  def publish(event, *params)
    @subscriptions.fetch(event, {}).each do |subsription|
      subsription[:callable].call(*params)
    end
  end

  # @param source [#subscriptions]
  #   source#subscriptions must return a Hash, with the event name as key,
  #   and a method name, or an object responding to #call as value
  #
  # @raise [Argyle::Error::TypeError] If the source does not respond to #subscriptions
  # @raise [Argyle::Error::TypeError] If a subscriber is invalid
  #
  def subscribe(source)
    unless source.respond_to?(:subscriptions)
      raise Argyle::Error::TypeError.new("#{source.class} must respond to #subscriptions")
    end

    source.subscriptions.each do |event, subscriber|
      @subscriptions[event] ||= []

      @subscriptions[event] << {
        callable: callable_from(source, subscriber, event),
        source: source
      }
    end
  end

  # @param source [#subscriptions] (see Argyle::Publisher.source)
  #
  def unsubscribe(source)
    @subscriptions.reject! do |_, event_subscriptions|
      event_subscriptions.reject! do |subscripton|
        source == subscripton[:source]
      end
    end
  end

  private

  def callable_from(source, subscriber, event)
    return source.method(subscriber) if subscriber.is_a?(Symbol)
    return subscriber if subscriber.respond_to?(:call)

    message = 'Subscriber must be a method name on the source object, or must respond to #call'

    raise Argyle::Error::TypeError.new(
      "#{message} .Event: #{event} Source: #{source.class}"
    )
  end
end
