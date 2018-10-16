class MNISTTest < Test::Unit::TestCase
  include Helper::Sandbox

  def setup_data(test_data)
    setup_sandbox

    def @dataset.cache_dir_path
      @cache_dir_path
    end

    def @dataset.cache_dir_path=(path)
      @cache_dir_path = path
    end
    @dataset.cache_dir_path = @tmp_dir

    def @dataset.test_data=(test_data)
      @test_data = test_data
    end
    @dataset.test_data = test_data

    def @dataset.download(output_path, url)
      image_magic_number = 2051
      label_magic_number = 2049
      n_image, image_size_x, image_size_y, label = 10, 28, 28, 1

      Zlib::GzipWriter.open(output_path) do |gz|
        if output_path.basename.to_s.include?("-images-")
          image_data = ([image_magic_number, n_image]).pack('N2') +
                        ([image_size_x,image_size_y]).pack('N2') +
                        @test_data.pack("C*") * n_image
          gz.puts(image_data)
        else
          label_data = ([label_magic_number, n_image]).pack('N2') +
                        ([label] * n_image).pack("C*")
          gz.puts(label_data)
        end
      end
    end
  end

  def teardown
    teardown_sandbox
  end

  def create_data
    (0..27).to_a * 28
  end

  def pixbuf_data
    ((255 - 27)..255).map{|d| [d] * 3}.flatten.reverse * 28
  end

  def setup
    @dataset = Datasets::MNIST.new(type: :train)
    setup_data(create_data)
  end

  test("#to_gdk_pixbuf") do
    assert_equal(pixbuf_data,
                 @dataset.first.to_gdk_pixbuf.pixels)
  end
end
