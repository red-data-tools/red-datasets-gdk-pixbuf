class FashionMNISTTest < Test::Unit::TestCase
  def setup
    @dataset = Datasets::FashionMNIST.new(type: :train)
  end

  test("#to_gdk_pixbuf") do
    assert_equal([74, 74, 70, 70, 70, 67, 67, 67, 66, 66],
                 @dataset.to_a.first.to_gdk_pixbuf.pixels[1960, 10])
  end
end
