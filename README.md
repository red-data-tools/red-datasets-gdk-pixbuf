# README

## Name

Red Datasets GDK Pixbuf

## Description

Red Datasets GDK Pixbuf adds [GDK Pixbuf](https://developer.gnome.org/gdk-pixbuf/stable/) object export feature to Red Datasets.

Red Datasets GDK Pixbuf adds `#to_gdk_pixbuf` method to some datasets in Red Datasets. You can get `GdkPixbuf::Pixbuf` objects from a dataset.

## Install

```console
% gem install red-datasets-gdk-pixbuf
```

## Usage

Here is an example to get images for CIFAR dataset by `#to_gdk_pixbuf`:

```ruby
require "datasets"

cifar = Datasets::CIFAR.new
cifar.each.with_index do |record, i|
  pixbuf = record.to_gdk_pixbuf
  pixbuf.save("#{record.label}-#{i}.png")
end
```

## License

The MIT license. See `LICENSE.txt` for details.
