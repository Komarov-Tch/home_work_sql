-- название и год выхода альбомов, вышедших в 2018 году;
SELECT name, "year" FROM album
	WHERE "year" = 2018;

-- название и продолжительность самого длительного трека;
SELECT name_track,duration FROM track
	WHERE duration = (
		SELECT max(duration)
		FROM track);
	 
-- название треков, продолжительность которых не менее 3,5 минуты;
SELECT name_track FROM track
	WHERE duration > '0 00:03:30';

-- названия сборников, вышедших в период с 2018 по 2020 год включительно;
SELECT name FROM collection
	WHERE "year" BETWEEN 2018 AND 2020;

-- исполнители, чье имя состоит из 1 слова;
SELECT name FROM performer
	WHERE name NOT LIKE '% %'

-- название треков, которые содержат слово "мой"/"my"
SELECT name_track FROM track
	where (lower(name_track) LIKE '%my%') OR (lower(name_track) LIKE '%мой%')