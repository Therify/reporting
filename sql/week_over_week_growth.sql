with sign_ups_by_week as (
  SELECT
    actor_id account,
    date_part('week', created_at) as week
      from activities
  WHERE created_at > '2023-02-17'
),
weekly_totals as (
  select count(*) sign_ups, week
  from sign_ups_by_week
  group by week
  order by week
),
wow as (
select
  sum(sign_ups) over (order by week rows between unbounded preceding and current row) total_users,
  week
from weekly_totals
group by sign_ups, week
)
select
  week
,total_users
, -
  round(
    -- numerator
  total_users -
  COALESCE(lag(total_users,1) over (order by week rows between unbounded preceding and current row),0)
  -- denominator
  / COALESCE(lag(total_users,1) over (order by week rows between unbounded preceding and current row),1) * 100) as percent_growth
from wow
