select count(*), actor_id
from activities
where action = 'Accounts/MemberRegistered'
group by actor_id
order by count desc;
