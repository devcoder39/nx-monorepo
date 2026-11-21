# 🅰️ Angular + ⚡ Nx Monorepo Lab

An isolated, reproducible, and secure development environment for learning and building modern **Angular** applications inside an **Nx** monorepo.

---

## 🛠️ Tech Stack & Tooling

- **Framework:** [Angular](https://angular.dev) (v22+)
- **Monorepo Orchestrator:** [Nx](https://nx.dev) (v24+)
- **Runtime & Tool Manager:** [mise](https://jdx.dev) (declarative versioning via `mise.toml`)
- **Package Manager:** [pnpm](https://pnpm.io) (strict `node_modules` isolation & zero `npm` usage)
- **Environment Isolation:** Docker + [Dev Containers](https://containers.dev) (running on macOS via [Colima](https://github.com))
- **IDE:** Visual Studio Code with pre-configured extensions & settings

---

## 📂 Workspace Structure

```text
.
├── .devcontainer/          # 🐳 Dev Container & Docker Compose setup
│   ├── containers/         #    └── compose.yaml service definition
│   ├── scripts/            #    └── post-create.sh automated bootstrap script
│   └── devcontainer.json   #    └── VS Code extensions, features & container settings
├── apps/                   # 📱 Angular applications & E2E test suites
├── libs/                   # 📦 Shared libraries (UI, data-access, utils)
├── mise.toml               # 🔧 Pinned runtime versions (Node.js & pnpm)
├── nx.json                 # ⚡ Nx workspace & caching configuration
└── package.json            # 📜 Monorepo dependencies (managed exclusively by pnpm)
```

---

## 🚀 Getting Started

### 1. Prerequisites (Host Machine)

- [Docker](https://docker.com) or [Colima](https://github.com) running (`virtiofs` / `sshfs` mount enabled)
- [Visual Studio Code](https://visualstudio.com) with the **Dev Containers** extension (`ms-vscode-remote.remote-containers`)

### 2. Launch the Isolated Environment

1. Open this repository root folder in **VS Code**.
2. Open the Command Palette (`Cmd + Shift + P` / `Ctrl + Shift + P`) and run:
   ```text
   Dev Containers: Reopen in Container
   ```
3. Wait for the container to build and execute `.devcontainer/scripts/post-create.sh` automatically (installs **Node.js**, **pnpm**, **Angular CLI**, and **Nx CLI**).

---

## 💻 Common Commands

Run these commands inside the Dev Container terminal:

| Action                    | Command                     |
| :------------------------ | :-------------------------- |
| **Serve Angular App**     | `pnpm nx serve <app-name>`  |
| **Build All Projects**    | `pnpm nx run-many -t build` |
| **Run Unit Tests**        | `pnpm nx run-many -t test`  |
| **Open Dependency Graph** | `pnpm nx graph`             |
| **Check Tool Versions**   | `mise current`              |

---

## 🛡️ Security Practices

- **Container Isolation:** Zero Node.js or global packages installed directly on the host OS.
- **Strict Dependency Management:** Uses `pnpm` with lockfile integrity (`pnpm-lock.yaml`) to prevent phantom dependencies and supply-chain attacks.
- **Declarative Runtimes:** All base tool versions are pinned in `mise.toml`.
