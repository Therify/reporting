with accounts as (
    select action, actor_id as account, (context->>'seats')::integer as seats
    from activities
    where action = 'Accounts/AccountCreated'
),
     seats_used as (
         select count(target_id) as seats_used, actor_id as account
         from activities
         where action = 'Accounts/MemberRegistered'
         group by actor_id
     )
select
    a.account,
    a.seats as total_seats,
    s.seats_used,
    (a.seats - s.seats_used) as seats_remaining,
    round(s.seats_used::decimal/a.seats, 4) * 100 as seat_usage_percent
from accounts a inner join seats_used s on a.account = s.account;
