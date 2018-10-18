require "gdk_pixbuf2"

module DatasetsGdkPixbuf
  module MNISTPixbufable
    def to_gdk_pixbuf
      n_channels = 3
      width = 28
      height = 28
      rgb_data = pixels.map{|p| [(p - 255).abs] * n_channels}.flatten
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
  class MNIST
    class Record
      include DatasetsGdkPixbuf::MNISTPixbufable
    end
  end
end
