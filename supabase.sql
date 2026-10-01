-- Rode no SQL Editor do Supabase, uma vez.

create table if not exists public.votos (
  user_id uuid primary key references auth.users (id) on delete cascade,
  email text,
  candidato text not null check (candidato in ('bolsonaro', 'lula')),
  created_at timestamptz not null default now()
);

alter table public.votos enable row level security;

drop policy if exists "ler votos" on public.votos;
create policy "ler votos" on public.votos
  for select using (true);

drop policy if exists "um voto por usuario" on public.votos;
create policy "um voto por usuario" on public.votos
  for insert
  with check (auth.uid() = user_id);

-- Sem policy de update/delete: o cliente não altera nem apaga voto.
-- A primary key em user_id impede um segundo insert da mesma conta.
