module Argyle::Subscriber
  def new(*args)
    super

    Argyle::Publisher.instance.subscribe(self)
  end
end
