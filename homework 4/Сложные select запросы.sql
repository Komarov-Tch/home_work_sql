-- считаем сколько групп в каждом стиле играет
select  g."name", COUNT(performer_id)
from genre_performer gp, genre g 
where gp.genre_id = g.id 
group by g."name";

-- Считаем количество треков, которые вошли в альбомы 2019-2020
select c."name", COUNT(track_id)
from track_collection tc , collection c 
where tc.collection_id = c.id AND c."year" between 2019 and 2020
group by c."name";

-- Считаем среднее продолжительность треков по каждому альбому
select a."name",  AVG(t.duration)
from track t, album a
where t.album_id = a.id
group by a."name"; 

-- Считаем исполнителей без альбомов в 2020
select p."name"
from performer_album pa, performer p, album a
where pa.performer_id = p.id and not a."year" = 2020
group by p."name";

-- названия сборников в которых есть исполнитель "Король и Шут"
select c."name", p."name" 
from collection c, track_collection tc, track t, performer_album pa, performer p  
where c.id = tc.collection_id and tc.track_id = t.id and t.album_id = pa.album_id and pa.performer_id = p.id and p.id = 2

-- названия альбомов в которых присутствуют исполнители более 1 жанра
select a."name" name_album
from album a
join performer_album pa on a.id = pa.album_id
join genre_performer gp on pa.performer_id = gp.performer_id
group by a."name"
having count(gp.performer_id) > 1

--найти названия треков, которые не входят в сборник
select t.name_track
from track t
where not exists (
	select tc.track_id 
	from track_collection tc
	where tc.track_id = t.id)

-- найти название треков которые не входят в сборники 2 вариант решения.
select t.name_track
from track t
left join track_collection tc on tc.track_id = t.id 
where tc.track_id  is null;

-- найти автора который написал самый короткий трек
select p."name" name_autor
from performer p
join performer_album pa on p.id = pa.performer_id
join album a on a.id = pa.performer_id 
join track t on t.album_id = a.id
where t.duration = (select min(duration) from track)

--найти альбомы с наименьшим количеством треков
select a."name" an
from album a
join track t on t.album_id = a.id
group by a.name
having count(a.name) = (
	select min(quan)
	from (
		select count(t2.album_id) as quan
		from album a2 
		join track t2 on a2.id = t2.album_id
		group by a2."name"
		)
	as foo
	)
	
-- альбомы с наименьшим количеством треков вариант 2
select a."name" album_name
from album a, track t
where t.album_id = a.id
group by album_name
having count(a.name) = (
	select min(quan)
	from (
		select count(t2.album_id) as quan
		from album a2, track t2
		where a2.id = t2.album_id
		group by a2."name"
		)
	as foo
	)

