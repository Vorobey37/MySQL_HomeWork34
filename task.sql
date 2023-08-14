/*1. Подсчитать общее количество лайков, которые получили пользователи
младше 12 лет.*/
select * from likes;
select * from profiles;
select * from media;

select count(*)
as "общее количество лайков, которые получили пользователи младше 12 лет"
from profiles as p
join media as m
on p.user_id = m.user_id
join likes as l
on m.id = l.media_id
where TIMESTAMPDIFF(year, p.birthday, curdate()) < 12;

/*2. Определить кто больше поставил лайков (всего): мужчины или
женщины.*/
select * from profiles;
select * from likes;

select count(*) as count, p.gender 
from profiles as p
join likes as l
on p.user_id = l.user_id
group by p.gender;
having count = ?;

/*3. Вывести всех пользователей, которые не отправляли сообщения.*/
select * from users;
select * from messages;

select u.id, u.firstname, u.lastname, m.id as 'отправленное сообщение', (select firstname from users )
from users as u
left join messages as m
on u.id = m.from_user_id
where m.id is null;

/*4. (по желанию)* Пусть задан некоторый пользователь. Из всех друзей
этого пользователя найдите человека, который больше всех написал
ему сообщений.*/
select * from users;
select * from friend_requests;
select * from messages;

select u.id, u.firstname, u.lastname, f.status, f.target_user_id, count(*) as 'количество сообщений'
from users as u
join friend_requests as f
on u.id = f.initiator_user_id
join messages as m
on m.to_user_id = u.id
where f.status = 'approved' and u.id = 1 /*пусть задан пользователь с id = 1*/
group by f.target_user_id;

