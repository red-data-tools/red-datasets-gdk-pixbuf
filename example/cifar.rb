#!/usr/bin/env ruby

require "fileutils"
require "datasets-gdk-pixbuf"

label_names = [
  "airplane",
  "automobile",
  "bird",
  "cat",
  "deer",
  "dog",
  "frog",
  "horse",
  "ship",
  "truck",
]
counts_per_label = {}
cifar = Datasets::CIFAR.new
cifar.each do |record|
  output_dir = "output/#{label_names[record.label]}"
  FileUtils.mkdir_p(output_dir)

  counts_per_label[record.label] ||= -1
  counts_per_label[record.label] += 1
  n = counts_per_label[record.label]
  pixbuf = record.to_gdk_pixbuf
  pixbuf.save("#{output_dir}/#{n}.png")
end
