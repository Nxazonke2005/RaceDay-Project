-- RaceDay Database Script
-- Part 1 - System Planning and Database

CREATE DATABASE RaceDayDB;
GO

USE RaceDayDB;
GO

-- =============================================
-- TABLE: Users (Organisers and Participants)
-- =============================================
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Email VARCHAR(100) NOT NULL UNIQUE,
    FullName VARCHAR(100) NOT NULL,
    Role VARCHAR(20) NOT NULL DEFAULT 'Participant' -- 'Organiser' or 'Participant'
);
GO

-- =============================================
-- TABLE: Events
-- =============================================
CREATE TABLE Events (
    EventID INT PRIMARY KEY IDENTITY(1,1),
    EventName VARCHAR(100) NOT NULL,
    EventDate DATE NOT NULL,
    Location VARCHAR(200),
    Status VARCHAR(20) DEFAULT 'Active',
    OrganiserID INT NOT NULL,
    FOREIGN KEY (OrganiserID) REFERENCES Users(UserID)
);
GO

-- =============================================
-- TABLE: Categories (e.g., 5km, 10km)
-- =============================================
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(200)
);
GO

-- =============================================
-- TABLE: EventCategories (Junction Table - Many-to-Many)
-- =============================================
CREATE TABLE EventCategories (
    EventID INT,
    CategoryID INT,
    PRIMARY KEY (EventID, CategoryID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
GO

-- =============================================
-- TABLE: Enrolments (Participants joining Events)
-- =============================================
CREATE TABLE Enrolments (
    EnrolmentID INT PRIMARY KEY IDENTITY(1,1),
    EventID INT NOT NULL,
    ParticipantID INT NOT NULL,
    EnrolmentDate DATETIME DEFAULT GETDATE(),
    Status VARCHAR(20) DEFAULT 'Enrolled',
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    FOREIGN KEY (ParticipantID) REFERENCES Users(UserID)
);
GO

-- =============================================
-- TABLE: Results
-- =============================================
CREATE TABLE Results (
    ResultID INT PRIMARY KEY IDENTITY(1,1),
    EnrolmentID INT NOT NULL,
    FinishTime TIME,
    Position INT,
    FOREIGN KEY (EnrolmentID) REFERENCES Enrolments(EnrolmentID)
);
GO

-- =============================================
-- SAMPLE DATA
-- =============================================

-- 2 Organisers
INSERT INTO Users (Email, FullName, Role) VALUES 
('org1@email.com', 'John Organiser', 'Organiser'),
('org2@email.com', 'Jane Organiser', 'Organiser');

-- 2 Participants
INSERT INTO Users (Email, FullName, Role) VALUES 
('part1@email.com', 'Bob Runner', 'Participant'),
('part2@email.com', 'Alice Runner', 'Participant');
GO

-- 3 Events
INSERT INTO Events (EventName, EventDate, Location, Status, OrganiserID) VALUES 
('City Marathon', '2026-10-15', 'Central Park', 'Active', 1),
('Half Marathon', '2026-11-01', 'Beach Road', 'Active', 1),
('5km Fun Run', '2026-12-05', 'Sports Ground', 'Active', 2);
GO

-- Categories
INSERT INTO Categories (CategoryName, Description) VALUES 
('5km', 'Short distance fun run'),
('10km', 'Medium distance race'),
('Half Marathon', '21km race');
GO

-- Link Events to Categories (Many-to-Many)
INSERT INTO EventCategories (EventID, CategoryID) VALUES 
(1, 1), -- City Marathon has 5km
(1, 2), -- City Marathon has 10km
(2, 3), -- Half Marathon has Half Marathon category
(3, 1); -- 5km Fun Run has 5km
GO

-- Enrolments (Participants join Events)
INSERT INTO Enrolments (EventID, ParticipantID, Status) VALUES 
(1, 3, 'Enrolled'), -- Bob joins City Marathon
(1, 4, 'Enrolled'), -- Alice joins City Marathon
(2, 3, 'Enrolled'); -- Bob joins Half Marathon
GO

-- Results (Only for finished events)
INSERT INTO Results (EnrolmentID, FinishTime, Position) VALUES 
(1, '01:30:00', 5),  -- Bob's result for City Marathon
(2, '01:45:00', 10); -- Alice's result for City Marathon
GO

-- View all data (optional, to check)
SELECT * FROM Users;
SELECT * FROM Events;
SELECT * FROM Categories;
SELECT * FROM EventCategories;
SELECT * FROM Enrolments;
SELECT * FROM Results;
GO
