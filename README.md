# Biblioteca-Guarrilla

- Simple responsive web to share books, [Calibre](https://calibre-ebook.com), [Nim](https://nim-lang.org), [Jester](https://github.com/dom96/jester#jester), [Spectre CSS](https://picturepan2.github.io/spectre/getting-started.html), [No JavaScript](http://tonsky.me/blog/disenchantment), [WebP](https://developers.google.com/speed/webp) &amp; ZIP to reduce bandwidth.


![Biblioteca-Guarrilla](https://raw.githubusercontent.com/juancarlospaco/biblioteca-guarrilla/master/temp.jpg "Biblioteca-Guarrilla")


![Biblioteca-Guarrilla](https://raw.githubusercontent.com/juancarlospaco/biblioteca-guarrilla/master/temp1.jpg "Biblioteca-Guarrilla")


![Biblioteca-Guarrilla](https://raw.githubusercontent.com/juancarlospaco/biblioteca-guarrilla/master/temp2.jpg "Mobile Responsive")


![Biblioteca-Guarrilla](https://raw.githubusercontent.com/juancarlospaco/biblioteca-guarrilla/master/temp4.jpg "300Kb file size")


- 1 file.
- ~300Kb.
- ~115 Lines of code.
- 0 Dependencies.
- English & Spanish supported.


# Requisites

- A [Calibre](https://calibre-ebook.com) database `metadata.db` (with the books on the same folder as the database, as typically used by Calibre App).


# Use

**Spanish:**

```
./biblioteca_guarrilla --color --filtros --mensaje='Un mensaje de Admin aqui' '/ruta/a/calibre/metadata.db'
```

- Ver Ayuda con `--ayuda`.

**English:**

```
./biblioteca_guarrilla --color --filters --message='Some Admin message here' '/path/to/calibre/metadata.db'
```

- See Help with `--help`.


# FAQ

- Works over Wifi?.

Yes.

- How to set English as default language?.

Its designed in a way that spoken language does not really matter too much.

- Necesita Nim instalado?.

No.

- Necesita Servidor Web?.

No.

- Como se instala?.

No se instala. Solo ejecutalo y listo.

- Como se configura?.

No se configura. Solo ejecutalo y listo.

- How to use Calibre?.

[See docs.](https://calibre-ebook.com/help)

- Que hace?.

Genera una web a partir de un catalogo de Calibre.
Calibre es una App de Libros Digitales.
Recorre la carpeta de Calibre procesando archivos.
Luego optimiza las tapas de libros de JPG a WebP.
WebP pesa la mitad que JPG, para previews es mas que suficiente.
La web mostrara una foto paisaje o similar si falta la tapa del libro.
Luego optimiza los libros Mobi y PDF comprimiendolos en ZIP.
PDF en ZIP es mas liviano. EPUB no se ZIPean. No borra ningun archivo nunca.
Al final la misma aplicacion sirve la web y se ve desde el browser.

- Fails with `Error: unhandled exception: cannot open: static/css/spectre.min.css [IOError]` ?

Copy over [the `/static/` folder](https://github.com/juancarlospaco/biblioteca-guarrilla/tree/master/src/static/css).


#### Internal Structure

<details>

![Biblioteca-Guarrilla](https://raw.githubusercontent.com/juancarlospaco/biblioteca-guarrilla/master/dot.jpg "GraphViz Plot for Developers")

</details>


Run `nim doc biblioteca_guarrilla.nim` for more Documentation.
