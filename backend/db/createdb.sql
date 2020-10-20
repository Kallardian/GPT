USE MASTER
GO
DROP DATABASE IF EXISTS GEPETO
GO
CREATE DATABASE GEPETO
GO
USE GEPETO
GO
CREATE TABLE [TB_USER]
(	
	[RA] CHAR(6) PRIMARY KEY,
	[FULL_NAME] VARCHAR(50) NOT NULL,
	[PASSWORD] VARCHAR(MAX) NOT NULL,
	[ACCESS] TINYINT NOT NULL
); 
GO
CREATE TABLE [TB_CLASSROOM]
(
	[ID_CLASSROOM] INT PRIMARY KEY IDENTITY,
	[NAME_CLASSROOM] CHAR(6) NOT NULL,
	[YEAR] DATE NOT NULL
);
GO
CREATE TABLE [TB_GROUP]
(
	[ID_GROUP] INT PRIMARY KEY IDENTITY,
	[GROUP_THEME] VARCHAR(50) NOT NULL,
	[GROUP_DESCRIPTION] VARCHAR(300) NULL,
	[ID_CLASSROOM] INT NOT NULL,
	CONSTRAINT [ID_CLASSROOM_FK_0] 
		FOREIGN KEY ([ID_CLASSROOM]) 
		REFERENCES [TB_CLASSROOM]([ID_CLASSROOM])
);
GO
CREATE TABLE [TB_BIG_CRITERION]
(
	[ID_BIG] INT PRIMARY KEY IDENTITY,
	[RA] CHAR(6) NOT NULL,
	CONSTRAINT [RA_FK_0] 
		FOREIGN KEY (RA) 
		REFERENCES [TB_USER]([RA]),
	[YEAR] DATE NOT NULL
);
GO
CREATE TABLE [TB_MEDIUM_CRITERION]
(
	[ID_MEDIUM] INT PRIMARY KEY IDENTITY,
	[ID_BIG] INT NOT NULL,
	CONSTRAINT [ID_BIG_FK_0] 
		FOREIGN KEY ([ID_BIG]) 
		REFERENCES [TB_BIG_CRITERION]([ID_BIG]),
	[NAME_MEDIUM] VARCHAR(30) NOT NULL,
	[DESCRIPTION] VARCHAR(100) NULL, -- QUICK NOTES
	[TOTAL_VALUE] DECIMAL(4,2)
);
GO
CREATE TABLE [TB_MEDIUM_GRADE]
(
	[ID_MEDIUM_GRADE] INT PRIMARY KEY IDENTITY,
	[RA] CHAR(6) NOT NULL,
	CONSTRAINT [RA_FK_1]
		FOREIGN KEY ([RA])
		REFERENCES [TB_USER]([RA]),
	[ID_MEDIUM] INT NOT NULL,
	CONSTRAINT [ID_MEDIUM_FK_1] 
		FOREIGN KEY ([ID_MEDIUM]) 
		REFERENCES [TB_MEDIUM_CRITERION]([ID_MEDIUM]),
	[ID_GROUP] INT NOT NULL,
	CONSTRAINT [ID_GROUP_FK_2] 
		FOREIGN KEY ([ID_GROUP]) 
		REFERENCES [TB_GROUP]([ID_GROUP]),
	[GRADE] DECIMAL(4,2) NOT NULL,
	[ATTEMPT] TINYINT NOT NULL
)
GO

/*----------------------------------SYSTEM FUNCTIONS------------------------------------*/

--TODO function for amount of groups/classroom
GO

CREATE FUNCTION Funcencrypt(@pwd1 VARCHAR(30)) 
returns VARCHAR(max) 
  BEGIN 
      DECLARE @pwd2 VARBINARY(100) 

      SET @pwd2 = CONVERT(VARBINARY(100), @pwd1, 0) 
      SET @pwd2 = Hashbytes('md4', @pwd2) 

      RETURN CONVERT(VARCHAR(max), @pwd2, 1) 
  END 

GO

CREATE FUNCTION Checkuserexists(@ra CHAR(6)) 
returns BIT 
  BEGIN 
      DECLARE @status BIT 

      IF EXISTS (SELECT * 
                 FROM   [TB_USER] 
                 WHERE  [RA] = @ra) 
        SET @status = 1 
      ELSE 
        SET @status = 0 

      RETURN @status 
  END -- 0 == inactive or 0 == does not exist  

GO

CREATE FUNCTION Checklogin(@RA  CHAR(6), 
                           @pwd VARCHAR(20)) 
returns TINYINT 
  BEGIN 
      DECLARE @access_level TINYINT, 
              @pwdHash      VARCHAR(max) 

      SET @pwdHash = dbo.FuncEncrypt(@pwd) 

      IF EXISTS (SELECT * 
                 FROM   tb_user 
                 WHERE  [RA] = @RA 
                        AND [PASSWORD] = @pwdHash) 
        SELECT @access_level = ACCESS 
        FROM   tb_user 
        WHERE  RA = @RA; 
      ELSE 
        SET @access_level = 0; 

      RETURN @access_level 
  END 

GO

CREATE FUNCTION Checkclassroomnameexists(@clasroom_name CHAR(6)) 
returns BIT 
  BEGIN 
      DECLARE @status BIT 

      IF EXISTS (SELECT * 
                 FROM   [TB_CLASSROOM] 
                 WHERE  [NAME_CLASSROOM] = @clasroom_name 
                        AND Year([YEAR]) = Year(Getdate())) 
        SET @status = 1; 
      ELSE 
        SET @status = 0; 

      RETURN @status 
  END 

GO

CREATE FUNCTION Returnamountofclassrooms() 
returns TINYINT 
  BEGIN 
      DECLARE @total_classroom TINYINT 

      SELECT @total_classroom = Count(*) 
      FROM   [TB_CLASSROOM] 
      WHERE  Year([YEAR]) = Year(Getdate()) 

      RETURN @total_classroom 
  END 

GO

CREATE FUNCTION Classroomnametoclassroomid(@classroom_name CHAR(6)) 
returns INT 
  BEGIN 
      DECLARE @classroom_id INT 

      SELECT @classroom_id = [ID_CLASSROOM] 
      FROM   [TB_CLASSROOM] 
      WHERE  [NAME_CLASSROOM] = @classroom_name 
             AND Year([YEAR]) = Year(Getdate()); 

      RETURN @classroom_id 
  END 

GO

CREATE FUNCTION GroupThemeToGroupId(@group_theme VARCHAR(50)) 
returns INT 
  BEGIN 
      DECLARE @group_id INT 

      SELECT @group_id = G.[ID_GROUP] 
      FROM   [TB_GROUP] G 
             INNER JOIN [TB_CLASSROOM] C 
                     ON G.[ID_CLASSROOM] = C.[ID_CLASSROOM] 
      WHERE  Year(C.YEAR) = Year(Getdate()) 
             AND [GROUP_THEME] = @group_theme 

      RETURN @group_id 
  END 
go

/*--------------------------------| STORED PROCEDURES |--------------------------------------*/ 
--TODO INSERT_MEDIUM FINISH 
go 

--| USER |-- 
CREATE PROCEDURE SP_INSERT_USER (@user_login CHAR(6), 
                                 @user_name  VARCHAR(50), 
                                 @user_pwd   VARCHAR(30), 
                                 @access     TINYINT) 
AS 
  BEGIN 
      IF( @access = 0 ) 
        PRINT 'Você não pode adicionar um usuário inativo' 
      ELSE 
        BEGIN 
            DECLARE @final_pwd VARCHAR(MAX) 

            SET @final_pwd = dbo.funcEncrypt(@user_pwd) 

            INSERT INTO [TB_USER] 
                        ([RA], 
                         [FULL_NAME], 
                         [PASSWORD], 
                         [ACCESS]) 
            VALUES     (@user_login, 
                        @user_name, 
                        @final_pwd, 
                        @access) 
        END 
  END 

GO 
CREATE PROCEDURE SP_UPDATE_USER (@ra     CHAR(6), 
                                 @name   VARCHAR(50), 
                                 @pwd    VARCHAR(30), 
                                 @access TINYINT) 
AS 
  BEGIN 
      DECLARE @finalpwd VARCHAR(MAX) 

      SELECT @finalpwd = DBO.funcEncrypt(@pwd) 

      UPDATE [TB_USER] 
      SET    [FULL_NAME] = @name, 
             [PASSWORD] = @finalpwd, 
             [ACCESS] = @access 
      WHERE  [RA] = @ra 
  END 

GO 
CREATE PROCEDURE SP_DELETE_USER (@ra CHAR(6)) 
AS 
  BEGIN 
      DELETE FROM TB_USER 
      WHERE  RA = @ra 
  END 

GO 
CREATE PROCEDURE SP_FIND_USER (@ra CHAR(6)) 
AS 
  BEGIN 
      SELECT * 
      FROM   TB_USER 
      WHERE  [RA] = @ra 
  END 

GO 
CREATE PROCEDURE SP_SHOW_USERS 
AS 
  BEGIN 
      SELECT * 
      FROM   TB_USER 
  END 

GO 


--| CLASSROOM |-- 
CREATE PROCEDURE SP_INSERT_CLASSROOM (@amount_clasroom TINYINT) 
AS 
  BEGIN 
      DECLARE @i      TINYINT, 
              @letter TINYINT, 
              @status BIT 

      SET @i = 0 
      SET @letter = Ascii('A') 

      WHILE @i < @amount_clasroom 
        BEGIN 
            SELECT @status = dbo.checkClassroomNameExists( 
                             'INF3' + Char(@letter) + 'M' 
                             ) 

            IF @status = 0 
              BEGIN 
                  INSERT INTO TB_CLASSROOM 
                              ([NAME_CLASSROOM], 
                               [YEAR]) 
                  VALUES      ('INF3' + Char(@letter) + 'M', 
                               Getdate()) 

                  SET @i += 1; 
                  SET @letter += 1; 
              END 
            ELSE 
              BEGIN 
                  SET @i += 1; 
                  SET @letter += 1; 
              END 
        END 
  END 

GO
CREATE PROCEDURE SP_DELETE_CLASSROOM (@classroom_name CHAR(6)) 
AS 
  BEGIN 
      DECLARE @classroom_id TINYINT 

      SELECT @classroom_id = dbo.Classroomnametoclassroomid(@classroom_name) 

      DELETE FROM TB_CLASSROOM 
      WHERE  [ID_CLASSROOM] = @classroom_id 
  END 

GO
CREATE PROCEDURE SP_FIND_CLASSROOM (@classroom_id INT) 
AS 
  BEGIN 
      SELECT * 
      FROM   [TB_CLASSROOM] 
      WHERE  [ID_CLASSROOM] = @classroom_id 
  END 

GO
CREATE PROCEDURE SP_SHOW_CLASSROOMS 
AS 
  BEGIN 
      SELECT * 
      FROM   TB_CLASSROOM C 
      WHERE  Year(C.YEAR) = Year(Getdate()) 
  END 

GO

--| GROUP |-- 
CREATE PROCEDURE SP_INSERT_GROUP (@group_theme    VARCHAR(50), 
                                  @description    VARCHAR(300), 
                                  @classroom_name CHAR(6)) 
AS 
  BEGIN 
      DECLARE @classroom_id INT 

      SELECT @classroom_id = dbo.Classroomnametoclassroomid(@classroom_name) 

      IF @description IS NULL 
        BEGIN 
            INSERT INTO TB_GROUP 
                        ([GROUP_THEME], 
                         [ID_CLASSROOM]) 
            VALUES      (@group_theme, 
                         @classroom_id) 
        END 
      ELSE 
        BEGIN 
            INSERT INTO TB_GROUP 
                        ([GROUP_THEME], 
                         [GROUP_DESCRIPTION], 
                         [ID_CLASSROOM]) 
            VALUES      (@group_theme, 
                         @description, 
                         @classroom_id) 
        END 
  END 

GO 
CREATE PROCEDURE SP_UPDATE_GROUP (@group_theme    VARCHAR(50), 
                                  @classroom_name CHAR(6), 
                                  @description    VARCHAR(300) = NULL, 
                                  @new_theme      VARCHAR(50) = NULL) 
AS 
  BEGIN 
      DECLARE @group_id INT 

      SELECT @group_id = [ID_GROUP] 
      FROM   TB_GROUP 
      WHERE  [GROUP_THEME] = @group_theme 
             AND [ID_CLASSROOM] = 
                 DBO.Classroomnametoclassroomid(@classroom_name) 

      IF @description IS NULL 
         AND @new_theme IS NOT NULL 
        UPDATE [TB_GROUP] 
        SET    [GROUP_THEME] = @new_theme 
        WHERE  ID_GROUP = @group_id 
      ELSE IF @description IS NOT NULL 
         AND @new_theme IS NULL 
        UPDATE [TB_GROUP] 
        SET    [GROUP_DESCRIPTION] = @description 
        WHERE  ID_GROUP = @group_id 
      ELSE IF @description IS NOT NULL 
         AND @new_theme IS NOT NULL 
        UPDATE [TB_GROUP] 
        SET    [GROUP_THEME] = @new_theme, 
               [GROUP_DESCRIPTION] = @description 
        WHERE  ID_GROUP = @group_id 
  END 

GO 
CREATE PROCEDURE SP_DELETE_GROUP (@group_theme    VARCHAR(50), 
                                  @classroom_name CHAR(6)) 
AS 
  BEGIN 
      DELETE FROM TB_GROUP 
      WHERE  [GROUP_THEME] = @group_theme 
             AND [ID_CLASSROOM] = 
                 DBO.Classroomnametoclassroomid(@classroom_name) 
  END 

GO 
CREATE PROCEDURE SP_FIND_GROUP (@group_id INT) 
AS 
  BEGIN 
      SELECT * 
      FROM   [TB_GROUP] 
      WHERE  ID_GROUP = @group_id 
  END 

GO 
CREATE PROCEDURE SP_SHOW_GROUPS 
AS 
  BEGIN 
      SELECT G.ID_GROUP, 
             G.ID_CLASSROOM, 
             G.GROUP_THEME, 
             G.GROUP_DESCRIPTION 
      FROM   TB_GROUP G 
             INNER JOIN TB_CLASSROOM C 
                     ON G.ID_CLASSROOM = C.ID_CLASSROOM 
      WHERE  Year(C.YEAR) = Year(Getdate()) 
  END 

GO 

--| BIG_CRETERION |--  
CREATE PROCEDURE SP_INSERT_BIG_CRITERION (@ra CHAR(6)) 
AS 
  BEGIN 
      INSERT INTO [TB_BIG_CRITERION] 
                  ([RA], 
                   [YEAR]) 
      VALUES      (@ra, 
                   Getdate()) 
  END 
GO 
CREATE PROCEDURE SP_UPDATE_BIG_CRITERION (@id_big INT, 
                                          @new_ra CHAR(6)) 
AS 
  BEGIN 
      IF (SELECT [ACCESS] 
          FROM   [TB_USER] 
          WHERE  [RA] = @new_ra) != 2 
        BEGIN 
            PRINT( 'O RA DEVE PERTENCER A UM COODENADOR' ) 
        END 
      ELSE 
        UPDATE TB_BIG_CRITERION 
        SET    [RA] = @new_ra 
        WHERE  [ID_BIG] = @id_big 
  END 

GO 
CREATE PROCEDURE SP_FIND_BIG_CRITERION (@id_big INT) 
AS 
  BEGIN 
      SELECT * 
      FROM   [TB_BIG_CRITERION] 
      WHERE  [ID_BIG] = @id_big 
  END 

GO 
CREATE PROCEDURE SP_SHOW_BIG_CRITERION 
AS 
  BEGIN 
      SELECT * 
      FROM   [TB_BIG_CRITERION] 
  END 

GO 


--| MEDIUM_CRETERION |--  
CREATE PROCEDURE SP_INSERT_MEDIUM_CRITERION (@id_big      INT, 
                                             @name_medium VARCHAR(30 ), 
                                             @description VARCHAR(300) = NULL, 
                                             @value       DECIMAL(4, 2)) 
AS 
  BEGIN 
      IF @description IS NULL 
        BEGIN 
            INSERT INTO [TB_MEDIUM_CRITERION] 
                        ([ID_BIG], 
                         [NAME_MEDIUM], 
                         [TOTAL_VALUE]) 
            VALUES      (@id_big, 
                         @name_medium, 
                         @value) 
        END 
      ELSE 
        BEGIN 
            INSERT INTO [TB_MEDIUM_CRITERION] 
                        ([ID_BIG], 
                         [NAME_MEDIUM], 
                         [DESCRIPTION], 
                         [TOTAL_VALUE]) 
            VALUES      (@id_big, 
                         @name_medium, 
                         @description, 
                         @value) 
        END 
  END 

GO 
CREATE PROCEDURE SP_UPDATE_MEDIUM_CRITERION(@id_medium   INT, 
                                            @name_medium VARCHAR(30 ), 
                                            @description VARCHAR(300) = NULL, 
                                            @value       DECIMAL(4, 2)) 
AS 
  BEGIN 
      UPDATE [TB_MEDIUM_CRITERION] 
      SET    [NAME_MEDIUM] = @name_medium, 
             [DESCRIPTION] = @description, 
             [TOTAL_VALUE] = @value 
      WHERE  [ID_MEDIUM] = @id_medium 
  END 

GO 
CREATE PROCEDURE SP_DELETE_MEDIUM_CRITERION(@id_medium INT) 
AS 
  BEGIN 
      DELETE FROM [TB_MEDIUM_CRITERION] 
      WHERE  [ID_MEDIUM] = @id_medium 
  END 
GO 
CREATE PROCEDURE SP_FIND_MEDIUM_CRITERION(@id_medium INT) 
AS 
  BEGIN 
      SELECT * 
      FROM   [TB_MEDIUM_CRITERION] 
      WHERE  [ID_MEDIUM] = @id_medium 
  END 
GO 
CREATE PROCEDURE SP_SHOW_MEDIUM_CRITERION 
AS 
  BEGIN 
      SELECT MC.ID_MEDIUM, 
             MC.ID_BIG, 
             MC.NAME_MEDIUM, 
             MC.DESCRIPTION, 
             MC.TOTAL_VALUE 
      FROM   [TB_MEDIUM_CRITERION] MC 
             INNER JOIN [TB_BIG_CRITERION] BC 
                     ON MC.ID_BIG = BC.ID_BIG 
      WHERE  Year(BC.YEAR) = Year(Getdate()) 
  END 

GO 

--| MEDIUM_GRADES |--  
CREATE PROCEDURE SP_INSERT_MEDIUM_GRADE (@id_medium INT, 
                                         @ra        CHAR(6), 
                                         @id_group  INT, 
                                         @grade     DECIMAL(4, 2), 
                                         @attempt   TINYINT) 
AS 
  BEGIN 
      DECLARE @value_grade DECIMAL(4, 2), 
              @final_grade DECIMAL(4, 2) 

      SELECT @value_grade = TOTAL_VALUE 
      FROM   TB_MEDIUM_CRITERION 
      WHERE  ID_MEDIUM = @id_medium 

      SET @final_grade = @grade * ( @value_grade / 10 ) 

      INSERT INTO [TB_MEDIUM_GRADE] 
                  ([ID_MEDIUM], 
                   [RA], 
                   [ID_GROUP], 
                   [GRADE], 
                   [ATTEMPT]) 
      VALUES      (@id_medium, 
                   @ra, 
                   @id_group, 
                   @final_grade, 
                   @attempt) 
  END 

GO 
CREATE PROCEDURE SP_FIND_MEDIUM_GRADE(@id_medium_grade INT) 
AS 
  BEGIN 
      SELECT * 
      FROM   TB_MEDIUM_GRADE 
      WHERE  ID_MEDIUM = @id_medium_grade 
  END 

GO 
CREATE PROCEDURE SP_SHOW_MEDIUM_GRADE 
AS 
  BEGIN 
      SELECT MG.ID_MEDIUM_GRADE, 
             MG.ID_MEDIUM, 
             MG.ID_GROUP, 
             MG.RA, 
             MG.GRADE, 
             MG.ATTEMPT 
      FROM   TB_MEDIUM_GRADE MG 
             INNER JOIN TB_MEDIUM_CRITERION MC 
                     ON MG.ID_MEDIUM = MC.ID_MEDIUM 
             INNER JOIN TB_BIG_CRITERION BC 
                     ON MC.ID_BIG = BC.ID_BIG 
      WHERE  Year(BC.YEAR) = Year(Getdate()) 
  END 

GO 

/*-------------SP_INSERTS-------------*/
GO
-- USER --
EXEC SP_INSERT_USER '854950', 'SAIU ESCOLA', 'SENHA123', 4; 
EXEC SP_INSERT_USER '000000', 'TEC', 'PASSWORD', 1;
EXEC SP_INSERT_USER '123456', 'MARCELLO LALLO', 'SENHA123', 2;
EXEC SP_INSERT_USER '654321', 'GUSMÃO', 'SENHA321', 3;
EXEC SP_INSERT_USER '246810', 'LEANDRO CRUZ', 'SENHA248', 4;
GO

/*---SP_INSERT_CLASSROOM---*/
EXEC SP_INSERT_CLASSROOM 9;
GO

/*-----SP_INSERT_GROUP-----*/
EXEC SP_INSERT_GROUP 'Churras Carnes', NULL,'INF3AM';
EXEC SP_INSERT_GROUP 'Asessoria Carros', NULL,'INF3BM';
EXEC SP_INSERT_GROUP 'Disco Store', 'Será um projeto basico para vender discos','INF3CM';
EXEC SP_INSERT_GROUP 'GEPETO', 'O projeto terá como objetivo avaliar TCCs','INF3DM';
EXEC SP_INSERT_GROUP 'CORASSAUM', NULL,'INF3EM';
EXEC SP_INSERT_GROUP 'Locadora de Roupas Cerimoniais', NULL,'INF3EM';
EXEC SP_INSERT_GROUP 'Loja de Açaí', 'Uma loja que vende açaí bem gostoso pra você','INF3DM';
GO

/*SP_INSERT_BIG_CRITERION*/
EXEC SP_INSERT_BIG_CRITERION '123456'
GO

/*SP_INSERT_MEDIUM_CRITERION*/
EXEC SP_INSERT_MEDIUM_CRITERION 1, 'Mobile', @VALUE = 2
EXEC SP_INSERT_MEDIUM_CRITERION 1, 'WEB', NULL, 4
EXEC SP_INSERT_MEDIUM_CRITERION 1, 'Desktop', 'Já tem WEB pra não ter que ter desktop, mas né?!', 4
GO
/*SP_INSERT_MEDIUM_GRADE*/
EXEC SP_INSERT_MEDIUM_GRADE 1, '246810', 2, 10, 1
GO

/*-------------SP_UPDATES-------------*/
/*-------SP_UPDATE_USER------*/
EXEC SP_UPDATE_USER '123456', 'MARCELLO LALLO LY', 'EU TE AMO', 2
GO 
EXEC SP_UPDATE_USER '854950', 'SAIU ESCOLA', 'EU TAMBÉM', 0
GO

/*-------SP_DELETE_USER-----*/
EXEC SP_DELETE_USER '654321'
GO
/*-------------SP_FIND-------------*/
EXEC SP_FIND_USER '246810'
GO
/*-------------INSERTS-------------*/
INSERT INTO TB_CLASSROOM (NAME_CLASSROOM, YEAR) VALUES ('INF3XM', '2019')
INSERT INTO TB_GROUP (GROUP_THEME, ID_CLASSROOM) VALUES ('Test', 10)
GO

SELECT * FROM TB_USER;
SELECT * FROM TB_CLASSROOM;
SELECT * FROM TB_GROUP;
SELECT * FROM TB_BIG_CRITERION;
SELECT * FROM TB_MEDIUM_CRITERION;
SELECT * FROM TB_MEDIUM_GRADE
EXEC SP_UPDATE_GROUP  'Churras Carnes', 'INF3AM', 'Uma churrascaria bem bacana', 'ChurrasquinhoS'
EXEC SP_UPDATE_GROUP  'Disco Store', 'INF3CM', NULL, 'Loja de Disco'


