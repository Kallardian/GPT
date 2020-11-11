-- ALTER DATABASE GEPETO SET SINGLE_USER WITH ROLLBACK IMMEDIATE


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
  -- 0 Inativo, 1 Coordenação, 2 Coordenador Curso, 3 Projetos, 4 Avaliador
); 
GO
CREATE TABLE [TB_CLASSROOM]
(
  [ID_CLASSROOM] INT PRIMARY KEY IDENTITY,
  [NAME_CLASSROOM] CHAR(6) NOT NULL,
  [YEAR] CHAR(4) NOT NULL
); 
GO
CREATE TABLE [TB_GROUP]
(
  [ID_GROUP] INT PRIMARY KEY IDENTITY,
  [GROUP_THEME] VARCHAR(50) NOT NULL,
  [GROUP_DESCRIPTION] VARCHAR(300) NOT NULL,
  [ID_CLASSROOM] INT NOT NULL,
  CONSTRAINT [ID_CLASSROOM_FK_0] 
		FOREIGN KEY ([ID_CLASSROOM]) 
		REFERENCES [TB_CLASSROOM]([ID_CLASSROOM]),
  [RA] CHAR(6) NOT NULL,
  CONSTRAINT [RA_FK_0] 
		FOREIGN KEY (RA) 
		REFERENCES [TB_USER]([RA])
);
GO
CREATE TABLE [TB_BIG_CRITERION]
(
  [ID_BIG] INT PRIMARY KEY IDENTITY,
  [YEAR] CHAR(4) NOT NULL
);
GO
CREATE TABLE [TB_MEDIUM_CRITERION]
(
  [ID_MEDIUM] INT PRIMARY KEY IDENTITY,
  [ID_BIG] INT NOT NULL,
  CONSTRAINT [ID_BIG_FK_0] 
		FOREIGN KEY ([ID_BIG]) 
		REFERENCES [TB_BIG_CRITERION]([ID_BIG]),
  [RA] CHAR(6) NOT NULL,
  CONSTRAINT [RA_FK_1] 
  
		FOREIGN KEY (RA) 
		REFERENCES [TB_USER]([RA]),
  [NAME_MEDIUM] VARCHAR(30) NOT NULL,
  [DESCRIPTION] VARCHAR(100) NULL,
  -- QUICK NOTES
  [TOTAL_VALUE] DECIMAL(4,2)
); 
GO

CREATE TABLE [TB_MEDIUM_GRADE]
(
  [ID_MEDIUM_GRADE] INT PRIMARY KEY IDENTITY,
  [RA] CHAR(6) NOT NULL,
  CONSTRAINT [RA_FK_2]
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
  FROM [TB_USER]
  WHERE  [RA] = @ra) 
        SET @status = 1 
      ELSE 
        SET @status = 0

  RETURN @status
END -- 0 == inactive or 0 == does not exist  

GO

CREATE FUNCTION Checklogin(@ra  CHAR(6), 
                           @pwd VARCHAR(20)) 
returns TINYINT 
  BEGIN
  DECLARE @access_level TINYINT, 
              @pwdHash      VARCHAR(max)

  SET @pwdHash = dbo.FuncEncrypt(@pwd)

  IF EXISTS (SELECT *
  FROM [TB_USER]
  WHERE  [RA] = @ra
    AND [PASSWORD] = @pwdHash) 
        SELECT @access_level = ACCESS
  FROM [TB_USER]
  WHERE  RA = @ra; 
      ELSE 
        SET @access_level = 0;

  RETURN @access_level
END 

GO


CREATE FUNCTION Checkclassroomnameexists(@classroom_name CHAR(6)) 
returns BIT 
  BEGIN
  DECLARE @status BIT

  IF EXISTS (SELECT *
  FROM [TB_CLASSROOM]
  WHERE  [NAME_CLASSROOM] = @classroom_name
    AND [YEAR] = Year(Getdate())) 
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
  FROM [TB_CLASSROOM]
  WHERE  [YEAR] = Year(Getdate())

  RETURN @total_classroom
END 

GO

CREATE FUNCTION Classroomnametoclassroomid(@classroom_name CHAR(6)) 
returns INT 
  BEGIN
  DECLARE @classroom_id INT

  SELECT @classroom_id = [ID_CLASSROOM]
  FROM [TB_CLASSROOM]
  WHERE  [NAME_CLASSROOM] = @classroom_name
    AND [YEAR] = Year(Getdate());

  RETURN @classroom_id
END 

GO

CREATE FUNCTION GroupThemeToGroupId(@group_theme VARCHAR(50)) 
returns INT 
  BEGIN
  DECLARE @group_id INT

  SELECT @group_id = G.[ID_GROUP]
  FROM [TB_GROUP] G
    INNER JOIN [TB_CLASSROOM] C
    ON G.[ID_CLASSROOM] = C.[ID_CLASSROOM]
  WHERE  C.YEAR = Year(Getdate())
    AND [GROUP_THEME] = @group_theme

  RETURN @group_id
END 
GO

/*--------------------------------| STORED PROCEDURES |--------------------------------------*/
--| USER |--
CREATE PROCEDURE  SP_UPDATE_PASSWORD_USER(@ra CHAR(6),
  @pwd CHAR(20))
AS
BEGIN
  DECLARE @finalpwd VARCHAR(MAX)
  SELECT @finalpwd = DBO.funcEncrypt(@pwd)

  UPDATE TB_USER
  SET PASSWORD = @finalpwd
  WHERE RA = @ra
END
GO
CREATE PROCEDURE SP_LOGIN_USER(@RA  CHAR(6),
  @pwd VARCHAR(20))
AS
BEGIN
  SELECT DBO.Checklogin(@ra, @pwd)
END
GO


--| GROUP |-- 
CREATE PROCEDURE SP_GROUP_USED(@group_id INT)
AS
BEGIN
  IF EXISTS(SELECT *
  FROM TB_MEDIUM_GRADE
  WHERE  ID_GROUP = @group_id)
    BEGIN
    SELECT 1
  END
    ELSE 
      BEGIN
    SELECT 0
  END
END
GO
CREATE PROCEDURE SP_LAST_GROUP
AS
BEGIN
  SELECT *
  FROM TB_GROUP
  WHERE  ID_GROUP = (SELECT MAX(ID_GROUP)
  FROM TB_GROUP)
END
GO
CREATE PROCEDURE SP_AMOUNT_GROUPS_CLASSROOM(@id_classroom INT)
AS
BEGIN
  SELECT COUNT(*)
  FROM TB_GROUP
  WHERE  ID_CLASSROOM = @id_classroom
END
GO
CREATE PROCEDURE SP_BIGGEST_ATTEMPT
  (@id_group INT)
AS
BEGIN
  SELECT MAX(ATTEMPT)
  FROM TB_MEDIUM_GRADE
  WHERE  ID_GROUP = @id_group
END
GO


--| MEDIUM_CRETERION |--  
CREATE PROCEDURE SP_CRITERION_USED(@criterion_id INT)
AS
BEGIN
  IF EXISTS(SELECT *
  FROM TB_MEDIUM_GRADE
  WHERE  ID_MEDIUM = @criterion_id)
       BEGIN
    SELECT 1
  END
    ELSE
    BEGIN
    SELECT 0
  END
END
GO


--| MEDIUM_GRADES |-- 
CREATE PROCEDURE SP_SHOW_FINAL_GRADE_GROUP(@group_id INT)
AS
BEGIN
  DECLARE @max_attempt TINYINT
  SELECT @max_attempt =
         MAX(ATTEMPT)
  FROM TB_MEDIUM_GRADE
  WHERE ID_GROUP = @group_id


  SELECT *
  FROM TB_MEDIUM_GRADE
  WHERE  ID_GROUP = @group_id
    AND ATTEMPT = @max_attempt
END 
GO
CREATE VIEW aView
AS
  SELECT MC.ID_MEDIUM,
    ROW_NUMBER() OVER(ORDER BY MC.ID_MEDIUM) ROWNUMBER
  FROM [TB_MEDIUM_CRITERION] MC
    INNER JOIN [TB_BIG_CRITERION] BC
    ON         MC.ID_BIG = BC.ID_BIG
  WHERE  BC.YEAR = Year(Getdate())

GO
CREATE PROCEDURE SP_SHOW_MEDIUM_GRADE_GROUP(@group_id INT)
AS
BEGIN
  DECLARE  @max_attempt TINYINT,
           @amount_medium INT,
           @id_medium INT,
           @i INT;

  CREATE TABLE #temp
  (
    NAME_MEDIUM VARCHAR(30) PRIMARY  KEY,
    GRADE DECIMAL (4,2)
  );

  SELECT @max_attempt =
         MAX(ATTEMPT)
  FROM TB_MEDIUM_GRADE
  WHERE ID_GROUP = @group_id;

  SELECT @amount_medium = COUNT(MC.ID_MEDIUM)
  FROM [TB_MEDIUM_CRITERION] MC
    INNER JOIN [TB_BIG_CRITERION] BC
    ON         MC.ID_BIG = BC.ID_BIG
  WHERE  BC.YEAR = Year(Getdate());

  SET @i = 1;

  WHILE @i <= @amount_medium
    BEGIN


    SELECT @id_medium = 
            ID_MEDIUM
    FROM aView
    WHERE   ROWNUMBER = @i;

    INSERT INTO #temp
      (NAME_MEDIUM, GRADE)
    SELECT MC.NAME_MEDIUM, SUM(MG.GRADE) / COUNT(MG.RA) as GRADE
    FROM TB_MEDIUM_GRADE MG
      INNER JOIN TB_MEDIUM_CRITERION MC
      ON MG.ID_MEDIUM = MC.ID_MEDIUM
    WHERE MG.ID_GROUP = @group_id
      AND MG.ID_MEDIUM = @id_medium
      AND MG.ATTEMPT = @max_attempt
    GROUP BY MC.NAME_MEDIUM;

    SET @i = @i + 1;
  END
  SELECT *
  FROM #temp
END
GO


--| USER |-- 
CREATE PROCEDURE SP_INSERT_USER
  (@user_login CHAR(6),
  @user_name  VARCHAR(50),
  @user_pwd   VARCHAR(30),
  @access     TINYINT)
AS
BEGIN
  IF(@access = 0) 
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
    VALUES
      (@user_login,
        @user_name,
        @final_pwd,
        @access)
    SELECT *
    FROM TB_USER
    WHERE  RA = @user_login
  END
  COMMIT
END

GO
CREATE PROCEDURE SP_UPDATE_USER
  (@ra     CHAR(6),
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
  COMMIT
END

GO
CREATE PROCEDURE SP_FIND_USER
  (@ra CHAR(6))
AS
BEGIN
  SELECT *
  FROM TB_USER
  WHERE  [RA] = @ra
END 
 
GO
CREATE PROCEDURE SP_SHOW_USERS
AS
BEGIN
  SELECT *
  FROM TB_USER
  WHERE ACCESS != 1
  ORDER BY ACCESS DESC
END
GO


--| CLASSROOM |-- 
CREATE PROCEDURE SP_INSERT_CLASSROOM
  (@amount_classroom TINYINT)
AS
BEGIN
  DECLARE @i      TINYINT, 
              @letter TINYINT, 
              @status BIT
  CREATE TABLE #temptable
  (
    ID_CLASSROOM INT,
    NAME_CLASSROOM CHAR(6),
    YEAR CHAR(4)
  );

  SET @i = 0
  SET @letter = Ascii('A')

  WHILE @i < @amount_classroom 
        BEGIN
    SELECT @status = dbo.checkClassroomNameExists( 
                             'INF3' + Char(@letter) + 'M' 
                             )

    IF @status = 0 
              BEGIN
      DECLARE @id_classroom_temp_table INT

      INSERT INTO TB_CLASSROOM
        ([NAME_CLASSROOM],
        [YEAR])
      VALUES
        ('INF3' + Char(@letter) + 'M',
          YEAR(Getdate()))

      SELECT @id_classroom_temp_table = ID_CLASSROOM
      FROM TB_CLASSROOM
      WHERE  NAME_CLASSROOM = 'INF3' + Char(@letter) + 'M'
        AND YEAR = YEAR(GETDATE())

      INSERT INTO #temptable
        (ID_CLASSROOM,
        NAME_CLASSROOM,
        [YEAR])
      VALUES
        (@id_classroom_temp_table,
          'INF3' + Char(@letter) + 'M',
          YEAR(GETDATE()))
      SET @i += 1;
      SET @letter += 1;
    END 
            ELSE 
              BEGIN
      SET @i += 1;
      SET @letter += 1;
    END
  END
  SELECT *
  FROM #temptable
  COMMIT
END 
GO

CREATE PROCEDURE SP_DELETE_CLASSROOM
  (@classroom_id INT)
AS
BEGIN
  IF EXISTS(SELECT *
  FROM TB_GROUP
  WHERE   ID_CLASSROOM = @classroom_id)
      BEGIN
    PRINT('TU NÃO PODE APAGAR ESSA SALA')
  END
    ELSE
      BEGIN
    DELETE FROM TB_CLASSROOM 
       WHERE  [ID_CLASSROOM] = @classroom_id
  END
  COMMIT
END 

GO
CREATE PROCEDURE SP_FIND_CLASSROOM
  (@classroom_id INT)
AS
BEGIN
  SELECT *
  FROM [TB_CLASSROOM]
  WHERE  [ID_CLASSROOM] = @classroom_id
END 

GO
CREATE PROCEDURE SP_SHOW_CLASSROOMS
AS
BEGIN
  SELECT *
  FROM TB_CLASSROOM C
  WHERE  C.YEAR = Year(Getdate())
END 

GO

--| GROUP |-- 
CREATE PROCEDURE SP_INSERT_GROUP
  (@group_theme   VARCHAR(50),
  @description    VARCHAR(300),
  @classroom_id   INT,
  @ra             CHAR(6))
AS
BEGIN
  INSERT INTO TB_GROUP
    ([GROUP_THEME],
    [GROUP_DESCRIPTION],
    [ID_CLASSROOM],
    [RA])
  VALUES
    (@group_theme,
      @description,
      @classroom_id,
      @ra)
  COMMIT
END 

GO
CREATE PROCEDURE SP_UPDATE_GROUP
  (@group_id       INT,
  @classroom_id   INT,
  @description    VARCHAR(300) = NULL,
  @new_theme      VARCHAR(50) = NULL)
AS
BEGIN
  IF  @description IS NULL
    AND @new_theme   IS NOT NULL 
        BEGIN
    UPDATE [TB_GROUP] 
          SET    [GROUP_THEME] = @new_theme 
          WHERE  ID_GROUP = @group_id
  END
      ELSE IF @description IS NOT NULL
    AND @new_theme   IS NULL
        BEGIN
    UPDATE [TB_GROUP] 
          SET    [GROUP_DESCRIPTION] = @description 
          WHERE  ID_GROUP = @group_id
  END

      ELSE IF @description IS NOT NULL
    AND @new_theme   IS NOT NULL
        BEGIN
    UPDATE [TB_GROUP] 
          SET    [GROUP_THEME] = @new_theme, 
                 [GROUP_DESCRIPTION] = @description 
          WHERE  ID_GROUP = @group_id
  END
  SELECT *
  FROM TB_GROUP
  WHERE  ID_GROUP = @group_id
  COMMIT
END 

GO
CREATE PROCEDURE SP_DELETE_GROUP
  (@group_id    INT)
AS
BEGIN
  IF EXISTS (SELECT *
  FROM TB_MEDIUM_GRADE
  WHERE   ID_GROUP = @group_id)
      BEGIN
    SELECT 'VOCÊ NÃO PODE DELETAR ESSE GRUPO'
  END
  SELECT *
  FROM TB_GROUP
  WHERE ID_GROUP = @group_id

  DELETE FROM TB_GROUP 
    WHERE  ID_GROUP = @group_id
  COMMIT
END 

GO
CREATE PROCEDURE SP_FIND_GROUP
  (@group_id INT)
AS
BEGIN
  SELECT *
  FROM [TB_GROUP]
  WHERE  ID_GROUP = @group_id
END 

GO
CREATE PROCEDURE SP_SHOW_GROUPS
  (@classroom_id INT)
AS
BEGIN
  SELECT G.ID_GROUP,
    G.ID_CLASSROOM,
    G.GROUP_THEME,
    G.GROUP_DESCRIPTION,
    G.RA
  FROM TB_GROUP G
    INNER JOIN TB_CLASSROOM C
    ON G.ID_CLASSROOM = C.ID_CLASSROOM
  WHERE  Year(C.YEAR) = Year(Getdate())
    AND C.ID_CLASSROOM = @classroom_id
END 
GO

--| BIG_CRETERION |--  
CREATE PROCEDURE SP_INSERT_BIG_CRITERION
AS
BEGIN
  IF EXISTS(SELECT *
  FROM TB_BIG_CRITERION
  WHERE  YEAR = YEAR(GETDATE()))
      BEGIN
    PRINT('VOCÊ NÃO PODE INSERIR ISSO AQUI')
  END
    ELSE
      BEGIN
    INSERT INTO [TB_BIG_CRITERION]
      ([YEAR])
    VALUES
      (YEAR(Getdate()))
  END
  COMMIT
END 
GO
CREATE PROCEDURE SP_FIND_BIG_CRITERION
  (@id_big INT)
AS
BEGIN
  SELECT *
  FROM [TB_BIG_CRITERION]
  WHERE  [ID_BIG] = @id_big
END 

GO
CREATE PROCEDURE SP_SHOW_BIG_CRITERION
AS
BEGIN
  SELECT *
  FROM [TB_BIG_CRITERION]
END 

GO


--| MEDIUM_CRETERION |--  
CREATE PROCEDURE SP_INSERT_MEDIUM_CRITERION
  (@id_big      INT,
  @name_medium VARCHAR(30),
  @ra          CHAR(6),
  @description VARCHAR(300),
  @value       DECIMAL(4, 2))
AS
BEGIN
  DECLARE @id_medium INT

  INSERT INTO [TB_MEDIUM_CRITERION]
    ([ID_BIG],
    [RA],
    [NAME_MEDIUM],
    [DESCRIPTION],
    [TOTAL_VALUE])
  VALUES
    (@id_big,
      @ra,
      @name_medium,
      @description,
      @value)

  SELECT @id_medium =
                ID_MEDIUM
  FROM TB_MEDIUM_CRITERION
  WHERE       ID_BIG = @id_big
    AND NAME_MEDIUM = @name_medium

  SELECT *
  FROM TB_MEDIUM_CRITERION
  WHERE  ID_MEDIUM = @id_medium
  COMMIT
END 

GO
CREATE PROCEDURE SP_UPDATE_MEDIUM_CRITERION(@id_medium   INT,
  @name_medium VARCHAR(30 ),
  @description VARCHAR(300) = NULL,
  @value       DECIMAL(4, 2))
AS
BEGIN
  IF EXISTS (SELECT *
  FROM TB_MEDIUM_GRADE
  WHERE  ID_MEDIUM = @id_medium
               )
        BEGIN
    PRINT('VOCÊ NÃO PODE ALTERAR ESSE CRITÉRIO')
  END
      ELSE
      BEGIN
    UPDATE [TB_MEDIUM_CRITERION] 
        SET    [NAME_MEDIUM] = @name_medium, 
              [DESCRIPTION] = @description, 
              [TOTAL_VALUE] = @value 
        WHERE  [ID_MEDIUM] = @id_medium

    SELECT *
    FROM TB_MEDIUM_CRITERION
    WHERE  ID_MEDIUM = @id_medium
  END
  COMMIT
END 

GO
CREATE PROCEDURE SP_DELETE_MEDIUM_CRITERION(@id_medium INT)
AS
BEGIN
  IF EXISTS (SELECT *
  FROM TB_MEDIUM_GRADE
  WHERE  ID_MEDIUM = @id_medium
               )
        BEGIN
    PRINT('VOCÊ NÃO PODE DELETAR ESSE CRITÉRIO')
  END
      ELSE 
        BEGIN
    SELECT *
    FROM TB_MEDIUM_CRITERION
    WHERE  ID_MEDIUM = @id_medium
    DELETE FROM [TB_MEDIUM_CRITERION] 
          WHERE  [ID_MEDIUM] = @id_medium
  END

  COMMIT
END 
GO
CREATE PROCEDURE SP_FIND_MEDIUM_CRITERION(@id_medium INT)
AS
BEGIN
  SELECT *
  FROM [TB_MEDIUM_CRITERION]
  WHERE  [ID_MEDIUM] = @id_medium
END 
GO
CREATE PROCEDURE SP_SHOW_MEDIUM_CRITERION
AS
BEGIN
  SELECT MC.ID_MEDIUM,
    MC.ID_BIG,
    MC.RA,
    MC.NAME_MEDIUM,
    MC.DESCRIPTION,
    MC.TOTAL_VALUE
  FROM [TB_MEDIUM_CRITERION] MC
    INNER JOIN [TB_BIG_CRITERION] BC
    ON         MC.ID_BIG = BC.ID_BIG
  WHERE  BC.YEAR = Year(Getdate())
END 

GO
--| MEDIUM_GRADES |--  
CREATE PROCEDURE SP_INSERT_MEDIUM_GRADE
  (@id_medium INT,
  @ra        CHAR(6),
  @id_group  INT,
  @grade     DECIMAL(4, 2),
  @attempt   TINYINT)
AS
BEGIN
  DECLARE @value_grade DECIMAL(4, 2), 
              @final_grade DECIMAL(4, 2)

  SELECT @value_grade = TOTAL_VALUE
  FROM TB_MEDIUM_CRITERION
  WHERE  ID_MEDIUM = @id_medium

  SET @final_grade = @grade * ( @value_grade / 10 )

  INSERT INTO [TB_MEDIUM_GRADE]
    ([ID_MEDIUM],
    [RA],
    [ID_GROUP],
    [GRADE],
    [ATTEMPT])
  VALUES
    (@id_medium,
      @ra,
      @id_group,
      @final_grade,
      @attempt)
  COMMIT
END 

GO
CREATE PROCEDURE SP_FIND_MEDIUM_GRADE(@id_medium_grade INT)
AS
BEGIN
  SELECT *
  FROM TB_MEDIUM_GRADE
  WHERE  ID_MEDIUM_GRADE = @id_medium_grade
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
  FROM TB_MEDIUM_GRADE MG
    INNER JOIN TB_MEDIUM_CRITERION MC
    ON MG.ID_MEDIUM = MC.ID_MEDIUM
    INNER JOIN TB_BIG_CRITERION BC
    ON MC.ID_BIG = BC.ID_BIG
  WHERE  BC.YEAR = Year(Getdate())
END 
GO













