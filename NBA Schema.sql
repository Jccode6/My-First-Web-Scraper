
use NBA;


CREATE TABLE Player (
	PlayerID INT NOT NULL AUTO_INCREMENT
	,FirstName VARCHAR(55)
	,LastName VARCHAR(55)
	,Team VARCHAR(3)
	,Position VARCHAR(2)
	,Age VARCHAR(2)
	,PRIMARY KEY (PlayerID)
);

CREATE TABLE Games (
	GameID INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	,GamesPlayed INT
	,GamesStarted INT
	,MinutesPlayed INT
	,PlayerID INT NOT NULL
	,FOREIGN KEY (PlayerID)
			REFERENCES Player(PlayerID)
)ENGINE = INNODB;

CREATE TABLE OffensiveStats (
	OffenseID INT NOT NULL AUTO_INCREMENT
	,FieldGoalsMade INT
	,FieldGoalAttempts INT
	,FieldGoalPercentage FLOAT
	,ThreePointMade INT
	,ThreePointAttempts INT
	,ThreePointPercentage FLOAT
	,EffectiveFieldGoalPercent FLOAT
	,Points INT
	,PlayerID INT NOT NULL
	,PRIMARY KEY (OffenseID)
	,FOREIGN KEY (PlayerID)
		REFERENCES Player(PlayerID)
) ENGINE = INNODB;

CREATE TABLE MiscStats (
	MiscID INT NOT NULL AUTO_INCREMENT
	,OffensiveRebounds INT
	,DefensiveRebounds INT
	,Assists INT
	,Steals INT
	,Blocks INT
	,PersonalFouls INT
	,PlayerID INT NOT NULL
	,PRIMARY KEY (MiscID)
	,FOREIGN KEY (PlayerID)
		REFERENCES Player(PlayerID)
)ENGINE = INNODB;


	