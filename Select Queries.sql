Question 1
	Select M.name
    FROM Member M
    Where M.memberId In
    (Select P.PlayerId
    from player P
    Where P.PlayerId In
		(SELECT TM.memberId
		FROM TeamMember TM
		WHERE TM.TeamId IN
			(SELECT TeamId 
			From Team T
			Where T.Year="2018" && T.Country ="Australia"
			)));

Question 2

	SELECT Distinct Name
	FROM Member M
    Where M.MemberId in(
	Select PlayerId
    From Goals G
    Where G.Count < 1);


Question 3

NOTE DONE
 Select Distinct *
From `Match` M
Where M.MatchId In (
Select MatchId
From PoolGame
);


Question 4
SELECT PlayerID 
FROM Player WHERE HomeClubName IN
	(SELECT HomeClubName 
	FROM HomeClub
	WHERE country = 'England')
AND PlayerId IN
	(SELECT MemberId 
	FROM TeamMember
	WHERE teamId IN 
		(SELECT TeamId 
		FROM TEAM 
		WHERE Country='Australia'));




Question 7
SELECT max(cnt)
FROM
	(Select count(*) as cnt
	FROM ticket T
	Group by T.matchId) c





Question 9

SELECT  Country
From Team
Group by Country
Having count(Country)>=(
SELECT Count(Year)
From Tournament);

Question 10
/////////////////// OLD
Select MatchId 
From `Match` M
Where M.HomeTeamId in (
Select TeamId
From Team 
Where Team.Country = "Iceland"
)
OR 
M.AwayTeamId in (
Select TeamId
From Team 
Where Team.Country = "Iceland"
);


//////////////// OLD
Select MatchID 
From Goals 
Where Goals.MatchId IN(
	Select MatchId 
	From `Match` M
	Where M.HomeTeamId in 
		(Select TeamId
		From Team 
		Where Team.Country = "Iceland")
	OR 
	M.AwayTeamId in 
		(Select TeamId
		From Team 
		Where Team.Country = "Iceland")
)
;
////// latest version below ////


Select PlayerId, count(*)
From Goals 
Where Goals.MatchId IN(
	Select MatchId 
	From `Match` M
	Where M.HomeTeamId in 
		(Select TeamId
		From Team 
		Where Team.Country = "Iceland")
	OR 
	M.AwayTeamId in 
		(Select TeamId
		From Team 
		Where Team.Country = "Iceland")
)
Group by PlayerId


/////
getting how many games iceland played:
Select Count(*)
From Goals 
Where Goals.MatchId IN(
	Select MatchId 
	From `Match` M
	Where M.HomeTeamId in 
		(Select TeamId
		From Team 
		Where Team.Country = "Iceland")
	OR 
	M.AwayTeamId in 
		(Select TeamId
		From Team 
		Where Team.Country = "Iceland")
)

//////////////////////////////[10]
//this should be the good one!!! PROVIDED WE REMOVE ZERO VALUES FROM SCORE!
Select PlayerId, count(*)
From Goals 
Where Goals.MatchId IN(
	Select MatchId 
	From `Match` M
	Where M.HomeTeamId in 
		(Select TeamId
		From Team 
		Where Team.Country = "Iceland")
	OR 
	M.AwayTeamId in 
		(Select TeamId
		From Team 
		Where Team.Country = "Iceland")
)
Group by PlayerId
Having count(*)=(Select Count(*)
From Goals 
Where Goals.MatchId IN(
	Select MatchId 
	From `Match` M
	Where M.HomeTeamId in 
		(Select TeamId
		From Team 
		Where Team.Country = "Iceland")
	OR 
	M.AwayTeamId in 
		(Select TeamId
		From Team 
		Where Team.Country = "Iceland")
))



//////////// question 6


Select M.Name, Sum(count)
From Saves S, Member M
Where PlayerId in(
	Select PlayerId 
	From Player) And S.PlayerId=M.MemberId
    Group by PlayerId;

    


/////////// number 8

Select M.Name, Sum(count) 
From Goals GP, Member M 
Where GP.MatchId IN(
	Select MatchID
	From Goals G
	Where G.MatchId In(
		Select E.EliminationId
		From EliminationGame E
)	) 
AND M.MemberId=GP.PlayerId
Group By PlayerId;






///// after zooom call: SelectSelect Sum(count) 
From Goals GP, Member M 
Where GP.MatchId IN(
	Select MatchID
	From Goals G
	Where G.MatchId In(
		Select E.EliminationId
		From EliminationGame E
)	) 
AND M.MemberId=GP.PlayerId
Group By PlayerId
Having Sum(count)>= All (
	Select Sum(count) 
	From Goals GP, Member M 
	Where GP.MatchId IN(
		Select  
		From Goals G
		Where G.MatchId In(
			Select E.EliminationId
			From EliminationGame E
)	) 
AND M.MemberId=GP.PlayerId
Group By PlayerId);


////// only slightly off now
Select M.Name, Sum(count)
From Goals GP, Member M 
Where GP.MatchId IN(
	Select MatchID
	From Goals G
	Where G.MatchId In(
		Select E.EliminationId
		From EliminationGame E
)	) 
AND M.MemberId=GP.PlayerId
Group by M.name
Having Sum(count) >= ANY (

-- Select Sum(count) 
-- From Goals GP, Member M 
-- Where GP.MatchId IN(
-- 	Select MatchID
-- 	From Goals G
-- 	Where G.MatchId In(
-- 		Select E.EliminationId
-- 		From EliminationGame E
-- )	) 
-- AND M.MemberId=GP.PlayerId
-- Group By PlayerId)
-- ;

	


DO NOT LOSE THIS!!

Select Sum(count), M.MemberId 
From Goals GP, Member M 
Where GP.MatchId IN(
		Select E.EliminationId
		From EliminationGame E
)	 
AND M.MemberId=GP.PlayerId
Group By PlayerId
;


	
///pretty close, kanye is a problem
Select Mo.Name, Sum(count)
From Goals Go, Member Mo 
Where Go.MatchId IN(
		Select Eo.EliminationId
		From EliminationGame Eo
)	 
AND Mo.MemberId=Go.PlayerId
Group by Mo.name

Having Sum(count) >= ANY (
	Select Sum(count)
	From Goals GP, Member M 
	Where GP.MatchId IN(
		Select E.EliminationId
		From EliminationGame E
	)	 
AND M.MemberId=GP.PlayerId
Group By PlayerId
);

	


//this is actually it!!

	Select Sum(count), GP.PlayerId
	From Goals GP
	Where GP.MatchId IN(
		Select E.EliminationId
		From EliminationGame E)	 
	Group By PlayerId
	Having Sum(count) >= ANY 
		(Select Sum(count)
		From Goals GP
		Where GP.MatchId IN
			(Select E.EliminationId
			From EliminationGame E)	 
			Group By PlayerId
    );
	




///final solution
Select Member.Name
From Member
Where Member.MemberId In(
Select Distinct PlayerId 
From Goals
Where Goals.PlayerId In (
	Select  GP.PlayerId
	From Goals GP
	Where GP.MatchId IN(
		Select E.EliminationId
		From EliminationGame E)	 
	Group By PlayerId
	Having Sum(count) >= ALL 
		(Select Sum(count)
		From Goals GP
		Where GP.MatchId IN
			(Select E.EliminationId
			From EliminationGame E)	 
			Group By PlayerId
    )));
	


////question 5
Select TeamId
from TeamMember
Where TeamMember.MemberId IN 
	(Select staffId 
	From supportstaff)
AND TeamMember.Year="2018"
Group By TeamMember.TeamId
Order By count(*) DESC;


/// Question 3

Select Distinct Tm.teamId
From team Tm, Tournament T
Where Tm.country=T.country ;























    




