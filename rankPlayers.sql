CREATE PROCEDURE `rankPlayers` ()
BEGIN
	UPDATE stats set true_skill = FLOOR(ppl * (wl+1)/2);
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
END
