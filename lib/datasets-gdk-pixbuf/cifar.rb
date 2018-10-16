require "gdk_pixbuf2"

module DatasetsGdkPixbuf
  module CIFARPixbufable
    def to_gdk_pixbuf
      n_channels = 3
      width = 32
      height = 32
      color_size = width * height
      rgb_data = pixels.each_slice(color_size).to_a.transpose.flatten
      # TODO: Remove the following line when gdk_pixbuf2 3.3.0 is released.
      rgb_data = rgb_data.pack("C*")
      GdkPixbuf::Pixbuf.new(:data => rgb_data,
                            :row_stride => width * n_channels,
                            :width => width,
                            :height => height)
    end
  end
end

module Datasets
  class CIFAR
    class Record10
      include DatasetsGdkPixbuf::CIFARPixbufable
    end

    class Record100
      include DatasetsGdkPixbuf::CIFARPixbufable
    end
  end
end
