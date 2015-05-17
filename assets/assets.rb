def css_files
  %w[normalize.css foundation.min.css]
end

def js_files
  js_base_files  = %w[vendor/jquery.js vendor/modernizr.js foundation.min.js]
  js_foundation_plugins = %w[alert].map{|f|"foundation/foundation.#{f}.js"}

  js_base_files + js_foundation_plugins
end

