# nvimAndo

✨ Mi configuración personalizada de **Neovim + LazyVim** ✨  

Este repo guarda todas mis configuraciones, plugins y keymaps de Neovim con LazyVim.  
La idea es poder clonar este repo en cualquier máquina y tener el mismo entorno listo para trabajar.

---

## 🚀 Características principales

- Basado en **[LazyVim](https://www.lazyvim.org/)** como framework de Neovim.
- Instalación reproducible gracias a `lazy-lock.json`.
- Incluye integración con:
  - **Lazygit**: control de Git dentro de Neovim.
  - **Lazydocker** (opcional): gestión de contenedores desde Neovim.
  - **Oil.nvim**: navegador de archivos minimalista.
  - **Obsidian.nvim**: notas y enlaces con Obsidian.
  - **Tmux navigation**: moverte entre splits y panes de tmux como si fueran uno.
- Keymaps personalizados para edición de texto, grep avanzado, buffers, marks, etc.
- Configuración portable y fácil de mantener con Git.

---

## 📦 Instalación

### 1. Clonar el repo
git clone https://github.com/BoyAndo/nvimAndo.git
cd nvimAndo

### 2. Ejecutar el instalador
bash bootstrap.sh

El script hace lo siguiente:

Instala Homebrew (Linux/macOS).

Instala Neovim (última versión) + utilidades:

git, ripgrep, fd, fzf, lazygit, node, npm, python.

Respalda cualquier ~/.config/nvim existente.

### 3. Abrir NeoVim
nvim

🔧 Requisitos

Linux o macOS.

Homebrew
 → el script lo instala si no existe.

Conexión a internet.

Dependencias instaladas automáticamente

Neovim (última versión, compatible con LazyVim).

Git (gestión de versiones).

ripgrep (rg) y fd → usados por Telescope y búsquedas.

fzf → búsqueda difusa.

lazygit → integración de Git dentro de Neovim.

node, npm, python → soporte para LSPs, linters y formateadores.


Crea un symlink desde este repo a ~/.config/nvim.

Sincroniza plugins automáticamente con lazy.nvim.
