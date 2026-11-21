#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Bootstrapping Dev Container (pnpm-only workflow)..."

export PATH="$HOME/.local/share/mise/shims:$HOME/.local/bin:$PATH"

# 1. Trust and install Node.js & pnpm defined in mise.toml
mise trust
mise install
mise reshim

eval "$(mise activate bash)"

# 2. Configure pnpm global bin directory
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME/bin:$PATH"
mkdir -p "$PNPM_HOME/bin"
pnpm config set global-bin-dir "$PNPM_HOME/bin"

# Persist PNPM_HOME in .zshrc and .bashrc
for rc_file in "$HOME/.zshrc" "$HOME/.bashrc"; do
  if [ -f "$rc_file" ] && ! grep -q "PNPM_HOME" "$rc_file"; then
    {
      echo ""
      echo "# pnpm global bin configuration"
      echo "export PNPM_HOME=\"$HOME/.local/share/pnpm\""
      echo "export PATH=\"\$PNPM_HOME/bin:\$PATH\""
    } >> "$rc_file"
  fi
done

# 3. Install Angular CLI and Nx CLI globally exclusively via pnpm
echo "🅰️ Installing Angular CLI via pnpm..."
pnpm add -g @angular/cli@22

echo "⚡ Installing Nx CLI via pnpm..."
pnpm add -g nx@24

# 4. Verify environment
echo ""
echo "✅ Environment ready (100% pnpm-managed):"
echo "   🟢 Node.js:     $(node -v)"
echo "   📦 pnpm:        $(pnpm -v)"
echo "   🅰️ Angular CLI: $(ng version --minimal 2>/dev/null || ng v | grep 'Angular CLI' || echo 'Installed')"
echo "   ⚡ Nx CLI:      $(nx --version)"
