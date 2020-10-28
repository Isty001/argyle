class Argyle::View::Base
  # @param style_transformer [Argyle::View::StyleTransformer]
  #
  def initialize(style_transformer)
    @style_transformer = style_transformer
  end

  # @param window [Ncurses::WINDOW]
  # @param component [Argyle::Component::Base]
  #
  def render(_window, _component)
    raise NotImplementedError.new("render method must be implemented in #{self.class}")
  end

  private

  def style(window, id, &block)
    @style_transformer.apply(window, id, &block)
  end
end
