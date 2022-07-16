CREATE TABLE public.performer(
	id integer primary key,
	name varchar not null
);

CREATE TABLE public.genre(
	id integer primary key,
	name varchar not null
);

CREATE TABLE public.genre_performer(
	id integer primary key,
	performer_id integer not null references public.performer(id),
	genre_id integer not null references public.genre(id)
);

CREATE TABLE public.album(
	id integer primary key,
	year integer not null,
	name varchar not null
);

CREATE TABLE public.performer_album(
	id integer primary key,
	performer_id integer not null references public.performer(id),
	album_id integer not null references public.album(id)
);

CREATE TABLE public.track(
	id integer primary key,
	name_track varchar not null,
	duration interval not null,
	album_id integer references public.album(id)
);

CREATE TABLE public.collection(
	id integer primary key,
	name varchar not null,
	year integer not null
);

CREATE TABLE public.track_collection(
	id integer primary key,
	track_id integer not null references public.track(id),
	collection_id integer not null references public.collection(id)
);