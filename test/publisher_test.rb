require 'test'

class PublisherTest < Minitest::Test
  class TestSubscriber
    def subscriptions
      {
        test_method: :hello
      }
    end

    def hello; end
  end

  def test_call_method
    publisher = Argyle::Publisher.instance

    params = [:some_args]

    subscriber = TestSubscriber.new
    subscriber.expects(:hello).with(params)

    publisher.subscribe(subscriber)
    publisher.publish(:test_method, params)
  end

  def test_call_callable
    publisher = Argyle::Publisher.instance

    params = [:some_args]

    callable = mock
    callable.expects(:call).with(params)
    callable.expects(:respond_to?).with(:call).returns(true)

    subscriber = TestSubscriber.new
    subscriber.expects(:subscriptions).returns({test_callable: callable})

    publisher.subscribe(subscriber)
    publisher.publish(:test_callable, params)
  end

  def test_no_subscriptions
    publisher = Argyle::Publisher.instance

    error = assert_raises(Argyle::Error::TypeError) do
      publisher.subscribe(1)
    end

    assert_equal('Integer must respond to #subscriptions', error.message)
  end

  def test_invalid_subscriber_type
    publisher = Argyle::Publisher.instance

    callable = mock
    callable.expects(:respond_to?).with(:call).returns(false)

    subscriber = TestSubscriber.new
    subscriber.expects(:subscriptions).returns({test_event: callable})

    error = assert_raises(Argyle::Error::TypeError) do
      publisher.subscribe(subscriber)
    end

    expected = "Subscriber must be a method name on the source object, \
or must respond to #call .Event: test_event Source: PublisherTest::TestSubscriber"

    assert_equal(expected, error.message)
  end

  def test_unsubscribe
    publisher = Argyle::Publisher.instance

    params = [:some_args]

    subscriber = TestSubscriber.new

    publisher.subscribe(subscriber)
    publisher.unsubscribe(subscriber)

    publisher.publish(:test_method, params)
  end
end
