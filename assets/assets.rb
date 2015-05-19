def css_files
  %w[normalize.css foundation.min.css]
end

def foundation_plugins(*plugins)
  plugins.map{|f| "foundation/foundation.#{f}.js" }
end

def js_files
  js = []
  js.concat %w[vendor/jquery.js vendor/modernizr.js vendor/fastclick.js foundation/foundation.js]
  js.concat foundation_plugins("alert", "topbar")
  js << "main.js"
  js
end

