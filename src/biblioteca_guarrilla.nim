import
  strutils, strformat, os, tables, json,
  xmlparser, xmltree, jester, webp, zip/zipfiles
include "biblioteca_guarrilla.nimf"

const
  bookCategories* = {
    "a": '1', "b": '1', "c": '1', "d": '1',
    "e": '2', "f": '2', "g": '2', "h": '2',
    "i": '3', "j": '3', "k": '3', "l": '3',
    "m": '4', "n": '4', "o": '4', "p": '4',
    "q": '5', "r": '5', "s": '5', "t": '5',
    "u": '6', "v": '6', "w": '6', "x": '6',
    "y": '7', "z": '7', "0": '7', "1": '7', "2": '7', "3": '7',
    "4": '7', "5": '7', "6": '7', "7": '7', "8": '7', "9": '7',
  }.toTable  ## Filter Categories based on 1st char of the Name of the book.
  bookOpfFields* = [
    "dc:identifier", "dc:title", "dc:creator", "dc:contributor", "dc:date",
    "dc:description", "dc:publisher", "dc:language", "dc:subject",
  ]  ## OPF Fields from the Books to convert them from XML to JSON.

func normalize_filename*(path: string, ext_new=""): string {.inline.} =
  ## Normalize a filename, appending a new extension, but dont touch the folders
  var (folder, name, ext_old) = splitFile(path)
  result = folder / name.normalize & ext_old.normalize & ext_new.normalize

proc zip_this(file, zip_path: string) {.inline.} =
  ## ZIP a file.
  var z: ZipArchive
  discard z.open(zip_path, fmWrite)
  z.addFile(file)
  z.close()

proc xml2json*(xmlstr: string, wanted_fields: seq[string]): JsonNode =
  ## Convert XML to JSON returning only wanted_fields.
  assert wanted_fields.len > 0, "wanted_fields must be a non empty seq[string]"
  assert xmlstr.len > 8, "xmlstr must be a non empty string with raw XML inside"
  result = parseJson("{}")
  let temp = xmlstr.parseXml
  for field in wanted_fields:
    var xml_tags = temp.findAll(field)
    if xml_tags.len > 0:
      var tagy = xml_tags[0]
      if not tagy.isNil:
        result.add(field, %normalize(tagy.innerText))
    else:
      result.add(field, %"")

proc walky(path: string, nowebp: bool, limit: byte): seq[JsonNode] =
  ## Walk & Preprocess a Calibre directory of files.
  var
    limite = limit.int16
    okmeta: JsonNode
    okcover, okmobi, okpdf, okepub, okopf: string
  for file in walkDirRec(path):
    if file.endsWith("cover.jpg"):
      echo file
      if nowebp:
        okcover = normalize_filename(file)
      else:
        okcover = normalize_filename(file, ".webp")
        discard cwebp(file, okcover, "text", quality=1, noalpha=true)
    elif file.endsWith(".mobi"): # ZIPed Mobi is smaller.
      echo file
      okmobi = normalize_filename(file, ".zip")
      zip_this(file, okmobi)
    elif file.endsWith(".pdf"):  # ZIPed PDF is smaller.
      echo file
      okpdf = normalize_filename(file, ".zip")
      zip_this(file, okpdf)
    elif file.endsWith(".epub"): # EPUB copy with Normalized name.
      echo file
      okepub = normalize_filename(file)
      copyFile(file, okepub)
    elif file.endsWith("metadata.opf"): # XML Metadata.
      echo file
      okopf = normalize_filename(file, ".json")
      okmeta = xml2json(readFile(file), @bookOpfFields)
      writeFile(okopf, okmeta.pretty)
      if limite == 1: #  0 Disabled.
        break         #  1 Break.
      if limite > 1:  # >1 Decrement.
        dec limite
      result.add %*{
        "cover": okcover.replace(path, ""),
        "mobi": okmobi.replace(path, ""),
        "pdf": okpdf.replace(path, ""),
        "epub": okepub.replace(path, ""),
        "opf": okopf.replace(path, ""),
        "identifier": okmeta["dc:identifier"].str,
        "title": okmeta["dc:title"].str,
        "creator": okmeta["dc:creator"].str,
        "contributor": okmeta["dc:contributor"].str,
        "date": okmeta["dc:date"].str.split("-")[0],
        "description": okmeta["dc:description"].str,
        "publisher": okmeta["dc:publisher"].str,
        "language": okmeta["dc:language"].str,
        "subject": okmeta["dc:subject"].str,
        "indice": $bookCategories[$okmeta["dc:title"].str.toLowerAscii[0]]
      }

proc main*(folder: string, filters, nowebp, debugs: bool, limit, autorefresh: byte, output: string, msg="") =
  ## Main function to preprocess, render and serve or write HTML. Also simple Debug.
  let
    jotason = walky(folder, nowebp, limit)
    web = generateHTML(jotason, bookCategories, filters, msg, autorefresh)
  if debugs: echo jotason
  if output.len > 0:
    writeFile(output, web)
  else:
    routes:
      get "/":
        setStaticDir(request, folder)
        resp web


when is_main_module:
  {. passL: "-s", passC: "-flto", optimization: size .}
  import parseopt, terminal, random
  var
    limit, autorefresh: byte
    message, output: string
    debugs, filters, nowebp: bool
  for tipoDeClave, clave, valor in getopt():
    case tipoDeClave
    of cmdShortOption, cmdLongOption:
      case clave
      of "version":             quit("0.1.8", 0)
      of "license", "licencia": quit("GPL", 0)
      of "help", "ayuda":       quit("biblioteca_guarrilla --color --filtros --desbichar --limite=42 --autorefresco=9 --mensaje='Admin Message' '/ruta/a/calibre/metadata.db'", 0)
      of "filters", "filtros":  filters = true
      of "nowebp":              nowebp = true
      of "debug", "desbichar":  debugs = true
      of "mensaje", "message":  message = valor.string.strip.normalize
      of "limit", "limite":     limit = valor.parseInt.byte
      of "output", "salida":    output = valor.string.strip
      of "autorefresco", "autorefresh":
        autorefresh = valor.parseInt.byte
      of "color":
        randomize()
        setBackgroundColor(bgBlack)
        setForegroundColor([fgRed, fgGreen, fgYellow, fgBlue, fgMagenta, fgCyan, fgWhite].sample)
    of cmdArgument:
      main(clave.string.strip.parentDir, filters, nowebp, debugs, limit, autorefresh, output, message)
    of cmdEnd: quit("Error desconocido. Ver la Ayuda con --ayuda", 1)
