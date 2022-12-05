
	Select M.name
    FROM Member M
    Where M.memberId In
    (SELECT TM.memberId
      FROM TeamMember TM
		WHERE TM.TeamId IN
		(SELECT TeamId 
		From Team T
		Where T.Year="2018" && T.Country ="Australia"
		));
				