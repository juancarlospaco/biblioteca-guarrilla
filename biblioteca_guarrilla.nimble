# Package

version       = "0.1.8"
author        = "Juan Carlos"
description   = "Simple web to share books, Calibre, Jester, Spectre CSS, No JavaScript, WebP & ZIP to reduce bandwidth"
license       = "GPL"
srcDir        = "src"
bin           = @["biblioteca_guarrilla"]
installFiles  = @["src/static/css/spectre-exp.min.css", "src/static/css/spectre.min.css"]


# Dependencies

requires "nim >= 0.19.0"
requires "jester"
requires "webp"
requires "zip"
