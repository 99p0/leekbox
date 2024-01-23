show processlist;

SELECT * FROM information_schema.INNODB_TRX;

SELECT * from information_schema.processlist ;




select * from shibei.t_user where open_uid in (2088022774111513);

#
select *
from shibei.t_game_mode
where period = '2023-01-02';


#
select *
from shibei.t_notice
where created_at > '2022-12-19 13:00:00'
# and uid=1544
and notice_type=3
order by 1 desc
limit 500;



#
update shibei.t_game_mode set fail_total_amount=fail_total_amount-1400, fail_total_people = fail_total_people-1
    where id= 10567;
#
select *
from shibei.t_game_mode_template;

#
select *
from shibei.t_game_mode_order
where uid =55640 and activity_id=10567;

#
select *
from shibei.t_game_mode_order
where uid =55640 and activity_id=10567;

#
select *
from shibei.t_game_mode_round
where uid =55640 and activity_id=10567;

#
select *
from shibei.t_notice
where created_at > '2023-01-02 08:00:00'
and uid=55640
order by 1 desc
limit 500;

#
select *
from shibei.t_wallet_withdraw_app
where created_at > '2022-08-03 08:00:00'
and status=0
limit 100;


#
select sum(fail_total_amount) as 总失败金, sum(bonus_pool_real) as 总下发金额, sum(fail_total_amount)-sum(bonus_pool_real) 纯收益
from shibei.t_game_mode
where  period between '2022-08-01' and '2022-08-31';

#
select sum(fail_total_amount) as 总失败金, sum(bonus_pool_real) as 总下发金额, sum(fail_total_amount)-sum(bonus_pool_real) 纯收益
from shibei.t_game_mode
where  period between '2022-09-01' and '2022-12-30';


# 总计
select sum(fail_total_amount) as 总失败金, sum(bonus_pool_real) as 总下发金额, sum(fail_total_amount)-sum(bonus_pool_real) 纯收益
from shibei.t_game_mode;


# 按月统计 - 总计
select DATE_FORMAT(period,'%Y-%m') AS currMonth,
       sum(fail_total_amount) as 总失败金, sum(bonus_pool_real) as 总下发金额, sum(fail_total_amount)-sum(bonus_pool_real) 纯收益
from shibei.t_game_mode
where  period between '2022-04-01' and '2022-09-30'
GROUP BY currMonth;



select * from shibei.t_game_mode
where period='2021-11-04';

select * from shibei.t_game_mode_order where activity_id=2935;
select * from shibei.t_wallet_dtl where id < 29543  and id > 29530  order by 1 desc limit 130 ;

select * from shibei.t_user where uid =55562;

#
update shibei.t_user set wallet = wallet+ 1416.400 where uid=0;
#
# select * from t_game_mode_bonus_tiered where type='P';
select sum(bonus) from shibei.t_game_mode_bonus_tiered where type='S' and round<=29;

#
INSERT INTO shibei.t_wallet_dtl (id, uid, type, content, amount, is_read, created_in)
VALUES (null, 0, 3, '0526期「延迟1400」闯关奖励及本金', '+1416.400', 0, now());


# 失败的
select CONCAT(DATE_FORMAT(gmo.period,'%m-%d'),' ',gm.title) AS currMonth,gmo.*
from shibei.t_game_mode_order gmo left join t_game_mode gm  on gmo.activity_id = gm.id
where  gmo.period between '2022-07-01' and '2022-07-30' and gmo.status=3;


select * from t_wallet_withdraw_app
         order by 1 desc limit 100;

select
    tgmo.uid, DATE_FORMAT(tgmo.period,'%m') AS currMonth,GROUP_CONCAT(date_format(tgmo.period, '%m%d期'),'.',tgm.title,' ') as remark, sum(tgmo.amount) totalAmout
    -- tgm.title, tgmo.*
from shibei.t_game_mode_order tgmo left join  t_game_mode tgm on tgm.id = tgmo.activity_id
where tgmo.uid in (55612)
    and
    tgmo.period >= '2022-06-01' and tgmo.period <= '2022-09-23'
and tgmo.status=3
group by tgmo.uid , currMonth;


# 多号打卡
select
    tgmo.ip_addr, GROUP_CONCAT(distinct tgmo.uid,'') as uids, count(distinct tgmo.uid) as num
from shibei.t_game_mode_order tgmo left join  t_game_mode tgm on tgm.id = tgmo.activity_id
where tgmo.period >= '2022-06-01' and tgmo.period <= '2022-09-27'
group by  ip_addr
having num >1
order by num desc;

# 多号打卡
select distinct (GROUP_CONCAT(distinct t1.uids order by uids desc) ) tuu from (
select
    tgmo.ip_addr, GROUP_CONCAT(distinct tgmo.uid,'') as uids, count(distinct tgmo.uid) as num
from shibei.t_game_mode_order tgmo left join  t_game_mode tgm on tgm.id = tgmo.activity_id
where tgmo.period >= '2022-06-01' and tgmo.period <= '2022-09-27'
group by  ip_addr
having num =2
order by num desc) t1;