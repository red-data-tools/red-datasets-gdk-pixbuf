#!/usr/bin/env ruby

require "fileutils"
require "datasets-gdk-pixbuf"

counts_per_label = {}
mnist = Datasets::MNIST.new
mnist.each do |record|
  output_dir = "output/#{record.label}"
  FileUtils.mkdir_p(output_dir)

  counts_per_label[record.label] ||= -1
  counts_per_label[record.label] += 1
  n = counts_per_label[record.label]
  pixbuf = record.to_gdk_pixbuf
  pixbuf.save("#{output_dir}/#{n}.png")
end
