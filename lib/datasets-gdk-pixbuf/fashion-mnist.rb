require_relative "mnist-pixbufable"

module Datasets
  class FashionMNIST
    class Record
      include DatasetsGdkPixbuf::MNISTPixbufable
    end
  end
end
