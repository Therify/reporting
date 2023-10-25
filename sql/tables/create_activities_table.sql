create table activities (
    id uuid primary key default (gen_random_uuid()),
    action varchar not null,
    actor_id uuid,
    target_id uuid,
    created_at timestamptz default now() not null,
    updated_at timestamptz default now() not null,
    context jsonb default '{}'
);
