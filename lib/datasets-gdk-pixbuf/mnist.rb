require_relative "mnist-pixbufable"

module Datasets
  class MNIST
    class Record
      include DatasetsGdkPixbuf::MNISTPixbufable
    end
  end
end
