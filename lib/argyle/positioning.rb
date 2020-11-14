class Argyle::Positioning
  class << self
    # @param raw [String] Relative size in form of percentage, ie 45%
    #
    # @return [Integer]
    #
    def parse_relative_size(raw)
      return 100 if raw.nil?

      match = raw.to_s.match(/(-?\d+)%/)

      raise Argyle::Error::ArgumentError.new("Invalid size format: #{raw}") unless match

      match.captures.first.to_i.clamp(1, 100)
    end

    def convert_relative_size(relative_size, max_size)
      relative_size ? (max_size * (relative_size / 100.0)).floor : max_size
    end

    # @param float [Array<Symbol>]
    # @param width [Integer]
    # @param height [Integer]
    # @param max_width [Integer]
    # @param max_height [Integer]
    #
    # @return [Array<Integer>] Actual coordiantes: [x, y]
    #
    def float_to_coordinates(float, width, height, max_width, max_height)
      x = 0
      y = 0

      float.to_a.each do |item|
        case item
        when :right
          x = max_width - width
        when :bottom
          y = max_height - height
        when :center
          x = (max_width - width) / 2
          y = (max_height - height) / 2
        end
      end

      [x, y]
    end

    # @param x [Integer]
    # @param y [Integer]
    # @param max_width [Integer]
    # @param max_height [Integer]
    # @param relative_offsets [Array<Symbol>]
    #
    # @return [Array<Integer>] Actual coordiantes: [x, y]
    #
    def apply_offsets(x, y, max_width, max_height, relative_offsets)
      relative_offsets.to_a.each do |offset, relative_value|
        case offset
        when :left
          x += convert_relative_size(relative_value, max_width)
        when :right
          x -= convert_relative_size(relative_value, max_width)
        when :top
          y += convert_relative_size(relative_value, max_height)
        when :bottom
          y -= convert_relative_size(relative_value, max_height)
        end
      end

      [x.clamp(0, max_width), y.clamp(0, max_height)]
    end
  end
end
