USE [WIXI]
GO
/****** Object:  Table [dbo].[authority_level]    Script Date: 7/1/2019 12:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[authority_level](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [date] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [date] NULL,
	[IsActive] [bit] NULL,
	[IsDelete] [bit] NULL,
 CONSTRAINT [PK_authority_level] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Actions]    Script Date: 7/1/2019 12:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Actions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[created_by] [int] NOT NULL,
	[created_date] [datetime] NOT NULL,
	[updated_by] [int] NULL,
	[updated_date] [datetime] NULL,
	[is_active] [bit] NOT NULL,
	[is_delete] [bit] NOT NULL,
 CONSTRAINT [PK_tbl_Actions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ModuleActions]    Script Date: 7/1/2019 12:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ModuleActions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[module_id] [int] NOT NULL,
	[action_id] [int] NOT NULL,
	[created_by] [int] NOT NULL,
	[created_date] [datetime] NOT NULL,
	[updated_by] [int] NULL,
	[updated_date] [datetime] NULL,
	[is_active] [bit] NOT NULL,
	[is_delete] [bit] NOT NULL,
 CONSTRAINT [PK_tbl_ModuleActions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Modules]    Script Date: 7/1/2019 12:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Modules](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[created_by] [int] NOT NULL,
	[created_date] [datetime] NOT NULL,
	[updated_by] [int] NULL,
	[updated_date] [datetime] NULL,
	[is_active] [bit] NOT NULL,
	[is_delete] [bit] NOT NULL,
 CONSTRAINT [PK_tbl_Modules] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_RoleModuleAction]    Script Date: 7/1/2019 12:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_RoleModuleAction](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userrole_id] [int] NOT NULL,
	[moduleaction_id] [int] NOT NULL,
	[created_by] [int] NOT NULL,
	[created_date] [datetime] NOT NULL,
	[updated_by] [int] NULL,
	[updated_date] [datetime] NULL,
	[is_active] [bit] NOT NULL,
	[is_delete] [bit] NOT NULL,
 CONSTRAINT [PK_tbl_RoleModuleAction] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_UserRoles]    Script Date: 7/1/2019 12:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_UserRoles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NULL,
	[created_date] [datetime] NOT NULL,
	[updated_date] [datetime] NOT NULL,
	[is_delete] [bit] NOT NULL,
 CONSTRAINT [PK_tbl_UserRoles] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_action_selectAll]    Script Date: 7/1/2019 12:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_action_selectAll] 
	
AS
BEGIN
	SELECT * 
FROM [dbo].[tbl_Actions]
WHERE is_delete='False';     

END
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckRole]    Script Date: 7/1/2019 12:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CheckRole]
@userrole_id INT,
@Permissionname VARCHAR(100)
AS
BEGIN
	SELECT a.name AS ActionName
	FROM tbl_RoleModuleAction rma
	INNER JOIN tbl_ModuleActions ma ON rma.moduleaction_id = ma.id
	INNER JOIN tbl_Actions a ON ma.action_id = a.id
	INNER JOIN tbl_Modules m ON ma.module_id= m.id
	WHERE userrole_id = @userrole_id AND 
	a.name = @Permissionname;
		     
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getpermissionforedit]    Script Date: 7/1/2019 12:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getpermissionforedit]
@userrole_id INT 
AS
BEGIN
	SELECT rma.userrole_id,ma.module_id,ma.action_id 
	FROM tbl_RoleModuleAction rma
	INNER JOIN tbl_ModuleActions ma ON rma.moduleaction_id = ma.id
	WHERE userrole_id =@userrole_id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_module_selectAll]    Script Date: 7/1/2019 12:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_module_selectAll] 
	
AS
BEGIN
	SELECT * FROM [dbo].[tbl_Modules] WHERE is_delete='False'; 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_moduleaction_Delete]    Script Date: 7/1/2019 12:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_moduleaction_Delete]
@roleid INT
AS
BEGIN
	DELETE tbl_ModuleActions  FROM tbl_ModuleActions
	INNER JOIN tbl_RoleModuleAction ON tbl_ModuleActions.id = tbl_RoleModuleAction.moduleaction_id 
	WHERE tbl_RoleModuleAction.userrole_id = @roleid;

	DELETE  FROM tbl_RoleModuleAction
	WHERE userrole_id = @roleid;

END
GO
/****** Object:  StoredProcedure [dbo].[sp_moduleAction_Insert]    Script Date: 7/1/2019 12:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_moduleAction_Insert]
@moduleid INT,
@actionid INT,
@userid INT,
@roleid INT
As
Declare @id_val int
BEGIN
			 INSERT INTO tbl_ModuleActions(module_id,action_id,created_by,created_date,is_active,is_delete)
			VALUES(@moduleid,@actionid,@userid,GETDATE(),'True','False');
		
	SET @id_val=(SELECT id  FROM tbl_ModuleActions WHERE id = @@Identity);
			INSERT INTO tbl_RoleModuleAction(userrole_id,moduleaction_id,created_by,created_date,is_active,is_delete)
			VALUES(@roleid,@id_val,@userid,GETDATE(),'True','False');

END
GO
/****** Object:  StoredProcedure [dbo].[sp_role_Delete]    Script Date: 7/1/2019 12:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_role_Delete]
@RoleID INT
As
BEGIN
	UPDATE authority_level SET IsDelete = 'True' WHERE RoleID = @RoleID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_role_Insert]    Script Date: 7/1/2019 12:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_role_Insert]
@Role_name VARCHAR(100),
@UserID INT
--@RoleLevel VARCHAR(100),
--@RoleDescription VARCHAR(100)
As
Declare @id_val int
BEGIN

IF NOT EXISTS(SELECT 1 FROM authority_level WHERE RoleName=@Role_name AND IsDelete='False')
	BEGIN
		INSERT INTO authority_level(RoleName,CreatedBy,CreatedDate,IsActive,IsDelete)
		VALUES(@Role_name,@UserID,GETDATE(),'True','False');

		SELECT RoleID AS roleid FROM authority_level WHERE RoleID = @@Identity;
		
     END
ELSE 
	BEGIN
		SELECT -1 AS roleid;
	END 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_role_Upadet]    Script Date: 7/1/2019 12:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_role_Upadet]
@Role_name VARCHAR(100),
@UserID INT,
@RoleID  INT
AS
BEGIN
IF NOT EXISTS(SELECT 1 FROM authority_level WHERE RoleName=@Role_name AND RoleID <> @RoleID AND IsDelete='False')
	BEGIN
		  UPDATE authority_level SET RoleName=@Role_name,UpdatedBy=@UserID WHERE RoleID=@RoleID ;
    --UPDATE user_access SET user_id=d_UserID,
			 --  role_id=d_RoleID,
			 --  role_level=d_RoleLevel,
			 --  access=d_RoleLevel
			 --  WHERE role_id=d_RoleID ;
		SELECT  @RoleID AS roleid;
	END
ELSE 
	BEGIN
		SELECT -1 AS roleid;
	END
END 
  
GO
/****** Object:  StoredProcedure [dbo].[sp_roleList_selectAll]    Script Date: 7/1/2019 12:49:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_roleList_selectAll] 
@userrole_id int=0
AS
BEGIN
	SELECT al.RoleID,al.RoleName
	FROM authority_level as al
	WHERE al.IsDelete='False'
END
GO
