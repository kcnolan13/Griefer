DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `rankPlayers`()
BEGIN
	UPDATE stats set kdr = ROUND(kills/GREATEST(1,deaths),2), ppl = ROUND(points/GREATEST(1,deaths)), wl = ROUND(wins/GREATEST(1,losses),2);
    UPDATE bot_stats set kdr = ROUND(kills/GREATEST(1,deaths),2), ppl = ROUND(points/GREATEST(1,deaths)), wl = ROUND(wins/GREATEST(1,losses),2);
	UPDATE stats join bot_stats ON stats.username=bot_stats.username 
	SET stats.true_skill = ROUND(
									GREATEST(
												LEAST(
														500, 
														(LEAST(stats.wins+stats.losses,10)*1/10*(stats.ppl/8 + stats.wl*125)+LEAST(50,stats.kills/10))/2
                                                     )
												,
												LEAST(
														200, 
														(LEAST(bot_stats.wins+bot_stats.losses,15)*1/15*(bot_stats.ppl/8 + bot_stats.wl*125)+LEAST(50,bot_stats.kills/10))/2 * 1/2.5
													)
											 )
								);
    
    set @true_skill := -1; 
	set @num := 0;  
	set @c := 1; 
	UPDATE stats 
	JOIN 
	( 
		SELECT username 
		  , true_skill 
		  , @num := if(@true_skill = true_skill, @num, @num + @c) AS global_rank 
		  , @c := if(@true_skill = true_skill, @c+1, 1) AS dummy 
		  , @true_skill := true_skill AS dummy2 
		FROM `stats` 
		ORDER BY true_skill DESC, username ASC 
	) stats_sorted 
	ON stats.username = stats_sorted.username 
	SET stats.global_rank = stats_sorted.global_rank;
END$$
DELIMITER ;
