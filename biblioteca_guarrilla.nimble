# Package

version       = "0.1.8"
author        = "Juan Carlos"
description   = "Simple web to share books, Calibre, Jester, Spectre CSS, No JavaScript, WebP & ZIP to reduce bandwidth"
license       = "MIT"
srcDir        = "src"
bin           = @["biblioteca_guarrilla"]
installDirs   = @["static", "static/css"]
installFiles  = @["static/css/spectre.min.css", "static/css/spectre-exp.min.css"]


# Dependencies

requires "nim >= 0.20.0"
requires "jester"
requires "webp"
requires "zip"
