class IrisTest < Test::Unit::TestCase
  include Helper::Sandbox

  def setup_raw_data(data)
    setup_sandbox

    def @dataset.cache_dir_path
      @cache_dir_path
    end
    def @dataset.cache_dir_path=(path)
      @cache_dir_path = path
    end
    @dataset.cache_dir_path = @tmp_dir

    def @dataset.data=(data)
      @data = data
    end
    @dataset.data = data

    def @dataset.download(output_path, url)
      Zlib::GzipWriter.open(output_path) do |gz|
        Gem::Package::TarWriter.new(gz) do |tar|
          @data.each do |path, content|
            if content == :directory
              tar.mkdir(path, 0755)
            else
              tar.add_file_simple(path, 0644, content.bytesize) do |file|
                file.write(content)
              end
            end
          end
        end
      end
    end
  end

  def teardown
    teardown_sandbox
  end

  sub_test_case("cifar-10") do
    def create_data(label, pixels)
      [label].pack("C") + pixels.pack("C*")
    end

    def setup
      @dataset = Datasets::CIFAR.new(n_classes: 10)
      directory = "cifar-10-batches-bin"
      pixels = [255] * (32 * 32) + [0] * (32 * 32) + [127] * (32 * 32)
      setup_raw_data(directory => :directory,
                     "#{directory}/data_batch_1.bin" => create_data(1, pixels))
    end

    test("#to_gdk_pixbuf") do
      assert_equal([255, 0, 127] * (32 * 32),
                   @dataset.first.to_gdk_pixbuf.pixels)
    end
  end

  sub_test_case("cifar-100") do
    def create_data(coarse_label, fine_label, pixels)
      [coarse_label, fine_label].pack("C*") + pixels.pack("C*")
    end

    def setup
      @dataset = Datasets::CIFAR.new(n_classes: 100)
      directory = "cifar-100-binary"
      pixels = [255] * (32 * 32) + [0] * (32 * 32) + [127] * (32 * 32)
      setup_raw_data(directory => :directory,
                     "#{directory}/train.bin" => create_data(1, 11, pixels))
    end

    test("#to_gdk_pixbuf") do
      assert_equal([255, 0, 127] * (32 * 32),
                   @dataset.first.to_gdk_pixbuf.pixels)
    end
  end
end
