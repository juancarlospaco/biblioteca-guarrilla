# Biblioteca-Guarrilla

- Simple responsive web to share books, [Calibre](https://calibre-ebook.com), [Nim](https://nim-lang.org), [Jester](https://github.com/dom96/jester#jester), [Spectre CSS](https://picturepan2.github.io/spectre/getting-started.html), [No JavaScript](http://tonsky.me/blog/disenchantment), [WebP](https://developers.google.com/speed/webp) &amp; ZIP to reduce bandwidth.


![Biblioteca-Guarrilla](https://raw.githubusercontent.com/juancarlospaco/biblioteca-guarrilla/master/temp.jpg "Biblioteca-Guarrilla")


![Biblioteca-Guarrilla](https://raw.githubusercontent.com/juancarlospaco/biblioteca-guarrilla/master/temp1.jpg "Biblioteca-Guarrilla")


![Biblioteca-Guarrilla](https://raw.githubusercontent.com/juancarlospaco/biblioteca-guarrilla/master/temp2.jpg "Mobile Responsive")


![Biblioteca-Guarrilla](https://raw.githubusercontent.com/juancarlospaco/biblioteca-guarrilla/master/temp4.jpg "300Kb file size")


- 1 file.
- ~300Kb.
- ~130 Lines of code.
- 0 Dependencies.
- English & Spanish supported.


# Requisites

- A [Calibre](https://calibre-ebook.com) database `metadata.db` (with the books on the same folder as the database, as typically used by Calibre App).


# Use

**Spanish:**

```
./biblioteca_guarrilla --color --filtros --desbichar --limite=42 --autorefresco=9 --mensaje='Un mensaje de Admin aqui' '/ruta/a/calibre/metadata.db'
```

Opciones:

- `--desbichar` Modo de depuracion de errores.
- `--color` Usar coloreado de la salide de Terminal.
- `--autorefresco=9` Forzar Auto-Refresco de la Web en Segundos, numero 1 ~ 255.
- `--filtros` Usar Filtros por Inicial del nombre del libro en la pagina Web.
- `--mensaje` Mensaje de Admin se ve en la pagina Web, ideal MOTD, COC, etc.
- `--limite=42` Limite maximo de Libros a publicar en la Web, numero 1 ~ 255.
- `--salida='/ruta/a/archivo.html'` Escribir Web a un archivo en lugar de servirla.
- Ver Ayuda con `--ayuda`.

**English:**

```
./biblioteca_guarrilla --color --filters --debug --limit=42 --autorefresh=9 --message='Some Admin message here' '/path/to/calibre/metadata.db'
```

Options:

- `--debug` Debug mode.
- `--color` Use colored Terminal output.
- `--autorefresh=9` Forze Auto-Refresh of Web on Seconds, 1 ~ 255 integer.
- `--filters` Use Filters per book name on the Web.
- `--message` Admin Message seen on the Web, ideal for MOTD, COC, etc.
- `--limit=42` Max number of books to publish on the Web, 1 ~ 255 integer.
- `--output='/path/to/file.html'` Write the Web to a file instead of serving it.
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

- Se puede usar con Python, Flask, Bottlepy, etc?.

Si, usar opcion `--salida=` y servir la web con la App Python (No provista).

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
PDF en ZIP es mas liviano. EPUB no se ZIPean. No borra ningun archivo.
Al final la misma aplicacion sirve la web y se ve desde el browser.

- Donde se Descarga?.

https://github.com/juancarlospaco/biblioteca-guarrilla/releases

- Fails with `Error: unhandled exception: cannot open: static/css/spectre.min.css [IOError]` ?

Copy over [the `/static/` folder](https://github.com/juancarlospaco/biblioteca-guarrilla/tree/master/src/static/css).


#### Internal Structure

<details>

![Biblioteca-Guarrilla](https://raw.githubusercontent.com/juancarlospaco/biblioteca-guarrilla/master/dot.jpg "GraphViz Plot for Developers")

</details>


Run `nim doc biblioteca_guarrilla.nim` for more Documentation.
