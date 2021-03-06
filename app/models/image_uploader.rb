class ImageUploader < Shrine
  include ImageProcessing::MiniMagick
  plugin :determine_mime_type
  plugin :processing
  plugin :versions
  plugin :store_dimensions
  plugin :default_url do |context|
    'ninja/noimage60x80.jpg'
  end

  process(:store) do |io, context|
    original = io.download
    thumbnail = resize_to_limit(io.download, 160, 240)
    small = resize_to_limit(io.download, 100, 150)
    medium = resize_to_limit(io.download, 640, 640)

    {original: original, thumbnail: thumbnail, small: small, medium: medium}
  end
end
