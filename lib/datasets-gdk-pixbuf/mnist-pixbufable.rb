require "gdk_pixbuf2"

module DatasetsGdkPixbuf
  module MNISTPixbufable
    def to_gdk_pixbuf
      rgb_data = pixels.map{|p| [(p - 255).abs] * 3}.flatten
      GdkPixbuf::Pixbuf.new(data: rgb_data.pack("C*"),
                            width: 28,
                            height: 28)
    end
  end
end
