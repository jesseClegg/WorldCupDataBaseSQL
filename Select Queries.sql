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


Select M.Name, S.playerId, Sum(count)
From Saves S, Member M
Where PlayerId in(
	Select PlayerId 
	From Player) And S.PlayerId=M.MemberId
    Group by PlayerId;

    




