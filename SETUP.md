# 📝 Guia de Inicialização: Projeto Fullstack Docker (Bun + Next.js)

Este guia documenta o processo para iniciar o projeto do zero, garantindo que o ambiente Docker gerencie todas as dependências sem necessidade de instalações locais.

---

## 🚀 1. Instalação Inicial

Se a pasta estiver vazia (apenas com Dockerfile/Makefile/Compose), siga este fluxo:

1. **Gerar Boilerplate Next.js em pasta temporária (usar React Compiler):**
``` bash
docker compose run -it --rm app bunx create-next-app@latest ./temp --typescript --tailwind --eslint --src-dir --app --import-alias "@/*"
```

2. **Retomar Permissões (Linux):**
Como o Docker cria os arquivos como `root`, execute para evitar erro de "Permissão Negada":
``` bash
sudo chown -R $USER:$USER .
```

3. **Mover Arquivos para a Raiz e Limpar:**
``` bash
mv temp/* . && mv temp/.* . && rm -rf temp
```

4. **Instalar dependências:**
Como você moveu os arquivos agora, precisamos garantir que o container tenha o `node_modules` atualizado.
``` bash
docker compose run --rm app bun install
```

5. **Rodar o projeto:**
Agora você já pode ver o `Next.js` funcionando
``` bash
make dev
```
Acesse no navegador: `http://localhost:3003.`

6. **Configuração visual:**
Assim que você confirmar que o site abriu na `porta 3003`, o próximo passo essencial é configurar o `Shadcn UI` para podermos criar os componentes do projeto:
``` bash
make ui-init
```

---

## 🔧 2. Sincronização e Setup de Dependências

Sempre que clonar o projeto ou se o comando `next` não for encontrado, execute:

1. **Forçar Instalação Interna (O segredo do funcionamento):**
``` bash
docker compose run --rm app sh -c "rm -rf node_modules bun.lockb && bun install"
```

2. **Setup de Ferramentas (Husky/Env):**
``` bash
make setup
```

---

## 🛠️ 3. Comandos de Manutenção (Makefile)

Utilize o `Makefile` para gerenciar o projeto de forma simplificada:

| Comando | Descrição |
| :--- | :--- |
| **make dev** | Inicia o servidor (Acesse em http://localhost:3003). |
| **make setup** | Builda a imagem e instala dependências iniciais. |
| **make install PKG=x** | Instala uma lib. Ex: `make install PKG=zod`. |
| **make ui-init** | Inicializa o CLI do Shadcn. |
| **make ui-add COMPONENT=x** | Adiciona componente. Ex: `make ui-add COMPONENT=button`. |
| **make lint** | Formata e corrige o código com Biome. |
| **make clean** | Limpa caches, node_modules e volumes Docker. |

---

## 📦 4. Bibliotecas de Profissionalização

Após o setup, adicione estas ferramentas essenciais através do Makefile:

``` bash
# Dependências de Lógica e Validação
make install PKG="zod react-hook-form @hookform/resolvers lucide-react @tanstack/react-query date-fns"

# Dependências de Desenvolvimento (Lint/Format)
make install PKG="@biomejs/biome husky lint-staged"
```

---

## 💡 Notas Importantes para Backup

* **Portas:** O Next.js roda na porta interna `3000`, mas o acesso externo é via **http://localhost:3003**.
* **Ambiente Isolado:** Não instale nada na máquina local. Tudo deve ser executado via `docker compose` ou `make`.
* **Persistência:** Se a pasta `node_modules` local parecer vazia, não se preocupe; o Docker está usando o volume montado.