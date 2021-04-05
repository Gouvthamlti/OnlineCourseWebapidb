create database onlinecourse
drop database onlinecourse
use onlinecourse

create table User_Table(
User_Id int identity(1,1) primary key,
UserName varchar(50),
Mobile_Number varchar(10),
Name Varchar(50),
Password Varchar(20),	
Gender varchar(20),
Age int,
Email varchar(50),
Address1 varchar(50),
Address2 varchar(50),
District varchar(50),
State varchar(50),
isAdmin Varchar(10))
insert into User_table values('admin1','7894561230','Gouvtham','admin284','male',34,'admin@lnt.com','54/1,pallavan street','Vadavalli','CBE','TN','true')


ALTER TABLE User_Table alter COLUMN Password BINARY(64) 
------------------------------------------------------------------------------------------------------------------------------
Create table Course_table(
Course_Id int identity(101,1) primary key,
Course_Name varchar(50),
Course_Description varchar(200),
Course_StartDate date,
Course_Author varchar(50),
Course_Duration varchar(50),
Course_Difficulty varchar(50),
credit_score varchar(20))

alter table Course_table add credits int
ALTER TABLE Course_table DROP COLUMN credit_score;
select * from Course_table
-------------------------------------------------------------------------------------------------------------
drop table Course_table

insert into Course_table values('Angular','This document contains the practices that we follow to provide you with a leading-edge app development platform, balanced with stability.','2021-05-21','David Boon','13 hours','easy',2)
insert into Course_table values('Sql','SQLite is a C-language library that implements a small, fast, self-contained, high-reliability, full-featured, SQL database engine.','2021-06-21','Alfred','18 hours','easy',3)
insert into Course_table values('.net', '.NET is a free, cross-platform, open source developer platform for building many different types of applications.','2021-07-21','Rishabh','8 hours','easy',2)
insert into Course_table values('C# Basics', 'C# is a free, cross-platform, open source developer platform for building many different types of applications.',SYSDATETIME(),'Jhonty','12 hours','medium',3)

update Course_table set Course_StartDate=Dateadd(month,1,sysdatetime()) where Course_Id=103
update Course_table set credits=2 where Course_Id=107
select * from Course_table
--------------------------------------------------------------------------------------------------------------------------------
create table Course_Enrolled(
Enroll_id int identity(1001,1) primary key,
User_Id int foreign key references User_table(User_Id),
Course_Id int foreign key references Course_table(Course_Id),
UserName varchar(50),
Course_Enrolleddate date,
Course_StartDtae date,
Course_CompletionDate date,
Status varchar(50)
)
alter table Course_Enrolled add credit_score varchar(20)
alter table Course_Enrolled add credits int
--------------------------------------------------------------------------------------------------------------------------------
create table Course_AssignedbyAdmin(
Assigned_id int identity(10001,1) primary key,
User_Id int foreign key references User_table(User_Id),
Course_Id int foreign key references Course_table(Course_Id),
UserName varchar(50),
Course_AssignedDate date,
Course_StartDate date,
Course_CompletionDate date,
AdminName varchar(50),
credit_score varchar(20),
Status varchar(50)
)

alter table Course_assignedbyadmin add credits int
drop table Course_AssignedbyAdmin

alter table course_Enrolled add  Enroll_id int identity(1001,1) primary key
select * from Course_assignedbyadmin
Create table admin_tbl(
Username varchar(50) primary key,
password varchar(50))

select * from User_table

-------------------------------------------------------------------------------------------------------------------
create proc Proc_ValidateExistingAuthGuard(@uname varchar(50),@pass varchar(20))
as
begin
select User_Id,Password,Name from User_Table where UserName=@uname and Password=@pass
end

exec Proc_ValidateExistingAuthGuard @uname='Jack02',@pass='jack1234'

Select * from User_Table
create proc Proc_ValidateExistingAuthGuardAdmin1(@uname varchar(50),@pass varchar(20))
as
begin
select * from User_Table where UserName=@uname and Password=@pass and isAdmin='yes'
end
exec Proc_ValidateExistingAuthGuardAdmin @uname='Jack02',@pass='jack1234'
exec Proc_ValidateExistingAuthGuardAdmin1 @uname='admin1', @pass=admin284
---------------------------------------------------------------------------------------------

create proc proc_HomeDisplay1
as
begin
select Course_Id,Course_Name,Course_Description,Course_StartDate from Course_table
end
exec proc_HomeDisplay1
----------------------------------------------------------------------------------------------------------------------------

create proc proc_ViewDetails2(@cid int)
as 
begin
select * from Course_table where course_id=@cid
end
proc_ViewDetails1 103
select * from User_table
----------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into Course_Enrolled1 (USER_ID,Course_Id,Course_Enrolleddate,Course_StartDtae,Status) values (1,101,SYSDATETIME(),'2021-05-21','enrolled')
select * from Course_Enrolled

create proc proc_CourseEnroll6(@uname varchar(50),@uid int,@cid int,@crescore int)
as 
begin
insert into Course_Enrolled (User_Id,UserName,Course_Id,Course_Enrolleddate,Course_StartDtae,Course_CompletionDate,Status,credits) values(@uid,@uname,@cid,SYSDATETIME(),Dateadd(month,1,sysdatetime()),dateadd(month,4,sysdatetime()),'enrolled',@crescore)
end
proc_Courseenroll6 'bob101',7,103,2
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

create proc proc_CourseAssign1(@uname varchar(50),@uid int,@cid int,@adname varchar(50),@crescore int)
as 
begin
insert into Course_AssignedbyAdmin (User_Id,UserName,Course_Id,Course_AssignedDate,Course_StartDate,Course_CompletionDate,AdminName,credits,Status) values(@uid,@uname,@cid,SYSDATETIME(),Dateadd(month,1,sysdatetime()),dateadd(month,4,sysdatetime()),@adname,@crescore,'assigned')
end
proc_CourseAssign1 'bob101',7,106,'admin1',3
select * from Course_AssignedbyAdmin


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
create proc proc_User_Detail1(@uname varchar(50))
as
begin
select * from User_table where UserName=@uname
end
exec proc_User_Detail1 'bob101'
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
create proc proc_Userdashboarddisp2(@uname varchar(50))
as
begin
select * from Course_Enrolled where Username=@uname and status ='enrolled'
end
exec proc_Userdashboarddisp1 'bob101'
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
create proc proc_Userdashboardassigndisp1(@uname varchar(50))
as
begin
select * from Course_AssignedbyAdmin where Username=@uname and status='assigned'
end
proc_Userdashboardassigndisp1 'peterk1'

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
create proc proc_CancelCourse2(@eid int )
as
begin
update Course_Enrolled set status='cancelled' where Enroll_id=@eid and Course_Startdtae!=SYSDATETIME()
end
select * from Course_Enrolled
proc_CancelCourse2 1001
----------------------------------------------------------------------------------------------------------------------------------------
create proc proc_CompleteCourse(@eid int)
as
begin
update Course_Enrolled set Status ='completed' where Enroll_id=@eid
end
proc_CompleteCourse 1030
-----------------------------------------------------------------------------------------------------------------------------------------
create proc proc_EnrolledStatus1(@aid int)
as
begin
update Course_AssignedbyAdmin set status='enrolled' where Assigned_id=@aid
end
proc_EnrolledStatus1 10002
---------------------------------------------------------------------------------------------------------------------------------------
create proc proc_CompletedStatus(@aid int)
as
begin
update Course_AssignedbyAdmin set status='completed' where Assigned_id=@aid
end

proc_CompletedStatus 10003
---------------------------------------------------------------------------------------------------------------------------------------
create proc proc_EditCourse1(@cid int,@cname varchar(50),@cdesc varchar(200), @cauth varchar(50),@cduration varchar(50),@cdifficulty varchar(50),@ccredscore  int)
as
begin
update Course_table set Course_Name=@cname,Course_Description=@cdesc,Course_Author=@cauth,Course_Duration=@cduration,Course_Difficulty=@cdifficulty,credits=@ccredscore where Course_Id=@cid
end

select * from Course_table
exec  proc_EditCourse 101,'Angular','This document contains the practices that we follow to provide you with a leading-edge app development platform, balanced with stability.','David Malan','13 hours','easy',2
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
create proc proc_DeleteCourse3(@cid int)
as 
begin
delete from  Course_Enrolled where Course_Id=@cid 
delete from  Course_AssignedbyAdmin where Course_Id=@cid
delete from  Course_Table where Course_Id=@cid

end
proc_DeleteCourse3 107
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from Course_Enrolled where User_Id=2
select * from Course_Table where User_Id=8
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
create proc proc_GetAllUsers2
as
begin
select * from User_Table where isAdmin!='yes'
end
proc_GetAllUsers2

update User_Table set isAdmin='no' where User_Id=10
-----------------------------------------------------------------------------------------------------------------------------------------
create proc proc_GetuserbyId(@uid int)
as
begin
select * from user_table where user_Id=@uid
end
proc_GetuserbyId 1
------------------------------------------------------------------------------------------------------------------------------------------------
create proc proc_GetAllCourse2
as 
begin 
select * from Course_table
end
------------------------------------------------------------------------------------------------------------------------------------------
select * from Course_Enrolled m join Course_AssignedbyAdmin u on
m.status='enrolled' and u.status='enrolled'
where u.User_Id=3
select Enroll_id  as Enroll_id,Course_Id  as Course_Id ,UserName  as UserName,Course_Enrolleddate  as Course_Enrolleddate,Course_StartDtae  as Course_StartDate,Course_CompletionDate  as Course_CompletionDate from Course_Enrolled where User_Id=3 and status='enrolled'
select Assigned_id as Assigned_id,Course_AssignedDate as Course_AssignedDate,AdminName  as AdminName  ,credit_score  as credit_score from Course_AssignedbyAdmin where User_id=3 and status='enrolled'

select v.Enroll_id,v.Course_Id,v.Course_StartDtae,v.Course_CompletionDate,m.Course_AssignedDate from Course_Enrolled v,Course_AssignedbyAdmin m where v.status='enrolled' and m.status='enrolled' and m.User_Id=3 and v.User_Id=3

select mit.Enroll_id  as Enroll_id , mit.User_Id  as User_Id , mit.Course_Id  as Course_Id , 
		mit.UserName  as UserName , mit.Course_Enrolleddate  as Course_Enrolleddate , mit.Course_StartDtae  as Course_StartDtae ,
		mit.Course_CompletionDate  as Course_CompletionDate , 
		udt.Assigned_id  as Assigned_id , udt.Course_AssignedDate  as Course_AssignedDate , udt.AdminName  as AdminName, udt.credit_score  as credit_score from (Course_Enrolled mit right join Course_AssignedbyAdmin udt on mit.UserName =udt.UserName)
where mit.User_Id =3 and mit.status='enrolled' 



------------------------------------------------------------------------------------------------------------------------------------------

create proc proc_GetUserEnrolledCourses(@uid int)
as
begin
select m.Enroll_id  as Enroll_id,m.Course_Id  as Course_Id ,m.UserName  as UserName,m.Course_Enrolleddate  as Course_Enrolleddate,m.Course_StartDtae  as Course_StartDate,m.Course_CompletionDate  as Course_CompletionDate , a.Assigned_id as Assigned_id,a.Course_AssignedDate as Course_AssignedDate,a.AdminName  as AdminName  ,a.credit_score  as credit_score  from Course_Enrolled m ,Course_AssignedbyAdmin a where a.User_id=3 and a.status='enrolled' and a.UserName=m.UserName
select Assigned_id as Assigned_id,Course_AssignedDate as Course_AssignedDate,AdminName  as AdminName  ,credit_score  as credit_score from Course_AssignedbyAdmin where User_id=3 and status='enrolled'
end

proc_GetUserEnrolledCourses 3

select SUM(credits) as credits from Course_Assignedbyadmin where User_id=15 and status='Completed'
select * from Course_Enrolled
select * from Course_Assignedbyadmin

create proc proc_GetCredits1(@uname varchar(50))
as
begin
SELECT (SELECT COALESCE(SUM(credits), 0) FROM Course_Enrolled where UserName=@uname and status='Completed') + (SELECT COALESCE(SUM(credits), 0) FROM Course_AssignedbyAdmin where UserName=@uname and status='Completed') as Total
end 
proc_GetCredits1 'sandy1'

select * from User_table
select * from Course_Enrolled
select * from Course_Assignedbyadmin
delete from Course_Enrolled where user_id=8
delete from Course_Assignedbyadmin where user_id=8
delete from user_table where user_id=13