/* UTILITY FUNCTIONS*/
DROP TABLE Tournament;
SHOW TABLES
/* UTILITY FUNCTIONS*/

CREATE SCHEMA `WorldCup` ;


CREATE TABLE Country (
Name CHAR(30),
Population INTEGER,
PRIMARY KEY (Name)
);

CREATE TABLE Tournament (
Year YEAR,
Country CHAR(30),  
PRIMARY KEY (Year),
FOREIGN KEY (Country) REFERENCES  Country(Name)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE Team(
Year YEAR,
TeamId INTEGER,
Country CHAR(30),
  PRIMARY KEY(Year, TeamId),
  FOREIGN KEY (Country) REFERENCES Country(Name)
   ON DELETE CASCADE
   ON UPDATE CASCADE,
  FOREIGN KEY (Year) REFERENCES Tournament(Year)
   ON DELETE CASCADE
   ON UPDATE CASCADE
);

CREATE TABLE Member(
MemberId INTEGER,
Name CHAR(30),
  PRIMARY KEY (MemberId)
); 

CREATE TABLE HomeClub(
HomeClubName CHAR(30),
Country CHAR(30),
PRIMARY KEY (HomeClubName),
  FOREIGN KEY (Country) REFERENCES Country(Name)
   ON DELETE CASCADE
   ON UPDATE CASCADE
);

CREATE TABLE SupportStaff(
StaffId INTEGER,
Role CHAR(30),
PRIMARY KEY (StaffId),
  FOREIGN KEY (StaffId) REFERENCES Member(MemberId)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE Player(
PlayerId INTEGER,
Position CHAR(30),
HomeClubName CHAR(30),
PRIMARY KEY (PlayerId),
  FOREIGN KEY (PlayerId) REFERENCES Member(MemberId)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (HomeClubName) REFERENCES HomeClub(HomeClubName)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE TeamMember(
Year YEAR,
TeamId INTEGER,
MemberId INTEGER,
PRIMARY KEY (Year, TeamId, MemberId),
  FOREIGN KEY (Year, TeamId) REFERENCES Team(Year, TeamId)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (MemberId) REFERENCES Member(MemberId)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE `Match` (
MatchId INTEGER,
Date DATE,
Time TIME,
Stadium CHAR(30),
HomeYear YEAR,
HomeTeamId INTEGER,
AwayYear YEAR,
AwayTeamId INTEGER,
PRIMARY KEY (MatchId),
  FOREIGN KEY (HomeYear, HomeTeamId) REFERENCES Team (Year, TeamId)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (AwayYear, AwayTeamId) REFERENCES Team (Year, TeamId)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


CREATE TABLE PoolGame (
PoolId INTEGER,
PRIMARY KEY (PoolId),
  FOREIGN KEY (PoolId) REFERENCES `Match` (MatchId)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE EliminationGame (
EliminationId INTEGER,
Stage CHAR(30),
HomePenalties INTEGER,
AwayPenalties INTEGER,
PRIMARY KEY (EliminationId),
  FOREIGN KEY (EliminationId) REFERENCES `Match` (MatchId)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE Goals (
PlayerId INTEGER,
MatchId INTEGER,
Count INTEGER,
PRIMARY KEY (PlayerId, MatchId),
  FOREIGN KEY (PlayerId) REFERENCES Player (PlayerId)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (MatchId) REFERENCES `Match` (MatchId)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

/* COMPLETED ABOVE  */





















