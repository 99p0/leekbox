
#
select REPLACE(unix_timestamp('2022-06-14 12:38:09.438'),'.',''),
       REPLACE(unix_timestamp(current_timestamp(3)),'.',''),
       now(3);




# 1655181489
# 1655181563808

#
select * from dakaya.t_game_mode
where period = '2022-08-31';

#
select sum(fail_total_amount) as 总失败金, sum(bonus_pool_real) as 总下发金额, sum(fail_total_amount)-sum(bonus_pool_real) 纯收益
from dakaya.t_game_mode
where  period between '2022-09-01' and '2022-09-30';