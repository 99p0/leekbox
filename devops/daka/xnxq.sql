#
select * from birdplanet.t_user where uid in (2101);

#
select * from birdplanet.t_game_mode_template;

update birdplanet.t_game_mode set
                                  fail_total_amount=fail_total_amount-1500,
                                  fail_total_people = fail_total_people-1
where id= 0;

#
select * from birdplanet.t_game_mode
where period = '2022-12-28';

#
select *
from birdplanet.t_game_mode_order
where uid =2101 and activity_id=11375
order by 1 desc
limit 50;

#
select *
from birdplanet.t_game_mode_round
where uid =2101 and activity_id=11375
limit 50;
;

#
select *
from birdplanet.t_notice
where created_at > '2022-12-23 08:00:00'
  and uid=1856
# and notice_type=3
order by 1 desc
limit 500;

#
update birdplanet.t_user set wallet = wallet+ 1507.8 where uid=0;
#
# select * from t_game_mode_bonus_tiered where type='P';
select sum(bonus) from t_game_mode_bonus_tiered where type='K' and round<=12;
#
INSERT INTO birdplanet.t_wallet_dtl (id, uid, type, content, amount, is_read, created_in)
VALUES (null, 0, 3, '0911期「延时闯关1500」闯关奖励及本金', '+1507.800', 0, now());

#
select sum(fail_total_amount) as 总失败金, sum(bonus_pool_real) as 总下发金额, sum(fail_total_amount)-sum(bonus_pool_real) 纯收益
from birdplanet.t_game_mode
where  period between '2022-07-01' and '2022-07-31';



# 4月以来没失败
select gmo.uid, count(gmo.id) times, 0 + CAST(sum(gmo.amount) AS CHAR)  ,
       GROUP_CONCAT(date_format(gmo.period, '%m%d期') ,'>',gm.title,'>',case gmo.status when 3 then '打卡失败' else '--' end,'>', concat(0 + CAST(gmo.amount AS CHAR),'倍') SEPARATOR ';  ')
from `t_game_mode_order` gmo left join `t_game_mode` gm on gmo.activity_id=gm.id
where (gmo.period >= '2022-05-01' and gmo.period <= '2022-07-31')
  and gmo.`status`=3
# and gmo.uid in (1022,1034,1038,1054,1057,1076,1097,1147,1170,1171,1194,1326,1339,1387,1398,1410,1456,1464,1487,1503,1511,1519,1546,1606,1610,1622,1633,1677,1679,1707,1729,1749,1819,1848,1873,1878,1880,1896,1900,1920,1928,1961,1969,1986,1992,1994,2043,2059,2085)
GROUP BY gmo.uid
order by times desc;

select GROUP_CONCAT(uid) from (
#
                                  select distinct uid from t_game_mode_order gmo
                                  where (gmo.period >= '2022-05-01' and gmo.period <= '2022-07-31')
                              ) aa
where uid not in (select distinct uid from t_game_mode_order gmo where (gmo.period >= '2022-05-01' and gmo.period <= '2022-07-31') and gmo.`status`=3)
;


#
select distinct uid from t_game_mode_order gmo
where (gmo.period >= '2022-12-01' and gmo.period <= '2022-12-31')
  and gmo.`status`=3
  and gmo.uid in (1125,1122);


# alter table t_game_mode_template add is_verify varchar(4)  default 'N'  null comment '是否验证';
# alter table t_game_mode_template add verify_type varchar(4)  default ''  null comment ' 验证类型 JH10：交互认证，SR20：输入随机字符，YZ30：输入图形验证码';
# alter table t_game_mode_template add verify_sourcecode varchar(128)  default ''  null comment '验证码源代码';
# alter table t_game_mode_template add verify_code_length tinyint  default 0  null comment '验证码长度';
#
# alter table t_game_mode add is_verify varchar(4)  default 'N'  null comment '是否验证';
# alter table t_game_mode add verify_type varchar(4)  default ''  null comment ' 验证类型 JH10：交互认证，SR20：输入随机字符，YZ30：输入图形验证码';
# alter table t_game_mode add verify_sourcecode varchar(128)  default ''  null comment '验证码源代码';
# alter table t_game_mode add verify_code_length tinyint  default 0  null comment '验证码长度';


#
select uid, count(distinct id) as num from t_game_mode_order where uid not in (
    select distinct uid from t_game_mode_order
    where status =3 and period between '2022-03-26' and '2022-04-26')
                                                               and period between '2022-03-26' and '2022-04-26'
group by uid
order by uid asc;
#
select GROUP_CONCAT(distinct uid, '') from t_game_mode_order where uid not in (
    select distinct uid from t_game_mode_order
    where status =3 and period between '2022-01-01' and '2022-04-30')
                                                               and  period between '2022-01-01' and '2022-04-30';

#
select DATE_FORMAT(period,'%Y-%m') AS currMonth,
       sum(fail_total_amount) as 总失败金, sum(bonus_pool_real) as 总下发金额, sum(fail_total_amount)-sum(bonus_pool_real) 纯收益
from birdplanet.t_game_mode
where period between '2022-12-01' and '2022-12-31'
GROUP BY currMonth;


# 某个人失败信息
select
    tgmo.uid, DATE_FORMAT(tgmo.period,'%m') AS currMonth,GROUP_CONCAT(date_format(tgmo.period, '%m%d期'),'.',tgm.title,' ') as remark,
    sum(tgmo.amount) '失败总金额'
-- tgm.title, tgmo.*
from birdplanet.t_game_mode_order tgmo left join  t_game_mode tgm on tgm.id = tgmo.activity_id
where tgmo.uid in (1122,1125)
  and
        tgmo.period >= '2022-12-01' and tgmo.period <= '2022-12-31'
  and tgmo.status=3
group by tgmo.uid , currMonth;


# 打卡情况
select
    tgmo.uid ,DATE_FORMAT(tgmo.period,'%Y-%m') AS currMonth, count(1) '参加活动数量', count(1)/30 as '平均每天参加活动'
from birdplanet.t_game_mode_order tgmo left join  t_game_mode tgm on tgm.id = tgmo.activity_id
where tgmo.uid in (2065)
  and
        tgmo.period >= '2022-06-01' and tgmo.period <= '2022-10-23'
group by tgmo.uid , currMonth;

# 多号打卡
select
    tgmo.ip_addr, GROUP_CONCAT(distinct tgmo.uid,'') as uids, count(distinct tgmo.uid) as num
from birdplanet.t_game_mode_order tgmo left join  t_game_mode tgm on tgm.id = tgmo.activity_id
where tgmo.period >= '2023-01-01' and tgmo.period <= '2023-09-27'
group by  ip_addr
having num >1
order by num desc;

#
select uid,  count(*) 打卡成功次数,sum(bonus) 总收益, sum(benefits) 额外奖励 from birdplanet.t_game_mode_settle_record tgmsr
where period between '2022-01-01' and '2023-12-31'
#   and tgmsr.uid in (2115)
  and tgmsr.punch_successful='Y'
group by tgmsr.uid;
#
select uid, DATE_FORMAT(tgmsr.period,'%Y-%m') AS 月份, count(*) 打卡成功次数,sum(bonus) 总收益, sum(benefits) 额外奖励 from birdplanet.t_game_mode_settle_record tgmsr
where period between '2023-01-01' and '2023-12-31'
  and tgmsr.uid in (2115)
  and tgmsr.punch_successful='Y'
group by tgmsr.uid,月份;

#
select uid,  count(*) 失败次数,sum(pay_amount) 失败金额,
       GROUP_CONCAT(date_format(tgmsr.period, '%m%d期'),'.',tgm.title,' ') as '失败明细'
from birdplanet.t_game_mode_settle_record tgmsr left join  t_game_mode tgm on tgm.id = tgmsr.activity_id
where tgmsr.period between '2022-01-01' and '2023-12-31'
#   and tgmsr.uid in (2115)
  and tgmsr.punch_successful='N'
group by tgmsr.uid;
#
select uid, DATE_FORMAT(tgmsr.period,'%Y-%m') AS 月份, count(*) 失败次数,sum(pay_amount) 失败金额,
       GROUP_CONCAT(date_format(tgmsr.period, '%m%d期'),'.',tgm.title,' ') as '失败明细'
from birdplanet.t_game_mode_settle_record tgmsr left join  t_game_mode tgm on tgm.id = tgmsr.activity_id
where tgmsr.period between '2023-03-01' and '2023-12-31'
  and tgmsr.uid in (2060,2065)
  and tgmsr.punch_successful='N'
group by tgmsr.uid,月份;

# 用户收益和失败
select uid,
       -- 总计
       case when(TRUNCATE(((sum(total_bonus) + sum(total_benefits))-sum(total_fail_amount)),5) > 0) then '是' else '否'end as 是否盈利,
       ((cast(sum(total_bonus) AS DECIMAL(10,3)) + cast(sum(total_benefits) AS DECIMAL(10,3)))-cast(sum(total_fail_amount) AS DECIMAL(10,3))) as 总收益,
       -- 成功
       sum(succ_times)as 成功次数,
       (cast(sum(total_bonus) AS DECIMAL(10,3)) + cast(sum(total_benefits) AS DECIMAL(10,3))) as 总收益,
       cast(sum(total_bonus) AS DECIMAL(10,3)) as 总佣金,
       cast(sum(total_benefits) AS DECIMAL(10,3)) as '总额外收益[满轮送]',

       -- 失败
       sum(fail_times)as 失败次数,
       cast(sum(total_fail_amount) AS DECIMAL(10,3)) as 总失败金,
       GROUP_CONCAT(fail_detail,'~~~') as 失败明细
from (
         select uid,  count(*) succ_times,sum(bonus) total_bonus, sum(benefits) total_benefits,
                '0'as fail_times,'0.000'as total_fail_amount,'' as fail_detail
         from birdplanet.t_game_mode_settle_record tgmsr left join  t_game_mode tgm on tgm.id = tgmsr.activity_id
         where tgmsr.period between '2023-01-01' and '2023-12-31'
#            and tgmsr.uid in (2103)
           and tgmsr.punch_successful='Y'
         group by tgmsr.uid
         UNION ALL
         select uid,'0'as succ_times,'0.000'as total_bonus, '0.000'as total_benefits,
                count(*) fail_times, TRUNCATE(sum(pay_amount),3 )total_fail_amount,
                GROUP_CONCAT(date_format(tgmsr.period, '%m%d期'),'.',tgm.title,' ') as fail_detail
         from birdplanet.t_game_mode_settle_record tgmsr left join  t_game_mode tgm on tgm.id = tgmsr.activity_id
         where tgmsr.period between '2023-01-01' and '2023-12-31'
#            and tgmsr.uid in (2103)
           and tgmsr.punch_successful='N'
         group by tgmsr.uid
     ) tb1
group by uid
order by uid asc;


#
select  tgmo.uid,count(*) joined_num,GROUP_CONCAT(date_format(tgm.period, '%m%d期'),'.',tgm.title,' ') as joined_detail
from t_game_mode_order tgmo left join  t_game_mode tgm on tgm.id = tgmo.activity_id
where tgmo.period between '2023-05-01' and '2023-05-19'
# and tgm.type in ('H')
group by uid
having joined_num>1
order by joined_num desc;