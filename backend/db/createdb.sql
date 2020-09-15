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
CREATE TABLE [TB_STUDENT]
(
	[RM] CHAR(6) PRIMARY KEY,
	[FULL_NAME] VARCHAR(50) NOT NULL,
	[GRADUATE_TCC] TINYINT DEFAULT 0
);
GO
CREATE TABLE [TB_GROUP_STUDENT]
(
	[ID_GROUP_STUDENT] INT PRIMARY KEY IDENTITY,
	[RM] CHAR(6) NOT NULL,
	CONSTRAINT [RM_FK_0] 
		FOREIGN KEY ([RM]) 
		REFERENCES TB_STUDENT([RM]),
	[ID_GROUP] INT NOT NULL,
	CONSTRAINT [ID_GROUP_FK_0] 
		FOREIGN KEY ([ID_GROUP]) 
		REFERENCES [TB_GROUP]([ID_GROUP])
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
	[TOTAL_VALUE] DECIMAL
);
GO
CREATE TABLE [TB_SMALL_CRITERION]
(
	[ID_SMALL] INT PRIMARY KEY IDENTITY,
	[ID_MEDIUM] INT NOT NULL,
	CONSTRAINT [ID_MEDIUM_FK_0] 
		FOREIGN KEY ([ID_MEDIUM]) 
		REFERENCES [TB_MEDIUM_CRITERION]([ID_MEDIUM]),
	[NAME_SMALL] VARCHAR(30) NOT NULL
);
GO
CREATE TABLE [TB_SMALL_GRADES]
(
	[ID_SMALL_GRADE] INT PRIMARY KEY IDENTITY,
	[RA] CHAR(6) NOT NULL,
	CONSTRAINT [RA_FK_1]
		FOREIGN KEY ([RA])
		REFERENCES [TB_USER]([RA]),
	[ID_SMALL] INT NOT NULL,
	CONSTRAINT [ID_SMALL_FK_0]
		FOREIGN KEY ([ID_SMALL])
		REFERENCES [TB_SMALL_CRITERION]([ID_SMALL]),
	[ID_GROUP] INT NOT NULL,
	CONSTRAINT [ID_GROUP_FK_1] 
		FOREIGN KEY ([ID_GROUP]) 
		REFERENCES [TB_GROUP]([ID_GROUP]),
	[GRADE] DECIMAL NOT NULL
);
GO
CREATE TABLE [TB_FINAL_GRADES]
(
	[ID_FINAL_GRADES] INT PRIMARY KEY IDENTITY,
	[ID_MEDIUM] INT NOT NULL,
	CONSTRAINT [ID_MEDIUM_FK_1] 
		FOREIGN KEY ([ID_MEDIUM]) 
		REFERENCES [TB_MEDIUM_CRITERION]([ID_MEDIUM]),
	[ID_GROUP] INT NOT NULL,
	CONSTRAINT [ID_GROUP_FK_2] 
		FOREIGN KEY ([ID_GROUP]) 
		REFERENCES [TB_GROUP]([ID_GROUP]),
	[GRADE] DECIMAL NOT NULL
)

GO
/*----------------------------------SYSTEM FUNCTIONS------------------------------------*/

--TODO function for amount of groups/classroom

CREATE FUNCTION Funcencrypt(@pwd1 VARCHAR(30)) 
returns VARCHAR(max) 
  BEGIN 
      DECLARE @pwd2 VARBINARY(100) 

      SET @pwd2 = CONVERT(VARBINARY(100), @pwd1, 0) 
      SET @pwd2 = Hashbytes('md4', @pwd2) 

      RETURN CONVERT(VARCHAR(max), @pwd2, 1) 
  END 
go 
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
go 
CREATE FUNCTION Checklogin(@RA  CHAR(6), 
                           @pwd VARCHAR(20)) 
returns TINYINT 
  BEGIN 
      DECLARE @access_level TINYINT, 
              @pwdHash      VARCHAR(max) 

      SET @pwdHash = dbo.FuncEncrypt(@pwd) 

      IF EXISTS (SELECT * 
                 FROM   tb_user 
                 WHERE  [ra] = @RA 
                        AND [password] = @pwdHash) 
		SELECT @access_level = access 
        FROM   tb_user 
        WHERE  ra = @RA; 
      ELSE 
        SET @access_level = 0; 

      RETURN @access_level 
  END 
go 
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
go 
CREATE FUNCTION Checkstudentexists(@rm CHAR(6))
returns CHAR(4)
	BEGIN
		DECLARE @insertionDate char(4)

		IF EXISTS (SELECT * 
				   FROM [TB_GROUP_STUDENT] 
				   WHERE [RM] = @rm)
			SELECT @insertionDate = MIN(YEAR(C.YEAR)) 
			FROM TB_STUDENT S 
				INNER JOIN TB_GROUP_STUDENT GS 
					ON S.RM = GS.RM 
				INNER JOIN TB_GROUP G
					ON G.ID_GROUP = GS.ID_GROUP
				INNER JOIN TB_CLASSROOM C
					ON C.ID_CLASSROOM = G.ID_CLASSROOM
			WHERE GS.RM = @rm
		ELSE
			SET @insertionDate = '0'

		RETURN @insertionDate
	END  --Returns the insertion date, or 0
GO
CREATE FUNCTION Returnamountofclassrooms()
returns TINYINT
	BEGIN
		DECLARE @total_classroom TINYINT

		SELECT @total_classroom = COUNT(*) 
		FROM [TB_CLASSROOM] 
		WHERE YEAR([YEAR]) = YEAR(GETDATE())

		RETURN @total_classroom
	END
GO
CREATE FUNCTION Classroomnametoclassroomid(@classroom_name CHAR(6))
returns INT
	BEGIN
		DECLARE  @classroom_id INT
		SELECT @classroom_id = [ID_CLASSROOM] FROM [TB_CLASSROOM]
		WHERE [NAME_CLASSROOM] = @classroom_name 
			AND YEAR([YEAR]) = YEAR(GETDATE());

		RETURN @classroom_id
	END
GO
CREATE FUNCTION groupThemeToGroupId(@group_theme VARCHAR(50))
RETURNS INT
BEGIN
	DECLARE
		@group_id INT
	SELECT @group_id = G.[ID_GROUP] 
	FROM [TB_GROUP] G INNER JOIN [TB_CLASSROOM] C 
			ON G.[ID_CLASSROOM] = C.[ID_CLASSROOM]
	WHERE YEAR(C.YEAR) = YEAR(GETDATE()) AND [GROUP_THEME] = @group_theme
	RETURN @group_id
END
GO
/*--------------------------------| STORED PROCEDURES |--------------------------------------*/

--| USER |--
CREATE PROCEDURE SP_INSERT_USER 
(
	@user_login char(6),
	@user_name varchar(50),
	@user_pwd varchar(30),
	@access tinyint
)
AS
	BEGIN
		IF(@access = 0)
			PRINT 'Você não pode adicionar um usuário inativo'
		ELSE
			BEGIN
				DECLARE
				@final_pwd VARCHAR(MAX)
				SET @final_pwd = dbo.funcEncrypt(@user_pwd)
				INSERT INTO [TB_USER] ([RA], [FULL_NAME], [PASSWORD], [ACCESS])
				VALUES(@user_login, @user_name, @final_pwd, @access)
			END
	END
GO
CREATE PROCEDURE SP_UPDATE_USER
(
	@ra char(6),
	@name varchar(50),
	@pwd VARCHAR(30),
	@access tinyint
)
AS
	BEGIN
		DECLARE 
		@finalpwd VARCHAR(MAX)
		SELECT @finalpwd = DBO.funcEncrypt(@pwd)
		UPDATE [TB_USER] SET [FULL_NAME] = @name, [PASSWORD] = @finalpwd,
		[ACCESS] = @access WHERE [RA] = @ra
	END
GO
CREATE PROCEDURE SP_DELETE_USER
(
	@ra CHAR(6)
)
AS
	BEGIN
		DELETE FROM TB_USER WHERE RA = @ra
	END
GO
CREATE PROCEDURE SP_FIND_USER
(
	@ra CHAR(6)
)
AS
	BEGIN
		SELECT * FROM TB_USER WHERE [RA] = @ra
	END
GO
CREATE PROCEDURE SP_SHOW_USERS
AS
BEGIN
	SELECT * FROM TB_USER
END
GO

--| CLASSROOM |--
CREATE PROCEDURE SP_INSERT_CLASSROOM
(
	@amount_clasroom TINYINT
)
AS
BEGIN
	DECLARE 
		@i TINYINT,
		@letter TINYINT,
		@status BIT
	SET @i = 0
	SET @letter = Ascii('A')
	WHILE @i < @amount_clasroom
	BEGIN
	SELECT @status = dbo.checkClassroomNameExists('INF3' + CHAR(@letter) + 'M')
	IF @status = 0
		BEGIN
			INSERT INTO TB_CLASSROOM ([NAME_CLASSROOM], [YEAR])
			VALUES ('INF3' + CHAR(@letter) + 'M', GETDATE())
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
CREATE PROCEDURE SP_DELETE_CLASSROOM
(
	@classroom_name char(6)
)
AS
	BEGIN
		DECLARE
		@classroom_id tinyint
		SELECT @classroom_id =  dbo.Classroomnametoclassroomid(@classroom_name)
		DELETE FROM TB_CLASSROOM WHERE [ID_CLASSROOM] = @classroom_id
	END
GO
CREATE PROCEDURE SP_FIND_CLASSROOM
(
	@classroom_id INT
)
AS
BEGIN
	SELECT * FROM [TB_CLASSROOM] WHERE [ID_CLASSROOM] = @classroom_id
END
GO
CREATE PROCEDURE SP_SHOW_CLASSROOMS
AS
BEGIN
	SELECT * FROM TB_CLASSROOM
END
GO

--| GROUP |--
CREATE PROCEDURE SP_INSERT_GROUP
(
	@group_theme VARCHAR(50),
	@description VARCHAR(300),
	@classroom_name CHAR(6)
)
AS
	BEGIN
		DECLARE
		@classroom_id int
		SELECT @classroom_id =  dbo.Classroomnametoclassroomid(@classroom_name)
		IF @description IS NULL
			BEGIN
				INSERT INTO TB_GROUP ([GROUP_THEME], [ID_CLASSROOM])
				VALUES (@group_theme, @classroom_id)

			END
		ELSE
			BEGIN
				INSERT INTO TB_GROUP ([GROUP_THEME], [GROUP_DESCRIPTION], [ID_CLASSROOM])
				VALUES (@group_theme, @description, @classroom_id)
			END
	END
GO
CREATE PROCEDURE SP_UPDATE_GROUP
(
	@group_theme VARCHAR(50),
	@classroom_name CHAR(6),
	@description VARCHAR(300) = NULL,
	@new_theme VARCHAR(50) = NULL
)
AS
BEGIN
	DECLARE
		@group_id INT
	SELECT @group_id = [ID_GROUP] FROM TB_GROUP
		WHERE [GROUP_THEME] = @group_theme 
		AND [ID_CLASSROOM] = DBO.Classroomnametoclassroomid(@classroom_name)

	IF @description IS NULL AND @new_theme IS NOT NULL
		UPDATE [TB_GROUP] 
			SET [GROUP_THEME] = @new_theme 
				WHERE ID_GROUP = @group_id
	ELSE IF @description IS NOT NULL AND @new_theme IS NULL
		UPDATE [TB_GROUP] 
			SET [GROUP_DESCRIPTION] = @description
				WHERE ID_GROUP = @group_id
	ELSE IF @description IS NOT NULL AND @new_theme IS NOT NULL
		UPDATE [TB_GROUP] 
			SET [GROUP_THEME] = @new_theme, 
				[GROUP_DESCRIPTION] = @description
				WHERE ID_GROUP = @group_id
END
GO
CREATE PROCEDURE SP_DELETE_GROUP
(
	@group_theme VARCHAR(50),
	@classroom_name CHAR(6)
)
AS
BEGIN
	DELETE FROM TB_GROUP 
		WHERE [GROUP_THEME] = @group_theme 
		AND [ID_CLASSROOM] = DBO.Classroomnametoclassroomid(@classroom_name)
END
GO
CREATE PROCEDURE SP_FIND_GROUP
(
	@group_id INT
)
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
	SELECT * FROM TB_GROUP
END
GO

--| STUDENT |--
CREATE PROCEDURE SP_INSERT_STUDENT
(
	@student_rm CHAR(6),
	@student_name VARCHAR(50),
	@class_name CHAR(6)
)
AS
  BEGIN 
      INSERT INTO [TB_STUDENT] 
                  ([RM], 
                   [FULL_NAME]) 
      VALUES     (@student_rm, 
                  @student_name) 
  END 
GO
CREATE PROCEDURE Sp_update_student 
(@rm        CHAR(6), 
@full_name VARCHAR(50) = NULL, 
@graduate  TINYINT = NULL) 
AS 
  BEGIN 
      IF @full_name IS NOT NULL 
         AND @graduate IS NULL 
        UPDATE [TB_STUDENT] 
        SET    [FULL_NAME] = @full_name 
        WHERE  [RM] = @rm 
      ELSE IF @full_name IS NULL 
         AND @graduate IS NOT NULL 
        UPDATE [TB_STUDENT] 
        SET    [GRADUATE_TCC] = @graduate 
        WHERE  [RM] = @rm 
      ELSE 
        PRINT 'Nenhuma alteração foi feita' 
  END 
GO
CREATE PROCEDURE Sp_delete_student
(@rm CHAR(6)) 
AS 
  BEGIN 
      IF EXISTS (SELECT * 
                 FROM   [TB_GROUP_STUDENT] 
                 WHERE  [RM] = @rm) 
        DELETE FROM [TB_GROUP_STUDENT] 
        WHERE  [RM] = @rm 

      DELETE FROM TB_STUDENT 
      WHERE  [RM] = @rm 
  END 
GO
CREATE PROCEDURE SP_FIND_STUDENT (@rm CHAR(6)) 
AS 
  BEGIN 
      SELECT * 
      FROM   [TB_STUDENT] 
      WHERE  [RM] = @rm 
  END 

GO 
CREATE PROCEDURE SP_SHOW_STUDENTS 
AS 
  BEGIN 
      SELECT * 
      FROM   TB_STUDENT 
  END 

GO 

--| GROUP_STUDENT |-- 
CREATE PROCEDURE SP_INSERT_GROUP_STUDENT (@rm CHAR(6),@group_id INT) 
AS 
  BEGIN 
      INSERT INTO [TB_GROUP_STUDENT] 
                  ([RM],[ID_GROUP]) 
      VALUES      (@rm,@group_id) 
  END 

GO 
CREATE PROCEDURE SP_UPDATE_GROUP_STUDENT (@rm CHAR(6),@new_group_theme VARCHAR( 
50)) 
AS 
  BEGIN 
      UPDATE TB_GROUP_STUDENT 
      SET    [ID_GROUP] = DBO.groupThemeToGroupId(@new_group_theme) 
      WHERE  [RM] = @rm 
  END 

GO 
CREATE PROCEDURE SP_DELETE_GROUP_STUDENT (@rm CHAR(6)) 
AS 
  BEGIN 
      DELETE FROM [TB_GROUP_STUDENT] 
      WHERE  [RM] = @rm 
  END 

GO 
CREATE PROCEDURE SP_FIND_GROUP_STUDENT (@rm CHAR(6)) 
AS 
  BEGIN 
      SELECT * 
      FROM   [TB_GROUP_STUDENT] 
      WHERE  [RM] = @rm 
  END 

GO 
CREATE PROCEDURE SP_SHOW_GROUPS_STUDENTS 
AS 
  BEGIN 
      SELECT * 
      FROM   [TB_GROUP_STUDENT] 
  END 

GO 

--| BIG_CRETERION |-- 
CREATE PROCEDURE SP_INSERT_BIG_CRITERION (@ra CHAR(6)) 
AS 
  BEGIN 
      INSERT INTO [TB_BIG_CRITERION] 
                  ([RA],[YEAR]) 
      VALUES      (@ra,Getdate()) 
  END 

GO 

--| MEDIUM_CRETERION |-- 
CREATE PROCEDURE SP_INSERT_MEDIUM_CRITERION (@id_big INT,@name_medium VARCHAR(30 
),@description VARCHAR(300) = NULL,@value DECIMAL) 
AS 
  BEGIN 
      IF @description IS NULL 
        BEGIN 
            INSERT INTO [TB_MEDIUM_CRITERION] 
                        ([ID_BIG],[NAME_MEDIUM],[TOTAL_VALUE]) 
            VALUES      (@id_big,@name_medium,@value) 
        END 
      ELSE 
        BEGIN 
            INSERT INTO [TB_MEDIUM_CRITERION] 
                        ([ID_BIG],[NAME_MEDIUM],[DESCRIPTION],[TOTAL_VALUE]) 
            VALUES      (@id_big,@name_medium,@description,@value) 
        END 
  END 

GO 

--| SMALL_CRETERION |-- 
CREATE PROCEDURE SP_INSERT_SMALL_CRITERION (@id_medium INT,@name_small VARCHAR( 
30)) 
AS 
  BEGIN 
      INSERT INTO [TB_SMALL_CRITERION] 
                  ([ID_MEDIUM],[NAME_SMALL]) 
      VALUES      (@id_medium,@name_small) 
  END 

GO 

CREATE PROCEDURE SP_STUDENTS_PER_CLASSROOM 
-- This could be a function that returns a table 
AS 
  BEGIN 
      SELECT C.ID_CLASSROOM,Count(S.RM) 
      FROM   TB_CLASSROOM C 
             INNER JOIN TB_GROUP G 
                     ON C.ID_CLASSROOM = G.ID_CLASSROOM 
             INNER JOIN TB_GROUP_STUDENT GS 
                     ON G.ID_GROUP = GS.ID_GROUP 
             INNER JOIN TB_STUDENT S 
                     ON GS.RM = S.RM 
      WHERE  Year(C.YEAR) = Year(Getdate()) 
      GROUP  BY C.ID_CLASSROOM 
  END 
GO 
/*-------------SP_INSERTS-------------*/
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

/*---SP_INSERT_STUDENT---*/
EXEC SP_INSERT_STUDENT  '64244', 'Paulo Bertanha','INF3DM'; 
EXEC SP_INSERT_STUDENT  '64245', 'MARIA ISABELA','INF3DM';
EXEC SP_INSERT_STUDENT  '64246', 'LUIS SANTANA','INF3DM';
EXEC SP_INSERT_STUDENT  '64247', 'JULLIA AVELAR','INF3DM';
EXEC SP_INSERT_STUDENT  '64248', 'GUSTAVO PEIXE','INF3AM';
EXEC SP_INSERT_STUDENT  '64249', 'CARLOS ABERTO','INF3BM';
GO

/*SP_INSERT_GROUP_STUDENT*/
EXEC SP_INSERT_GROUP_STUDENT '64244', 4;
EXEC SP_INSERT_GROUP_STUDENT '64245', 4;
EXEC SP_INSERT_GROUP_STUDENT '64246', 4;
EXEC SP_INSERT_GROUP_STUDENT '64247', 4;
EXEC SP_INSERT_GROUP_STUDENT '64248', 3;
EXEC SP_INSERT_GROUP_STUDENT '64249', 3;
GO

/*SP_INSERT_BIG_CRITERION*/
EXEC SP_INSERT_BIG_CRITERION '123456'
GO

/*SP_INSERT_MEDIUM_CRITERION*/
EXEC SP_INSERT_MEDIUM_CRITERION 1, 'Mobile', @VALUE = 2
EXEC SP_INSERT_MEDIUM_CRITERION 1, 'WEB', NULL, 4
EXEC SP_INSERT_MEDIUM_CRITERION 1, 'Desktop', 'Já tem WEB pra não ter que ter desktop, mas né?!', 4
GO

/*SP_INSERT_SMALL_CRITERION*/
EXEC SP_INSERT_SMALL_CRITERION 1, 'Conexão com o Banco', '4'
EXEC SP_INSERT_SMALL_CRITERION 1, 'UX', '4'
EXEC SP_INSERT_SMALL_CRITERION 1, 'Beleza', '2'
EXEC SP_INSERT_SMALL_CRITERION 2, 'Conexão com o Banco', '5'
EXEC SP_INSERT_SMALL_CRITERION 2, 'Responsividade', '5'
EXEC SP_INSERT_SMALL_CRITERION 3, 'Eficiência', '10'
/*---SP_STUDENTS_PER_CLASSROOM---*/
EXEC SP_STUDENTS_PER_CLASSROOM

GO
/*-------------SP_UPDATES-------------*/
/*-------SP_UPDATE_USER------*/
EXEC SP_UPDATE_USER '123456', 'MARCELLO LALLO LY', 'EU TE AMO', 2
GO 
EXEC SP_UPDATE_USER '854950', 'SAIU ESCOLA', 'EU TAMBÉM', 0
GO

/*-------SP_DELETE_USER-----*/
EXEC SP_DELETE_USER '654321'

/*-------------SP_FIND-------------*/
EXEC SP_FIND_USER '246810'

/*-------------INSERTS-------------*/
INSERT INTO TB_STUDENT VALUES ('111111', 'ANTIGO', 0)
INSERT INTO TB_CLASSROOM (NAME_CLASSROOM, YEAR) VALUES ('INF3XM', '2019')
INSERT INTO TB_GROUP (GROUP_THEME, ID_CLASSROOM) VALUES ('Test', 10)
EXEC SP_INSERT_GROUP_STUDENT '111111', 8;
GO

SELECT DBO.checkStudentExists('111111')
SELECT * FROM TB_USER;
SELECT * FROM TB_CLASSROOM;
SELECT * FROM TB_GROUP;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_GROUP_STUDENT;
SELECT * FROM TB_BIG_CRITERION;
SELECT * FROM TB_MEDIUM_CRITERION;
SELECT * FROM TB_SMALL_CRITERION

EXEC SP_UPDATE_GROUP  'Churras Carnes', 'INF3AM', 'Uma churrascaria bem bacana', 'ChurrasquinhoS'
EXEC SP_UPDATE_GROUP  'Disco Store', 'INF3CM', NULL, 'Loja de Disco'
