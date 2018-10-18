class MNISTTest < Test::Unit::TestCase
  def setup
    @dataset = Datasets::MNIST.new(type: :train)
  end

  test("#to_gdk_pixbuf") do
    assert_equal([2, 2, 2, 2, 2, 11, 11, 11, 122, 122],
                 @dataset.to_a.first.to_gdk_pixbuf.pixels[1960, 10])
  end
end
