-- RaceDay Database Script
CREATE DATABASE RaceDayDB;
GO
USE RaceDayDB;
GO

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Email VARCHAR(100) NOT NULL UNIQUE,
    FullName VARCHAR(100) NOT NULL,
    Role VARCHAR(20) NOT NULL DEFAULT 'Participant'
);

INSERT INTO Users VALUES ('org1@email.com', 'John Organiser', 'Organiser');
INSERT INTO Users VALUES ('org2@email.com', 'Jane Organiser', 'Organiser');
INSERT INTO Users VALUES ('part1@email.com', 'Bob Runner', 'Participant');
INSERT INTO Users VALUES ('part2@email.com', 'Alice Runner', 'Participant');
