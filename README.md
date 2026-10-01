# Eleições 2026 — um e-mail, um voto

Enquete informal. O voto trava na conta confirmada, não no navegador.

GitHub Pages não guarda voto. O banco é o Supabase (plano grátis). A chave `anon` fica no site de propósito: quem manda no segundo voto é a regra do banco, não o JavaScript.

## 1. Banco

1. Crie um projeto em https://supabase.com
2. SQL Editor → cole `supabase.sql` → Run
3. Authentication → Providers → Email: ligado
4. Authentication → Providers → desligue "Confirm email" só se quiser o código na hora. Com o link mágico o padrão já serve.
5. Authentication → URL Configuration → Site URL: a URL do GitHub Pages, por exemplo `https://SEU_USUARIO.github.io/enquete-2026/`
6. Em Redirect URLs, acrescente a mesma URL
7. Project Settings → API → copie Project URL e a chave `anon` public

## 2. Chaves

Edite `config.js`:

```js
export const SUPABASE_URL = "https://xxxx.supabase.co";
export const SUPABASE_ANON = "eyJ...";
```

Não use a chave `service_role`. Ela ignora as regras e não pode ir para o site.

## 3. Publicar

```bash
git init
git add .
git commit -m "Enquete Eleições 2026"
git branch -M main
git remote add origin https://github.com/SEU_USUARIO/enquete-2026.git
git push -u origin main
```

GitHub → Settings → Pages → branch `main` / root.

## O que trava o segundo voto

- A pessoa pede um link no e-mail e só entra se abrir esse link.
- O voto grava `user_id` como chave primária.
- A policy só aceita insert se `auth.uid()` for o dono da linha.
- Não existe policy de update nem delete.
- Segundo insert da mesma conta volta erro `23505`.

Aba anônima não ajuda: sem o mesmo login não vota, e com o mesmo e-mail o banco recusa.

Limite real: outra conta de e-mail ainda passa. Travaria de verdade só com documento oficial, e isso não cabe numa enquete de GitHub.
