with total_members as (
    select count(*) as total
    from member_profiles
),
total_by_genders as (
    select count(*) as total,
        g.name as gender
    from member_profiles mp
        join genders g on 1 = 1
        and g.id = mp.gender_id
    group by g.name
)
select (total_by_genders.total * 100) / (
        select total
        from total_members
    ) as percent_of_total_population,
    total_by_genders.gender as gender
from total_by_genders