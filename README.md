# Guía de Neovim

> Ábrela desde nvim con `Espacio ?`
> Para salir de esta guía: `Espacio bd` (cierra la pestaña) o `:q`

---

## 1. Lo mínimo para no perderse

**Vim tiene modos.** Siempre abre en **Normal**, donde las teclas son *comandos*, no texto.

| Tecla | Qué hace |
|---|---|
| `i` | Entra a modo **Inserción** (escribir normal) |
| `Esc` | Vuelve a Normal. **Si te pierdes, pulsa `Esc` varias veces** |
| `:w` Enter / `Espacio w` | Guardar |
| `:q` Enter / `Espacio q` | Salir |
| `:q!` Enter | Salir sin guardar |
| `u` / `Ctrl+r` | Deshacer / Rehacer |
| `Ctrl+z` | Suspende nvim y vuelves a la terminal. `fg` para regresar |

El **mouse funciona**: clic, seleccionar, scroll.

**La tecla líder es `Espacio`.** Púlsala y espera: aparece un menú con todos los atajos.
`Espacio fk` busca entre *todos* los atajos por descripción.

---

## 2. El truco que hace que Vim valga la pena: verbo + objeto

En modo Normal, editas "hablando": **verbo** + **qué**.

| Verbos  |                                     | Objetos             |                                            |
| ------- | ----------------------------------- | ------------------- | ------------------------------------------ |
| `d`     | borrar (y copiar)                   | `w`                 | hasta la siguiente palabra                 |
| `c`     | cambiar (borra y entra a Inserción) | `iw`                | la palabra entera                          |
| `y`     | copiar                              | `i"` `i'` `` i` ``  | dentro de comillas                         |
| p       | pegar                               |                     |                                            |
| `v`     | seleccionar                         | `i(` `i{` `i[` `i<` | dentro de paréntesis/llaves/corchetes/tags |
| `>` `<` | indentar / desindentar              | `it`                | dentro de una etiqueta HTML                |
|         |                                     | `ip`                | el párrafo/bloque                          |
|         |                                     | `$`                 | hasta el final de la línea                 |

Cambia `i` por `a` para incluir los delimitadores: `da"` borra el string *con* sus comillas.

**Ejemplos que vas a usar a diario:**

| Escribes | Resultado |
|---|---|
| `ciw` | reemplazar la palabra bajo el cursor |
| `ci"` | reemplazar el contenido de un string (el cursor puede estar en cualquier parte de la línea) |
| `ci(` | reescribir los argumentos de una función |
| `cit` | cambiar el texto dentro de un `<button>…</button>` |
| `di{` | vaciar el cuerpo de una función |
| `yip` / `dip` | copiar / borrar un bloque entero |
| `dd` / `yy` / `p` | borrar línea / copiar línea / pegar debajo |
| `.` | **repite el último cambio** (el comando más poderoso de Vim) |

Los números multiplican: `3dd` borra 3 líneas, `5j` baja 5 líneas.

`Ctrl+a` / `Ctrl+x` suma / resta 1 al número bajo el cursor (o el siguiente en la línea). `10 Ctrl+a` suma 10.

### Moverse

| Tecla               | Movimiento                                                          |
| ------------------- | ------------------------------------------------------------------- |
| `h` `j` `k` `l`     | ← ↓ ↑ → (las flechas también funcionan)                             |
| `w` / `b`           | palabra siguiente / anterior                                        |
| `0` / `$`           | inicio / fin de línea                                               |
| `gg` / `G`          | inicio / fin del archivo                                            |
| `Ctrl+d` / `Ctrl+u` | media pantalla abajo / arriba                                       |
| `%`                 | saltar al paréntesis/llave que cierra (o abre)                      |
| `/texto` `Enter`    | buscar. `n` siguiente, `N` anterior. `Esc` quita el resaltado       |
| `*`                 | buscar la palabra bajo el cursor                                    |
| `Ctrl+o` / `Ctrl+i` | **volver atrás / adelante** a donde estabas (tras `gd`, búsquedas…) |

### Selección

| Tecla | Qué selecciona |
|---|---|
| `v` | por caracteres |
| `V` | por líneas (luego `J`/`K` mueve las líneas arriba/abajo) |
| `Ctrl+v` | **bloque/columna** (edición multilínea, ver reto 9) |

Con algo seleccionado: `d` borra, `y` copia, `c` cambia, `>` indenta.

---

## 3. Atajos de esta configuración

### Explorador de archivos (neo-tree)

| Tecla | Acción |
|---|---|
| `Espacio e` | abrir/cerrar explorador |
| `Espacio o` | saltar al explorador |
| `Ctrl+h` / `Ctrl+l` | moverse entre explorador y código |
| `Enter` o `l` | abrir archivo / expandir carpeta |
| `h` | colapsar carpeta |
| `a` | crear archivo (termina en `/` para carpeta: `services/`) |
| `d` / `r` | borrar / renombrar |
| `c` / `m` | copiar / mover |
| `y` `x` `p` | copiar / cortar / pegar |
| `P` | vista previa sin abrir |
| `H` | mostrar/ocultar archivos ocultos |
| `/` | filtrar por nombre |
| `?` | **ver todos los atajos del explorador** |

Los colores indican estado git (modificado, nuevo, ignorado atenuado).

#### Cambiar el ancho del explorador

**En el momento** (vuelve al ancho normal al cerrarlo y reabrirlo):

| Cómo | Acción |
|---|---|
| Mouse | arrastra la línea vertical entre el explorador y el código |
| `Ctrl+w >` / `Ctrl+w <` | más ancho / más angosto (1 columna; con el cursor en el explorador) |
| `10 Ctrl+w >` | más ancho de a 10 columnas (el número multiplica) |
| `:vertical resize 45` | ancho exacto de 45 columnas |
| `e` (dentro del explorador) | se ajusta solo al nombre más largo; `e` otra vez para volver |

Estos `Ctrl+w` sirven para cualquier ventana dividida, no solo el explorador.

**Para siempre:** cambia `width = 34` en `~/.config/nvim/lua/plugins/explorer.lua`:
1. `nvim ~/.config/nvim/lua/plugins/explorer.lua`
2. `/width` Enter → el cursor va a la línea `width = 34,`
3. `w` dos veces → quedas sobre el `34`
4. `ciw`, escribe `40`, `Esc`
   - o el truco: **`Ctrl+a` suma 1 y `Ctrl+x` resta 1** al número bajo el cursor (`6 Ctrl+a` → 34 pasa a 40)
5. `Espacio w` para guardar, `:qa` y vuelve a abrir nvim para que tome el cambio

### Archivos y búsqueda (Telescope)

| Tecla | Acción |
|---|---|
| `Espacio Espacio` | buscar archivo por nombre |
| `Espacio fg` | buscar **texto** en todo el proyecto |
| `Espacio fs` | buscar **texto** en el archivo actual |
| `Espacio fr` | archivos recientes |
| `Espacio fb` | archivos abiertos |
| `Espacio fd` | todos los errores/avisos |
| `Espacio fk` | todos los atajos |
| `Espacio fh` | ayuda de nvim |

Dentro de Telescope: escribe para filtrar, `↑`/`↓` o `Ctrl+n`/`Ctrl+p` para moverte, `Enter` abre,
`Ctrl+v` abre en división vertical, `Ctrl+q` manda los resultados a la *lista quickfix*, `Esc` cierra.

### Pestañas (archivos abiertos)

| Tecla | Acción |
|---|---|
| `Shift+l` / `Shift+h` | pestaña siguiente / anterior |
| `Espacio bd` | cerrar pestaña |
| `Espacio bo` | cerrar todas las demás |
| `Espacio bp` | elegir pestaña por letra |

### Código (LSP)

| Tecla | Acción |
|---|---|
| `gd` | ir a la definición |
| `gr` | ver todas las referencias (dónde se usa) |
| `gI` | ir a la implementación |
| `K` | documentación / tipo de lo que está bajo el cursor |
| `]d` / `[d` | siguiente / anterior error |
| `Espacio d` | ver el error completo de la línea |
| `Espacio ca` | acciones de código / quick fix (imports, arreglos…) |
| `Espacio cr` | renombrar símbolo en todo el proyecto |
| `Espacio cs` | lista de funciones/clases del archivo |
| `Espacio cf` | formatear archivo |

**Autocompletado** (modo Inserción): aparece solo. `Ctrl+n`/`Ctrl+p` navegar, `Ctrl+y` aceptar,
`Ctrl+Espacio` forzar que aparezca, `Ctrl+e` cerrarlo.

### Git

| Tecla | Acción |
|---|---|
| `Espacio gs` | archivos modificados |
| `]h` / `[h` | siguiente / anterior cambio en el archivo |
| `Espacio gp` | ver el cambio (qué había antes) |
| `Espacio gr` | deshacer ese cambio |
| `Espacio gd` | diff del archivo completo |
| `Espacio gb` | blame de la línea |
| `Espacio gB` | blame siempre visible |
| `Espacio gc` | historial de commits |
| `Espacio gf` | commits de este archivo |
| `Espacio gn` | ramas |

---

## 4. Retos con tus proyectos reales

Elige uno por día. Cada uno practica algo distinto.

### Reto 1 — Moverte por un proyecto Angular sin el mouse
1. `cd` a un proyecto Angular, `nvim .`
2. `Espacio Espacio`, escribe `comp ts` → abre un `.component.ts`
3. Pon el cursor sobre un servicio inyectado y pulsa `gd` → te lleva al servicio
4. `Ctrl+o` → vuelves. Repite con otra cosa y vuelve otra vez
5. Pulsa `K` sobre un método para ver su firma

### Reto 2 — Dejar un archivo sin errores
1. Abre un archivo con avisos (los verás en la columna izquierda y en la pestaña)
2. `]d` salta al primero, `Espacio d` para leerlo entero
3. `Espacio ca` para ver si hay arreglo automático (p. ej. "Add missing import")
4. `]d` al siguiente hasta terminar. `Espacio fd` para ver los del proyecto entero

### Reto 3 — Renombrar algo en todo el proyecto
1. Cursor sobre una función, clase o variable mal nombrada (Rust, TS o Kotlin)
2. `Espacio cr`, escribe el nuevo nombre, Enter
3. `Espacio gs` → mira todos los archivos que cambió

### Reto 4 — Buscar y reemplazar en todo el proyecto
1. `Espacio fg`, escribe el texto a buscar (p. ej. una URL vieja de un test de Playwright)
2. `Ctrl+q` → manda todos los resultados a la lista quickfix
3. Escribe: `:cdo s/textoViejo/textoNuevo/gc | update` Enter
   - `g` = todas las veces en cada línea, `c` = te pregunta en cada una (`y` sí, `n` no, `a` todas)
   - `update` guarda cada archivo
4. Pulsa `:cclose` para cerrar la lista

### Reto 5 — Entender código ajeno
1. Abre un archivo que no escribiste tú
2. `Espacio cs` → ves la estructura (funciones, clases) y saltas a la que quieras
3. Sobre una función: `gr` → ¿quién la llama?
4. `Espacio gb` → ¿quién escribió esta línea y en qué commit?

### Reto 6 — Revisar tus cambios antes de hacer commit
1. `Espacio gs` → archivos modificados
2. Abre uno, `]h` para ir de cambio en cambio, `Espacio gp` para ver el antes/después
3. ¿Un cambio de debug que no querías? `Espacio gr` lo descarta
4. `Ctrl+z` → `git add -p && git commit` → `fg` para volver al editor

### Reto 7 — Ciclo editar/probar sin salir del editor
- **Playwright:** con el test abierto: `:!npx playwright test %` (`%` = archivo actual)
- **Rust:** `:!cargo build` o mejor `Ctrl+z`, `cargo run`, `fg`
- Los errores de Rust y TS ya los ves en vivo mientras escribes; no necesitas compilar para encontrarlos

### Reto 8 — Edición quirúrgica con verbo + objeto
En un template Angular o un componente:
1. `cit` sobre un `<button>Guardar</button>` → cambias el texto del botón
2. `ci"` en un atributo `class="..."` → reescribes las clases
3. `ci(` dentro de la llamada a una función → reescribes los argumentos
4. Haz un cambio, muévete a otro sitio parecido y pulsa `.` → se repite

### Reto 9 — Editar varias líneas a la vez
Tienes varias líneas y quieres añadir `pub ` (Rust) o `readonly ` (TS) al inicio:
1. Ve al inicio de la primera, `Ctrl+v`
2. `j` hasta la última línea (selección en columna)
3. `I` (i mayúscula), escribe el texto, `Esc` → aparece en todas

Para añadir al final de varias líneas: `Ctrl+v`, `j`…, `$`, `A`, texto, `Esc`.

### Reto 10 — Crear un componente/archivo desde el explorador
1. `Espacio e`, navega a la carpeta
2. `a`, escribe `user-card/user-card.component.ts` (crea la carpeta y el archivo)
3. Para mover un archivo: `m` y escribe la nueva ruta

---

## 5. Qué hay instalado y dónde

| Cosa | Ubicación |
|---|---|
| Neovim v0.12.6 | `~/.local/opt/nvim-linux-x86_64` (enlace en `~/.local/bin/nvim`) |
| Configuración | `~/.config/nvim/` |
| Plugins | `~/.local/share/nvim/lazy/` |
| Servidores de lenguaje | `~/.local/share/nvim/mason/` |
| `tree-sitter` CLI | instalado vía npm (nvm) |
| rust-analyzer | componente de rustup |

### Archivos de la configuración

```
init.lua                    leader = Espacio, carga todo
lua/config/options.lua      números, indentación, portapapeles del sistema, undo persistente…
lua/config/keymaps.lua      atajos generales
lua/config/lazy.lua         gestor de plugins lazy.nvim
lua/plugins/explorer.lua    explorador neo-tree
lua/plugins/ui.lua          tema tokyonight, barra de estado, pestañas, which-key
lua/plugins/editor.lua      telescope, autopairs, detección de indentación
lua/plugins/git.lua         gitsigns + atajos de git
lua/plugins/treesitter.lua  resaltado de sintaxis (lista de lenguajes)
lua/plugins/lsp.lua         servidores de lenguaje, autocompletado, formateo
```

### Lenguajes

| Lenguaje | Servidor | Notas |
|---|---|---|
| TypeScript / JavaScript | `ts_ls` + `eslint` | Playwright y Angular |
| Angular | `angularls` | templates `.component.html` |
| HTML / CSS / JSON | `html`, `cssls`, `jsonls` | |
| Rust | `rust_analyzer` (rustup) | revisa con clippy |
| Kotlin | `kotlin_lsp` (JetBrains) | necesita proyecto Gradle; la primera indexación tarda; soporte KMP aún limitado |
| C# | `csharp_ls` | **pendiente**: instala el SDK (`sudo apt install dotnet-sdk-8.0`) y al abrir nvim se instala solo |
| Lua | `lua_ls` | para editar esta configuración |

Formateo con Prettier para web (usa el del proyecto si existe) y el LSP para lo demás.
**Formatear al guardar está apagado**; para activarlo, descomenta `format_on_save` en `lua/plugins/lsp.lua`.

---

## 6. Mantenimiento

| Tarea | Cómo |
|---|---|
| Ver/actualizar plugins | `:Lazy` → `U` actualiza todo |
| Ver/actualizar servidores | `:Mason` → `U` actualiza todo |
| Actualizar parsers de sintaxis | `:TSUpdate` |
| Diagnosticar problemas | `:checkhealth` |
| Ver errores recientes | `:messages` |

**Actualizar Neovim:** descarga `nvim-linux-x86_64.tar.gz` de la nueva versión en
<https://github.com/neovim/neovim/releases> y descomprímelo en `~/.local/opt/` (reemplaza la carpeta). El enlace sigue funcionando.

**Desinstalar Neovim:**
```sh
rm -rf ~/.local/opt/nvim-linux-x86_64 ~/.local/bin/nvim
# y si quieres borrar también configuración, plugins y datos:
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
```
