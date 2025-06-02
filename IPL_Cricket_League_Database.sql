create database IPL_Cricket_League

use IPL_Cricket_League

create table Staging_Dim_Country(
Country_Id int,
Country_Name varchar(255))

select * from Staging_Dim_Country

create table Dim_Country(
Country_Id int primary key,
Country_Name varchar(255) not null)

select * from Dim_Country

create table Dim_City(
City_Id int primary key,
City_Name varchar(255) not null,
Country_Id int foreign key references Dim_Country(Country_Id) on delete cascade on update cascade)

select * from Dim_City

create table Dim_Venue(
Venue_Id int primary key,
Venue_Name varchar(255) not null,
City_Id int foreign key references Dim_City(City_Id) on delete cascade on update cascade)

select * from Dim_Venue

create table Dim_Rolee(
Role_Id int primary key,
Role_Desc varchar(255) not null)

select * from Dim_Rolee

create table Dim_Team(
Team_Id int primary key,
Team_Name varchar(255) not null)

select * from Dim_Team

create table Dim_Toss_Decision(
Toss_Id int primary key check(Toss_Id in(1,2)), --it contains either bat or field
Toss_Name varchar(255) not null)

select * from Dim_Toss_Decision

create table Dim_Batting_Style(
Batting_Id int primary key,
Batting_Hand varchar(255) not null)

select * from Dim_Batting_Style

create table Dim_Bowling_Style(
Bowling_Id int primary key,
Bowling_Skill varchar(255) not null)

select * from Dim_Bowling_Style

create table Dim_Player(
Player_Id int primary key,
Player_Name varchar(255) not null,
DOB date,
Batting_Id int null foreign key references Dim_Batting_Style(Batting_Id) on delete cascade on update cascade,
Bowling_Id int null foreign key references Dim_Bowling_Style(Bowling_Id) on delete cascade on update cascade,
Country_Id int null foreign key references Dim_Country(Country_Id) on delete cascade on update cascade)

select * from Dim_Player

create table Dim_Extra_Type(
Extra_Id int primary key,
Extra_Name varchar(255) not null)

select * from Dim_Extra_Type

create table Dim_Out_Type(
Out_Id int primary key,
Out_Name varchar(255) not null)

select * from Dim_Out_Type

create table Dim_Outcome(
Outcome_Id int primary key,
Outcome_Type varchar(255) not null)

select * from Dim_Outcome

create table Dim_Win_By(
Win_Id int primary key,
Win_Type varchar(255) not null)

select * from Dim_Win_By

create table Fact_Season(
Season_Id int primary key,
Man_of_the_Series int foreign key references Dim_Player(Player_Id) on delete cascade on update cascade,
Orange_Cap int foreign key references Dim_Player(Player_Id),
Purple_Cap int foreign key references Dim_Player(Player_Id),
Season_Year int check(Season_Year Between 1900 and 2100)) --it contains only year's information between 2008 to 2016

select * from Fact_Season

create table Fact_Match(
Match_Id int primary key,
Team_1 int not null foreign key references Dim_Team(Team_Id) on delete cascade on update cascade,
Team_2 int not null foreign key references Dim_Team(Team_Id),
Match_Date Date not null,
Season_Id int foreign key references Fact_Season(Season_Id) on delete cascade on update cascade,
Venue_Id int foreign key references Dim_Venue(Venue_Id),
Team_Toss_Winner int foreign key references Dim_Team(Team_Id),
Toss_Id int foreign key references Dim_Toss_Decision(Toss_Id) on delete cascade on update cascade,
Win_Id int foreign key references Dim_Win_By(Win_Id) on delete cascade on update cascade,
Win_Margin int null,
Outcome_Id int foreign key references Dim_Outcome(Outcome_Id) on delete cascade on update cascade,
Match_Winner_Team_Name int null foreign key references Dim_Team(Team_Id),
Man_of_the_match int foreign key references Dim_Player(Player_Id))

select * from Fact_Match

create table Fact_Ball_by_Ball(
primary key(Match_Id, Over_Id, Ball_Id, Innings_No),
Match_Id int foreign key references Fact_Match(Match_Id),
Ball_Id int,
Over_Id int,
Innings_No int check (Innings_No between 1 and 4), --in Test Cricket, no. of innings is up to 4
Team_Battings int foreign key references Dim_Team(Team_Id) on delete cascade on update cascade,
Team_Bowlings int foreign key references Dim_Team(Team_Id),
Striker_Batting_Position int,
Striker int foreign key references Dim_Player(Player_Id) on delete cascade on update cascade,
Non_Striker int foreign key references Dim_Player(Player_Id),
Bowler int foreign key references Dim_Player(Player_Id))

select * from Fact_Ball_by_Ball

create table Fact_Batsman_Scored(
Match_Id int foreign key references Fact_Match(Match_Id),
Ball_Id int,
Over_Id int,
Innings_No int check (Innings_No between 1 and 4),
primary key(Match_Id, Over_Id, Ball_Id, Innings_No),
foreign key(Match_Id, Over_Id, Ball_Id, Innings_No)
references Fact_Ball_by_Ball(Match_Id, Over_Id, Ball_Id, Innings_No) on delete cascade on update cascade,
Runs_Scored int)

select * from Fact_Batsman_Scored

create table Fact_Extra_Runs(
Match_Id int foreign key references Fact_Match(Match_Id),
Ball_Id int,
Over_Id int,
Innings_No int check (Innings_No between 1 and 4),
primary key(Match_Id, Over_Id, Ball_Id, Innings_No),
foreign key(Match_Id, Over_Id, Ball_Id, Innings_No)
references Fact_Ball_by_Ball(Match_Id, Over_Id, Ball_Id, Innings_No) on delete cascade on update cascade,
Extra_Runs_Id int,
Extra_Type_Id int)

select * from Fact_Extra_Runs

create table Fact_Wicket_Taken(
Match_Id int foreign key references Fact_Match(Match_Id),
Ball_Id int,
Over_Id int,
Innings_No int check (Innings_No between 1 and 4),
primary key(Match_Id, Over_Id, Ball_Id, Innings_No),
foreign key(Match_Id, Over_Id, Ball_Id, Innings_No)
references Fact_Ball_by_Ball(Match_Id, Over_Id, Ball_Id, Innings_No) on delete cascade on update cascade,
Player_Out int foreign key references Dim_Player(Player_Id),
Kind_out int,
Fielders int null foreign key references Dim_Player(Player_Id)) --as it contains the null values

select * from Fact_Wicket_Taken

create table Fact_Player_Match(
Match_Id int foreign key references Fact_Match(Match_Id),
Player_Id int foreign key references Dim_Player(Player_Id) on delete cascade on update cascade,
Role_Id int foreign key references Dim_Rolee(Role_Id) on delete cascade on update cascade,
Team_Id int foreign key references Dim_Team(Team_Id) on delete cascade on update cascade)

select * from Fact_Player_Match

create table IPL_ErrorLog(
Error_Log_Id int identity(1,1) primary key,
Table_Name nvarchar(max),
Error_Descrpiption nvarchar(max) not null,
Error_Data nvarchar(max) not null,
log_date datetime default GETDATE())

drop table IPL_ErrorLog

select * from IPL_ErrorLog