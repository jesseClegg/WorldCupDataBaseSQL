/* UTILITY FUNCTIONS*/
/* DROP TABLE Tournament;*/
/* SHOW TABLES; */
/* UTILITY FUNCTIONS*/
/* CREATE SCHEMA `WorldCup` ;*/


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

CREATE TABLE Saves (
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

CREATE TABLE Customer(
CustomerId INTEGER,
Name CHAR(30),
Email CHAR(30),
CountryName CHAR(30),
PRIMARY KEY (CustomerId)
);

CREATE TABLE Ticket (
MatchId INTEGER,
`Ticket#` INTEGER,
CustomerId INTEGER,
Price DECIMAL(13,2),
PRIMARY KEY (MatchId, `Ticket#`)
); 



/*********************** BEGIN INSERT *********************************/
INSERT INTO 
  Country(Name, Population)
VALUES
  ("United States", 310000000),
  ("Iceland", 372295),
  ("England", 55000000),
  ("Germany", 83000000),
  ("Australia", 25000000);

INSERT INTO
  Customer(CustomerId, Name, Email, CountryName)
VALUES
  (918, "John Smith", "johnSmith@gmail.com", "United States"),
  (501, "Jane Smith", "janeSmith@gmail.com", "Iceland"),
  (168, "John Doe", "johnDoe@gmail.com", "England"),
  (576, "Jane Doe", "janeDoe@gmail.com", "Germany"),
  (804, "John Johnson", "johnJohnson@gmail.com", "Australia");


INSERT INTO
  Tournament(Year, Country)
VALUES
  ("2018", "United States"),
  ("2014", "Iceland"),
  ("2010", "England"),
  ("2006", "Germany"),
  ("2002", "Australia");

INSERT INTO
  Team(Year, TeamId, Country)
VALUES
  ("2018", 82180, "United States"),
  ("2018", 42859, "Iceland"),
  ("2018", 78242, "Australia"),
  ("2018", 55608, "Germany"),
  ("2018", 62098, "England"),
  ("2014", 62098, "England"),
  ("2010", 62098, "England"),
  ("2006", 62098, "England"),
  ("2002", 62098, "England"),
  ("2014", 82180, "United States"),
  ("2010", 78242, "Australia"),
  ("2006", 55608, "Germany"),
  ("2002", 42859, "Iceland");
  
INSERT INTO
    `Match`(MatchId, Date, Time, Stadium, HomeYear, HomeTeamId, AwayYear, AwayTeamId)
VALUES
    (635287, '2012-06-21', "19:30:00", "Wembly", "2018", 62098, "2018", 42859),
    (228564, '2014-07-08', "18:30:00", "Azteca", "2014", 62098, "2014", 82180),
    (897449, '2010-07-21', "17:30:00", "Stamford", "2010", 62098, "2010", 78242),
    (876960,  "2006-05-29", "16:15:00",    "Celtic",  "2006",  62098, "2006",  55608),
    (755050,  "2002-06-02",  "19:45:00",  "Emirates",  "2002",  62098, "2002",  42859),
    (707650,  "2018-08-19",  "18:10:00",  "Wembly",  "2018",  78242, "2018",  55608),
    (364820,  "2018-06-19",  "17:50:00",  "Azteca",  "2018",  82180, "2018",  55608),
    (962067,  "2018-07-04",  "16:25:00",  "Stamford",  "2018",  82180, "2018",  62098),
    (619043,  "2018-09-01",  "21:30:00",  "Celtic",  "2018",  82180, "2018",  78242),
    (849739,  "2018-04-30",  "18:30:00",  "Emirates",  "2018",  78242, "2018",  62098);
  
INSERT INTO
  PoolGame(PoolId)
VALUES
  (962067),
  (635287),
  (619043),
  (849739),
  (228564);

/* completed above ^^^    */




  





  
 

  






























