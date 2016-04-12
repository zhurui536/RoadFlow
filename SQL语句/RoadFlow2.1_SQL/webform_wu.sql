create database RoadFlow
go
use RoadFlow
go
/*
Sysobjects：SQL-SERVER的每个数据库内都有此系统表，它存放该数据库内创建的所有对象，如约束、默认值、日志、规则、存储过程等，每个对象在表中占一行。
以下是此系统表的字段名称和相关说明。 
Name，id，xtype，uid，status：分别是对象名，对象ID，对象类型，所有者对象的用户ID,对象状态。 
对象类型(xtype)。可以是下列对象类型中的一种： 
C = CHECK 约束 D = 默认值或 DEFAULT 约束 F = FOREIGN KEY 约束L = 日志FN = 标量函数 IF = 内嵌表函数 P = 存储过程 PK = PRIMARY KEY 约束（类型是 K） 
RF = 复制筛选存储过程S = 系统表TF = 表函数 TR = 触发器U = 用户表UQ = UNIQUE 约束（类型是 K）V = 视图X = 扩展存储过程 
当xtype='U' and status>0代表是用户建立的表，对象名就是表名，对象ID就是表的ID值。 
用: select * from misa.dbo.sysobjects where xtype='U' and status>0 就可以列出库misa中所有的用户建立的表名。 
列出表cs的所有属性,上面是trigger!
*/


--##################################################################################################################
--如果存在，则删除这5个CONSTRAINT
--TempTest_PurchaseList:DF_TempTest_PurchaseList_ID
--TempTest_News:		DF_TempTest_News_State
--TempTest:				DF_TempTest_WriteTime
--TempTest:				DF_TempTest_DeptID
--Log:					DF_Log_WriteTime
--（视图->系统视图—>sys.sysobjects）
--##################################################################################################################
--1
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TempTest_PurchaseList_ID]') AND type = 'D')
BEGIN
ALTER TABLE [TempTest_PurchaseList] DROP CONSTRAINT [DF_TempTest_PurchaseList_ID]
END
/*对应最下面 DF_TempTest_PurchaseList_ID
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TempTest_PurchaseList_ID]') AND type = 'D')
BEGIN
ALTER TABLE [TempTest_PurchaseList] ADD  CONSTRAINT [DF_TempTest_PurchaseList_ID]  DEFAULT (newid()) FOR [ID]
END
*/
GO--2
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TempTest_News_State]') AND type = 'D')
BEGIN
ALTER TABLE [TempTest_News] DROP CONSTRAINT [DF_TempTest_News_State]
END
GO--3
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TempTest_WriteTime]') AND type = 'D')
BEGIN
ALTER TABLE [TempTest] DROP CONSTRAINT [DF_TempTest_WriteTime]
END
GO--4
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TempTest_DeptID]') AND type = 'D')
BEGIN
ALTER TABLE [TempTest] DROP CONSTRAINT [DF_TempTest_DeptID]
END
GO--5
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Log_WriteTime]') AND type = 'D')
BEGIN
ALTER TABLE [Log] DROP CONSTRAINT [DF_Log_WriteTime]
END
/*“可编程性”-》“函数”-》“系统函数”-》“元数据函数”，就能找到object_id和OBJECTPROPERTY*/


--##################################################################################################################
--如果存在，则删除这些表（视图->系统视图—>sys.objects）
--##################################################################################################################
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WorkGroup]') AND type in (N'U'))
DROP TABLE [WorkGroup]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WorkFlowTask]') AND type in (N'U'))
DROP TABLE [WorkFlowTask]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WorkFlowForm]') AND type in (N'U'))
DROP TABLE [WorkFlowForm]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WorkFlowDelegation]') AND type in (N'U'))
DROP TABLE [WorkFlowDelegation]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WorkFlowComment]') AND type in (N'U'))
DROP TABLE [WorkFlowComment]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WorkFlowButtons]') AND type in (N'U'))
DROP TABLE [WorkFlowButtons]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WorkFlowArchives]') AND type in (N'U'))
DROP TABLE [WorkFlowArchives]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WorkFlow]') AND type in (N'U'))
DROP TABLE [WorkFlow]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[UsersRole]') AND type in (N'U'))
DROP TABLE [UsersRole]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[UsersRelation]') AND type in (N'U'))
DROP TABLE [UsersRelation]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[UsersInfo]') AND type in (N'U'))
DROP TABLE [UsersInfo]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[UsersApp]') AND type in (N'U'))
DROP TABLE [UsersApp]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Users]') AND type in (N'U'))
DROP TABLE [Users]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[TempTest_WorkOrder]') AND type in (N'U'))
DROP TABLE [TempTest_WorkOrder]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[TempTest_PurchaseList]') AND type in (N'U'))
DROP TABLE [TempTest_PurchaseList]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[TempTest_Purchase]') AND type in (N'U'))
DROP TABLE [TempTest_Purchase]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[TempTest_News]') AND type in (N'U'))
DROP TABLE [TempTest_News]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[TempTest_CustomForm]') AND type in (N'U'))
DROP TABLE [TempTest_CustomForm]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[TempTest]') AND type in (N'U'))
DROP TABLE [TempTest]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RoleApp]') AND type in (N'U'))
DROP TABLE [RoleApp]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Role]') AND type in (N'U'))
DROP TABLE [Role]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Organize]') AND type in (N'U'))
DROP TABLE [Organize]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Log]') AND type in (N'U'))
DROP TABLE [Log]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Dictionary]') AND type in (N'U'))
DROP TABLE [Dictionary]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBConnection]') AND type in (N'U'))
DROP TABLE [DBConnection]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[AppLibrary]') AND type in (N'U'))
DROP TABLE [AppLibrary]
GO



--##################################################################################################################
--如果不存在，则新建这些表
--##################################################################################################################
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[AppLibrary]') AND type in (N'U'))
BEGIN
CREATE TABLE [AppLibrary](
	[ID] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[Type] [uniqueidentifier] NOT NULL,
	[OpenMode] [int] NOT NULL,
	[Width] [int] NULL,
	[Height] [int] NULL,
	[Params] [varchar](max) NULL,
	[Manager] [varchar](max) NULL,
	[Note] [varchar](max) NULL,
	[Code] [varchar](50) NULL,
	[UseMember] [varchar](max) NULL,
 CONSTRAINT [PK_AppLibrary] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBConnection]') AND type in (N'U'))
BEGIN
CREATE TABLE [DBConnection](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[Type] [varchar](500) NOT NULL,
	[ConnectionString] [varchar](max) NOT NULL,
	[Note] [varchar](max) NULL,
 CONSTRAINT [PK_DBConnection] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Dictionary]') AND type in (N'U'))
BEGIN
CREATE TABLE [Dictionary](
	[ID] [uniqueidentifier] NOT NULL,
	[ParentID] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[Code] [varchar](500) NULL,
	[Value] [varchar](max) NULL,
	[Note] [varchar](max) NULL,
	[Other] [varchar](max) NULL,
	[Sort] [int] NOT NULL,
 CONSTRAINT [PK_Dictionary] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Log]') AND type in (N'U'))
BEGIN
CREATE TABLE [Log](
	[ID] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[WriteTime] [datetime] NOT NULL,
	[UserID] [uniqueidentifier] NULL,
	[UserName] [nvarchar](50) NULL,
	[IPAddress] [varchar](50) NULL,
	[URL] [varchar](max) NULL,
	[Contents] [varchar](max) NULL,
	[Others] [varchar](max) NULL,
	[OldXml] [varchar](max) NULL,
	[NewXml] [varchar](max) NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Organize]') AND type in (N'U'))
BEGIN
CREATE TABLE [Organize](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [varchar](2000) NOT NULL,
	[Number] [varchar](900) NOT NULL,
	[Type] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[ParentID] [uniqueidentifier] NOT NULL,
	[Sort] [int] NOT NULL,
	[Depth] [int] NOT NULL,
	[ChildsLength] [int] NOT NULL,
	[ChargeLeader] [varchar](200) NULL,
	[Leader] [varchar](200) NULL,
	[Note] [nvarchar](max) NULL,
 CONSTRAINT [PK_Organize] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Role]') AND type in (N'U'))
BEGIN
CREATE TABLE [Role](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[UseMember] [varchar](max) NULL,
	[Note] [nvarchar](max) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[RoleApp]') AND type in (N'U'))
BEGIN
CREATE TABLE [RoleApp](
	[ID] [uniqueidentifier] NOT NULL,
	[ParentID] [uniqueidentifier] NOT NULL,
	[RoleID] [uniqueidentifier] NOT NULL,
	[AppID] [uniqueidentifier] NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Params] [varchar](max) NULL,
	[Sort] [int] NOT NULL,
	[Ico] [varchar](200) NULL,
	[Type] [int] NOT NULL,
 CONSTRAINT [PK_RoleApp] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------

------##########################################################################################################################################################
------##########################################################################################################################################################-----------------------------------------------------------------------------------------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[TempTest]') AND type in (N'U'))
BEGIN
CREATE TABLE [TempTest](
	[ID] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](500) NULL,
	[UserID] [varchar](50) NULL,
	[UserID_text] [nvarchar](50) NULL,
	[DeptID] [varchar](50) NULL,
	[DeptName] [nvarchar](500) NULL,
	[Date1] [datetime] NULL,
	[Date2] [datetime] NULL,
	[Type] [varchar](500) NULL,
	[Reason] [nvarchar](max) NULL,
	[WriteTime] [datetime] NULL,
	[Days] [float] NULL,
	[test] [varchar](5000) NULL,
	[test1] [varchar](5000) NULL,
	[test2] [varchar](5000) NULL,
	[test2_text] [varchar](5000) NULL,
	[flowcompleted] [int] NULL,
 CONSTRAINT [PK_TempTest] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
------##########################################################################################################################################################
------##########################################################################################################################################################-----------------------------------------------------------------------------------------------------------------------------------------------------




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[TempTest_CustomForm]') AND type in (N'U'))
BEGIN
CREATE TABLE [TempTest_CustomForm](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](500) NOT NULL,
	[Contents] [nvarchar](4000) NOT NULL,
	[Type] [varchar](50) NULL,
	[FlowCompleted] [int] NULL,
	[wdate] [datetime] NULL,
 CONSTRAINT [PK_TempTest_CustomForm] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[TempTest_News]') AND type in (N'U'))
BEGIN
CREATE TABLE [TempTest_News](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](500) NOT NULL,
	[Title1] [nvarchar](50) NULL,
	[UserID] [varchar](50) NULL,
	[Type] [varchar](500) NULL,
	[Contents] [text] NULL,
	[State] [int] NOT NULL,
 CONSTRAINT [PK_TempTest_News] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[TempTest_Purchase]') AND type in (N'U'))
BEGIN
CREATE TABLE [TempTest_Purchase](
	[ID] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](500) NULL,
	[UserID] [varchar](50) NULL,
	[UserDept] [varchar](50) NULL,
	[SqDateTime] [varchar](50) NULL,
	[TypeOther] [nvarchar](500) NULL,
	[Note] [nvarchar](500) NULL,
	[IsCompleted] [int] NULL,
 CONSTRAINT [PK_TempTest_Purchase] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[TempTest_PurchaseList]') AND type in (N'U'))
BEGIN
CREATE TABLE [TempTest_PurchaseList](
	[ID] [uniqueidentifier] NOT NULL,
	[PurchaseID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](500) NULL,
	[Model] [varchar](50) NULL,
	[Unit] [varchar](50) NULL,
	[Quantity] [int] NULL,
	[Sum1] [decimal](18, 2) NULL,
	[Date] [datetime] NULL,
	[Type] [varchar](5000) NULL,
	[Note] [nvarchar](500) NULL,
 CONSTRAINT [PK_TempTest_PurchaseList] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[TempTest_WorkOrder]') AND type in (N'U'))
BEGIN
CREATE TABLE [TempTest_WorkOrder](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Client_Number] [varchar](50) NULL,
	[Client_Name] [varchar](50) NULL,
	[Client_Phone] [varchar](50) NULL,
	[Client_Tel] [varchar](50) NULL,
	[Client_Company] [varchar](500) NULL,
	[Client_CarNumber] [varchar](50) NULL,
	[Client_CarJH] [varchar](50) NULL,
	[Disp_Number] [varchar](50) NULL,
	[Disp_Urgency] [varchar](50) NULL,
	[Disp_SubmitUser] [varchar](50) NULL,
	[Disp_HelpModel] [varchar](50) NULL,
	[Disp_SelectModel] [varchar](50) NULL,
	[Disp_Jdd] [varchar](50) NULL,
	[Disp_Time] [datetime] NULL,
	[Disp_Bc] [varchar](50) NULL,
	[Disp_Engineer] [varchar](50) NULL,
	[Disp_EngineerPhone] [varchar](50) NULL,
	[Disp_CarNumber] [varchar](50) NULL,
	[Disp_Type] [varchar](50) NULL,
	[Disp_BussType] [varchar](50) NULL,
	[Disp_Completed] [varchar](50) NULL,
	[Disp_Address] [varchar](500) NULL,
 CONSTRAINT [PK_TempTest_WorkOrder] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Users]') AND type in (N'U'))
BEGIN
CREATE TABLE [Users](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Account] [varchar](255) NOT NULL,
	[Password] [varchar](500) NOT NULL,
	[Status] [int] NOT NULL,
	[Sort] [int] NOT NULL,
	[Note] [nvarchar](max) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[UsersApp]') AND type in (N'U'))
BEGIN
CREATE TABLE [UsersApp](
	[ID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[ParentID] [uniqueidentifier] NOT NULL,
	[RoleID] [uniqueidentifier] NOT NULL,
	[AppID] [uniqueidentifier] NULL,
	[Title] [nvarchar](200) NULL,
	[Params] [varchar](500) NULL,
	[Ico] [varchar](500) NULL,
	[Sort] [int] NOT NULL,
 CONSTRAINT [PK_UsersApp] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[UsersInfo]') AND type in (N'U'))
BEGIN
CREATE TABLE [UsersInfo](
	[UserID] [uniqueidentifier] NOT NULL,
	[Tel] [varchar](500) NULL,
	[Phone] [varchar](500) NULL,
	[OtherTel] [varchar](500) NULL,
	[Fax] [varchar](500) NULL,
	[Address] [varchar](500) NULL,
	[Email] [varchar](50) NULL,
	[QQ] [varchar](50) NULL,
	[Note] [nvarchar](max) NULL,
 CONSTRAINT [PK_UsersInfo] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[UsersRelation]') AND type in (N'U'))
BEGIN
CREATE TABLE [UsersRelation](
	[UserID] [uniqueidentifier] NOT NULL,
	[OrganizeID] [uniqueidentifier] NOT NULL,
	[IsMain] [int] NOT NULL,
	[Sort] [int] NOT NULL,
 CONSTRAINT [PK_UsersRelation] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[OrganizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[UsersRole]') AND type in (N'U'))
BEGIN
CREATE TABLE [UsersRole](
	[MemberID] [uniqueidentifier] NOT NULL,
	[RoleID] [uniqueidentifier] NOT NULL,
	[IsDefault] [bit] NOT NULL,
 CONSTRAINT [PK_UsersRole] PRIMARY KEY CLUSTERED 
(
	[MemberID] ASC,
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WorkFlow]') AND type in (N'U'))
BEGIN
CREATE TABLE [WorkFlow](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[Type] [uniqueidentifier] NOT NULL,
	[Manager] [varchar](5000) NOT NULL,
	[InstanceManager] [varchar](5000) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[DesignJSON] [varchar](max) NULL,
	[InstallDate] [datetime] NULL,
	[InstallUserID] [uniqueidentifier] NULL,
	[RunJSON] [varchar](max) NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_WorkFlow_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WorkFlowArchives]') AND type in (N'U'))
BEGIN
CREATE TABLE [WorkFlowArchives](
	[ID] [uniqueidentifier] NOT NULL,
	[FlowID] [uniqueidentifier] NOT NULL,
	[StepID] [uniqueidentifier] NOT NULL,
	[FlowName] [nvarchar](500) NOT NULL,
	[StepName] [nvarchar](500) NOT NULL,
	[TaskID] [uniqueidentifier] NOT NULL,
	[GroupID] [uniqueidentifier] NOT NULL,
	[InstanceID] [varchar](500) NOT NULL,
	[Title] [nvarchar](4000) NOT NULL,
	[Contents] [text] NOT NULL,
	[Comments] [text] NOT NULL,
	[WriteTime] [datetime] NOT NULL,
 CONSTRAINT [PK_WorkFlowArchives] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WorkFlowButtons]') AND type in (N'U'))
BEGIN
CREATE TABLE [WorkFlowButtons](
	[ID] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](500) NOT NULL,
	[Ico] [varchar](500) NULL,
	[Script] [varchar](max) NULL,
	[Note] [varchar](max) NULL,
	[Sort] [int] NOT NULL,
 CONSTRAINT [PK_WorkFlowButtons] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WorkFlowComment]') AND type in (N'U'))
BEGIN
CREATE TABLE [WorkFlowComment](
	[ID] [uniqueidentifier] NOT NULL,
	[MemberID] [varchar](max) NOT NULL,
	[Comment] [nvarchar](500) NOT NULL,
	[Type] [int] NOT NULL,
	[Sort] [int] NOT NULL,
 CONSTRAINT [PK_WorkFlowComment] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WorkFlowDelegation]') AND type in (N'U'))
BEGIN
CREATE TABLE [WorkFlowDelegation](
	[ID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[FlowID] [uniqueidentifier] NULL,
	[ToUserID] [uniqueidentifier] NOT NULL,
	[WriteTime] [datetime] NOT NULL,
	[Note] [nvarchar](4000) NULL,
 CONSTRAINT [PK_WorkFlowDelegate] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WorkFlowForm]') AND type in (N'U'))
BEGIN
CREATE TABLE [WorkFlowForm](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[Type] [uniqueidentifier] NOT NULL,
	[CreateUserID] [uniqueidentifier] NOT NULL,
	[CreateUserName] [nvarchar](50) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[LastModifyTime] [datetime] NOT NULL,
	[Html] [text] NULL,
	[SubTableJson] [text] NULL,
	[EventsJson] [text] NULL,
	[Attribute] [varchar](max) NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_WorkFlowForm] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WorkFlowTask]') AND type in (N'U'))
BEGIN
CREATE TABLE [WorkFlowTask](
	[ID] [uniqueidentifier] NOT NULL,
	[PrevID] [uniqueidentifier] NOT NULL,
	[PrevStepID] [uniqueidentifier] NOT NULL,
	[FlowID] [uniqueidentifier] NOT NULL,
	[StepID] [uniqueidentifier] NOT NULL,
	[StepName] [nvarchar](500) NOT NULL,
	[InstanceID] [varchar](50) NOT NULL,
	[GroupID] [uniqueidentifier] NOT NULL,
	[Type] [int] NOT NULL,
	[Title] [nvarchar](2000) NOT NULL,
	[SenderID] [uniqueidentifier] NOT NULL,
	[SenderName] [nvarchar](50) NOT NULL,
	[SenderTime] [datetime] NOT NULL,
	[ReceiveID] [uniqueidentifier] NOT NULL,
	[ReceiveName] [nvarchar](50) NOT NULL,
	[ReceiveTime] [datetime] NOT NULL,
	[OpenTime] [datetime] NULL,
	[CompletedTime] [datetime] NULL,
	[CompletedTime1] [datetime] NULL,
	[Comment] [varchar](max) NULL,
	[IsSign] [int] NULL,
	[Status] [int] NOT NULL,
	[Note] [nvarchar](max) NULL,
	[Sort] [int] NOT NULL,
	[SubFlowGroupID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_WorkFlowTask] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WorkGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [WorkGroup](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[Members] [varchar](max) NOT NULL,
	[Note] [nvarchar](max) NULL,
 CONSTRAINT [PK_WorkGroup] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO





--##################################################################################################################
--在这些表中插入数据
--##################################################################################################################

INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'8cff8e9f-f539-41c9-80ce-06a97f481390', N'日志查询', N'Platform/Log/Default.aspx', N'94decd1d-8c60-4c85-8f00-e740c1d4847b', 0, 0, 0, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'cdbbb050-6f83-4468-9915-1476407a0071', N'会签测试', N'Platform/WorkFlowRun/Default.aspx', N'90d6ad24-28f5-49d3-ac3f-cb473fb64cc5', 0, NULL, NULL, N'flowid=f35d0b4a-b1f9-4fdc-b552-3720953b889f', NULL, N'流程应用', N'f35d0b4a-b1f9-4fdc-b552-3720953b889f', NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'303def4d-5ad8-420c-98ec-14b0882a300b', N'实例管理', N'Platform/WorkFlowTasks/Instance.aspx', N'ba6a867d-75ec-4223-b123-84229e29ff0c', 0, NULL, NULL, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'c6190ad6-1e45-4725-83ed-15ff9c3f7dc6', N'请假申请', N'Platform/WorkFlowRun/Default.aspx', N'48d05cf9-81c2-4713-87ab-1a45321500de', 0, NULL, NULL, N'flowid=a6509c1b-f49f-47a6-829d-ec43b9210eb2', NULL, N'流程应用', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'90cba9bf-8fe2-4bbc-a472-1dcf4becf5d6', N'流程设计', N'Platform/WorkFlowDesigner/Default.aspx', N'ba6a867d-75ec-4223-b123-84229e29ff0c', 0, NULL, NULL, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'297f012f-4987-4cdd-b2c0-1f9672d65d64', N'应用程序库', N'Platform/AppLibrary/Default.aspx', N'94decd1d-8c60-4c85-8f00-e740c1d4847b', 0, NULL, NULL, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'f8f771dd-156a-41d5-ad9d-31250082a17a', N'综合测试', N'Platform/WorkFlowRun/Default.aspx', N'48d05cf9-81c2-4713-87ab-1a45321500de', 0, NULL, NULL, N'flowid=04018979-6810-456a-9e15-396c4849e31a', NULL, N'流程应用', N'04018979-6810-456a-9e15-396c4849e31a', NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'63a2da04-fbfc-42e8-9b6b-3e5ad2299eca', N'请假申请', N'/Platform/WorkFlowFormDesigner/Forms/59137107-1594-1f6c-9d7d-ca7e912acec8.aspx', N'626480b3-eaa9-4705-acbb-82901db4fda4', 0, NULL, NULL, N'', NULL, N'流程表单', N'59137107-1594-1f6c-9d7d-ca7e912acec8', NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'a6c6e23f-1726-486b-b91c-3fad52f3f0f7', N'已办事项', N'Platform/WorkFlowTasks/CompletedList.aspx', N'ba6a867d-75ec-4223-b123-84229e29ff0c', 0, NULL, NULL, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'4e3e4eb0-f875-4283-bbe9-42beb4558164', N'12341234', N'/Platform/WorkFlowFormDesigner/Forms/6553a6de-6f11-a411-66a8-ffdfa87ac164.aspx', N'2a1070f6-af14-45b3-8292-fe0962701c04', 0, NULL, NULL, N'', NULL, N'流程表单', N'6553a6de-6f11-a411-66a8-ffdfa87ac164', NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'bb411263-3dfc-4e4c-92e4-45049327bc42', N'数据库连接', N'Platform/DBConnection/Default.aspx', N'94decd1d-8c60-4c85-8f00-e740c1d4847b', 0, NULL, NULL, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'2193be16-fea9-4903-b80a-45b2dacb02b5', N'表单设计', N'Platform/WorkFlowFormDesigner/Default.aspx', N'ba6a867d-75ec-4223-b123-84229e29ff0c', 0, NULL, NULL, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'3553dd3d-491c-463c-832f-512e33959f44', N'工作委托', N'Platform/WorkFlowDelegation/Default.aspx', N'ba6a867d-75ec-4223-b123-84229e29ff0c', 0, NULL, NULL, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'f597f0ab-6589-411f-a9ee-53068b19772c', N'自定义表单', N'Platform/WorkFlowRun/Default.aspx', N'90d6ad24-28f5-49d3-ac3f-cb473fb64cc5', 0, NULL, NULL, N'flowid=538beb68-4e56-439e-b50f-be6b3b9f4957', NULL, N'流程应用', N'538beb68-4e56-439e-b50f-be6b3b9f4957', NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'44c058a0-e21e-4df4-beda-54c1a4070c28', N'角色应用', N'/Platform/RoleApp/Default.aspx', N'94decd1d-8c60-4c85-8f00-e740c1d4847b', 0, NULL, NULL, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'6e2c4423-5fa7-4367-b790-5b8c6329ede6', N'物资采购申请', N'Platform/WorkFlowRun/Default.aspx', N'90d6ad24-28f5-49d3-ac3f-cb473fb64cc5', 0, NULL, NULL, N'flowid=c41d6eb9-e5f5-4171-a457-0cafe6b22757', NULL, N'流程应用', N'c41d6eb9-e5f5-4171-a457-0cafe6b22757', NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'371aeb5b-b318-40b9-a7a2-6157e6123179', N'信息发布', N'Platform/WorkFlowRun/Default.aspx', N'48d05cf9-81c2-4713-87ab-1a45321500de', 0, NULL, NULL, N'flowid=86875775-2f25-443d-ac42-57124f3479a5', NULL, N'流程应用', N'86875775-2f25-443d-ac42-57124f3479a5', NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'f709c6f3-5733-40db-be21-65dad93d0cdc', N'子流程测试', N'Platform/WorkFlowRun/Default.aspx', N'90d6ad24-28f5-49d3-ac3f-cb473fb64cc5', 0, NULL, NULL, N'flowid=8434dd1c-3e75-4877-b379-72df38d79bf7', NULL, N'流程应用', N'8434dd1c-3e75-4877-b379-72df38d79bf7', NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'9be06969-89ea-406d-8262-691700c37c77', N'综合测试', N'/Platform/WorkFlowFormDesigner/Forms/53ebb42f-22e4-9bbb-7ad1-2e619ab43bb2.aspx', N'7283b92f-21b4-4b0a-8b00-72cc9656f4dc', 0, NULL, NULL, N'', NULL, N'流程表单', N'53ebb42f-22e4-9bbb-7ad1-2e619ab43bb2', NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'e5676181-e55c-4553-948b-6a8b3d2cf747', N'意见管理(个人)', N'Platform/WorkFlowComments/Default.aspx?isoneself=1', N'ba6a867d-75ec-4223-b123-84229e29ff0c', 0, NULL, NULL, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'7f4c74d6-4113-4196-ada8-70c8e30a4a55', N'自定义表单', N'/Tests/CustomForm.aspx', N'626480b3-eaa9-4705-acbb-82901db4fda4', 0, NULL, NULL, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'f1107c5d-b3b6-4227-88fb-7253bb4ad067', N'测试自定义表单', N'/Tests/CustomForm.aspx', N'626480b3-eaa9-4705-acbb-82901db4fda4', 0, NULL, NULL, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'b4c634fa-22b7-4e7c-a2bd-7c46bb83a0a0', N'物资采购申请子表', N'/Platform/WorkFlowFormDesigner/Forms/aea45b74-667d-7701-7a26-652305b13dc1.aspx', N'74facc24-969f-4604-bc21-ce9e14dfa1ed', 0, NULL, NULL, N'', NULL, N'流程表单', N'aea45b74-667d-7701-7a26-652305b13dc1', NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'd375ff8d-1cdd-44d1-ab6c-8e7064336eb4', N'自由流程测试', N'Platform/WorkFlowRun/Default.aspx', N'90d6ad24-28f5-49d3-ac3f-cb473fb64cc5', 0, NULL, NULL, N'flowid=6f24065c-18e5-443b-8935-3a531678a842', NULL, N'流程应用', N'6f24065c-18e5-443b-8935-3a531678a842', NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'ff355143-fa05-4d3c-ace8-92acc7c59ca8', N'信息发布', N'/Platform/WorkFlowFormDesigner/Forms/475bda65-9c5f-5fcc-a008-9d65d0c1a533.aspx', N'626480b3-eaa9-4705-acbb-82901db4fda4', 0, NULL, NULL, N'', NULL, N'流程表单', N'475bda65-9c5f-5fcc-a008-9d65d0c1a533', NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'11304c22-887c-4ebf-8718-95326a6a58b4', N'数据字典', N'Platform/Dictionary/Default.aspx', N'94decd1d-8c60-4c85-8f00-e740c1d4847b', 0, NULL, NULL, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'15578cd3-9d10-49ee-b0bf-aaabc70a436e', N'按钮管理', N'Platform/WorkFlowButtons/Default.aspx', N'ba6a867d-75ec-4223-b123-84229e29ff0c', 0, NULL, NULL, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'072a784c-8a0e-402f-804f-aae783d10f46', N'待办事项', N'Platform/WorkFlowTasks/WaitList.aspx', N'ba6a867d-75ec-4223-b123-84229e29ff0c', 0, NULL, NULL, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'f0aa6c46-5dcc-41a5-a811-b5d333986687', N'物资采购申请', N'/Platform/WorkFlowFormDesigner/Forms/37355170-bda6-8217-3a34-ffce9c8aae24.aspx', N'626480b3-eaa9-4705-acbb-82901db4fda4', 0, NULL, NULL, N'', NULL, N'流程表单', N'37355170-bda6-8217-3a34-ffce9c8aae24', NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'f0dfb92c-7fd7-42ea-bfd1-b7ef8a91fab3', N'在线用户', N'Platform/OnlineUsers/Default.aspx', N'94decd1d-8c60-4c85-8f00-e740c1d4847b', 0, NULL, NULL, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'35024003-1206-4c20-b7d2-d0bca4134056', N'归档中心', N'Platform/WorkFlowArchives/Default.aspx', N'ba6a867d-75ec-4223-b123-84229e29ff0c', 0, NULL, NULL, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'9e65d8b1-6353-4846-a655-d778187a8b57', N'工作委托(个人)', N'Platform/WorkFlowDelegation/Default.aspx?isoneself=1', N'ba6a867d-75ec-4223-b123-84229e29ff0c', 0, NULL, NULL, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'dd12865d-63e6-44fe-83fc-d98cc9e093c0', N'组织机构', N'Platform/Members/Default.aspx', N'94decd1d-8c60-4c85-8f00-e740c1d4847b', 0, 900, 500, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'37283038-798f-4a5b-9175-f4e2dc69b0e4', N'报告请示', N'/Platform/WorkFlowFormDesigner/Forms/2e114e74-f21e-06dd-9474-535551c30a3e.aspx', N'626480b3-eaa9-4705-acbb-82901db4fda4', 0, NULL, NULL, N'', NULL, N'流程表单', N'2e114e74-f21e-06dd-9474-535551c30a3e', NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'8523cec5-750b-4fb6-b665-fa33600a4378', N'签名管理', N'Platform/WorkFlowSign/Default.aspx', N'ba6a867d-75ec-4223-b123-84229e29ff0c', 0, NULL, NULL, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'b4ccf4c8-671f-4211-9f57-fbd371f4ff42', N'意见管理', N'Platform/WorkFlowComments/Default.aspx', N'ba6a867d-75ec-4223-b123-84229e29ff0c', 0, NULL, NULL, N'', NULL, N'', NULL, NULL)
INSERT [AppLibrary] ([ID], [Title], [Address], [Type], [OpenMode], [Width], [Height], [Params], [Manager], [Note], [Code], [UseMember]) VALUES (N'b334e5fd-e995-4d5b-bfd6-feb9ac14122a', N'物资采购申请子表', N'/Platform/WorkFlowFormDesigner/Forms/8d5b11a7-4f3d-ebc6-b182-11e632df4819.aspx', N'626480b3-eaa9-4705-acbb-82901db4fda4', 0, NULL, NULL, N'', NULL, N'流程表单', N'8d5b11a7-4f3d-ebc6-b182-11e632df4819', NULL)
INSERT [DBConnection] ([ID], [Name], [Type], [ConnectionString], [Note]) VALUES (N'06075250-30dc-4d32-bf97-e922cb30fac8', N'平台连接', N'SqlServer', N'Data Source=.;Initial Catalog=RoadFlowWebForm;UID=sa;PWD=111', N'')
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'48d05cf9-81c2-4713-87ab-1a45321500de', N'7bc7c158-3492-41dd-8082-388495edf20c', N'办公类流程', NULL, NULL, NULL, NULL, 1)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'b50d5b1e-436a-48a4-b1fb-1f3cfb5579af', N'f3a258bf-c3c9-4591-9792-22401e017c83', N'弹出窗口(模态)', NULL, N'4', NULL, NULL, 5)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'f3a258bf-c3c9-4591-9792-22401e017c83', N'52e83a92-6ddf-43c2-86a9-944ce7421cbb', N'应用程序打开方式', N'appopenmodel', NULL, NULL, NULL, 1)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'7bc7c158-3492-41dd-8082-388495edf20c', N'df2acf3d-a35d-4b36-9caf-c2e3d5b9cd2c', N'流程分类', N'FlowTypes', NULL, NULL, NULL, 1)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'cbeb8fff-3b38-4f31-99e2-411a52976a37', N'f3a258bf-c3c9-4591-9792-22401e017c83', N'弹出层(模态)', NULL, N'2', NULL, NULL, 3)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'2a2bbee3-9883-4185-a64c-4430aa20e0cb', N'00000000-0000-0000-0000-000000000000', N'数据字典', NULL, NULL, NULL, NULL, 1)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'4da3afc3-7131-4657-b0e2-4665884b6e35', N'a8b9101f-4f8b-4830-9de1-c86ad89405c3', N'业界动态', NULL, NULL, NULL, NULL, 2)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'97867c71-9bbd-4894-b5cd-4ab0142803cc', N'f3a258bf-c3c9-4591-9792-22401e017c83', N'标签方式', NULL, N'0', NULL, NULL, 1)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'7a146fb1-4f3e-4a08-88ca-5287d87e1ddc', N'a8b9101f-4f8b-4830-9de1-c86ad89405c3', N'内部资讯', NULL, NULL, NULL, NULL, 1)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'719c6c30-3d6a-44e2-8730-637c651f1df7', N'df2acf3d-a35d-4b36-9caf-c2e3d5b9cd2c', N'表单分类', N'FormTypes', NULL, NULL, NULL, 2)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'f594d6d0-4ad7-4695-ad2e-6a06c870b25d', N'e7f836be-f091-460f-86e1-f0b6cdceba39', N'陪护假', NULL, NULL, NULL, NULL, 5)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'5f1a27c8-2e7a-419a-9dff-701602a5c40f', N'f3a258bf-c3c9-4591-9792-22401e017c83', N'弹出窗口', NULL, N'3', NULL, NULL, 4)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'7283b92f-21b4-4b0a-8b00-72cc9656f4dc', N'719c6c30-3d6a-44e2-8730-637c651f1df7', N'自定义表单', NULL, NULL, NULL, NULL, 1)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'626480b3-eaa9-4705-acbb-82901db4fda4', N'2a1070f6-af14-45b3-8292-fe0962701c04', N'办公类表单', NULL, NULL, NULL, NULL, 2)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'ba6a867d-75ec-4223-b123-84229e29ff0c', N'df2acf3d-a35d-4b36-9caf-c2e3d5b9cd2c', N'流程管理', NULL, NULL, NULL, NULL, 5)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'b8bffd9a-1ab5-447d-9f5d-933e327e77c4', N'f3a258bf-c3c9-4591-9792-22401e017c83', N'弹出层', NULL, N'1', NULL, NULL, 2)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'52e83a92-6ddf-43c2-86a9-944ce7421cbb', N'2a2bbee3-9883-4185-a64c-4430aa20e0cb', N'系统字典条目', NULL, NULL, NULL, NULL, 1)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'3df45a21-e94f-4e67-9e09-a87448b7885f', N'a8b9101f-4f8b-4830-9de1-c86ad89405c3', N'集团动态', NULL, NULL, NULL, NULL, 3)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'268ee7df-e4ac-4b6a-bfff-ae995ccdc7fa', N'f3a258bf-c3c9-4591-9792-22401e017c83', N'新窗口', NULL, N'5', NULL, NULL, 6)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'88f884d7-4b8e-441a-a3f5-b9192629d4e0', N'e7f836be-f091-460f-86e1-f0b6cdceba39', N'年假', NULL, NULL, NULL, NULL, 3)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'd2122199-23a7-4b59-87d4-b9b60e17735b', N'e7f836be-f091-460f-86e1-f0b6cdceba39', N'产假', NULL, NULL, NULL, NULL, 4)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'a1e92887-8230-4aba-8a06-bebffdee8043', N'e7f836be-f091-460f-86e1-f0b6cdceba39', N'事假', NULL, NULL, NULL, NULL, 1)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'df2acf3d-a35d-4b36-9caf-c2e3d5b9cd2c', N'52e83a92-6ddf-43c2-86a9-944ce7421cbb', N'应用程序库分类', N'AppLibraryTypes', NULL, NULL, NULL, 2)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'a8b9101f-4f8b-4830-9de1-c86ad89405c3', N'4d143b01-e29b-48cc-9bf4-dc647fd1c07f', N'新闻分类', N'newstype', NULL, NULL, NULL, 1)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'90d6ad24-28f5-49d3-ac3f-cb473fb64cc5', N'7bc7c158-3492-41dd-8082-388495edf20c', N'业务类流程', NULL, NULL, NULL, NULL, 2)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'74facc24-969f-4604-bc21-ce9e14dfa1ed', N'2a1070f6-af14-45b3-8292-fe0962701c04', N'合同类表单', NULL, NULL, NULL, NULL, 1)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'1cc3d849-b755-4f2c-8fc7-d47610030373', N'e7f836be-f091-460f-86e1-f0b6cdceba39', N'探亲假', NULL, NULL, NULL, NULL, 6)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'4d143b01-e29b-48cc-9bf4-dc647fd1c07f', N'2a2bbee3-9883-4185-a64c-4430aa20e0cb', N'应用字典条目', NULL, NULL, NULL, NULL, 2)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'94decd1d-8c60-4c85-8f00-e740c1d4847b', N'df2acf3d-a35d-4b36-9caf-c2e3d5b9cd2c', N'系统管理', NULL, NULL, NULL, NULL, 3)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'e7f836be-f091-460f-86e1-f0b6cdceba39', N'4d143b01-e29b-48cc-9bf4-dc647fd1c07f', N'请假类型', N'qjtype', NULL, NULL, NULL, 2)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'd0b8d5f6-b708-4bec-ba2f-f4bd15d274e4', N'e7f836be-f091-460f-86e1-f0b6cdceba39', N'病假', NULL, NULL, NULL, NULL, 2)
INSERT [Dictionary] ([ID], [ParentID], [Title], [Code], [Value], [Note], [Other], [Sort]) VALUES (N'2a1070f6-af14-45b3-8292-fe0962701c04', N'719c6c30-3d6a-44e2-8730-637c651f1df7', N'普通表单', NULL, NULL, NULL, NULL, 2)
INSERT [Organize] ([ID], [Name], [Number], [Type], [Status], [ParentID], [Sort], [Depth], [ChildsLength], [ChargeLeader], [Leader], [Note]) VALUES (N'3975624c-148f-4838-88c9-12af85d2e05e', N'财务部', N'04f12beb-d99d-43df-ac9a-3042957d6bda,3975624c-148f-4838-88c9-12af85d2e05e', 2, 0, N'04f12beb-d99d-43df-ac9a-3042957d6bda', 2, 1, 5, N'u_8086d01f-7ae3-402e-b543-d34f1059f79a', N'u_c2d3012a-c816-4149-ac04-9da0b60e3867', NULL)
INSERT [Organize] ([ID], [Name], [Number], [Type], [Status], [ParentID], [Sort], [Depth], [ChildsLength], [ChargeLeader], [Leader], [Note]) VALUES (N'82682cf5-50e1-4901-911b-1a935b5ddb6c', N'总经理', N'04f12beb-d99d-43df-ac9a-3042957d6bda,82682cf5-50e1-4901-911b-1a935b5ddb6c', 3, 0, N'04f12beb-d99d-43df-ac9a-3042957d6bda', 1, 1, 1, N'', N'', NULL)
INSERT [Organize] ([ID], [Name], [Number], [Type], [Status], [ParentID], [Sort], [Depth], [ChildsLength], [ChargeLeader], [Leader], [Note]) VALUES (N'04f12beb-d99d-43df-ac9a-3042957d6bda', N'重庆天知软件技术有限公司', N'04f12beb-d99d-43df-ac9a-3042957d6bda', 1, 0, N'00000000-0000-0000-0000-000000000000', 1, 0, 12, NULL, NULL, NULL)
INSERT [Organize] ([ID], [Name], [Number], [Type], [Status], [ParentID], [Sort], [Depth], [ChildsLength], [ChargeLeader], [Leader], [Note]) VALUES (N'74ceda12-c919-4d80-b0f2-3ac254adb65a', N'出纳', N'04f12beb-d99d-43df-ac9a-3042957d6bda,3975624c-148f-4838-88c9-12af85d2e05e,74ceda12-c919-4d80-b0f2-3ac254adb65a', 3, 0, N'3975624c-148f-4838-88c9-12af85d2e05e', 3, 2, 1, NULL, NULL, NULL)
INSERT [Organize] ([ID], [Name], [Number], [Type], [Status], [ParentID], [Sort], [Depth], [ChildsLength], [ChargeLeader], [Leader], [Note]) VALUES (N'1e9fba5a-7ba2-48dc-a89f-9377837912f7', N'会计', N'04f12beb-d99d-43df-ac9a-3042957d6bda,3975624c-148f-4838-88c9-12af85d2e05e,1e9fba5a-7ba2-48dc-a89f-9377837912f7', 3, 0, N'3975624c-148f-4838-88c9-12af85d2e05e', 1, 2, 1, N'', N'', NULL)
INSERT [Organize] ([ID], [Name], [Number], [Type], [Status], [ParentID], [Sort], [Depth], [ChildsLength], [ChargeLeader], [Leader], [Note]) VALUES (N'96f75a51-779b-491a-9773-cb5f90cef11e', N'研发部', N'04f12beb-d99d-43df-ac9a-3042957d6bda,96f75a51-779b-491a-9773-cb5f90cef11e', 2, 0, N'04f12beb-d99d-43df-ac9a-3042957d6bda', 3, 1, 4, N'u_8086d01f-7ae3-402e-b543-d34f1059f79a', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', NULL)
INSERT [Organize] ([ID], [Name], [Number], [Type], [Status], [ParentID], [Sort], [Depth], [ChildsLength], [ChargeLeader], [Leader], [Note]) VALUES (N'4f4865de-fda0-417b-9465-d7648309b772', N'后勤部', N'04f12beb-d99d-43df-ac9a-3042957d6bda,4f4865de-fda0-417b-9465-d7648309b772', 2, 0, N'04f12beb-d99d-43df-ac9a-3042957d6bda', 4, 1, 3, N'', N'u_0362149c-af22-491f-baef-37bffcc1fd5c,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378', NULL)
INSERT [Role] ([ID], [Name], [UseMember], [Note]) VALUES (N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'系统管理员', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', NULL)
INSERT [Role] ([ID], [Name], [UseMember], [Note]) VALUES (N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', N'工作人员', N'04f12beb-d99d-43df-ac9a-3042957d6bda', NULL)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'77b14053-24f3-49e3-a3fc-033cc0468d6b', N'df9f00a0-75c9-45f5-892c-7f2e9d1a3d35', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'3553dd3d-491c-463c-832f-512e33959f44', N'工作委托', NULL, 6, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'89c5233c-53b0-4962-afc5-05b2f244adbf', N'ffc56a9c-d4b1-48e7-8354-a1336ae6164b', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', N'f709c6f3-5733-40db-be21-65dad93d0cdc', N'子流程测试', NULL, 3, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'8a66eb6a-c615-4ffc-a0ce-0612309e3b72', N'3eb2aa53-2095-41f4-8c3d-5a957db3e7d8', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'e5676181-e55c-4553-948b-6a8b3d2cf747', N'意见管理', NULL, 4, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'9fb260a3-432f-4e25-bf9f-0b72c4813700', N'ffc56a9c-d4b1-48e7-8354-a1336ae6164b', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', N'6e2c4423-5fa7-4367-b790-5b8c6329ede6', N'物资采购申请', NULL, 2, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'a8249985-deaa-493b-926d-159430647986', N'22f1c24e-cb9c-428a-86d7-7c0e714d6244', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'f597f0ab-6589-411f-a9ee-53068b19772c', N'自定义表单', NULL, 3, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'48b8a588-e838-42bd-8d1d-1e29f59e092c', N'22f1c24e-cb9c-428a-86d7-7c0e714d6244', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'f8f771dd-156a-41d5-ad9d-31250082a17a', N'综合测试', NULL, 9, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'47a2dc9a-f438-4a3e-8efc-1ec59a3300cd', N'3eb2aa53-2095-41f4-8c3d-5a957db3e7d8', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'a6c6e23f-1726-486b-b91c-3fad52f3f0f7', N'已办事项', NULL, 2, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'ce5b7f56-275b-4733-b485-298102f1479c', N'df9f00a0-75c9-45f5-892c-7f2e9d1a3d35', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'b4ccf4c8-671f-4211-9f57-fbd371f4ff42', N'意见管理', NULL, 4, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'622d30d7-46ee-4a24-aa59-2b78d464a98a', N'ffc56a9c-d4b1-48e7-8354-a1336ae6164b', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', N'371aeb5b-b318-40b9-a7a2-6157e6123179', N'信息发布', NULL, 5, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'c81d056c-f3cf-47f7-87b1-3113a8a8cd89', N'22f1c24e-cb9c-428a-86d7-7c0e714d6244', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'f709c6f3-5733-40db-be21-65dad93d0cdc', N'子流程测试', NULL, 4, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'431c2a81-d12d-4d20-914f-37d526585232', N'3eb2aa53-2095-41f4-8c3d-5a957db3e7d8', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'9e65d8b1-6353-4846-a655-d778187a8b57', N'工作委托', NULL, 5, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'4141d2a1-feb8-410d-a9ff-56eb1f13cb6b', N'22f1c24e-cb9c-428a-86d7-7c0e714d6244', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'371aeb5b-b318-40b9-a7a2-6157e6123179', N'信息发布', NULL, 7, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'3eb2aa53-2095-41f4-8c3d-5a957db3e7d8', N'ceae1645-9785-45e1-822e-f082db3ea902', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', NULL, N'流程处理', NULL, 1, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'0a9e2201-c921-47d0-9497-5ed9cf22f672', N'3eb2aa53-2095-41f4-8c3d-5a957db3e7d8', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'072a784c-8a0e-402f-804f-aae783d10f46', N'待办事项', NULL, 1, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'ae221280-9561-4d93-9cf2-63c6d6ad7698', N'7a8294ed-4393-46eb-8f11-81bc7bbe8458', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'f0dfb92c-7fd7-42ea-bfd1-b7ef8a91fab3', N'在线用户', NULL, 7, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'74e0add2-3c51-4e6a-b1dc-6a256918ca4c', N'df9f00a0-75c9-45f5-892c-7f2e9d1a3d35', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'15578cd3-9d10-49ee-b0bf-aaabc70a436e', N'按钮管理', NULL, 3, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'eaa99c2b-c0ee-4504-854b-72ab85620256', N'907fbba6-64dc-44a5-af96-c04e5942226b', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', N'072a784c-8a0e-402f-804f-aae783d10f46', N'待办事项', NULL, 1, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'34213b3e-5ca5-4439-965f-78e0dcbbcab8', N'00000000-0000-0000-0000-000000000000', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', NULL, N'管理目录', NULL, 1, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'22f1c24e-cb9c-428a-86d7-7c0e714d6244', N'ceae1645-9785-45e1-822e-f082db3ea902', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', NULL, N'流程测试', NULL, 2, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'7539137b-909e-4fd3-8470-7c9d9f15d7b6', N'907fbba6-64dc-44a5-af96-c04e5942226b', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', N'9e65d8b1-6353-4846-a655-d778187a8b57', N'工作委托(个人)', NULL, 4, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'df9f00a0-75c9-45f5-892c-7f2e9d1a3d35', N'ceae1645-9785-45e1-822e-f082db3ea902', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', NULL, N'流程管理', NULL, 3, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'7a8294ed-4393-46eb-8f11-81bc7bbe8458', N'ceae1645-9785-45e1-822e-f082db3ea902', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', NULL, N'系统管理', NULL, 4, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'64cc2dd2-e224-444c-8ffe-8ba7942dae25', N'df9f00a0-75c9-45f5-892c-7f2e9d1a3d35', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'35024003-1206-4c20-b7d2-d0bca4134056', N'归档中心', NULL, 8, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'233d8ad4-8369-4201-b9a7-927d51ff0e35', N'7a8294ed-4393-46eb-8f11-81bc7bbe8458', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'dd12865d-63e6-44fe-83fc-d98cc9e093c0', N'组织机构', NULL, 1, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'461795cc-af9d-4bf9-bddb-9736bfb97bdb', N'7a8294ed-4393-46eb-8f11-81bc7bbe8458', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'8cff8e9f-f539-41c9-80ce-06a97f481390', N'日志查询', NULL, 2, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'7f015f83-e3c0-46ef-8c37-9a59d15b5f5b', N'907fbba6-64dc-44a5-af96-c04e5942226b', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', N'a6c6e23f-1726-486b-b91c-3fad52f3f0f7', N'已办事项', NULL, 2, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'ffc56a9c-d4b1-48e7-8354-a1336ae6164b', N'34213b3e-5ca5-4439-965f-78e0dcbbcab8', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', NULL, N'流程测试', NULL, 2, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'aa80e3aa-6547-416e-839b-a25bc7f2a099', N'df9f00a0-75c9-45f5-892c-7f2e9d1a3d35', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'90cba9bf-8fe2-4bbc-a472-1dcf4becf5d6', N'流程设计', NULL, 1, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'a1279ab3-4498-450b-98ac-b3e113343399', N'7a8294ed-4393-46eb-8f11-81bc7bbe8458', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'44c058a0-e21e-4df4-beda-54c1a4070c28', N'角色应用', NULL, 5, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'58f06d96-1ebe-456d-b86b-b97d24e62ab0', N'df9f00a0-75c9-45f5-892c-7f2e9d1a3d35', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'303def4d-5ad8-420c-98ec-14b0882a300b', N'实例管理', NULL, 5, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'72844f88-d2ec-495c-a2da-bb11e1bb7fec', N'df9f00a0-75c9-45f5-892c-7f2e9d1a3d35', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'2193be16-fea9-4903-b80a-45b2dacb02b5', N'表单设计', NULL, 2, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'907fbba6-64dc-44a5-af96-c04e5942226b', N'34213b3e-5ca5-4439-965f-78e0dcbbcab8', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', NULL, N'流程处理', NULL, 1, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'b0fdbfd5-4f5e-4637-9af5-cbb851273696', N'3eb2aa53-2095-41f4-8c3d-5a957db3e7d8', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'8523cec5-750b-4fb6-b665-fa33600a4378', N'签名管理', NULL, 3, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'4c520912-9454-4ed9-8060-cc3a612862aa', N'7a8294ed-4393-46eb-8f11-81bc7bbe8458', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'11304c22-887c-4ebf-8718-95326a6a58b4', N'数据字典', NULL, 3, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'02b4b66d-75f6-428f-b68d-cdceb5a49cdd', N'ffc56a9c-d4b1-48e7-8354-a1336ae6164b', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', N'f597f0ab-6589-411f-a9ee-53068b19772c', N'自定义表单', NULL, 4, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'775f6fc6-035c-4414-9dfb-cf40ad35711e', N'22f1c24e-cb9c-428a-86d7-7c0e714d6244', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'c6190ad6-1e45-4725-83ed-15ff9c3f7dc6', N'请假申请', NULL, 1, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'd694dce9-9ed8-4e68-ab89-cf87f19f1f91', N'ffc56a9c-d4b1-48e7-8354-a1336ae6164b', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', N'c6190ad6-1e45-4725-83ed-15ff9c3f7dc6', N'请假申请', NULL, 1, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'49c1d67f-40f0-4e0f-bc6e-d24885d412d0', N'907fbba6-64dc-44a5-af96-c04e5942226b', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', N'8523cec5-750b-4fb6-b665-fa33600a4378', N'签名管理', NULL, 3, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'2e7c322a-1cb3-4cde-9f59-dda0028e6eec', N'907fbba6-64dc-44a5-af96-c04e5942226b', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', N'e5676181-e55c-4553-948b-6a8b3d2cf747', N'意见管理(个人)', NULL, 5, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'01976305-2bbf-4809-8bc6-decdc733b532', N'22f1c24e-cb9c-428a-86d7-7c0e714d6244', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'6e2c4423-5fa7-4367-b790-5b8c6329ede6', N'物资采购申请', NULL, 2, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'01145d31-c9e4-46ad-8ba4-df3d42ec7009', N'22f1c24e-cb9c-428a-86d7-7c0e714d6244', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'd375ff8d-1cdd-44d1-ab6c-8e7064336eb4', N'自由流程测试', NULL, 8, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'3e0bbdee-92b4-4303-b434-ed752fc20902', N'7a8294ed-4393-46eb-8f11-81bc7bbe8458', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'297f012f-4987-4cdd-b2c0-1f9672d65d64', N'应用程序库', NULL, 4, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'ad60040d-99a1-420a-8c47-eda6166f2b74', N'7a8294ed-4393-46eb-8f11-81bc7bbe8458', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'bb411263-3dfc-4e4c-92e4-45049327bc42', N'数据库连接', NULL, 6, NULL, 0)
INSERT [RoleApp] ([ID], [ParentID], [RoleID], [AppID], [Title], [Params], [Sort], [Ico], [Type]) VALUES (N'ceae1645-9785-45e1-822e-f082db3ea902', N'00000000-0000-0000-0000-000000000000', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', NULL, N'管理目录', NULL, 1, NULL, 0)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'a4a68842-9d7d-4345-9711-18f11a4fbbac', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A539014B8330 AS DateTime), CAST(0x0000A541014B8330 AS DateTime), N'd0b8d5f6-b708-4bec-ba2f-f4bd15d274e4', N'1`23', NULL, 1, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'c4856564-db98-4049-ad35-1d0e6e4c0bad', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A539014BC980 AS DateTime), CAST(0x0000A541014BC980 AS DateTime), N'd0b8d5f6-b708-4bec-ba2f-f4bd15d274e4', N'32323232', NULL, 23, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'9dbfd622-5e21-46bf-b796-36aa0422d594', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A4DD00000000 AS DateTime), CAST(0x0000A4E300000000 AS DateTime), N'a1e92887-8230-4aba-8a06-bebffdee8043', N'565656', NULL, 6, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'902b4dcf-2716-46ae-be6f-4f0e643a0dba', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A539014BC980 AS DateTime), CAST(0x0000A541014BC980 AS DateTime), N'd0b8d5f6-b708-4bec-ba2f-f4bd15d274e4', N'32323232', NULL, 23, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'e459f59c-2ad4-4458-91ff-52f0a6fb45e2', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A4D700000000 AS DateTime), CAST(0x0000A4D600000000 AS DateTime), N'88f884d7-4b8e-441a-a3f5-b9192629d4e0', N'6666', NULL, 6, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'a9682e77-4ccb-4496-8b99-555bb40a6059', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A539014B8330 AS DateTime), CAST(0x0000A541014B8330 AS DateTime), N'd0b8d5f6-b708-4bec-ba2f-f4bd15d274e4', N'1`23', NULL, 1, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'21bc1dd1-95e0-4a0a-80c6-5d123eb1ad8f', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A4E600000000 AS DateTime), CAST(0x0000A4D700000000 AS DateTime), N'f594d6d0-4ad7-4695-ad2e-6a06c870b25d', N'343443', NULL, 1, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'd86ecefb-8515-4b26-81c7-60c49a8a64c0', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A50200000000 AS DateTime), CAST(0x0000A50200000000 AS DateTime), N'd0b8d5f6-b708-4bec-ba2f-f4bd15d274e4', N'66', NULL, 6, N'/Files/UploadFiles/201508/28/windows激活.txt', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'b9c5fbf9-b493-42f1-b3f9-60f280b89d84', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A4D000000000 AS DateTime), CAST(0x0000A4D700000000 AS DateTime), N'd0b8d5f6-b708-4bec-ba2f-f4bd15d274e4', N'343434', NULL, 4, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'1dc5a929-5a5e-43ef-b8f1-645ec7eba8a3', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A4DC00000000 AS DateTime), CAST(0x0000A4E600000000 AS DateTime), N'd0b8d5f6-b708-4bec-ba2f-f4bd15d274e4', N'2222222222', NULL, 1, N'', NULL, N'', N'', NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'b9718db3-f1c7-410a-b532-793b5b8a1794', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A51D0087F4B0 AS DateTime), CAST(0x0000A52500B12790 AS DateTime), N'd0b8d5f6-b708-4bec-ba2f-f4bd15d274e4', N'5555', NULL, 1, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'062663cb-b5ec-458b-9eae-7d8bda717aa6', NULL, N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', NULL, NULL, CAST(0x0000A50100000000 AS DateTime), CAST(0x0000A50500000000 AS DateTime), NULL, N'254235', NULL, 5, NULL, NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'c26e1110-63a4-4c7a-80e7-81a12c883f68', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A4D000000000 AS DateTime), CAST(0x0000A4D900000000 AS DateTime), N'd0b8d5f6-b708-4bec-ba2f-f4bd15d274e4', N'777', NULL, 7, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'e725a8b5-2a0d-4683-ad55-844b67ed0d6a', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A516010B3E10 AS DateTime), CAST(0x0000A532010B3E10 AS DateTime), N'd0b8d5f6-b708-4bec-ba2f-f4bd15d274e4', N'22', NULL, 2, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'25195a01-51a0-4506-9cd3-895c03f08bca', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A56801526100 AS DateTime), CAST(0x0000A56F0152A750 AS DateTime), N'd0b8d5f6-b708-4bec-ba2f-f4bd15d274e4', N'', NULL, 2, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'fd84c226-b800-4b29-b15e-8d19aca14c5e', N'李晨新的请假申请', N'u_8086d01f-7ae3-402e-b543-d34f1059f79a', N'李晨新', N'04f12beb-d99d-43df-ac9a-3042957d6bda', NULL, CAST(0x0000A4DC00000000 AS DateTime), CAST(0x0000A4DD00000000 AS DateTime), N'd0b8d5f6-b708-4bec-ba2f-f4bd15d274e4', N'3434', NULL, 4, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'ce08d2d4-c9fe-417b-99e4-98730c3df690', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A4D000000000 AS DateTime), CAST(0x0000A4D600000000 AS DateTime), N'88f884d7-4b8e-441a-a3f5-b9192629d4e0', N'6666', NULL, 6, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'eb462ccf-abff-4351-8747-9bd7c3afc6ad', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A50B00000000 AS DateTime), CAST(0x0000A51E00000000 AS DateTime), N'd2122199-23a7-4b59-87d4-b9b60e17735b', N'44', NULL, 4, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'82e69a62-76be-40b6-946c-b1c945b2554e', N'毛明明的请假申请', N'u_0362149c-af22-491f-baef-37bffcc1fd5c', N'毛明明', N'4f4865de-fda0-417b-9465-d7648309b772', NULL, CAST(0x0000A50B00000000 AS DateTime), CAST(0x0000A50F00000000 AS DateTime), N'd0b8d5f6-b708-4bec-ba2f-f4bd15d274e4', N'111111111111111111', NULL, 1, N'', NULL, NULL, NULL, 1)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'12aedc73-910f-4a59-a3ff-b270f2d3a6ec', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A4E300000000 AS DateTime), CAST(0x0000A4E600000000 AS DateTime), N'f594d6d0-4ad7-4695-ad2e-6a06c870b25d', N'44', NULL, 4, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'a6238f6e-11af-4caa-8ac0-b3838d04445e', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A4D600000000 AS DateTime), CAST(0x0000A4D800000000 AS DateTime), N'88f884d7-4b8e-441a-a3f5-b9192629d4e0', N'4444', NULL, 4, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'27180112-f5a5-4877-895a-c2fe30fe1320', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A4D700000000 AS DateTime), CAST(0x0000A4DF00000000 AS DateTime), N'd2122199-23a7-4b59-87d4-b9b60e17735b', N'111111111111', NULL, 1, N'', NULL, NULL, NULL, 1)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'a1bf302e-0e4c-47fc-b777-d144a41ed03e', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A4D000000000 AS DateTime), CAST(0x0000A4DF00000000 AS DateTime), N'f594d6d0-4ad7-4695-ad2e-6a06c870b25d', N'444', NULL, 4, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'014aa672-416c-4a62-bc2f-d3a6234314a8', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A4D000000000 AS DateTime), CAST(0x0000A4DE00000000 AS DateTime), N'88f884d7-4b8e-441a-a3f5-b9192629d4e0', N'6666666666', NULL, 6, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'12de6307-2860-4c85-9965-d7035adf1527', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A4D000000000 AS DateTime), CAST(0x0000A4DE00000000 AS DateTime), N'88f884d7-4b8e-441a-a3f5-b9192629d4e0', N'ggggggggggggg', NULL, 6, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'a42b6694-5f98-476a-83c9-db485340ef33', NULL, N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', NULL, NULL, CAST(0x0000A50200000000 AS DateTime), CAST(0x0000A50500000000 AS DateTime), NULL, N'土土土地', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'23211f52-6b7b-4926-b0e7-e8214f7789de', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A4D700000000 AS DateTime), CAST(0x0000A4DE00000000 AS DateTime), N'd0b8d5f6-b708-4bec-ba2f-f4bd15d274e4', N'3', NULL, 1, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'1093dcf8-8b08-4177-9468-e8d3e4600474', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A4D000000000 AS DateTime), CAST(0x0000A4D700000000 AS DateTime), N'88f884d7-4b8e-441a-a3f5-b9192629d4e0', N'555', NULL, 5, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'7441f7ba-7b83-442b-aed0-f4234c143c2d', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A4D700000000 AS DateTime), CAST(0x0000A4E600000000 AS DateTime), N'd0b8d5f6-b708-4bec-ba2f-f4bd15d274e4', N'1241242314', NULL, 1, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'8542c297-39fe-4622-b537-fdc54f58c0e9', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A4DD00000000 AS DateTime), CAST(0x0000A4E600000000 AS DateTime), N'a1e92887-8230-4aba-8a06-bebffdee8043', N'6hhhh', NULL, 6, N'', NULL, NULL, NULL, NULL)
INSERT [TempTest] ([ID], [Title], [UserID], [UserID_text], [DeptID], [DeptName], [Date1], [Date2], [Type], [Reason], [WriteTime], [Days], [test], [test1], [test2], [test2_text], [flowcompleted]) VALUES (N'52103a3b-115c-4417-8e92-fe7a52212db5', N'徐洪的请假申请', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'96f75a51-779b-491a-9773-cb5f90cef11e', NULL, CAST(0x0000A5630103D3A0 AS DateTime), CAST(0x0000A57701038D50 AS DateTime), N'a1e92887-8230-4aba-8a06-bebffdee8043', N'21341234213', NULL, 2, N'', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [TempTest_CustomForm] ON 

INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (37, N'徐洪的报告请示', N'uuuuuuuu', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (38, N'徐洪的报告请示', N'uuuuuuuu', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (39, N'毛明明的报告请示', N'oooooo', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (40, N'徐洪的报告请示', N'llllll', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (41, N'徐洪的报告请示', N'999999', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (42, N'徐洪的报告请示', N'999999', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (43, N'徐洪的报告请示', N'tttttttttttttttttt', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (44, N'徐洪的报告请示', N'wwwwwwwwwwwwwww', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (45, N'徐洪的报告请示', N'立立立', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (46, N'徐洪的报告请示', N'', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (47, N'徐洪的报告请示', N'', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (48, N'徐洪的报告请示', N'', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (49, N'徐洪的报告请示', N'', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (50, N'徐洪的报告请示', N'', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (51, N'徐洪的报告请示', N'', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (52, N'徐洪的报告请示', N'', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (53, N'徐洪的报告请示', N'', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (54, N'徐洪的报告请示', N'', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (55, N'徐洪的报告请示', N'', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (56, N'徐洪的报告请示', N'kkk', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (57, N'徐洪的报告请示', N'', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (58, N'徐洪的报告请示', N'uuuuuuu', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (59, N'徐洪的报告请示', N'uuuuuuu', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (60, N'徐洪的报告请示', N'uuuuuuu', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (61, N'徐洪的报告请示', N'uuuuuuu', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (62, N'徐洪的报告请示', N'uu', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (63, N'徐洪的报告请示', N'', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (64, N'u', N'uuuu', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (65, N'徐洪的报告请示', N'', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (66, N'徐洪的报告请示', N'', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (67, N'徐洪的报告请示', N'', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (68, N'徐洪的报告请示', N'', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (69, N'徐洪的报告请示', N'212342314', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (70, N'徐洪的报告请示', N'qrqwereqwr', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (71, N'徐洪的报告请示', N'wfwqfrqewr', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (72, N'徐洪的报告请示', N'qwere', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (73, N'徐洪的报告请示', N'', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (74, N'徐洪的报告请示', N'qreeqewrqwerwqer', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (75, N'1234321', N'', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (76, N'12342314', N'', NULL, NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (77, N'2352435435', N'', N'fded2b24-e7a0-41e4-90ed-aab7148ae113', 1, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (78, N'王', N'', N'23c3e9fc-6d8a-4ea0-925a-0a0671d61378', 1, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (79, N'王', N'', N'23c3e9fc-6d8a-4ea0-925a-0a0671d61378', NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (80, N'王', N'', N'23c3e9fc-6d8a-4ea0-925a-0a0671d61378', 1, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (81, N'五', N'', N'23c3e9fc-6d8a-4ea0-925a-0a0671d61378', 1, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (82, N'的', N'', N'23c3e9fc-6d8a-4ea0-925a-0a0671d61378', 1, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (83, N'12341234', N'', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', NULL, NULL)
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (84, N'xxxxx', N'', N'c2d3012a-c816-4149-ac04-9da0b60e3867', NULL, CAST(0x0000A57900000000 AS DateTime))
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (85, N'111', N'', N'23c3e9fc-6d8a-4ea0-925a-0a0671d61378', NULL, CAST(0x0000A57800000000 AS DateTime))
INSERT [TempTest_CustomForm] ([ID], [Title], [Contents], [Type], [FlowCompleted], [wdate]) VALUES (86, N'111', N'', N'23c3e9fc-6d8a-4ea0-925a-0a0671d61378', NULL, CAST(0x0000A57000000000 AS DateTime))
SET IDENTITY_INSERT [TempTest_CustomForm] OFF
SET IDENTITY_INSERT [TempTest_News] ON 

INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (1002, N'', N'', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', NULL, 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (1003, N'wertw', N'wertewrt', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', NULL, 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (1004, N'', N'', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', NULL, 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (1005, N'qwer', N'qwerwqer', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', N'<p>qwre</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (1006, N'11111111111', N'11111111111111111111111111', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', N'<p>111111111</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (1007, N'wqerwqerwqerwqeweqr', N'qwerqwerqwerwqerwq', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', NULL, 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (1008, N'1234213412341234', N'1234213412342134', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', NULL, 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (1009, N'12341234', N'1234123412342314', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', NULL, 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (1010, N'qqqqqqqqqqqq', N'qqqqqqqqqqqqqqqqqqqq', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', N'<p>123421342134qqqqqq</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (1011, N'wqerweqr', N'qwerwqerweqrweqr', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', N'<p>123412341234213</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (1012, N'weqr', N'eqwrweqr', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', N'<p>wqerweqrqwerqwerweq</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (1013, N'qerqwerqrqewr', N'qwerwqerewq', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', N'<p>qwerweqrqwer</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (1014, N'11111111111111', N'1111111111111111111111111', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', N'<p>111111111111111111111</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (2002, N'', N'', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', NULL, 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (2003, N'1234123', N'41234123', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', N'<p>431241234321</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3002, N'ggggggggggg', N'wqrwqrewqer', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', N'<p>qwrwqerweqr</p>', 1)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3003, N'ggggggg', N'gggggg', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', N'<p>ggggg</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3004, N'ggggggg', N'gggggg', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', N'<p>ggggg</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3005, N'ggggggg', N'gggggg', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', N'<p>ggggg</p>', 1)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3006, N'ggggggggggggg', N'', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'1', N'<p>12341234123431<br/></p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3007, N'111111111111111cccccccc', N'qwerqew', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'1', N'<p>wereqwreqwrcccccccccccccccccccccc</p>', 1)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3008, N'wqerewqr', N'wqrewqer', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0', N'<p>qwreqwerwqerwer</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3009, N'12342134', N'12342134', NULL, N'业务动态', N'213421342134', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3010, N'11111111111111111111111', N'111111111', NULL, N'公司动态', N'11111111111111', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3011, N'111111111111', N'111111111111', NULL, N'业务动态', N'11111111111111111111111', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3012, N'11111111111111', N'1111111111', NULL, N'业务动态', N'111111111111111', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3013, N'11111111111111111111', N'11111111111111111111', NULL, N'业务动态', N'11111111111111111111', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3014, N'111111111111', N'111', NULL, N'业务动态', N'111111111111', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3015, N'1111111111111', N'111', NULL, N'业务动态', N'1111111111111111', 1)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3016, N'qqqqqqqq', N'qqqqqqqqqqqq', NULL, N'业务动态', N'qqqqqqqq', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3017, N'2345234', N'523452', NULL, N'业务动态', N'435345', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3018, N'23454235', N'23452345423', NULL, N'业务动态', N'23532452345345', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3019, N'xxxxxxxxxxxx', N'xxxxxxxxxxxxxxxxx', NULL, N'业务动态', N'xxxxxxxxxxxxxxxxxxxxxxxxxx', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3020, N'cccccccccccccccccccc', N'cccccccccccccccccccc', NULL, N'业务动态', N'ccccccccccccccccccccc', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3021, N'fffffff', N'ffffffffffffffffff', NULL, N'业务动态', N'fffffffffffffffffffff', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3022, N'qwerqew', N'rewr', NULL, N'业务动态', N'qwreqwer', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3023, N'ggggggggggggggg', N'ggggggggggggggg', NULL, N'业务动态', N'gggggggg', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3024, N'111111112222222222', N'22222222222222222222', NULL, N'业务动态', N'2222222222222222222222222222', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3025, N'2222222222222222222222', N'222222222222222222222222222', NULL, N'业务动态', N'2222222222222222222222', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3026, N'qwereqr', N'qwrqwe', NULL, N'业务动态', N'rwer', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3027, N'', N'', NULL, NULL, N'', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3028, N'53234', N'5345', NULL, N'业务动态', N'534554', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3029, N'wwr', N'werwrer', NULL, N'业务动态', N'werwe', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3030, N'wrqwereqwr', N'qwreqwreqwr', NULL, N'业务动态', N'qwerwqerqwer', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3031, N'ttttttttttt', N'tttttttttttttttt', NULL, N'业务动态', N'g', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3032, N'2235324', N'523452345', NULL, N'业务动态', N'2353245xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3033, N'gggggggggggggggggggg', N'gggggggggggggggggggggggg', NULL, N'业务动态', N'gggggggggggggggggg', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3034, N'ggg', N'gg', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'1', N'<p>ggg</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3035, N'gggggg', N'g', N'u_095ba7de-084a-41aa-a21e-4ccbb7cd4ff8', N'0', N'<p>gggggggggggggg</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3036, N'gggggggg', N'gggggggggggggggggg', NULL, N'4da3afc3-7131-4657-b0e2-4665884b6e35', N'<p>ggggggggggg<br/></p>', 1)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3037, N'qwerqew', N'rqwerqwer', NULL, N'4da3afc3-7131-4657-b0e2-4665884b6e35,3df45a21-e94f-4e67-9e09-a87448b7885f', N'<p>qwrqwerqwerwqerwqer<img alt="153835_r9xk_1402271_thumb.gif" src="/Scripts/Ueditor/net/upload/image/20141120/6355209065181356956444327.gif" title="153835_r9xk_1402271_thumb.gif"/></p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3038, N'1111111111111111111', N'1', NULL, N'3df45a21-e94f-4e67-9e09-a87448b7885f', N'<p>1111</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3039, N'1134123', N'1234', NULL, N'4da3afc3-7131-4657-b0e2-4665884b6e35', N'<p>12342134</p>', 1)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3040, N'11341234123', N'2142134', NULL, N'4da3afc3-7131-4657-b0e2-4665884b6e35', N'<p>123423142314</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3041, N'qwerqwerq', N'werqwerweqr', NULL, N'4da3afc3-7131-4657-b0e2-4665884b6e35', N'<p>qwerqwerewq</p>', 1)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3042, N'213431241234', N'12342134', NULL, N'4da3afc3-7131-4657-b0e2-4665884b6e35', N'<p>2314231</p>', 1)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3043, N'qwerqewrqwerqwerqwerqwer', N'wqerwqer', NULL, N'4da3afc3-7131-4657-b0e2-4665884b6e35', N'<p>wqerweqrweqrwqrweq</p>', 1)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3044, N'qwerwqe', N'rqwerwqer', NULL, N'7a146fb1-4f3e-4a08-88ca-5287d87e1ddc', N'<p>qwerqwererqwreqw</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3045, N'1234123412341234', N'123421341234', NULL, N'4da3afc3-7131-4657-b0e2-4665884b6e35', N'<p>12342134</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3046, N'33333333333333333', N'33333333333333333333333333', NULL, N'4da3afc3-7131-4657-b0e2-4665884b6e35', N'<p>33333333333333333333333</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3047, N'wqerqwerwqerwqer', N'rrrrrrrrrrrrrrr', NULL, N'3df45a21-e94f-4e67-9e09-a87448b7885f,4da3afc3-7131-4657-b0e2-4665884b6e35', N'<p>wqerwqerqwe</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3048, N'143r515134', N'', NULL, N'3df45a21-e94f-4e67-9e09-a87448b7885f', N'<p>1<br/></p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3049, N'23452345423', N'', NULL, N'3df45a21-e94f-4e67-9e09-a87448b7885f', N'<p>2345qqwerqw<strong>ereqwrewr</strong></p><p>wrwer</p><p>qrqwer</p><p>wre<img src="/Scripts/Ueditor/net/upload/image/20150310/6356161444801361024305608.jpg" title="13.jpg" alt="13.jpg"/></p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3050, N'21123412', N'1243124', NULL, N'3df45a21-e94f-4e67-9e09-a87448b7885f', N'<p>111</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3051, N'hhhhhhhhhhhhhhh', N'hhhhhhhhhhh', NULL, N'3df45a21-e94f-4e67-9e09-a87448b7885f', N'<p>hhhhhhhhh<br/></p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3052, N'uuuuuuuuuuuuuu', N'uuuuuuuuuuuuuuunnnnnnnnnnnnnnnnnnnnn', NULL, N'3df45a21-e94f-4e67-9e09-a87448b7885f', N'<p><strong>uuuuuuuuuuuuuuuu</strong><em><span style="text-decoration: underline;"><strong>uuuuu</strong></span></em><strong>u</strong></p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3053, N'言言言言言言言言言 ', N'gggggggggggggggggggggggggggg', NULL, N'3df45a21-e94f-4e67-9e09-a87448b7885f', N'<p>gggggggggggggggggggggggggggggggggg</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3054, N'rrrrrrrrrrrrrrr', N'rrrrrrrrrrrrrrrrrrrrrrrr', NULL, N'3df45a21-e94f-4e67-9e09-a87448b7885f', N'<p>rrrrrrrrrrrrrrr</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3055, N'555555555555555', N'55555555555555555555555', NULL, N'3df45a21-e94f-4e67-9e09-a87448b7885f', N'<p>tttttttttttttttttttt</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3056, N'555555555555555', N'55555555555555555555555', NULL, N'3df45a21-e94f-4e67-9e09-a87448b7885f', N'<p>tttttttttttttttttttt</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3057, N'555555555555555', N'55555555555555555555555', NULL, N'3df45a21-e94f-4e67-9e09-a87448b7885f', N'<p>tttttttttttttttttttt</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (3058, N'555555555555555555555555', N'55555555555555555555555', NULL, N'3df45a21-e94f-4e67-9e09-a87448b7885f', N'<p>66666666666666666666666666666666666666666</p>', 1)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (4058, N'tttttttttttt', N'tttttttttttttttttttttttt', NULL, N'4da3afc3-7131-4657-b0e2-4665884b6e35', N'<p>tttggggggggggggggggggg</p>', 1)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (4059, N'12342134', N'23142134', NULL, N'7a146fb1-4f3e-4a08-88ca-5287d87e1ddc', N'<p>1234</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (4060, N'nnnnnnnnnnnn', N'nnnnnnnnnnnnnnnn', NULL, N'4da3afc3-7131-4657-b0e2-4665884b6e35', N'<p>uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu</p>', 1)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (4061, N'uuuuuuuuuuuu', N'uuuuuuuuuuuuuuuuuu', NULL, N'7a146fb1-4f3e-4a08-88ca-5287d87e1ddc', N'<p>uuuuuuuuuuuuu</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (4062, N'yyyyyyyyyyyy', N'yyyyyyyyyyyyyyyyyyyy', NULL, N'7a146fb1-4f3e-4a08-88ca-5287d87e1ddc', N'<p>yyyyyyyyyyyyy</p>', 1)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (4063, N'22222222222222222', N'555', NULL, N'7a146fb1-4f3e-4a08-88ca-5287d87e1ddc', N'<p>2222222222</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (4064, N'yyyyyyyyyyyyyyyy', N'yyyyyyyyyyyyyyyyyy', NULL, N'7a146fb1-4f3e-4a08-88ca-5287d87e1ddc', N'<p>yyyyyyyyyy</p>', 1)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (4065, N'ttttttttttttt', N'ttttttttttt', NULL, N'7a146fb1-4f3e-4a08-88ca-5287d87e1ddc', N'<p>tttttttttttyyyyyyttttt</p>', 1)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (4066, N'11111111111', N'1111111', NULL, N'4da3afc3-7131-4657-b0e2-4665884b6e35', N'<p>1111111111111xxxxxxxxx</p>', 1)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (4067, N'yyyyyyyyyyyyyyyyyyyyyyyyyyy', N'yyyyyyyyyyyyyyyyyyyyyy', NULL, N'7a146fb1-4f3e-4a08-88ca-5287d87e1ddc', N'<p>yyyyyyyyyyyyyyyyyy</p>', 1)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (4068, N'hhhhhhhhhhhhhhhhhhh', N'hhhhhhhhhhhhhhhhhhhhhhh', NULL, N'7a146fb1-4f3e-4a08-88ca-5287d87e1ddc', N'<p>hhhhhhhhhhhhhhyyyyyyyyyyyyy</p>', 1)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (4069, N'rrrrrrrrrr', N'rrrr', NULL, N'4da3afc3-7131-4657-b0e2-4665884b6e35', N'<p>rrrrr</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (4070, N'yyyyyyyy', N'yyy', NULL, N'7a146fb1-4f3e-4a08-88ca-5287d87e1ddc', N'<p>yyy</p>', 0)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (4071, N'gggggg', N'ggggg', NULL, N'7a146fb1-4f3e-4a08-88ca-5287d87e1ddc', N'<p>ggggg</p>', 1)
INSERT [TempTest_News] ([ID], [Title], [Title1], [UserID], [Type], [Contents], [State]) VALUES (4072, N'999', N'9999', NULL, N'4da3afc3-7131-4657-b0e2-4665884b6e35', N'<p>88</p>', 0)
SET IDENTITY_INSERT [TempTest_News] OFF
INSERT [TempTest_Purchase] ([ID], [Title], [UserID], [UserDept], [SqDateTime], [TypeOther], [Note], [IsCompleted]) VALUES (N'b3d6a9cd-01aa-42f6-9c00-1fd985b6460b', N'2141234', NULL, NULL, N'2015年06月10日', N'/Files/UploadFiles/201506/02/.net笔试题.docx', N'2141234', NULL)
INSERT [TempTest_Purchase] ([ID], [Title], [UserID], [UserDept], [SqDateTime], [TypeOther], [Note], [IsCompleted]) VALUES (N'6064f7cd-1e7b-4f65-9215-220f0b175a4d', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [TempTest_Purchase] ([ID], [Title], [UserID], [UserDept], [SqDateTime], [TypeOther], [Note], [IsCompleted]) VALUES (N'f5fe13f8-09a6-49ff-9521-85d09c7a0de5', N'nnnnnnnnnnn', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', NULL, NULL, NULL, NULL, NULL)
INSERT [TempTest_Purchase] ([ID], [Title], [UserID], [UserDept], [SqDateTime], [TypeOther], [Note], [IsCompleted]) VALUES (N'9bb52f09-2858-45b7-80eb-a87b1ddd8bc4', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [TempTest_Purchase] ([ID], [Title], [UserID], [UserDept], [SqDateTime], [TypeOther], [Note], [IsCompleted]) VALUES (N'55dcae3c-e7cc-47d5-919a-c61a3232de52', NULL, N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'96f75a51-779b-491a-9773-cb5f90cef11e', N'2015-07-23', NULL, N'21342134', NULL)
INSERT [TempTest_Purchase] ([ID], [Title], [UserID], [UserDept], [SqDateTime], [TypeOther], [Note], [IsCompleted]) VALUES (N'090f559d-8b3f-43f6-a623-dbcb59b88039', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [TempTest_Purchase] ([ID], [Title], [UserID], [UserDept], [SqDateTime], [TypeOther], [Note], [IsCompleted]) VALUES (N'5fdb9ef7-9e6c-4cad-b00e-de1e43bd7ce5', NULL, N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'96f75a51-779b-491a-9773-cb5f90cef11e', N'2015-07-06', NULL, N',rqwerqwer,,rqwerqwer,,rqwerqwer,,rqwerqwer', 1)
INSERT [TempTest_Purchase] ([ID], [Title], [UserID], [UserDept], [SqDateTime], [TypeOther], [Note], [IsCompleted]) VALUES (N'ac3343ae-e18d-409a-b5c1-e1a0c5a0f4d3', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [TempTest_Purchase] ([ID], [Title], [UserID], [UserDept], [SqDateTime], [TypeOther], [Note], [IsCompleted]) VALUES (N'ef359b01-9a6a-4389-b730-e93ad0aa10f5', NULL, N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'96f75a51-779b-491a-9773-cb5f90cef11e', N'2015/06/10', NULL, N',1234,,1234,,1234,,1234', NULL)
INSERT [TempTest_PurchaseList] ([ID], [PurchaseID], [Name], [Model], [Unit], [Quantity], [Sum1], [Date], [Type], [Note]) VALUES (N'6c2ed864-737e-4108-99a8-7dc1b444cf44', N'55dcae3c-e7cc-47d5-919a-c61a3232de52', N'qwer', N'2134', N'qwre', 2, NULL, CAST(0x0000A4D000000000 AS DateTime), N'办公用品', N'')
INSERT [TempTest_PurchaseList] ([ID], [PurchaseID], [Name], [Model], [Unit], [Quantity], [Sum1], [Date], [Type], [Note]) VALUES (N'd2c2f829-286d-4eec-941b-9381b4b16f15', N'55dcae3c-e7cc-47d5-919a-c61a3232de52', N'11111111111111111', N'1234', N'42314', 11111111, NULL, CAST(0x0000A4D600000000 AS DateTime), N'办公用品', N'')
SET IDENTITY_INSERT [TempTest_WorkOrder] ON 

INSERT [TempTest_WorkOrder] ([ID], [Client_Number], [Client_Name], [Client_Phone], [Client_Tel], [Client_Company], [Client_CarNumber], [Client_CarJH], [Disp_Number], [Disp_Urgency], [Disp_SubmitUser], [Disp_HelpModel], [Disp_SelectModel], [Disp_Jdd], [Disp_Time], [Disp_Bc], [Disp_Engineer], [Disp_EngineerPhone], [Disp_CarNumber], [Disp_Type], [Disp_BussType], [Disp_Completed], [Disp_Address]) VALUES (1, N'242314231', N'1243213', N'1234', N'2134', N'1241234', N'21342314', N'12342134', N'21341234124', N'一般', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'救援', N'用户自主选店', N'通宝', CAST(0x0000A49600000000 AS DateTime), N'白班', N'u_1acf9c22-bfb6-4673-a698-a58233747b92', N'2134213', N'12432134', N'现场处理', N'普通话', N'未完成', N'213421342134')
INSERT [TempTest_WorkOrder] ([ID], [Client_Number], [Client_Name], [Client_Phone], [Client_Tel], [Client_Company], [Client_CarNumber], [Client_CarJH], [Disp_Number], [Disp_Urgency], [Disp_SubmitUser], [Disp_HelpModel], [Disp_SelectModel], [Disp_Jdd], [Disp_Time], [Disp_Bc], [Disp_Engineer], [Disp_EngineerPhone], [Disp_CarNumber], [Disp_Type], [Disp_BussType], [Disp_Completed], [Disp_Address]) VALUES (2, N'4123412341', N'21341', N'421341', N'234123', N'2141234', N'123', N'412341', N'12341234123', N'一般', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'救援', N'用户自主选店', N'通宝', CAST(0x0000A49700000000 AS DateTime), N'白班', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'412341234', N'1243', N'现场处理', N'方言', N'已完成', N'123412342314')
SET IDENTITY_INSERT [TempTest_WorkOrder] OFF
INSERT [Users] ([ID], [Name], [Account], [Password], [Status], [Sort], [Note]) VALUES (N'23c3e9fc-6d8a-4ea0-925a-0a0671d61378', N'阿德明', N'admin', N'3FAC7AE3767C2FB89B67D714D9D99CA0', 0, 1, N'0')
INSERT [Users] ([ID], [Name], [Account], [Password], [Status], [Sort], [Note]) VALUES (N'0362149c-af22-491f-baef-37bffcc1fd5c', N'毛明明', N'mmm', N'7577447B52FB96045ADD91A8F2AB06FB', 0, 1, NULL)
INSERT [Users] ([ID], [Name], [Account], [Password], [Status], [Sort], [Note]) VALUES (N'095ba7de-084a-41aa-a21e-4ccbb7cd4ff8', N'张刚', N'zg', N'32D782480428DFB43FC52A3E89BD8B2E', 0, 3, N'0')
INSERT [Users] ([ID], [Name], [Account], [Password], [Status], [Sort], [Note]) VALUES (N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', N'xh', N'ECD43EBFA68902CD4E0DCBD8D44D694C', 0, 2, N'0')
INSERT [Users] ([ID], [Name], [Account], [Password], [Status], [Sort], [Note]) VALUES (N'c2d3012a-c816-4149-ac04-9da0b60e3867', N'王中平', N'wzp', N'A58EC1C8100D0E28ECAB5FE090F41CE2', 0, 1, NULL)
INSERT [Users] ([ID], [Name], [Account], [Password], [Status], [Sort], [Note]) VALUES (N'1acf9c22-bfb6-4673-a698-a58233747b92', N'周丽', N'zl', N'C6E72931096E04CBCC3F04ECA9A65515', 0, 1, N'0')
INSERT [Users] ([ID], [Name], [Account], [Password], [Status], [Sort], [Note]) VALUES (N'fded2b24-e7a0-41e4-90ed-aab7148ae113', N'王磊', N'wl', N'A812D75485728C38E831E7D9724C7BA8', 0, 4, N'0')
INSERT [Users] ([ID], [Name], [Account], [Password], [Status], [Sort], [Note]) VALUES (N'8086d01f-7ae3-402e-b543-d34f1059f79a', N'李晨新', N'lcx', N'5558FE1D778166F58C7E8CB7C505A2D0', 0, 1, N'0')
INSERT [UsersApp] ([ID], [UserID], [ParentID], [RoleID], [AppID], [Title], [Params], [Ico], [Sort]) VALUES (N'b161d811-e52f-41aa-b2be-eacb592e440b', N'1acf9c22-bfb6-4673-a698-a58233747b92', N'7a8294ed-4393-46eb-8f11-81bc7bbe8458', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', N'dd56ebf0-6fdb-46bf-86e9-9b57adb64766', N'请假申请', NULL, NULL, 11)
INSERT [UsersInfo] ([UserID], [Tel], [Phone], [OtherTel], [Fax], [Address], [Email], [QQ], [Note]) VALUES (N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'444444444444444', N'44444', N'11111', N'1111111111', N'111111111111', N'rwe', N'qrweq', N'xxxxxxxxxxxxxxxxxxxxxxx')
INSERT [UsersRelation] ([UserID], [OrganizeID], [IsMain], [Sort]) VALUES (N'23c3e9fc-6d8a-4ea0-925a-0a0671d61378', N'96f75a51-779b-491a-9773-cb5f90cef11e', 1, 4)
INSERT [UsersRelation] ([UserID], [OrganizeID], [IsMain], [Sort]) VALUES (N'0362149c-af22-491f-baef-37bffcc1fd5c', N'4f4865de-fda0-417b-9465-d7648309b772', 1, 4)
INSERT [UsersRelation] ([UserID], [OrganizeID], [IsMain], [Sort]) VALUES (N'095ba7de-084a-41aa-a21e-4ccbb7cd4ff8', N'96f75a51-779b-491a-9773-cb5f90cef11e', 1, 3)
INSERT [UsersRelation] ([UserID], [OrganizeID], [IsMain], [Sort]) VALUES (N'8d61ad4d-0742-411f-9fcb-935862185d56', N'04f12beb-d99d-43df-ac9a-3042957d6bda', 1, 1)
INSERT [UsersRelation] ([UserID], [OrganizeID], [IsMain], [Sort]) VALUES (N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'96f75a51-779b-491a-9773-cb5f90cef11e', 1, 5)
INSERT [UsersRelation] ([UserID], [OrganizeID], [IsMain], [Sort]) VALUES (N'c2d3012a-c816-4149-ac04-9da0b60e3867', N'1e9fba5a-7ba2-48dc-a89f-9377837912f7', 1, 1)
INSERT [UsersRelation] ([UserID], [OrganizeID], [IsMain], [Sort]) VALUES (N'1acf9c22-bfb6-4673-a698-a58233747b92', N'74ceda12-c919-4d80-b0f2-3ac254adb65a', 1, 1)
INSERT [UsersRelation] ([UserID], [OrganizeID], [IsMain], [Sort]) VALUES (N'fded2b24-e7a0-41e4-90ed-aab7148ae113', N'96f75a51-779b-491a-9773-cb5f90cef11e', 1, 1)
INSERT [UsersRelation] ([UserID], [OrganizeID], [IsMain], [Sort]) VALUES (N'8086d01f-7ae3-402e-b543-d34f1059f79a', N'82682cf5-50e1-4901-911b-1a935b5ddb6c', 1, 1)
INSERT [UsersRole] ([MemberID], [RoleID], [IsDefault]) VALUES (N'23c3e9fc-6d8a-4ea0-925a-0a0671d61378', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', 1)
INSERT [UsersRole] ([MemberID], [RoleID], [IsDefault]) VALUES (N'0362149c-af22-491f-baef-37bffcc1fd5c', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', 1)
INSERT [UsersRole] ([MemberID], [RoleID], [IsDefault]) VALUES (N'095ba7de-084a-41aa-a21e-4ccbb7cd4ff8', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', 1)
INSERT [UsersRole] ([MemberID], [RoleID], [IsDefault]) VALUES (N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'efb111aa-2308-48e2-b1fc-54181ec35e3f', 1)
INSERT [UsersRole] ([MemberID], [RoleID], [IsDefault]) VALUES (N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', 1)
INSERT [UsersRole] ([MemberID], [RoleID], [IsDefault]) VALUES (N'c2d3012a-c816-4149-ac04-9da0b60e3867', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', 1)
INSERT [UsersRole] ([MemberID], [RoleID], [IsDefault]) VALUES (N'1acf9c22-bfb6-4673-a698-a58233747b92', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', 1)
INSERT [UsersRole] ([MemberID], [RoleID], [IsDefault]) VALUES (N'fded2b24-e7a0-41e4-90ed-aab7148ae113', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', 1)
INSERT [UsersRole] ([MemberID], [RoleID], [IsDefault]) VALUES (N'8086d01f-7ae3-402e-b543-d34f1059f79a', N'0cf2abb1-5f90-4fb3-8fa9-b53628b92879', 1)
INSERT [WorkFlow] ([ID], [Name], [Type], [Manager], [InstanceManager], [CreateDate], [CreateUserID], [DesignJSON], [InstallDate], [InstallUserID], [RunJSON], [Status]) VALUES (N'c41d6eb9-e5f5-4171-a457-0cafe6b22757', N'物资采购申请', N'90d6ad24-28f5-49d3-ac3f-cb473fb64cc5', N'96f75a51-779b-491a-9773-cb5f90cef11e', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378', CAST(0x0000A32400B79416 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'{"id":"c41d6eb9-e5f5-4171-a457-0cafe6b22757","name":"物资采购申请","type":"90d6ad24-28f5-49d3-ac3f-cb473fb64cc5","manager":"96f75a51-779b-491a-9773-cb5f90cef11e","instanceManager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378","removeCompleted":"0","debug":"0","debugUsers":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","note":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest_Purchase","primaryKey":"ID"},{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest_PurchaseList","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest_Purchase","field":"IsCompleted"},"steps":[{"id":"122d7c1a-6479-4537-bb4d-b982d81d623d","type":"normal","name":"填写申请","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":28,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"3","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"f0aa6c46-5dcc-41a5-a811-b5d333986687","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Title","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserID","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserDept","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.SqDateTime","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.TypeOther","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Note","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.IsCompleted","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.PurchaseID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Name","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Model","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Unit","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Quantity","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Sum1","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Date","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Type","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Note","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"205be606-8380-4ec9-8335-c605e41b72c8","type":"normal","name":"部门审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"说明：金额小于1000元由公办室直接采购,大于等于1000元由分管领导审核,大于等于5000元需要部门会签","position":{"x":179,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"9","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"3","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"f0aa6c46-5dcc-41a5-a811-b5d333986687","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"other_splitline","sort":1},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":2},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":3}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserDept","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.SqDateTime","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.TypeOther","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Note","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.IsCompleted","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.PurchaseID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Name","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Model","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Unit","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Quantity","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Sum1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Date","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Note","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"d01ecc37-98e9-4901-8816-82efc70eb219","type":"normal","name":"分管领导审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"2","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":351,"y":98,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"10","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"f0aa6c46-5dcc-41a5-a811-b5d333986687","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserDept","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.SqDateTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.TypeOther","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Note","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.IsCompleted","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.PurchaseID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Name","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Model","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Unit","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Quantity","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Sum1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Date","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Note","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"05c306f4-2896-4d12-85fd-195ecfb8db0e","type":"normal","name":"总经理审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"2","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":528,"y":145,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"0","handlerType":"4","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"u_8086d01f-7ae3-402e-b543-d34f1059f79a","hanlderModel":"3","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"1","countersignaturePercentage":""},"forms":[{"id":"f0aa6c46-5dcc-41a5-a811-b5d333986687","name":"","type":"2a1070f6-af14-45b3-8292-fe0962701c04","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserDept","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.SqDateTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.TypeOther","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Note","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.IsCompleted","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.PurchaseID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Name","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Model","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Unit","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Quantity","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Sum1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Date","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Note","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"b4d9efa0-23d5-49e3-8fdd-403a06b37ca2","type":"normal","name":"财务部会签","opinionDisplay":"1","expiredPrompt":"1","signatureType":"1","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":348,"y":184,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"0","handlerType":"4","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"u_c2d3012a-c816-4149-ac04-9da0b60e3867","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"f0aa6c46-5dcc-41a5-a811-b5d333986687","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserDept","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.SqDateTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.TypeOther","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Note","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.IsCompleted","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.PurchaseID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Name","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Model","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Unit","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Quantity","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Sum1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Date","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Note","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"dbe24bf8-981c-4f83-b936-f671fe1b4f57","type":"normal","name":"办公室采购","opinionDisplay":"1","expiredPrompt":"1","signatureType":"2","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":529,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"4","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","hanlderModel":"3","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"f0aa6c46-5dcc-41a5-a811-b5d333986687","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":1},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":2}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserDept","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.SqDateTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.TypeOther","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Note","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.IsCompleted","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.PurchaseID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Name","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Model","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Unit","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Quantity","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Sum1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Date","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Note","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"3167d841-b10b-403a-b4ca-3bb54c60bee0","type":"normal","name":"通知发起人领用","opinionDisplay":"1","expiredPrompt":"1","signatureType":"2","workTime":"","limitTime":"","otherTime":"","archives":"1","archivesParams":"","note":"","position":{"x":680,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"0","handlerType":"5","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"0","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"f0aa6c46-5dcc-41a5-a811-b5d333986687","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"954effa8-03b8-461a-aaa8-8727d090dcb9","sort":0}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserDept","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.SqDateTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.TypeOther","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Note","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.IsCompleted","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.PurchaseID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Name","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Model","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Unit","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Quantity","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Sum1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Date","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Note","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"836673ab-41a2-4dbd-920d-5ea25b0a8cc7","type":"normal","name":"技术部会签","opinionDisplay":"1","expiredPrompt":"1","signatureType":"1","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":349,"y":254,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"0","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"f0aa6c46-5dcc-41a5-a811-b5d333986687","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserDept","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.SqDateTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.TypeOther","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Note","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.IsCompleted","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.PurchaseID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Name","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Model","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Unit","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Quantity","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Sum1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Date","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Note","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"7f49aa0c-4012-4591-9608-f7f5d657018d","type":"normal","name":"销售部会签","opinionDisplay":"1","expiredPrompt":"1","signatureType":"1","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":347,"y":330,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"0","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"u_0362149c-af22-491f-baef-37bffcc1fd5c","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"f0aa6c46-5dcc-41a5-a811-b5d333986687","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserDept","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.SqDateTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.TypeOther","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Note","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.IsCompleted","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.PurchaseID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Name","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Model","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Unit","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Quantity","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Sum1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Date","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Note","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"lines":[{"id":"572db0d0-1bab-4462-9811-d8360de3ef8a","from":"122d7c1a-6479-4537-bb4d-b982d81d623d","to":"205be606-8380-4ec9-8335-c605e41b72c8","customMethod":"","sql":"","noaccordMsg":""},{"id":"da353191-ff6f-489d-a37c-2a52e2ae4839","from":"205be606-8380-4ec9-8335-c605e41b72c8","to":"d01ecc37-98e9-4901-8816-82efc70eb219","customMethod":"","text":"","sql":"(select sum(sum1) from TempTest_PurchaseList where PurchaseID=TempTest_Purchase.ID)>=1000 and (select sum(sum1) from TempTest_PurchaseList where PurchaseID=TempTest_Purchase.ID)<5000","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"},{"id":"faaf7a13-7e5f-423e-bf0f-39e4206daef1","from":"205be606-8380-4ec9-8335-c605e41b72c8","to":"b4d9efa0-23d5-49e3-8fdd-403a06b37ca2","customMethod":"","sql":"(select sum(sum1) from TempTest_PurchaseList where PurchaseID=TempTest_Purchase.ID)>=5000"},{"id":"79d5384e-53f4-4ecf-8af8-a7ab4d718fef","from":"d01ecc37-98e9-4901-8816-82efc70eb219","to":"dbe24bf8-981c-4f83-b936-f671fe1b4f57","customMethod":"","sql":"","noaccordMsg":""},{"id":"f42ded8b-50d4-46c4-8d0b-38a666f10b01","from":"205be606-8380-4ec9-8335-c605e41b72c8","to":"dbe24bf8-981c-4f83-b936-f671fe1b4f57","customMethod":"","text":"","sql":"(select sum(sum1) from TempTest_PurchaseList where PurchaseID=TempTest_Purchase.ID)<1000","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"},{"id":"988033e4-ef06-48f8-9b80-f96c47807aaa","from":"dbe24bf8-981c-4f83-b936-f671fe1b4f57","to":"3167d841-b10b-403a-b4ca-3bb54c60bee0","customMethod":"","sql":"","noaccordMsg":""},{"id":"5d183749-7fc0-49ec-9d29-dabfb2ba7754","from":"205be606-8380-4ec9-8335-c605e41b72c8","to":"836673ab-41a2-4dbd-920d-5ea25b0a8cc7","customMethod":"","sql":"(select sum(sum1) from TempTest_PurchaseList where PurchaseID=TempTest_Purchase.ID)>=5000"},{"id":"c7f82a73-58e6-4f37-ba0b-ee52cfba8935","from":"205be606-8380-4ec9-8335-c605e41b72c8","to":"7f49aa0c-4012-4591-9608-f7f5d657018d","customMethod":"","sql":"(select sum(sum1) from TempTest_PurchaseList where PurchaseID=TempTest_Purchase.ID)>=5000"},{"id":"2f9baadc-edde-41af-9704-c2f81ebf352c","from":"b4d9efa0-23d5-49e3-8fdd-403a06b37ca2","to":"05c306f4-2896-4d12-85fd-195ecfb8db0e","customMethod":"","sql":"","noaccordMsg":""},{"id":"abedd949-1277-4932-b747-cc76635b4e1c","from":"836673ab-41a2-4dbd-920d-5ea25b0a8cc7","to":"05c306f4-2896-4d12-85fd-195ecfb8db0e","customMethod":"","sql":"","noaccordMsg":""},{"id":"b8a2eb3b-0247-4cc1-a53f-79cc159ba97c","from":"7f49aa0c-4012-4591-9608-f7f5d657018d","to":"05c306f4-2896-4d12-85fd-195ecfb8db0e","customMethod":"","sql":"","noaccordMsg":""},{"id":"baa6579f-9f55-4109-bbfe-06bebb05975d","from":"05c306f4-2896-4d12-85fd-195ecfb8db0e","to":"dbe24bf8-981c-4f83-b936-f671fe1b4f57","customMethod":"","sql":"","noaccordMsg":""}]}', CAST(0x0000A4DF012C51AF AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'{"id":"c41d6eb9-e5f5-4171-a457-0cafe6b22757","name":"物资采购申请","type":"90d6ad24-28f5-49d3-ac3f-cb473fb64cc5","manager":"96f75a51-779b-491a-9773-cb5f90cef11e","instanceManager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378","removeCompleted":"0","debug":"0","debugUsers":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","note":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest_Purchase","primaryKey":"ID"},{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest_PurchaseList","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest_Purchase","field":"IsCompleted"},"steps":[{"id":"122d7c1a-6479-4537-bb4d-b982d81d623d","type":"normal","name":"填写申请","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":28,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"3","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"f0aa6c46-5dcc-41a5-a811-b5d333986687","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Title","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserID","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserDept","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.SqDateTime","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.TypeOther","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Note","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.IsCompleted","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.PurchaseID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Name","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Model","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Unit","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Quantity","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Sum1","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Date","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Type","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Note","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"205be606-8380-4ec9-8335-c605e41b72c8","type":"normal","name":"部门审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"说明：金额小于1000元由公办室直接采购,大于等于1000元由分管领导审核,大于等于5000元需要部门会签","position":{"x":179,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"9","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"3","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"f0aa6c46-5dcc-41a5-a811-b5d333986687","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"other_splitline","sort":1},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":2},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":3}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserDept","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.SqDateTime","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.TypeOther","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Note","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.IsCompleted","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.PurchaseID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Name","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Model","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Unit","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Quantity","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Sum1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Date","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Note","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"d01ecc37-98e9-4901-8816-82efc70eb219","type":"normal","name":"分管领导审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"2","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":351,"y":98,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"10","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"f0aa6c46-5dcc-41a5-a811-b5d333986687","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserDept","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.SqDateTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.TypeOther","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Note","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.IsCompleted","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.PurchaseID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Name","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Model","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Unit","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Quantity","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Sum1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Date","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Note","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"05c306f4-2896-4d12-85fd-195ecfb8db0e","type":"normal","name":"总经理审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"2","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":528,"y":145,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"0","handlerType":"4","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"u_8086d01f-7ae3-402e-b543-d34f1059f79a","hanlderModel":"3","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"1","countersignaturePercentage":""},"forms":[{"id":"f0aa6c46-5dcc-41a5-a811-b5d333986687","name":"","type":"2a1070f6-af14-45b3-8292-fe0962701c04","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserDept","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.SqDateTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.TypeOther","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Note","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.IsCompleted","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.PurchaseID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Name","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Model","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Unit","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Quantity","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Sum1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Date","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Note","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"b4d9efa0-23d5-49e3-8fdd-403a06b37ca2","type":"normal","name":"财务部会签","opinionDisplay":"1","expiredPrompt":"1","signatureType":"1","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":348,"y":184,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"0","handlerType":"4","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"u_c2d3012a-c816-4149-ac04-9da0b60e3867","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"f0aa6c46-5dcc-41a5-a811-b5d333986687","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserDept","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.SqDateTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.TypeOther","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Note","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.IsCompleted","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.PurchaseID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Name","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Model","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Unit","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Quantity","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Sum1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Date","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Note","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"dbe24bf8-981c-4f83-b936-f671fe1b4f57","type":"normal","name":"办公室采购","opinionDisplay":"1","expiredPrompt":"1","signatureType":"2","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":529,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"4","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","hanlderModel":"3","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"f0aa6c46-5dcc-41a5-a811-b5d333986687","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":1},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":2}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserDept","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.SqDateTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.TypeOther","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Note","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.IsCompleted","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.PurchaseID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Name","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Model","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Unit","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Quantity","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Sum1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Date","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Note","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"3167d841-b10b-403a-b4ca-3bb54c60bee0","type":"normal","name":"通知发起人领用","opinionDisplay":"1","expiredPrompt":"1","signatureType":"2","workTime":"","limitTime":"","otherTime":"","archives":"1","archivesParams":"","note":"","position":{"x":680,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"0","handlerType":"5","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"0","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"f0aa6c46-5dcc-41a5-a811-b5d333986687","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"954effa8-03b8-461a-aaa8-8727d090dcb9","sort":0}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserDept","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.SqDateTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.TypeOther","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Note","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.IsCompleted","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.PurchaseID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Name","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Model","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Unit","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Quantity","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Sum1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Date","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Note","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"836673ab-41a2-4dbd-920d-5ea25b0a8cc7","type":"normal","name":"技术部会签","opinionDisplay":"1","expiredPrompt":"1","signatureType":"1","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":349,"y":254,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"0","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"f0aa6c46-5dcc-41a5-a811-b5d333986687","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserDept","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.SqDateTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.TypeOther","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Note","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.IsCompleted","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.PurchaseID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Name","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Model","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Unit","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Quantity","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Sum1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Date","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Note","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"7f49aa0c-4012-4591-9608-f7f5d657018d","type":"normal","name":"销售部会签","opinionDisplay":"1","expiredPrompt":"1","signatureType":"1","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":347,"y":330,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"0","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"u_0362149c-af22-491f-baef-37bffcc1fd5c","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"f0aa6c46-5dcc-41a5-a811-b5d333986687","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.UserDept","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.SqDateTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.TypeOther","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.Note","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_Purchase.IsCompleted","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.PurchaseID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Name","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Model","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Unit","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Quantity","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Sum1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Date","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_PurchaseList.Note","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"lines":[{"id":"572db0d0-1bab-4462-9811-d8360de3ef8a","from":"122d7c1a-6479-4537-bb4d-b982d81d623d","to":"205be606-8380-4ec9-8335-c605e41b72c8","customMethod":"","sql":"","noaccordMsg":""},{"id":"da353191-ff6f-489d-a37c-2a52e2ae4839","from":"205be606-8380-4ec9-8335-c605e41b72c8","to":"d01ecc37-98e9-4901-8816-82efc70eb219","customMethod":"","text":"","sql":"(select sum(sum1) from TempTest_PurchaseList where PurchaseID=TempTest_Purchase.ID)>=1000 and (select sum(sum1) from TempTest_PurchaseList where PurchaseID=TempTest_Purchase.ID)<5000","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"},{"id":"faaf7a13-7e5f-423e-bf0f-39e4206daef1","from":"205be606-8380-4ec9-8335-c605e41b72c8","to":"b4d9efa0-23d5-49e3-8fdd-403a06b37ca2","customMethod":"","sql":"(select sum(sum1) from TempTest_PurchaseList where PurchaseID=TempTest_Purchase.ID)>=5000"},{"id":"79d5384e-53f4-4ecf-8af8-a7ab4d718fef","from":"d01ecc37-98e9-4901-8816-82efc70eb219","to":"dbe24bf8-981c-4f83-b936-f671fe1b4f57","customMethod":"","sql":"","noaccordMsg":""},{"id":"f42ded8b-50d4-46c4-8d0b-38a666f10b01","from":"205be606-8380-4ec9-8335-c605e41b72c8","to":"dbe24bf8-981c-4f83-b936-f671fe1b4f57","customMethod":"","text":"","sql":"(select sum(sum1) from TempTest_PurchaseList where PurchaseID=TempTest_Purchase.ID)<1000","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"},{"id":"988033e4-ef06-48f8-9b80-f96c47807aaa","from":"dbe24bf8-981c-4f83-b936-f671fe1b4f57","to":"3167d841-b10b-403a-b4ca-3bb54c60bee0","customMethod":"","sql":"","noaccordMsg":""},{"id":"5d183749-7fc0-49ec-9d29-dabfb2ba7754","from":"205be606-8380-4ec9-8335-c605e41b72c8","to":"836673ab-41a2-4dbd-920d-5ea25b0a8cc7","customMethod":"","sql":"(select sum(sum1) from TempTest_PurchaseList where PurchaseID=TempTest_Purchase.ID)>=5000"},{"id":"c7f82a73-58e6-4f37-ba0b-ee52cfba8935","from":"205be606-8380-4ec9-8335-c605e41b72c8","to":"7f49aa0c-4012-4591-9608-f7f5d657018d","customMethod":"","sql":"(select sum(sum1) from TempTest_PurchaseList where PurchaseID=TempTest_Purchase.ID)>=5000"},{"id":"2f9baadc-edde-41af-9704-c2f81ebf352c","from":"b4d9efa0-23d5-49e3-8fdd-403a06b37ca2","to":"05c306f4-2896-4d12-85fd-195ecfb8db0e","customMethod":"","sql":"","noaccordMsg":""},{"id":"abedd949-1277-4932-b747-cc76635b4e1c","from":"836673ab-41a2-4dbd-920d-5ea25b0a8cc7","to":"05c306f4-2896-4d12-85fd-195ecfb8db0e","customMethod":"","sql":"","noaccordMsg":""},{"id":"b8a2eb3b-0247-4cc1-a53f-79cc159ba97c","from":"7f49aa0c-4012-4591-9608-f7f5d657018d","to":"05c306f4-2896-4d12-85fd-195ecfb8db0e","customMethod":"","sql":"","noaccordMsg":""},{"id":"baa6579f-9f55-4109-bbfe-06bebb05975d","from":"05c306f4-2896-4d12-85fd-195ecfb8db0e","to":"dbe24bf8-981c-4f83-b936-f671fe1b4f57","customMethod":"","sql":"","noaccordMsg":""}]}', 2)
INSERT [WorkFlow] ([ID], [Name], [Type], [Manager], [InstanceManager], [CreateDate], [CreateUserID], [DesignJSON], [InstallDate], [InstallUserID], [RunJSON], [Status]) VALUES (N'f35d0b4a-b1f9-4fdc-b552-3720953b889f', N'会签测试', N'90d6ad24-28f5-49d3-ac3f-cb473fb64cc5', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378', CAST(0x0000A3C400AB7D77 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'{"id":"f35d0b4a-b1f9-4fdc-b552-3720953b889f","name":"会签测试","type":"90d6ad24-28f5-49d3-ac3f-cb473fb64cc5","manager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378","instanceManager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378","removeCompleted":"0","debug":"0","debugUsers":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","note":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest_News","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest_News","field":"State"},"steps":[{"id":"77a56a2d-4ff2-4b88-804c-da81dc96e88f","type":"normal","name":"发起申请","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":12,"y":126,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.State","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"24986fbb-a343-4701-818b-f3755b1700d4","type":"normal","name":"财务部审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":228,"y":45,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"3975624c-148f-4838-88c9-12af85d2e05e","handlerStep":"","valueField":"","defaultHandler":"u_c2d3012a-c816-4149-ac04-9da0b60e3867","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.State","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"6ed3e265-f90f-4d2d-9813-1d00b0408dd7","type":"normal","name":"研发部审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":230,"y":126,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"96f75a51-779b-491a-9773-cb5f90cef11e","handlerStep":"","valueField":"","defaultHandler":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","hanlderModel":"1","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.State","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"1a29f7fb-b8e2-4fbc-96e6-e5f0065dcd11","type":"normal","name":"市场部审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":233,"y":225,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"4f4865de-fda0-417b-9465-d7648309b772","handlerStep":"","valueField":"","defaultHandler":"u_0362149c-af22-491f-baef-37bffcc1fd5c","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.State","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"7f865ae5-7e63-4797-97dd-eac5be6ab807","type":"normal","name":"总经理批准","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":482,"y":126,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"82682cf5-50e1-4901-911b-1a935b5ddb6c","handlerStep":"","valueField":"","defaultHandler":"u_8086d01f-7ae3-402e-b543-d34f1059f79a","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"1","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"b8a7af17-7ad5-4699-b679-d421691dd737","sort":0},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":1},{"id":"954effa8-03b8-461a-aaa8-8727d090dcb9","sort":2}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.State","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"lines":[{"id":"c0456161-b50f-4d32-bb2c-c8ee1ef70d5a","from":"77a56a2d-4ff2-4b88-804c-da81dc96e88f","to":"24986fbb-a343-4701-818b-f3755b1700d4","customMethod":"","sql":"","noaccordMsg":""},{"id":"a5079b90-ff07-4e0f-91b5-a00664a337d1","from":"77a56a2d-4ff2-4b88-804c-da81dc96e88f","to":"6ed3e265-f90f-4d2d-9813-1d00b0408dd7","customMethod":"","sql":"","noaccordMsg":""},{"id":"a90135e4-5680-4864-8b7e-37a2a0255600","from":"77a56a2d-4ff2-4b88-804c-da81dc96e88f","to":"1a29f7fb-b8e2-4fbc-96e6-e5f0065dcd11","customMethod":"","text":"","sql":"","title":"","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"},{"id":"423786c5-e5b3-404b-a67e-93d6c9a4c052","from":"24986fbb-a343-4701-818b-f3755b1700d4","to":"7f865ae5-7e63-4797-97dd-eac5be6ab807","customMethod":"","sql":"","noaccordMsg":""},{"id":"b554d41b-0009-473d-a626-5a27661484d6","from":"6ed3e265-f90f-4d2d-9813-1d00b0408dd7","to":"7f865ae5-7e63-4797-97dd-eac5be6ab807","customMethod":"","sql":"","noaccordMsg":""},{"id":"9edecaed-7d6c-4af7-b90d-2599035796fe","from":"1a29f7fb-b8e2-4fbc-96e6-e5f0065dcd11","to":"7f865ae5-7e63-4797-97dd-eac5be6ab807","customMethod":"","sql":"","noaccordMsg":""}]}', CAST(0x0000A56E011F14F3 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'{"id":"f35d0b4a-b1f9-4fdc-b552-3720953b889f","name":"会签测试","type":"90d6ad24-28f5-49d3-ac3f-cb473fb64cc5","manager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378","instanceManager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378","removeCompleted":"0","debug":"0","debugUsers":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","note":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest_News","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest_News","field":"State"},"steps":[{"id":"77a56a2d-4ff2-4b88-804c-da81dc96e88f","type":"normal","name":"发起申请","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":12,"y":126,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.State","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"24986fbb-a343-4701-818b-f3755b1700d4","type":"normal","name":"财务部审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":228,"y":45,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"3975624c-148f-4838-88c9-12af85d2e05e","handlerStep":"","valueField":"","defaultHandler":"u_c2d3012a-c816-4149-ac04-9da0b60e3867","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.State","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"6ed3e265-f90f-4d2d-9813-1d00b0408dd7","type":"normal","name":"研发部审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":230,"y":126,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"96f75a51-779b-491a-9773-cb5f90cef11e","handlerStep":"","valueField":"","defaultHandler":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","hanlderModel":"1","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.State","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"1a29f7fb-b8e2-4fbc-96e6-e5f0065dcd11","type":"normal","name":"市场部审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":233,"y":225,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"4f4865de-fda0-417b-9465-d7648309b772","handlerStep":"","valueField":"","defaultHandler":"u_0362149c-af22-491f-baef-37bffcc1fd5c","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.State","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"7f865ae5-7e63-4797-97dd-eac5be6ab807","type":"normal","name":"总经理批准","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":482,"y":126,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"82682cf5-50e1-4901-911b-1a935b5ddb6c","handlerStep":"","valueField":"","defaultHandler":"u_8086d01f-7ae3-402e-b543-d34f1059f79a","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"1","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"b8a7af17-7ad5-4699-b679-d421691dd737","sort":0},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":1},{"id":"954effa8-03b8-461a-aaa8-8727d090dcb9","sort":2}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.State","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"lines":[{"id":"c0456161-b50f-4d32-bb2c-c8ee1ef70d5a","from":"77a56a2d-4ff2-4b88-804c-da81dc96e88f","to":"24986fbb-a343-4701-818b-f3755b1700d4","customMethod":"","sql":"","noaccordMsg":""},{"id":"a5079b90-ff07-4e0f-91b5-a00664a337d1","from":"77a56a2d-4ff2-4b88-804c-da81dc96e88f","to":"6ed3e265-f90f-4d2d-9813-1d00b0408dd7","customMethod":"","sql":"","noaccordMsg":""},{"id":"a90135e4-5680-4864-8b7e-37a2a0255600","from":"77a56a2d-4ff2-4b88-804c-da81dc96e88f","to":"1a29f7fb-b8e2-4fbc-96e6-e5f0065dcd11","customMethod":"","text":"","sql":"","title":"","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"},{"id":"423786c5-e5b3-404b-a67e-93d6c9a4c052","from":"24986fbb-a343-4701-818b-f3755b1700d4","to":"7f865ae5-7e63-4797-97dd-eac5be6ab807","customMethod":"","sql":"","noaccordMsg":""},{"id":"b554d41b-0009-473d-a626-5a27661484d6","from":"6ed3e265-f90f-4d2d-9813-1d00b0408dd7","to":"7f865ae5-7e63-4797-97dd-eac5be6ab807","customMethod":"","sql":"","noaccordMsg":""},{"id":"9edecaed-7d6c-4af7-b90d-2599035796fe","from":"1a29f7fb-b8e2-4fbc-96e6-e5f0065dcd11","to":"7f865ae5-7e63-4797-97dd-eac5be6ab807","customMethod":"","sql":"","noaccordMsg":""}]}', 2)
INSERT [WorkFlow] ([ID], [Name], [Type], [Manager], [InstanceManager], [CreateDate], [CreateUserID], [DesignJSON], [InstallDate], [InstallUserID], [RunJSON], [Status]) VALUES (N'04018979-6810-456a-9e15-396c4849e31a', N'综合测试', N'48d05cf9-81c2-4713-87ab-1a45321500de', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', CAST(0x0000A567016AD54D AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'{"id":"04018979-6810-456a-9e15-396c4849e31a","name":"综合测试","type":"48d05cf9-81c2-4713-87ab-1a45321500de","manager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","instanceManager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","removeCompleted":"0","debug":"0","debugUsers":"","note":"","flowType":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest_CustomForm","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest_CustomForm","field":"FlowCompleted"},"steps":[{"id":"d6f56e83-0e7b-4928-92c4-207e65b3d271","type":"normal","name":"新步骤","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":10,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":"","copyFor":"","concurrentModel":"0"},"forms":[{"id":"9be06969-89ea-406d-8262-691700c37c77","name":"","type":"7283b92f-21b4-4b0a-8b00-72cc9656f4dc","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"c53824ca-dacb-49bc-9dae-bebb596f6f55","type":"normal","name":"新步骤2","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":350,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":"","copyFor":"","concurrentModel":"0"},"forms":[{"id":"9be06969-89ea-406d-8262-691700c37c77","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"954effa8-03b8-461a-aaa8-8727d090dcb9","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"bd1eb25a-835f-4a4a-91b6-47a20b69620d","type":"normal","name":"新步骤1","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":180,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"3","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":"","copyFor":"","concurrentModel":"0"},"forms":[{"id":"9be06969-89ea-406d-8262-691700c37c77","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"lines":[{"id":"9cd635c5-360a-44b7-bda0-e31217d44269","text":"","from":"d6f56e83-0e7b-4928-92c4-207e65b3d271","to":"bd1eb25a-835f-4a4a-91b6-47a20b69620d","customMethod":"","sql":"","noaccordMsg":""},{"id":"4c374fb6-02c0-408c-a461-1b3425742e95","from":"bd1eb25a-835f-4a4a-91b6-47a20b69620d","to":"c53824ca-dacb-49bc-9dae-bebb596f6f55","customMethod":"","text":"","sql":"1=0","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"}]}', CAST(0x0000A56E010B612B AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'{"id":"04018979-6810-456a-9e15-396c4849e31a","name":"综合测试","type":"48d05cf9-81c2-4713-87ab-1a45321500de","manager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","instanceManager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","removeCompleted":"0","debug":"0","debugUsers":"","note":"","flowType":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest_CustomForm","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest_CustomForm","field":"FlowCompleted"},"steps":[{"id":"d6f56e83-0e7b-4928-92c4-207e65b3d271","type":"normal","name":"新步骤","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":10,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":"","copyFor":"","concurrentModel":"0"},"forms":[{"id":"9be06969-89ea-406d-8262-691700c37c77","name":"","type":"7283b92f-21b4-4b0a-8b00-72cc9656f4dc","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"c53824ca-dacb-49bc-9dae-bebb596f6f55","type":"normal","name":"新步骤2","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":350,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":"","copyFor":"","concurrentModel":"0"},"forms":[{"id":"9be06969-89ea-406d-8262-691700c37c77","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"954effa8-03b8-461a-aaa8-8727d090dcb9","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"bd1eb25a-835f-4a4a-91b6-47a20b69620d","type":"normal","name":"新步骤1","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":180,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"3","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":"","copyFor":"","concurrentModel":"0"},"forms":[{"id":"9be06969-89ea-406d-8262-691700c37c77","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"lines":[{"id":"9cd635c5-360a-44b7-bda0-e31217d44269","text":"","from":"d6f56e83-0e7b-4928-92c4-207e65b3d271","to":"bd1eb25a-835f-4a4a-91b6-47a20b69620d","customMethod":"","sql":"","noaccordMsg":""},{"id":"4c374fb6-02c0-408c-a461-1b3425742e95","from":"bd1eb25a-835f-4a4a-91b6-47a20b69620d","to":"c53824ca-dacb-49bc-9dae-bebb596f6f55","customMethod":"","text":"","sql":"1=0","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"}]}', 2)
INSERT [WorkFlow] ([ID], [Name], [Type], [Manager], [InstanceManager], [CreateDate], [CreateUserID], [DesignJSON], [InstallDate], [InstallUserID], [RunJSON], [Status]) VALUES (N'6f24065c-18e5-443b-8935-3a531678a842', N'自由流程测试', N'90d6ad24-28f5-49d3-ac3f-cb473fb64cc5', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', CAST(0x0000A50E00FD22E7 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'{"id":"6f24065c-18e5-443b-8935-3a531678a842","name":"自由流程测试","type":"90d6ad24-28f5-49d3-ac3f-cb473fb64cc5","manager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","instanceManager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","removeCompleted":"0","debug":"0","debugUsers":"","note":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest_CustomForm","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest_CustomForm","field":"FlowCompleted"},"steps":[{"id":"19dfdd62-4e3a-4d00-bc74-fe2764bd32e6","type":"normal","name":"发起","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":10,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":"","copyFor":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"flowType":"1"}', CAST(0x0000A50E0114188A AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'{"id":"6f24065c-18e5-443b-8935-3a531678a842","name":"自由流程测试","type":"90d6ad24-28f5-49d3-ac3f-cb473fb64cc5","manager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","instanceManager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","removeCompleted":"0","debug":"0","debugUsers":"","note":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest_CustomForm","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest_CustomForm","field":"FlowCompleted"},"steps":[{"id":"19dfdd62-4e3a-4d00-bc74-fe2764bd32e6","type":"normal","name":"发起","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":10,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":"","copyFor":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"flowType":"1"}', 2)
INSERT [WorkFlow] ([ID], [Name], [Type], [Manager], [InstanceManager], [CreateDate], [CreateUserID], [DesignJSON], [InstallDate], [InstallUserID], [RunJSON], [Status]) VALUES (N'86875775-2f25-443d-ac42-57124f3479a5', N'信息发布', N'48d05cf9-81c2-4713-87ab-1a45321500de', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', CAST(0x0000A33A016564C5 AS DateTime), N'23c3e9fc-6d8a-4ea0-925a-0a0671d61378', N'{"id":"86875775-2f25-443d-ac42-57124f3479a5","name":"信息发布","type":"48d05cf9-81c2-4713-87ab-1a45321500de","manager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","instanceManager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","removeCompleted":"0","debug":"0","debugUsers":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","note":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest_News","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest_News","field":"State"},"steps":[{"id":"a292842c-3041-4492-b098-82092a3dd651","type":"normal","name":"编辑","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":8,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"0","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"ff355143-fa05-4d3c-ace8-92acc7c59ca8","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Type","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Contents","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.State","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"18337d9c-be91-4963-8d0a-ae188829a3b6","type":"normal","name":"审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"2","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":180,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"2","runSelect":"0","handlerType":"14","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"2","backModel":"1","backType":"0","backStep":"","percentage":"50","countersignature":"0","countersignaturePercentage":"","copyFor":"u_0362149c-af22-491f-baef-37bffcc1fd5c"},"forms":[{"id":"ff355143-fa05-4d3c-ace8-92acc7c59ca8","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"347b811c-7568-4472-9a61-6c31f66980ae","sort":0},{"id":"other_splitline","sort":1},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":2},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":3}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Contents","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.State","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"89047e5f-d548-4142-826d-33d0af8c393c","type":"normal","name":"发布","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":508,"y":51,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"2","backModel":"1","backType":"0","backStep":"","percentage":"60","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"ff355143-fa05-4d3c-ace8-92acc7c59ca8","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Contents","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.State","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"3f1dead9-5c71-4a45-b378-aa714a02539d","type":"normal","name":"批准","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":345,"y":51,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"ff355143-fa05-4d3c-ace8-92acc7c59ca8","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.State","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"lines":[{"id":"e7f35492-3b0c-4869-8afb-40c6e289bafe","from":"a292842c-3041-4492-b098-82092a3dd651","to":"18337d9c-be91-4963-8d0a-ae188829a3b6","customMethod":"","sql":"","noaccordMsg":""},{"id":"a39a3a78-5e92-46cc-aabf-e2034b81494a","text":"","from":"18337d9c-be91-4963-8d0a-ae188829a3b6","to":"3f1dead9-5c71-4a45-b378-aa714a02539d","customMethod":"","sql":"","noaccordMsg":""},{"id":"327b0dcc-0809-4535-ab9f-036904cedfd9","text":"","from":"3f1dead9-5c71-4a45-b378-aa714a02539d","to":"89047e5f-d548-4142-826d-33d0af8c393c","customMethod":"","sql":"","noaccordMsg":""}]}', CAST(0x0000A538015E3D5D AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'{"id":"86875775-2f25-443d-ac42-57124f3479a5","name":"信息发布","type":"48d05cf9-81c2-4713-87ab-1a45321500de","manager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","instanceManager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","removeCompleted":"0","debug":"0","debugUsers":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","note":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest_News","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest_News","field":"State"},"steps":[{"id":"a292842c-3041-4492-b098-82092a3dd651","type":"normal","name":"编辑","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":8,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"0","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"ff355143-fa05-4d3c-ace8-92acc7c59ca8","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Type","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Contents","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.State","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"18337d9c-be91-4963-8d0a-ae188829a3b6","type":"normal","name":"审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"2","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":180,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"2","runSelect":"0","handlerType":"14","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"2","backModel":"1","backType":"0","backStep":"","percentage":"50","countersignature":"0","countersignaturePercentage":"","copyFor":"u_0362149c-af22-491f-baef-37bffcc1fd5c"},"forms":[{"id":"ff355143-fa05-4d3c-ace8-92acc7c59ca8","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"347b811c-7568-4472-9a61-6c31f66980ae","sort":0},{"id":"other_splitline","sort":1},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":2},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":3}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Contents","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.State","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"89047e5f-d548-4142-826d-33d0af8c393c","type":"normal","name":"发布","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":508,"y":51,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"2","backModel":"1","backType":"0","backStep":"","percentage":"60","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"ff355143-fa05-4d3c-ace8-92acc7c59ca8","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Contents","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.State","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"3f1dead9-5c71-4a45-b378-aa714a02539d","type":"normal","name":"批准","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":345,"y":51,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"ff355143-fa05-4d3c-ace8-92acc7c59ca8","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Title1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_News.State","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"lines":[{"id":"e7f35492-3b0c-4869-8afb-40c6e289bafe","from":"a292842c-3041-4492-b098-82092a3dd651","to":"18337d9c-be91-4963-8d0a-ae188829a3b6","customMethod":"","sql":"","noaccordMsg":""},{"id":"a39a3a78-5e92-46cc-aabf-e2034b81494a","text":"","from":"18337d9c-be91-4963-8d0a-ae188829a3b6","to":"3f1dead9-5c71-4a45-b378-aa714a02539d","customMethod":"","sql":"","noaccordMsg":""},{"id":"327b0dcc-0809-4535-ab9f-036904cedfd9","text":"","from":"3f1dead9-5c71-4a45-b378-aa714a02539d","to":"89047e5f-d548-4142-826d-33d0af8c393c","customMethod":"","sql":"","noaccordMsg":""}]}', 2)
INSERT [WorkFlow] ([ID], [Name], [Type], [Manager], [InstanceManager], [CreateDate], [CreateUserID], [DesignJSON], [InstallDate], [InstallUserID], [RunJSON], [Status]) VALUES (N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'子流程测试', N'90d6ad24-28f5-49d3-ac3f-cb473fb64cc5', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', CAST(0x0000A3FD0148445C AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'{"id":"8434dd1c-3e75-4877-b379-72df38d79bf7","name":"子流程测试","type":"90d6ad24-28f5-49d3-ac3f-cb473fb64cc5","manager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","instanceManager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","removeCompleted":"0","debug":"0","debugUsers":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","note":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest_CustomForm","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest_CustomForm","field":"FlowCompleted"},"steps":[{"id":"0b296b11-c5ae-41e6-8e78-d3730a4982a4","type":"normal","name":"请示","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":10,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"1","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"e65d4b59-c1f7-4262-bf84-bb5268609182","type":"subflow","name":"请假子流程","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":366,"y":50,"width":108,"height":50},"countersignature":0,"subflow":"a6509c1b-f49f-47a6-829d-ec43b9210eb2","behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"u_0362149c-af22-491f-baef-37bffcc1fd5c","hanlderModel":"1","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":"","subflowstrategy":"0"},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"fd768e2b-5739-4bc1-b397-8a151bc0881d","sort":0},{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":1},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":2},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":3}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"1","check":"0"}],"event":{"subflowActivationBefore":"","subflowCompletedBefore":"","submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"a3890463-3268-49a9-be46-c56d527c257f","type":"normal","name":"审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":203,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"3","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":"","copyFor":"","concurrentModel":"1"},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"lines":[{"id":"6134e741-0bd9-42cd-9f16-b9e717d1ee60","text":"","from":"0b296b11-c5ae-41e6-8e78-d3730a4982a4","to":"a3890463-3268-49a9-be46-c56d527c257f","customMethod":"","sql":"","noaccordMsg":""},{"id":"ffe15397-8ec0-42a2-9935-77818694c59a","text":"","from":"a3890463-3268-49a9-be46-c56d527c257f","to":"e65d4b59-c1f7-4262-bf84-bb5268609182","customMethod":"","sql":"","noaccordMsg":""}]}', CAST(0x0000A56301188559 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'{"id":"8434dd1c-3e75-4877-b379-72df38d79bf7","name":"子流程测试","type":"90d6ad24-28f5-49d3-ac3f-cb473fb64cc5","manager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","instanceManager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","removeCompleted":"0","debug":"0","debugUsers":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","note":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest_CustomForm","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest_CustomForm","field":"FlowCompleted"},"steps":[{"id":"0b296b11-c5ae-41e6-8e78-d3730a4982a4","type":"normal","name":"请示","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":10,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"1","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"e65d4b59-c1f7-4262-bf84-bb5268609182","type":"subflow","name":"请假子流程","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":366,"y":50,"width":108,"height":50},"countersignature":0,"subflow":"a6509c1b-f49f-47a6-829d-ec43b9210eb2","behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"u_0362149c-af22-491f-baef-37bffcc1fd5c","hanlderModel":"1","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":"","subflowstrategy":"0"},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"fd768e2b-5739-4bc1-b397-8a151bc0881d","sort":0},{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":1},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":2},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":3}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"1","check":"0"}],"event":{"subflowActivationBefore":"","subflowCompletedBefore":"","submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"a3890463-3268-49a9-be46-c56d527c257f","type":"normal","name":"审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":203,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"3","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":"","copyFor":"","concurrentModel":"1"},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"lines":[{"id":"6134e741-0bd9-42cd-9f16-b9e717d1ee60","text":"","from":"0b296b11-c5ae-41e6-8e78-d3730a4982a4","to":"a3890463-3268-49a9-be46-c56d527c257f","customMethod":"","sql":"","noaccordMsg":""},{"id":"ffe15397-8ec0-42a2-9935-77818694c59a","text":"","from":"a3890463-3268-49a9-be46-c56d527c257f","to":"e65d4b59-c1f7-4262-bf84-bb5268609182","customMethod":"","sql":"","noaccordMsg":""}]}', 2)
INSERT [WorkFlow] ([ID], [Name], [Type], [Manager], [InstanceManager], [CreateDate], [CreateUserID], [DesignJSON], [InstallDate], [InstallUserID], [RunJSON], [Status]) VALUES (N'538beb68-4e56-439e-b50f-be6b3b9f4957', N'自定义表单', N'90d6ad24-28f5-49d3-ac3f-cb473fb64cc5', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378', CAST(0x0000A355010D142A AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'{"id":"538beb68-4e56-439e-b50f-be6b3b9f4957","name":"自定义表单","type":"90d6ad24-28f5-49d3-ac3f-cb473fb64cc5","manager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378","instanceManager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378","removeCompleted":"0","debug":"0","debugUsers":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","note":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest_CustomForm","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest_CustomForm","field":"FlowCompleted"},"steps":[{"id":"1844d7a6-5f8f-445e-b4b8-ec2ea2c0e2f7","type":"normal","name":"填写表单","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":10,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"7f4c74d6-4113-4196-ada8-70c8e30a4a55","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"b47b6455-ebbc-493d-9e8a-cfd8ea7d95f4","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"51ebcb52-b939-432f-b6f3-4f9543cb3255","type":"normal","name":"审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":180,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"7f4c74d6-4113-4196-ada8-70c8e30a4a55","name":"","type":"2a1070f6-af14-45b3-8292-fe0962701c04","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"d2ab2fe0-1e9d-4a33-86b0-4079909f3b02","type":"normal","name":"批准","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":351,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"7f4c74d6-4113-4196-ada8-70c8e30a4a55","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"954effa8-03b8-461a-aaa8-8727d090dcb9","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"lines":[{"id":"4771f439-16be-4b1a-aecd-a77e359ea214","from":"1844d7a6-5f8f-445e-b4b8-ec2ea2c0e2f7","to":"51ebcb52-b939-432f-b6f3-4f9543cb3255","customMethod":"","sql":"","noaccordMsg":""},{"id":"7406095a-a6e4-405c-a705-609e2036647e","from":"51ebcb52-b939-432f-b6f3-4f9543cb3255","to":"d2ab2fe0-1e9d-4a33-86b0-4079909f3b02","customMethod":"","sql":"","noaccordMsg":""}]}', CAST(0x0000A4FF016857F7 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'{"id":"538beb68-4e56-439e-b50f-be6b3b9f4957","name":"自定义表单","type":"90d6ad24-28f5-49d3-ac3f-cb473fb64cc5","manager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378","instanceManager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378","removeCompleted":"0","debug":"0","debugUsers":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","note":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest_CustomForm","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest_CustomForm","field":"FlowCompleted"},"steps":[{"id":"1844d7a6-5f8f-445e-b4b8-ec2ea2c0e2f7","type":"normal","name":"填写表单","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":10,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"7f4c74d6-4113-4196-ada8-70c8e30a4a55","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"b47b6455-ebbc-493d-9e8a-cfd8ea7d95f4","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"51ebcb52-b939-432f-b6f3-4f9543cb3255","type":"normal","name":"审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":180,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"7f4c74d6-4113-4196-ada8-70c8e30a4a55","name":"","type":"2a1070f6-af14-45b3-8292-fe0962701c04","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"d2ab2fe0-1e9d-4a33-86b0-4079909f3b02","type":"normal","name":"批准","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":351,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"7f4c74d6-4113-4196-ada8-70c8e30a4a55","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"954effa8-03b8-461a-aaa8-8727d090dcb9","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"lines":[{"id":"4771f439-16be-4b1a-aecd-a77e359ea214","from":"1844d7a6-5f8f-445e-b4b8-ec2ea2c0e2f7","to":"51ebcb52-b939-432f-b6f3-4f9543cb3255","customMethod":"","sql":"","noaccordMsg":""},{"id":"7406095a-a6e4-405c-a705-609e2036647e","from":"51ebcb52-b939-432f-b6f3-4f9543cb3255","to":"d2ab2fe0-1e9d-4a33-86b0-4079909f3b02","customMethod":"","sql":"","noaccordMsg":""}]}', 2)
INSERT [WorkFlow] ([ID], [Name], [Type], [Manager], [InstanceManager], [CreateDate], [CreateUserID], [DesignJSON], [InstallDate], [InstallUserID], [RunJSON], [Status]) VALUES (N'5daba797-febe-4577-a98e-c6abb32cebde', N'子流程测试', N'48d05cf9-81c2-4713-87ab-1a45321500de', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', CAST(0x0000A3CC00FB8CBA AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'{"id":"5daba797-febe-4577-a98e-c6abb32cebde","name":"子流程测试","type":"48d05cf9-81c2-4713-87ab-1a45321500de","manager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","instanceManager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","removeCompleted":"0","debug":"0","debugUsers":"","note":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest_CustomForm","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest_CustomForm","field":"FlowCompleted"},"steps":[{"id":"36768785-d406-49f1-9f18-fbdbb5d85797","name":"填写表单","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":10,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"334436a9-cbeb-49fd-a29b-22c471e39a3d","name":"审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":180,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"c40fb454-4e1a-414f-9a3a-ac66a998c8a7","sort":0},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":1},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":2}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"12d70225-979d-44d8-ac79-6619c4f9e970","type":"subflow","position":{"x":350,"y":50,"width":108,"height":50},"name":"子流程步骤","flowid":"a6509c1b-f49f-47a6-829d-ec43b9210eb2","handler":"u_c2d3012a-c816-4149-ac04-9da0b60e3867","strategy":"0"},{"id":"f1d44b66-6d8e-4d83-9902-7550b4167e3f","name":"完成","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":520,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"954effa8-03b8-461a-aaa8-8727d090dcb9","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"lines":[{"id":"9f71a8c7-274a-48c3-8832-57fce8669747","from":"36768785-d406-49f1-9f18-fbdbb5d85797","to":"334436a9-cbeb-49fd-a29b-22c471e39a3d","customMethod":"","sql":"","noaccordMsg":""},{"id":"100d54c2-54e8-43e2-bc9e-6c17aac8da49","from":"334436a9-cbeb-49fd-a29b-22c471e39a3d","to":"12d70225-979d-44d8-ac79-6619c4f9e970","customMethod":"","sql":"","noaccordMsg":""},{"id":"727b39b8-7124-47fd-8b43-97f5f1ebe629","from":"12d70225-979d-44d8-ac79-6619c4f9e970","to":"f1d44b66-6d8e-4d83-9902-7550b4167e3f","customMethod":"","sql":"","noaccordMsg":""}]}', CAST(0x0000A3CC0101C9EF AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'{"id":"5daba797-febe-4577-a98e-c6abb32cebde","name":"子流程测试","type":"48d05cf9-81c2-4713-87ab-1a45321500de","manager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","instanceManager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","removeCompleted":"0","debug":"0","debugUsers":"","note":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest_CustomForm","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest_CustomForm","field":"FlowCompleted"},"steps":[{"id":"36768785-d406-49f1-9f18-fbdbb5d85797","name":"填写表单","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":10,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"334436a9-cbeb-49fd-a29b-22c471e39a3d","name":"审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":180,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"c40fb454-4e1a-414f-9a3a-ac66a998c8a7","sort":0},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":1},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":2}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"12d70225-979d-44d8-ac79-6619c4f9e970","type":"subflow","position":{"x":350,"y":50,"width":108,"height":50},"name":"子流程步骤","flowid":"a6509c1b-f49f-47a6-829d-ec43b9210eb2","handler":"u_c2d3012a-c816-4149-ac04-9da0b60e3867","strategy":"0"},{"id":"f1d44b66-6d8e-4d83-9902-7550b4167e3f","name":"完成","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":520,"y":50,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"954effa8-03b8-461a-aaa8-8727d090dcb9","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.Contents","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest_CustomForm.FlowCompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"lines":[{"id":"9f71a8c7-274a-48c3-8832-57fce8669747","from":"36768785-d406-49f1-9f18-fbdbb5d85797","to":"334436a9-cbeb-49fd-a29b-22c471e39a3d","customMethod":"","sql":"","noaccordMsg":""},{"id":"100d54c2-54e8-43e2-bc9e-6c17aac8da49","from":"334436a9-cbeb-49fd-a29b-22c471e39a3d","to":"12d70225-979d-44d8-ac79-6619c4f9e970","customMethod":"","sql":"","noaccordMsg":""},{"id":"727b39b8-7124-47fd-8b43-97f5f1ebe629","from":"12d70225-979d-44d8-ac79-6619c4f9e970","to":"f1d44b66-6d8e-4d83-9902-7550b4167e3f","customMethod":"","sql":"","noaccordMsg":""}]}', 4)
INSERT [WorkFlow] ([ID], [Name], [Type], [Manager], [InstanceManager], [CreateDate], [CreateUserID], [DesignJSON], [InstallDate], [InstallUserID], [RunJSON], [Status]) VALUES (N'6ac8dc74-e6eb-4b5c-b234-e00f316a6cbb', N'请假申请测试', N'48d05cf9-81c2-4713-87ab-1a45321500de', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_8086d01f-7ae3-402e-b543-d34f1059f79a', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', CAST(0x0000A50200A9EC5F AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'{"id":"6ac8dc74-e6eb-4b5c-b234-e00f316a6cbb","name":"请假申请测试","type":"48d05cf9-81c2-4713-87ab-1a45321500de","manager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_8086d01f-7ae3-402e-b543-d34f1059f79a","instanceManager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","removeCompleted":"0","debug":"1","debugUsers":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","note":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest","field":"flowcompleted"},"steps":[{"id":"91791ef2-8332-4b42-9f3c-a1d1ffeb78e2","type":"normal","name":"申请","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":18,"y":91,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"f1107c5d-b3b6-4227-88fb-7253bb4ad067","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"b47b6455-ebbc-493d-9e8a-cfd8ea7d95f4","sort":0},{"id":"c40fb454-4e1a-414f-9a3a-ac66a998c8a7","sort":1},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":2}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptName","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Reason","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.WriteTime","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Days","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.flowcompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"e8a748c7-9758-4f8b-8c4f-e81a29643499","type":"normal","name":"总经理审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":218,"y":54,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID_text","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptName","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date2","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Reason","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.WriteTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Days","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2_text","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.flowcompleted","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"58f8b849-6408-4776-a067-69895e43fb8d","type":"normal","name":"归档","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":401,"y":94,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"5eb71cab-01e1-4ac5-9aef-5e4a784e5cef","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptName","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Reason","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.WriteTime","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Days","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.flowcompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"92dd27e5-e5d7-410a-8589-5c573ae013b7","type":"normal","name":"部门经理审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":218,"y":148,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"5eb71cab-01e1-4ac5-9aef-5e4a784e5cef","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptName","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Reason","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.WriteTime","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Days","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.flowcompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"lines":[{"id":"882f137a-0bdc-4110-8aad-7b5f4ef30f7f","from":"91791ef2-8332-4b42-9f3c-a1d1ffeb78e2","to":"e8a748c7-9758-4f8b-8c4f-e81a29643499","customMethod":"","text":"","sql":"days>3","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"},{"id":"aa42936f-6bff-4c55-9cee-c48fb47ecaeb","text":"","from":"e8a748c7-9758-4f8b-8c4f-e81a29643499","to":"58f8b849-6408-4776-a067-69895e43fb8d","customMethod":"","sql":"","noaccordMsg":""},{"id":"5c329b48-ef14-4f08-8fe6-c5d0bff4685f","from":"91791ef2-8332-4b42-9f3c-a1d1ffeb78e2","to":"92dd27e5-e5d7-410a-8589-5c573ae013b7","customMethod":"","text":"","sql":"days<=3","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"},{"id":"d0772202-eed3-49c7-b9bb-75efc356e107","text":"","from":"92dd27e5-e5d7-410a-8589-5c573ae013b7","to":"58f8b849-6408-4776-a067-69895e43fb8d","customMethod":"","sql":"","noaccordMsg":""}]}', CAST(0x0000A50200B20BCA AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'{"id":"6ac8dc74-e6eb-4b5c-b234-e00f316a6cbb","name":"请假申请测试","type":"48d05cf9-81c2-4713-87ab-1a45321500de","manager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_8086d01f-7ae3-402e-b543-d34f1059f79a","instanceManager":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","removeCompleted":"0","debug":"1","debugUsers":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","note":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest","field":"flowcompleted"},"steps":[{"id":"91791ef2-8332-4b42-9f3c-a1d1ffeb78e2","type":"normal","name":"申请","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":18,"y":91,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"f1107c5d-b3b6-4227-88fb-7253bb4ad067","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"b47b6455-ebbc-493d-9e8a-cfd8ea7d95f4","sort":0},{"id":"c40fb454-4e1a-414f-9a3a-ac66a998c8a7","sort":1},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":2}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptName","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Reason","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.WriteTime","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Days","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.flowcompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"e8a748c7-9758-4f8b-8c4f-e81a29643499","type":"normal","name":"总经理审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":218,"y":54,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"37283038-798f-4a5b-9175-f4e2dc69b0e4","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID_text","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptName","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date2","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Reason","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.WriteTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Days","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2_text","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.flowcompleted","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"58f8b849-6408-4776-a067-69895e43fb8d","type":"normal","name":"归档","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":401,"y":94,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"5eb71cab-01e1-4ac5-9aef-5e4a784e5cef","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptName","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Reason","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.WriteTime","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Days","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.flowcompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"92dd27e5-e5d7-410a-8589-5c573ae013b7","type":"normal","name":"部门经理审核","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":218,"y":148,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"5eb71cab-01e1-4ac5-9aef-5e4a784e5cef","name":"","type":"626480b3-eaa9-4705-acbb-82901db4fda4","srot":0}],"buttons":[{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":0},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":1}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptName","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Reason","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.WriteTime","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Days","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.flowcompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"lines":[{"id":"882f137a-0bdc-4110-8aad-7b5f4ef30f7f","from":"91791ef2-8332-4b42-9f3c-a1d1ffeb78e2","to":"e8a748c7-9758-4f8b-8c4f-e81a29643499","customMethod":"","text":"","sql":"days>3","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"},{"id":"aa42936f-6bff-4c55-9cee-c48fb47ecaeb","text":"","from":"e8a748c7-9758-4f8b-8c4f-e81a29643499","to":"58f8b849-6408-4776-a067-69895e43fb8d","customMethod":"","sql":"","noaccordMsg":""},{"id":"5c329b48-ef14-4f08-8fe6-c5d0bff4685f","from":"91791ef2-8332-4b42-9f3c-a1d1ffeb78e2","to":"92dd27e5-e5d7-410a-8589-5c573ae013b7","customMethod":"","text":"","sql":"days<=3","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"},{"id":"d0772202-eed3-49c7-b9bb-75efc356e107","text":"","from":"92dd27e5-e5d7-410a-8589-5c573ae013b7","to":"58f8b849-6408-4776-a067-69895e43fb8d","customMethod":"","sql":"","noaccordMsg":""}]}', 4)
INSERT [WorkFlow] ([ID], [Name], [Type], [Manager], [InstanceManager], [CreateDate], [CreateUserID], [DesignJSON], [InstallDate], [InstallUserID], [RunJSON], [Status]) VALUES (N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'请假申请', N'48d05cf9-81c2-4713-87ab-1a45321500de', N'u_8086d01f-7ae3-402e-b543-d34f1059f79a,u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378', N'u_8086d01f-7ae3-402e-b543-d34f1059f79a,u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378', CAST(0x0000A22000AE1E2B AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'{"id":"a6509c1b-f49f-47a6-829d-ec43b9210eb2","name":"请假申请","type":"48d05cf9-81c2-4713-87ab-1a45321500de","manager":"u_8086d01f-7ae3-402e-b543-d34f1059f79a,u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378","instanceManager":"u_8086d01f-7ae3-402e-b543-d34f1059f79a,u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378","removeCompleted":"0","debug":"0","debugUsers":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","note":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest","field":"flowcompleted"},"steps":[{"id":"6421e3b1-a2bc-4418-b6d8-d38b4456bc9e","type":"normal","name":"填写请假单","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"1","archivesParams":"","note":"","position":{"x":140,"y":209,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"0","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"0","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"63a2da04-fbfc-42e8-9b6b-3e5ad2299eca","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"c40fb454-4e1a-414f-9a3a-ac66a998c8a7","sort":0},{"id":"29b358e1-ad64-4f09-846c-4554ae6b85c4","sort":1},{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":2},{"id":"da7c699c-3c55-4657-8781-6881ac9117b7","sort":3},{"id":"other_splitline","sort":4},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":5}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Title","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptID","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptName","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date1","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date2","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Type","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Reason","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.WriteTime","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Days","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.flowcompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"ce0c165a-778b-4817-a9c5-21f862f1c96e","name":"领导审批","opinionDisplay":"1","expiredPrompt":"1","signatureType":"2","workTime":"2.5","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":318,"y":54,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"4","selectRange":"04f12beb-d99d-43df-ac9a-3042957d6bda","handlerStep":"","valueField":"","defaultHandler":"u_8086d01f-7ae3-402e-b543-d34f1059f79a","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"63a2da04-fbfc-42e8-9b6b-3e5ad2299eca","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"other_splitline","sort":1},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":2},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":3}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserName","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptName","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date2","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Reason","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.WriteTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Days","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test3","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.flowcompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"fabd66d0-e260-4a4b-b774-3302a1617cc5","type":"normal","name":"部门主管审批","opinionDisplay":"1","expiredPrompt":"1","signatureType":"2","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"请假天数大于3天由人事部经理审批，大于5天由领导审批。","position":{"x":318,"y":131,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"9","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"1","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"63a2da04-fbfc-42e8-9b6b-3e5ad2299eca","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"c40fb454-4e1a-414f-9a3a-ac66a998c8a7","sort":0},{"id":"b8a7af17-7ad5-4699-b679-d421691dd737","sort":1},{"id":"other_splitline","sort":2},{"id":"29b358e1-ad64-4f09-846c-4554ae6b85c4","sort":3},{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":4},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":5},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":6},{"id":"7217b1b1-663d-4f7a-83ff-5b89047ace51","sort":7}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptName","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Reason","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.WriteTime","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Days","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.flowcompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"93536eaf-2ea1-4a29-9d88-8bad1927a96e","type":"normal","name":"反馈发起人","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"1","archivesParams":"","note":"","position":{"x":675,"y":209,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"5","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"3","backModel":"1","backType":"2","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"63a2da04-fbfc-42e8-9b6b-3e5ad2299eca","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"b8a7af17-7ad5-4699-b679-d421691dd737","sort":0},{"id":"29b358e1-ad64-4f09-846c-4554ae6b85c4","sort":1},{"id":"other_splitline","sort":2},{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":3},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":4},{"id":"954effa8-03b8-461a-aaa8-8727d090dcb9","sort":5}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptName","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date2","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Reason","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.WriteTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Days","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.flowcompleted","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"baac846e-4ee2-44ee-b684-8cedb39578bb","type":"normal","name":"人事部备案","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":511,"y":209,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"5","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"u_1acf9c22-bfb6-4673-a698-a58233747b92","hanlderModel":"3","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"63a2da04-fbfc-42e8-9b6b-3e5ad2299eca","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"b8a7af17-7ad5-4699-b679-d421691dd737","sort":0},{"id":"29b358e1-ad64-4f09-846c-4554ae6b85c4","sort":1},{"id":"other_splitline","sort":2},{"id":"da7c699c-3c55-4657-8781-6881ac9117b7","sort":3},{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":4},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":5},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":6}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptName","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Reason","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.WriteTime","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Days","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.flowcompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"lines":[{"id":"028177ab-ffe6-4e33-b210-6aeb94f3a0fd","from":"6421e3b1-a2bc-4418-b6d8-d38b4456bc9e","to":"fabd66d0-e260-4a4b-b774-3302a1617cc5","customMethod":"","text":"","sql":"","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"1","organize_notsponsorchargeleader":"1"},{"id":"1a7746f0-3a3d-4937-8e3a-65fe0646bff8","from":"fabd66d0-e260-4a4b-b774-3302a1617cc5","to":"baac846e-4ee2-44ee-b684-8cedb39578bb","customMethod":"","sql":"Days<=3","title":"","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"},{"id":"3e639661-e46c-4041-b3ba-3d1d63212b67","from":"baac846e-4ee2-44ee-b684-8cedb39578bb","to":"93536eaf-2ea1-4a29-9d88-8bad1927a96e","customMethod":"","text":"","sql":"","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"},{"id":"bd314a34-69a4-4421-9c97-fac8df183221","from":"6421e3b1-a2bc-4418-b6d8-d38b4456bc9e","to":"ce0c165a-778b-4817-a9c5-21f862f1c96e","customMethod":"","text":"","sql":"","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"1","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"},{"id":"3b7627a0-d138-40b1-9230-9f254a57a411","from":"ce0c165a-778b-4817-a9c5-21f862f1c96e","to":"baac846e-4ee2-44ee-b684-8cedb39578bb","customMethod":"","sql":"","noaccordMsg":""},{"id":"ee49e751-324d-4111-9796-7809ac0cd7ed","from":"fabd66d0-e260-4a4b-b774-3302a1617cc5","to":"ce0c165a-778b-4817-a9c5-21f862f1c96e","customMethod":"","text":"","sql":"days>3","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"},{"id":"678c65e7-eaf8-4014-9d0e-fb4f08fe24da","from":"6421e3b1-a2bc-4418-b6d8-d38b4456bc9e","to":"baac846e-4ee2-44ee-b684-8cedb39578bb","customMethod":"","text":"","sql":"","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"1","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"}]}', CAST(0x0000A4D7015F39D2 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'{"id":"a6509c1b-f49f-47a6-829d-ec43b9210eb2","name":"请假申请","type":"48d05cf9-81c2-4713-87ab-1a45321500de","manager":"u_8086d01f-7ae3-402e-b543-d34f1059f79a,u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378","instanceManager":"u_8086d01f-7ae3-402e-b543-d34f1059f79a,u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe,u_23c3e9fc-6d8a-4ea0-925a-0a0671d61378","removeCompleted":"0","debug":"0","debugUsers":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","note":"","databases":[{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","linkName":"平台连接","table":"TempTest","primaryKey":"ID"}],"titleField":{"link":"06075250-30dc-4d32-bf97-e922cb30fac8","table":"TempTest","field":"flowcompleted"},"steps":[{"id":"6421e3b1-a2bc-4418-b6d8-d38b4456bc9e","type":"normal","name":"填写请假单","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"1","archivesParams":"","note":"","position":{"x":140,"y":209,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"0","handlerType":"0","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"0","backModel":"0","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"63a2da04-fbfc-42e8-9b6b-3e5ad2299eca","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"c40fb454-4e1a-414f-9a3a-ac66a998c8a7","sort":0},{"id":"29b358e1-ad64-4f09-846c-4554ae6b85c4","sort":1},{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":2},{"id":"da7c699c-3c55-4657-8781-6881ac9117b7","sort":3},{"id":"other_splitline","sort":4},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":5}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Title","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptID","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptName","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date1","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date2","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Type","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Reason","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.WriteTime","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Days","status":"0","check":"2"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.flowcompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"ce0c165a-778b-4817-a9c5-21f862f1c96e","name":"领导审批","opinionDisplay":"1","expiredPrompt":"1","signatureType":"2","workTime":"2.5","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":318,"y":54,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"4","selectRange":"04f12beb-d99d-43df-ac9a-3042957d6bda","handlerStep":"","valueField":"","defaultHandler":"u_8086d01f-7ae3-402e-b543-d34f1059f79a","hanlderModel":"0","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"63a2da04-fbfc-42e8-9b6b-3e5ad2299eca","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":0},{"id":"other_splitline","sort":1},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":2},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":3}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserName","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptName","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date2","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Reason","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.WriteTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Days","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test3","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.flowcompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"fabd66d0-e260-4a4b-b774-3302a1617cc5","type":"normal","name":"部门主管审批","opinionDisplay":"1","expiredPrompt":"1","signatureType":"2","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"请假天数大于3天由人事部经理审批，大于5天由领导审批。","position":{"x":318,"y":131,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"1","runSelect":"1","handlerType":"9","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"1","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"63a2da04-fbfc-42e8-9b6b-3e5ad2299eca","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"c40fb454-4e1a-414f-9a3a-ac66a998c8a7","sort":0},{"id":"b8a7af17-7ad5-4699-b679-d421691dd737","sort":1},{"id":"other_splitline","sort":2},{"id":"29b358e1-ad64-4f09-846c-4554ae6b85c4","sort":3},{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":4},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":5},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":6},{"id":"7217b1b1-663d-4f7a-83ff-5b89047ace51","sort":7}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptName","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Reason","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.WriteTime","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Days","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.flowcompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"93536eaf-2ea1-4a29-9d88-8bad1927a96e","type":"normal","name":"反馈发起人","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"1","archivesParams":"","note":"","position":{"x":675,"y":209,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"5","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"","hanlderModel":"3","backModel":"1","backType":"2","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"63a2da04-fbfc-42e8-9b6b-3e5ad2299eca","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"b8a7af17-7ad5-4699-b679-d421691dd737","sort":0},{"id":"29b358e1-ad64-4f09-846c-4554ae6b85c4","sort":1},{"id":"other_splitline","sort":2},{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":3},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":4},{"id":"954effa8-03b8-461a-aaa8-8727d090dcb9","sort":5}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.ID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Title","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptID","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptName","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date2","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Type","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Reason","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.WriteTime","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Days","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test1","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2","status":"1","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.flowcompleted","status":"1","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}},{"id":"baac846e-4ee2-44ee-b684-8cedb39578bb","type":"normal","name":"人事部备案","opinionDisplay":"1","expiredPrompt":"1","signatureType":"0","workTime":"","limitTime":"","otherTime":"","archives":"0","archivesParams":"","note":"","position":{"x":511,"y":209,"width":108,"height":50},"countersignature":0,"behavior":{"flowType":"0","runSelect":"1","handlerType":"5","selectRange":"","handlerStep":"","valueField":"","defaultHandler":"u_1acf9c22-bfb6-4673-a698-a58233747b92","hanlderModel":"3","backModel":"1","backType":"0","backStep":"","percentage":"","countersignature":"0","countersignaturePercentage":""},"forms":[{"id":"63a2da04-fbfc-42e8-9b6b-3e5ad2299eca","name":"","type":"719c6c30-3d6a-44e2-8730-637c651f1df7","srot":0}],"buttons":[{"id":"b8a7af17-7ad5-4699-b679-d421691dd737","sort":0},{"id":"29b358e1-ad64-4f09-846c-4554ae6b85c4","sort":1},{"id":"other_splitline","sort":2},{"id":"da7c699c-3c55-4657-8781-6881ac9117b7","sort":3},{"id":"3b271f67-0433-4082-ad1a-8df1b967b879","sort":4},{"id":"86b7fa6c-891f-4565-9309-81672d3ba80a","sort":5},{"id":"8982b97c-adba-4a3a-afd9-9a3ef6ff12d8","sort":6}],"fieldStatus":[{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.ID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Title","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.UserID_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptID","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.DeptName","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Date2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Type","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Reason","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.WriteTime","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.Days","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test1","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.test2_text","status":"0","check":"0"},{"field":"06075250-30dc-4d32-bf97-e922cb30fac8.TempTest.flowcompleted","status":"0","check":"0"}],"event":{"submitBefore":"","submitAfter":"","backBefore":"","backAfter":""}}],"lines":[{"id":"028177ab-ffe6-4e33-b210-6aeb94f3a0fd","from":"6421e3b1-a2bc-4418-b6d8-d38b4456bc9e","to":"fabd66d0-e260-4a4b-b774-3302a1617cc5","customMethod":"","text":"","sql":"","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"1","organize_notsponsorchargeleader":"1"},{"id":"1a7746f0-3a3d-4937-8e3a-65fe0646bff8","from":"fabd66d0-e260-4a4b-b774-3302a1617cc5","to":"baac846e-4ee2-44ee-b684-8cedb39578bb","customMethod":"","sql":"Days<=3","title":"","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"},{"id":"3e639661-e46c-4041-b3ba-3d1d63212b67","from":"baac846e-4ee2-44ee-b684-8cedb39578bb","to":"93536eaf-2ea1-4a29-9d88-8bad1927a96e","customMethod":"","text":"","sql":"","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"},{"id":"bd314a34-69a4-4421-9c97-fac8df183221","from":"6421e3b1-a2bc-4418-b6d8-d38b4456bc9e","to":"ce0c165a-778b-4817-a9c5-21f862f1c96e","customMethod":"","text":"","sql":"","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"1","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"},{"id":"3b7627a0-d138-40b1-9230-9f254a57a411","from":"ce0c165a-778b-4817-a9c5-21f862f1c96e","to":"baac846e-4ee2-44ee-b684-8cedb39578bb","customMethod":"","sql":"","noaccordMsg":""},{"id":"ee49e751-324d-4111-9796-7809ac0cd7ed","from":"fabd66d0-e260-4a4b-b774-3302a1617cc5","to":"ce0c165a-778b-4817-a9c5-21f862f1c96e","customMethod":"","text":"","sql":"days>3","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"0","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"},{"id":"678c65e7-eaf8-4014-9d0e-fb4f08fe24da","from":"6421e3b1-a2bc-4418-b6d8-d38b4456bc9e","to":"baac846e-4ee2-44ee-b684-8cedb39578bb","customMethod":"","text":"","sql":"","organize_senderin":"","organize_sendernotin":"","organize_sponsorin":"","organize_sponsornotin":"","organize_senderleader":"0","organize_senderchargeleader":"0","organize_sponsorleader":"0","organize_sponsorchargeleader":"1","organize_notsenderleader":"0","organize_notsenderchargeleader":"0","organize_notsponsorleader":"0","organize_notsponsorchargeleader":"0"}]}', 2)

--#############################################################################################################################################
--#############################################################################################################################################
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) 
VALUES (N'cac94423-f037-472c-a0bb-01f153407e4c', 
		N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', 
		N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', 
		N'请假申请', 
		N'填写请假单',
		N'ab3c8ae2-ba77-430e-a530-27abc6d52f9e', 
		N'583f4eae-cacb-44bf-b680-fef181b766ac',
		N'b9718db3-f1c7-410a-b532-793b5b8a1794', 
		N'徐洪的请假申请', 
		N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"b9718db3-f1c7-410a-b532-793b5b8a1794","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015/9/24 8:15:00","TempTest_Date2":"2015/10/2 10:45:00","TempTest_Type":"d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4","TempTest_Reason":"5555","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":""};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="1" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="1" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>',
		N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-09-17 11:30:18</th>
        <th style="width:25%;">&nbsp;完成时间：2015-09-17 14:26:30</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：不同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ',
		CAST(0x0000A51600FC1DED AS DateTime))
--#############################################################################################################################################
--#############################################################################################################################################
	
	
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'ffe3fb41-775b-46c5-9726-048fffe80e4f', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'93536eaf-2ea1-4a29-9d88-8bad1927a96e', N'请假申请', N'反馈发起人', N'28c24213-d13a-4388-8752-a93481bab627', N'f9c3eca1-8d58-4ea1-a1a2-2674f8b68ef2', N'27180112-f5a5-4877-895a-c2fe30fe1320', N'请假申请-反馈发起人', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"27180112-f5a5-4877-895a-c2fe30fe1320","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015-07-16 00:00:00","TempTest_Date2":"2015-07-24 00:00:00","TempTest_Type":"d2122199-23a7-4b59-87d4-b9b60e17735b","TempTest_Reason":"111111111111","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":""};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"1_0","TempTest_Title":"1_0","TempTest_UserID":"1_0","TempTest_UserID_text":"0_0","TempTest_DeptID":"1_0","TempTest_DeptName":"1_0","TempTest_Date1":"1_0","TempTest_Date2":"1_0","TempTest_Type":"1_0","TempTest_Reason":"1_0","TempTest_WriteTime":"1_0","TempTest_Days":"1_0","TempTest_test":"1_0","TempTest_test1":"1_0","TempTest_test2":"1_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"1_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="周丽的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_1acf9c22-bfb6-4673-a698-a58233747b92" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="3975624c-148f-4838-88c9-12af85d2e05e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:23</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:15:31</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：不同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:54</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:16:15</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A4D7015ED575 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'0b3b15ef-7655-4c9d-9a46-05343a7aacf2', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'e725a8b5-2a0d-4683-ad55-844b67ed0d6a', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="2015-09-17 16:13" defaultvalue="%3C%25=RoadFlow.Utility.DateTimeNew.ShortDateTime%25%3E" istime="1" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="1" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A516010B5F68 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'f79159b7-aa7f-4387-9555-0c103398b82c', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'e725a8b5-2a0d-4683-ad55-844b67ed0d6a', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="2015-09-17 16:13" defaultvalue="%3C%25=RoadFlow.Utility.DateTimeNew.ShortDateTime%25%3E" istime="1" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="1" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A516010B5F68 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'1dcc8318-d4c8-4f21-9397-0c3b0fbe972e', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'd86ecefb-8515-4b26-81c7-60c49a8a64c0', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A502009D785A AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'5dffdbd8-7a79-431a-9e6d-16f2e703f184', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'82e69a62-76be-40b6-946c-b1c945b2554e', N'毛明明的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="毛明明的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_0362149c-af22-491f-baef-37bffcc1fd5c" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="4f4865de-fda0-417b-9465-d7648309b772" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A50B0152588F AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'1110ac75-9ea1-46ab-8287-16f3daaa4327', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'04a41e2e-0426-44a5-a307-54456820a417', N'c98fd80c-23c9-4947-82aa-305b89009be3', N'8542c297-39fe-4622-b537-fdc54f58c0e9', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"8542c297-39fe-4622-b537-fdc54f58c0e9","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015-07-22 00:00:00","TempTest_Date2":"2015-07-31 00:00:00","TempTest_Type":"a1e92887-8230-4aba-8a06-bebffdee8043","TempTest_Reason":"6hhhh","TempTest_WriteTime":"","TempTest_Days":"6","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":""};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：人事部备案</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-07 20:42:35</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-07 20:42:51</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：人事部备案</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-07 20:42:59</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-07 20:43:52</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:25:25</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-09 20:38:27</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:38:39</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-09 20:39:19</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:39:28</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-09 20:46:23</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:46:37</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-09 20:47:13</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:50:02</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:05:49</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：人事部备案</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-10 12:05:49</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:07:16</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-10 12:07:16</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:07:23</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-10 12:07:54</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:10:34</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-10 12:10:49</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:14:12</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A4D100C9B0A6 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'2b8068b8-8bf9-4f5a-90b0-18933fc52375', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'93536eaf-2ea1-4a29-9d88-8bad1927a96e', N'请假申请', N'反馈发起人', N'28c24213-d13a-4388-8752-a93481bab627', N'f9c3eca1-8d58-4ea1-a1a2-2674f8b68ef2', N'27180112-f5a5-4877-895a-c2fe30fe1320', N'请假申请-反馈发起人', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"27180112-f5a5-4877-895a-c2fe30fe1320","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015-07-16 00:00:00","TempTest_Date2":"2015-07-24 00:00:00","TempTest_Type":"d2122199-23a7-4b59-87d4-b9b60e17735b","TempTest_Reason":"111111111111","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":""};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"1_0","TempTest_Title":"1_0","TempTest_UserID":"1_0","TempTest_UserID_text":"0_0","TempTest_DeptID":"1_0","TempTest_DeptName":"1_0","TempTest_Date1":"1_0","TempTest_Date2":"1_0","TempTest_Type":"1_0","TempTest_Reason":"1_0","TempTest_WriteTime":"1_0","TempTest_Days":"1_0","TempTest_test":"1_0","TempTest_test1":"1_0","TempTest_test2":"1_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"1_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="周丽的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_1acf9c22-bfb6-4673-a698-a58233747b92" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="3975624c-148f-4838-88c9-12af85d2e05e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:23</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:15:31</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：不同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:54</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:16:15</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A4D7015ED575 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'f5ae698c-39f2-4889-a184-24a94606f4df', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'93536eaf-2ea1-4a29-9d88-8bad1927a96e', N'请假申请', N'反馈发起人', N'5d1f9a32-3887-4cd7-9900-f376d3dcf529', N'f9c3eca1-8d58-4ea1-a1a2-2674f8b68ef2', N'27180112-f5a5-4877-895a-c2fe30fe1320', N'请假申请-反馈发起人', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"27180112-f5a5-4877-895a-c2fe30fe1320","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015-07-16 00:00:00","TempTest_Date2":"2015-07-24 00:00:00","TempTest_Type":"d2122199-23a7-4b59-87d4-b9b60e17735b","TempTest_Reason":"111111111111","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":"1"};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"1_0","TempTest_Title":"1_0","TempTest_UserID":"1_0","TempTest_UserID_text":"0_0","TempTest_DeptID":"1_0","TempTest_DeptName":"1_0","TempTest_Date1":"1_0","TempTest_Date2":"1_0","TempTest_Type":"1_0","TempTest_Reason":"1_0","TempTest_WriteTime":"1_0","TempTest_Days":"1_0","TempTest_test":"1_0","TempTest_test1":"1_0","TempTest_test2":"1_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"1_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="毛明明的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_0362149c-af22-491f-baef-37bffcc1fd5c" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="4f4865de-fda0-417b-9465-d7648309b772" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:23</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:15:31</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：不同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:54</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:16:15</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A4D7015FAF06 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'cbb74f99-28b0-4af3-99b1-2c36fdcb3341', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'93536eaf-2ea1-4a29-9d88-8bad1927a96e', N'请假申请', N'反馈发起人', N'970a0a81-d9d1-4dac-af3f-1ca71e71e805', N'f9c3eca1-8d58-4ea1-a1a2-2674f8b68ef2', N'27180112-f5a5-4877-895a-c2fe30fe1320', N'请假申请-反馈发起人', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"27180112-f5a5-4877-895a-c2fe30fe1320","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015-07-16 00:00:00","TempTest_Date2":"2015-07-24 00:00:00","TempTest_Type":"d2122199-23a7-4b59-87d4-b9b60e17735b","TempTest_Reason":"111111111111","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":"1"};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"1_0","TempTest_Title":"1_0","TempTest_UserID":"1_0","TempTest_UserID_text":"0_0","TempTest_DeptID":"1_0","TempTest_DeptName":"1_0","TempTest_Date1":"1_0","TempTest_Date2":"1_0","TempTest_Type":"1_0","TempTest_Reason":"1_0","TempTest_WriteTime":"1_0","TempTest_Days":"1_0","TempTest_test":"1_0","TempTest_test1":"1_0","TempTest_test2":"1_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"1_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:23</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:15:31</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：不同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:54</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:16:15</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A4D70161A639 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'5e03be5a-9515-4d1c-a7e7-32cff309c2f5', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'7441f7ba-7b83-442b-aed0-f4234c143c2d', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A4D7015B020B AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'd5a28b9a-dc6e-44df-9592-32d97b788862', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'b9718db3-f1c7-410a-b532-793b5b8a1794', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A51600BD990F AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'b4a5bdc9-dbe4-40a2-b1ca-3784dc240dd2', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'82e69a62-76be-40b6-946c-b1c945b2554e', N'毛明明的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="毛明明的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_0362149c-af22-491f-baef-37bffcc1fd5c" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="4f4865de-fda0-417b-9465-d7648309b772" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A50B0152588F AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'b5eb3f85-e9b3-49d4-bf8f-3982a1c30f58', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'e725a8b5-2a0d-4683-ad55-844b67ed0d6a', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="2015-09-17 16:13" defaultvalue="%3C%25=RoadFlow.Utility.DateTimeNew.ShortDateTime%25%3E" istime="1" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="1" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A516010B5F68 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'4c3e68ab-7fc6-4695-a6e7-3cd0d2ed0f57', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'93536eaf-2ea1-4a29-9d88-8bad1927a96e', N'请假申请', N'反馈发起人', N'5d1f9a32-3887-4cd7-9900-f376d3dcf529', N'f9c3eca1-8d58-4ea1-a1a2-2674f8b68ef2', N'27180112-f5a5-4877-895a-c2fe30fe1320', N'请假申请-反馈发起人', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"27180112-f5a5-4877-895a-c2fe30fe1320","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015-07-16 00:00:00","TempTest_Date2":"2015-07-24 00:00:00","TempTest_Type":"d2122199-23a7-4b59-87d4-b9b60e17735b","TempTest_Reason":"111111111111","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":"1"};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"1_0","TempTest_Title":"1_0","TempTest_UserID":"1_0","TempTest_UserID_text":"0_0","TempTest_DeptID":"1_0","TempTest_DeptName":"1_0","TempTest_Date1":"1_0","TempTest_Date2":"1_0","TempTest_Type":"1_0","TempTest_Reason":"1_0","TempTest_WriteTime":"1_0","TempTest_Days":"1_0","TempTest_test":"1_0","TempTest_test1":"1_0","TempTest_test2":"1_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"1_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="毛明明的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_0362149c-af22-491f-baef-37bffcc1fd5c" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="4f4865de-fda0-417b-9465-d7648309b772" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:23</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:15:31</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：不同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:54</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:16:15</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A4D7015FAF06 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'8e2c7c3c-2845-41c9-8166-440ac543496b', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'd86ecefb-8515-4b26-81c7-60c49a8a64c0', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A502009D785A AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'6fccfba9-76fa-448f-8ec3-4b4a3c805020', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'93536eaf-2ea1-4a29-9d88-8bad1927a96e', N'请假申请', N'反馈发起人', N'c3a7bb76-1c4d-45ea-abf9-723a47e9f01c', N'656f814b-9383-4153-beb5-385e6fd4bbe3', N'82e69a62-76be-40b6-946c-b1c945b2554e', N'请假申请-反馈发起人', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"82e69a62-76be-40b6-946c-b1c945b2554e","TempTest_Title":"\u6BDB\u660E\u660E\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_0362149c-af22-491f-baef-37bffcc1fd5c","TempTest_UserID_text":"\u6BDB\u660E\u660E","TempTest_DeptID":"4f4865de-fda0-417b-9465-d7648309b772","TempTest_DeptName":"","TempTest_Date1":"2015/9/6 0:00:00","TempTest_Date2":"2015/9/10 0:00:00","TempTest_Type":"d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4","TempTest_Reason":"111111111111111111","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":""};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"1_0","TempTest_Title":"1_0","TempTest_UserID":"1_0","TempTest_UserID_text":"0_0","TempTest_DeptID":"1_0","TempTest_DeptName":"1_0","TempTest_Date1":"1_0","TempTest_Date2":"1_0","TempTest_Type":"1_0","TempTest_Reason":"1_0","TempTest_WriteTime":"1_0","TempTest_Days":"1_0","TempTest_test":"1_0","TempTest_test1":"1_0","TempTest_test2":"1_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"1_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="毛明明的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_0362149c-af22-491f-baef-37bffcc1fd5c" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="4f4865de-fda0-417b-9465-d7648309b772" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：部门主管审批</th>
        <th style="width:20%;">&nbsp;处理人：毛明明</th>
        <th style="width:25%;">&nbsp;收件时间：2015-09-06 20:31:52</th>
        <th style="width:25%;">&nbsp;完成时间：2015-09-06 20:32:12</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/0362149c-af22-491f-baef-37bffcc1fd5c.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A50B01528B09 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'9b23c13c-9806-48dc-8a7a-594f9733aa73', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'93536eaf-2ea1-4a29-9d88-8bad1927a96e', N'请假申请', N'反馈发起人', N'970a0a81-d9d1-4dac-af3f-1ca71e71e805', N'f9c3eca1-8d58-4ea1-a1a2-2674f8b68ef2', N'27180112-f5a5-4877-895a-c2fe30fe1320', N'请假申请-反馈发起人', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"27180112-f5a5-4877-895a-c2fe30fe1320","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015-07-16 00:00:00","TempTest_Date2":"2015-07-24 00:00:00","TempTest_Type":"d2122199-23a7-4b59-87d4-b9b60e17735b","TempTest_Reason":"111111111111","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":"1"};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"1_0","TempTest_Title":"1_0","TempTest_UserID":"1_0","TempTest_UserID_text":"0_0","TempTest_DeptID":"1_0","TempTest_DeptName":"1_0","TempTest_Date1":"1_0","TempTest_Date2":"1_0","TempTest_Type":"1_0","TempTest_Reason":"1_0","TempTest_WriteTime":"1_0","TempTest_Days":"1_0","TempTest_test":"1_0","TempTest_test1":"1_0","TempTest_test2":"1_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"1_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:23</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:15:31</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：不同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:54</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:16:15</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A4D70161A639 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'872c50f9-bed7-43fe-957b-5a979c51e58e', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'93536eaf-2ea1-4a29-9d88-8bad1927a96e', N'请假申请', N'反馈发起人', N'970a0a81-d9d1-4dac-af3f-1ca71e71e805', N'f9c3eca1-8d58-4ea1-a1a2-2674f8b68ef2', N'27180112-f5a5-4877-895a-c2fe30fe1320', N'请假申请-反馈发起人', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"27180112-f5a5-4877-895a-c2fe30fe1320","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015-07-16 00:00:00","TempTest_Date2":"2015-07-24 00:00:00","TempTest_Type":"d2122199-23a7-4b59-87d4-b9b60e17735b","TempTest_Reason":"111111111111","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":"1"};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"1_0","TempTest_Title":"1_0","TempTest_UserID":"1_0","TempTest_UserID_text":"0_0","TempTest_DeptID":"1_0","TempTest_DeptName":"1_0","TempTest_Date1":"1_0","TempTest_Date2":"1_0","TempTest_Type":"1_0","TempTest_Reason":"1_0","TempTest_WriteTime":"1_0","TempTest_Days":"1_0","TempTest_test":"1_0","TempTest_test1":"1_0","TempTest_test2":"1_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"1_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:23</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:15:31</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：不同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:54</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:16:15</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A4D70161A639 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'bf265a98-4c00-4b21-bcfb-622aad23929f', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'd86ecefb-8515-4b26-81c7-60c49a8a64c0', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A502009D785A AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'6154cedb-19fc-40fe-ae3b-6878a2be30ec', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'b9718db3-f1c7-410a-b532-793b5b8a1794', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A51600BD990F AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'691567cd-eeed-489f-bd91-75c1335e06c0', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'04a41e2e-0426-44a5-a307-54456820a417', N'c98fd80c-23c9-4947-82aa-305b89009be3', N'8542c297-39fe-4622-b537-fdc54f58c0e9', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"8542c297-39fe-4622-b537-fdc54f58c0e9","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015-07-22 00:00:00","TempTest_Date2":"2015-07-31 00:00:00","TempTest_Type":"a1e92887-8230-4aba-8a06-bebffdee8043","TempTest_Reason":"6hhhh","TempTest_WriteTime":"","TempTest_Days":"6","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":""};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：人事部备案</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-07 20:42:35</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-07 20:42:51</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：人事部备案</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-07 20:42:59</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-07 20:43:52</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:25:25</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-09 20:38:27</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:38:39</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-09 20:39:19</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:39:28</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-09 20:46:23</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:46:37</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-09 20:47:13</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:50:02</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:05:49</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：人事部备案</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-10 12:05:49</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:07:16</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-10 12:07:16</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:07:23</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-10 12:07:54</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:10:34</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-10 12:10:49</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:14:12</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A4D100C9B0A6 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'00ace700-9431-4f07-89f0-7aa34add5607', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'82e69a62-76be-40b6-946c-b1c945b2554e', N'毛明明的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="毛明明的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_0362149c-af22-491f-baef-37bffcc1fd5c" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="4f4865de-fda0-417b-9465-d7648309b772" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A50B0152588F AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'0a7fb768-6880-476a-8da8-7e6c178b1e89', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'b9718db3-f1c7-410a-b532-793b5b8a1794', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A51600BD990F AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'92ebb576-9f51-4b6d-a49e-7ec2ec172ebf', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'eb462ccf-abff-4351-8747-9bd7c3afc6ad', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A4FF0168B8E8 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'd7e4f1ef-735a-4100-a071-80af0aad8b7d', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'7441f7ba-7b83-442b-aed0-f4234c143c2d', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A4D7015B020B AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'66186b30-dd2a-4458-a45a-856642167b22', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'eb462ccf-abff-4351-8747-9bd7c3afc6ad', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A4FF0168B8E8 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'21b83f9a-f972-47b5-b0a9-8d28b45dd672', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'93536eaf-2ea1-4a29-9d88-8bad1927a96e', N'请假申请', N'反馈发起人', N'c3a7bb76-1c4d-45ea-abf9-723a47e9f01c', N'656f814b-9383-4153-beb5-385e6fd4bbe3', N'82e69a62-76be-40b6-946c-b1c945b2554e', N'请假申请-反馈发起人', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"82e69a62-76be-40b6-946c-b1c945b2554e","TempTest_Title":"\u6BDB\u660E\u660E\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_0362149c-af22-491f-baef-37bffcc1fd5c","TempTest_UserID_text":"\u6BDB\u660E\u660E","TempTest_DeptID":"4f4865de-fda0-417b-9465-d7648309b772","TempTest_DeptName":"","TempTest_Date1":"2015/9/6 0:00:00","TempTest_Date2":"2015/9/10 0:00:00","TempTest_Type":"d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4","TempTest_Reason":"111111111111111111","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":""};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"1_0","TempTest_Title":"1_0","TempTest_UserID":"1_0","TempTest_UserID_text":"0_0","TempTest_DeptID":"1_0","TempTest_DeptName":"1_0","TempTest_Date1":"1_0","TempTest_Date2":"1_0","TempTest_Type":"1_0","TempTest_Reason":"1_0","TempTest_WriteTime":"1_0","TempTest_Days":"1_0","TempTest_test":"1_0","TempTest_test1":"1_0","TempTest_test2":"1_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"1_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="毛明明的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_0362149c-af22-491f-baef-37bffcc1fd5c" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="4f4865de-fda0-417b-9465-d7648309b772" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：部门主管审批</th>
        <th style="width:20%;">&nbsp;处理人：毛明明</th>
        <th style="width:25%;">&nbsp;收件时间：2015-09-06 20:31:52</th>
        <th style="width:25%;">&nbsp;完成时间：2015-09-06 20:32:12</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/0362149c-af22-491f-baef-37bffcc1fd5c.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A50B01528B09 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'6476f4e5-b432-4ce5-bbdc-8fbea1333f84', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'93536eaf-2ea1-4a29-9d88-8bad1927a96e', N'请假申请', N'反馈发起人', N'c3a7bb76-1c4d-45ea-abf9-723a47e9f01c', N'656f814b-9383-4153-beb5-385e6fd4bbe3', N'82e69a62-76be-40b6-946c-b1c945b2554e', N'请假申请-反馈发起人', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"82e69a62-76be-40b6-946c-b1c945b2554e","TempTest_Title":"\u6BDB\u660E\u660E\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_0362149c-af22-491f-baef-37bffcc1fd5c","TempTest_UserID_text":"\u6BDB\u660E\u660E","TempTest_DeptID":"4f4865de-fda0-417b-9465-d7648309b772","TempTest_DeptName":"","TempTest_Date1":"2015/9/6 0:00:00","TempTest_Date2":"2015/9/10 0:00:00","TempTest_Type":"d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4","TempTest_Reason":"111111111111111111","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":""};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"1_0","TempTest_Title":"1_0","TempTest_UserID":"1_0","TempTest_UserID_text":"0_0","TempTest_DeptID":"1_0","TempTest_DeptName":"1_0","TempTest_Date1":"1_0","TempTest_Date2":"1_0","TempTest_Type":"1_0","TempTest_Reason":"1_0","TempTest_WriteTime":"1_0","TempTest_Days":"1_0","TempTest_test":"1_0","TempTest_test1":"1_0","TempTest_test2":"1_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"1_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="毛明明的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_0362149c-af22-491f-baef-37bffcc1fd5c" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="4f4865de-fda0-417b-9465-d7648309b772" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：部门主管审批</th>
        <th style="width:20%;">&nbsp;处理人：毛明明</th>
        <th style="width:25%;">&nbsp;收件时间：2015-09-06 20:31:52</th>
        <th style="width:25%;">&nbsp;完成时间：2015-09-06 20:32:12</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/0362149c-af22-491f-baef-37bffcc1fd5c.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A50B01528B09 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'b724a8f2-521b-4ae8-91a9-914bd77f36c1', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'd86ecefb-8515-4b26-81c7-60c49a8a64c0', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A502009D785A AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'65c68211-15b1-443f-8efd-91888c4bc809', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'93536eaf-2ea1-4a29-9d88-8bad1927a96e', N'请假申请', N'反馈发起人', N'28c24213-d13a-4388-8752-a93481bab627', N'f9c3eca1-8d58-4ea1-a1a2-2674f8b68ef2', N'27180112-f5a5-4877-895a-c2fe30fe1320', N'请假申请-反馈发起人', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"27180112-f5a5-4877-895a-c2fe30fe1320","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015-07-16 00:00:00","TempTest_Date2":"2015-07-24 00:00:00","TempTest_Type":"d2122199-23a7-4b59-87d4-b9b60e17735b","TempTest_Reason":"111111111111","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":""};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"1_0","TempTest_Title":"1_0","TempTest_UserID":"1_0","TempTest_UserID_text":"0_0","TempTest_DeptID":"1_0","TempTest_DeptName":"1_0","TempTest_Date1":"1_0","TempTest_Date2":"1_0","TempTest_Type":"1_0","TempTest_Reason":"1_0","TempTest_WriteTime":"1_0","TempTest_Days":"1_0","TempTest_test":"1_0","TempTest_test1":"1_0","TempTest_test2":"1_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"1_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="周丽的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_1acf9c22-bfb6-4673-a698-a58233747b92" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="3975624c-148f-4838-88c9-12af85d2e05e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:23</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:15:31</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：不同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:54</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:16:15</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A4D7015ED575 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'52431f20-4936-425f-a26a-91ebe4327f21', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'04a41e2e-0426-44a5-a307-54456820a417', N'c98fd80c-23c9-4947-82aa-305b89009be3', N'8542c297-39fe-4622-b537-fdc54f58c0e9', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"8542c297-39fe-4622-b537-fdc54f58c0e9","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015-07-22 00:00:00","TempTest_Date2":"2015-07-31 00:00:00","TempTest_Type":"a1e92887-8230-4aba-8a06-bebffdee8043","TempTest_Reason":"6hhhh","TempTest_WriteTime":"","TempTest_Days":"6","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":""};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：人事部备案</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-07 20:42:35</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-07 20:42:51</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：人事部备案</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-07 20:42:59</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-07 20:43:52</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:25:25</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-09 20:38:27</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:38:39</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-09 20:39:19</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:39:28</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-09 20:46:23</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:46:37</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-09 20:47:13</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:50:02</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:05:49</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：人事部备案</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-10 12:05:49</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:07:16</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-10 12:07:16</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:07:23</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-10 12:07:54</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:10:34</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-10 12:10:49</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:14:12</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A4D100C9B0A6 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'8effa538-59f1-412d-8c0d-9975dd2bddf1', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'ab3c8ae2-ba77-430e-a530-27abc6d52f9e', N'583f4eae-cacb-44bf-b680-fef181b766ac', N'b9718db3-f1c7-410a-b532-793b5b8a1794', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"b9718db3-f1c7-410a-b532-793b5b8a1794","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015/9/24 8:15:00","TempTest_Date2":"2015/10/2 10:45:00","TempTest_Type":"d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4","TempTest_Reason":"5555","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":""};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="1" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="1" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-09-17 11:30:18</th>
        <th style="width:25%;">&nbsp;完成时间：2015-09-17 14:26:30</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：不同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A51600FC1DED AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'f128f504-0984-4a88-94b9-9c3bf0580574', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'b9718db3-f1c7-410a-b532-793b5b8a1794', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A51600BD990F AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'ff63abc8-139b-491b-8baf-9ce09b9e377b', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'e725a8b5-2a0d-4683-ad55-844b67ed0d6a', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="2015-09-17 16:13" defaultvalue="%3C%25=RoadFlow.Utility.DateTimeNew.ShortDateTime%25%3E" istime="1" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="1" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A516010B5F68 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'6bd66340-5309-48af-bfc5-9e8dc5661706', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'eb462ccf-abff-4351-8747-9bd7c3afc6ad', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A4FF0168B8E8 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'3a3d4666-80fb-44cf-b22b-a248465720e0', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'93536eaf-2ea1-4a29-9d88-8bad1927a96e', N'请假申请', N'反馈发起人', N'28c24213-d13a-4388-8752-a93481bab627', N'f9c3eca1-8d58-4ea1-a1a2-2674f8b68ef2', N'27180112-f5a5-4877-895a-c2fe30fe1320', N'请假申请-反馈发起人', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"27180112-f5a5-4877-895a-c2fe30fe1320","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015-07-16 00:00:00","TempTest_Date2":"2015-07-24 00:00:00","TempTest_Type":"d2122199-23a7-4b59-87d4-b9b60e17735b","TempTest_Reason":"111111111111","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":""};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"1_0","TempTest_Title":"1_0","TempTest_UserID":"1_0","TempTest_UserID_text":"0_0","TempTest_DeptID":"1_0","TempTest_DeptName":"1_0","TempTest_Date1":"1_0","TempTest_Date2":"1_0","TempTest_Type":"1_0","TempTest_Reason":"1_0","TempTest_WriteTime":"1_0","TempTest_Days":"1_0","TempTest_test":"1_0","TempTest_test1":"1_0","TempTest_test2":"1_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"1_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="周丽的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_1acf9c22-bfb6-4673-a698-a58233747b92" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="3975624c-148f-4838-88c9-12af85d2e05e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:23</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:15:31</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：不同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:54</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:16:15</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A4D7015ED575 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'a252fbc3-e762-478e-a3e3-a258d5f92c5d', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'93536eaf-2ea1-4a29-9d88-8bad1927a96e', N'请假申请', N'反馈发起人', N'5d1f9a32-3887-4cd7-9900-f376d3dcf529', N'f9c3eca1-8d58-4ea1-a1a2-2674f8b68ef2', N'27180112-f5a5-4877-895a-c2fe30fe1320', N'请假申请-反馈发起人', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"27180112-f5a5-4877-895a-c2fe30fe1320","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015-07-16 00:00:00","TempTest_Date2":"2015-07-24 00:00:00","TempTest_Type":"d2122199-23a7-4b59-87d4-b9b60e17735b","TempTest_Reason":"111111111111","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":"1"};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"1_0","TempTest_Title":"1_0","TempTest_UserID":"1_0","TempTest_UserID_text":"0_0","TempTest_DeptID":"1_0","TempTest_DeptName":"1_0","TempTest_Date1":"1_0","TempTest_Date2":"1_0","TempTest_Type":"1_0","TempTest_Reason":"1_0","TempTest_WriteTime":"1_0","TempTest_Days":"1_0","TempTest_test":"1_0","TempTest_test1":"1_0","TempTest_test2":"1_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"1_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="毛明明的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_0362149c-af22-491f-baef-37bffcc1fd5c" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="4f4865de-fda0-417b-9465-d7648309b772" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:23</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:15:31</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：不同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:54</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:16:15</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A4D7015FAF06 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'58273126-bd8a-4337-aff7-a71b0468b736', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'7441f7ba-7b83-442b-aed0-f4234c143c2d', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A4D7015B020B AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'a872d249-3aca-469d-8922-a903a2835f13', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'7441f7ba-7b83-442b-aed0-f4234c143c2d', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A4D7015B020B AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'156da0cf-ad3c-40db-8a09-b3b3238bfad2', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'93536eaf-2ea1-4a29-9d88-8bad1927a96e', N'请假申请', N'反馈发起人', N'c3a7bb76-1c4d-45ea-abf9-723a47e9f01c', N'656f814b-9383-4153-beb5-385e6fd4bbe3', N'82e69a62-76be-40b6-946c-b1c945b2554e', N'请假申请-反馈发起人', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"82e69a62-76be-40b6-946c-b1c945b2554e","TempTest_Title":"\u6BDB\u660E\u660E\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_0362149c-af22-491f-baef-37bffcc1fd5c","TempTest_UserID_text":"\u6BDB\u660E\u660E","TempTest_DeptID":"4f4865de-fda0-417b-9465-d7648309b772","TempTest_DeptName":"","TempTest_Date1":"2015/9/6 0:00:00","TempTest_Date2":"2015/9/10 0:00:00","TempTest_Type":"d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4","TempTest_Reason":"111111111111111111","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":""};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"1_0","TempTest_Title":"1_0","TempTest_UserID":"1_0","TempTest_UserID_text":"0_0","TempTest_DeptID":"1_0","TempTest_DeptName":"1_0","TempTest_Date1":"1_0","TempTest_Date2":"1_0","TempTest_Type":"1_0","TempTest_Reason":"1_0","TempTest_WriteTime":"1_0","TempTest_Days":"1_0","TempTest_test":"1_0","TempTest_test1":"1_0","TempTest_test2":"1_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"1_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="毛明明的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_0362149c-af22-491f-baef-37bffcc1fd5c" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="4f4865de-fda0-417b-9465-d7648309b772" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：部门主管审批</th>
        <th style="width:20%;">&nbsp;处理人：毛明明</th>
        <th style="width:25%;">&nbsp;收件时间：2015-09-06 20:31:52</th>
        <th style="width:25%;">&nbsp;完成时间：2015-09-06 20:32:12</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/0362149c-af22-491f-baef-37bffcc1fd5c.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A50B01528B09 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'7f65345d-f024-44ab-aa3e-b87daba93604', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'93536eaf-2ea1-4a29-9d88-8bad1927a96e', N'请假申请', N'反馈发起人', N'970a0a81-d9d1-4dac-af3f-1ca71e71e805', N'f9c3eca1-8d58-4ea1-a1a2-2674f8b68ef2', N'27180112-f5a5-4877-895a-c2fe30fe1320', N'请假申请-反馈发起人', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"27180112-f5a5-4877-895a-c2fe30fe1320","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015-07-16 00:00:00","TempTest_Date2":"2015-07-24 00:00:00","TempTest_Type":"d2122199-23a7-4b59-87d4-b9b60e17735b","TempTest_Reason":"111111111111","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":"1"};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"1_0","TempTest_Title":"1_0","TempTest_UserID":"1_0","TempTest_UserID_text":"0_0","TempTest_DeptID":"1_0","TempTest_DeptName":"1_0","TempTest_Date1":"1_0","TempTest_Date2":"1_0","TempTest_Type":"1_0","TempTest_Reason":"1_0","TempTest_WriteTime":"1_0","TempTest_Days":"1_0","TempTest_test":"1_0","TempTest_test1":"1_0","TempTest_test2":"1_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"1_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:23</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:15:31</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：不同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:54</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:16:15</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A4D70161A639 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'd0495a53-a286-4fe8-b5ea-b8cfda529318', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'82e69a62-76be-40b6-946c-b1c945b2554e', N'毛明明的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="毛明明的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_0362149c-af22-491f-baef-37bffcc1fd5c" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="4f4865de-fda0-417b-9465-d7648309b772" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A50B0152588F AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'b49351f5-a2f4-4652-909e-c5e867d16b8d', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'eb462ccf-abff-4351-8747-9bd7c3afc6ad', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A4FF0168B8E8 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'ec058325-5962-4b75-89fa-c860f34f5925', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'93536eaf-2ea1-4a29-9d88-8bad1927a96e', N'请假申请', N'反馈发起人', N'5d1f9a32-3887-4cd7-9900-f376d3dcf529', N'f9c3eca1-8d58-4ea1-a1a2-2674f8b68ef2', N'27180112-f5a5-4877-895a-c2fe30fe1320', N'请假申请-反馈发起人', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"27180112-f5a5-4877-895a-c2fe30fe1320","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015-07-16 00:00:00","TempTest_Date2":"2015-07-24 00:00:00","TempTest_Type":"d2122199-23a7-4b59-87d4-b9b60e17735b","TempTest_Reason":"111111111111","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":"1"};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"1_0","TempTest_Title":"1_0","TempTest_UserID":"1_0","TempTest_UserID_text":"0_0","TempTest_DeptID":"1_0","TempTest_DeptName":"1_0","TempTest_Date1":"1_0","TempTest_Date2":"1_0","TempTest_Type":"1_0","TempTest_Reason":"1_0","TempTest_WriteTime":"1_0","TempTest_Days":"1_0","TempTest_test":"1_0","TempTest_test1":"1_0","TempTest_test2":"1_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"1_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="毛明明的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_0362149c-af22-491f-baef-37bffcc1fd5c" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="4f4865de-fda0-417b-9465-d7648309b772" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:23</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:15:31</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：不同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-16 21:15:54</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-16 21:16:15</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A4D7015FAF06 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'05e5b960-4f61-4daf-97ac-d3b28585d9fe', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'52103a3b-115c-4417-8e92-fe7a52212db5', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
	var fieldStatus = "1"==""? {} : {"temptest_id":"0_0","temptest_title":"0_2","temptest_userid":"0_2","temptest_userid_text":"0_0","temptest_deptid":"0_2","temptest_deptname":"0_2","temptest_date1":"0_2","temptest_date2":"0_2","temptest_type":"0_2","temptest_reason":"0_0","temptest_writetime":"0_0","temptest_days":"0_2","temptest_test":"0_0","temptest_test1":"0_0","temptest_test2":"0_0","temptest_test2_text":"0_0","temptest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext text1" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="hidden" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe"><input type="text" type1="flow_org" id="TempTest.UserID_text" name="TempTest.UserID_text" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mytext text1" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid="" readonly="" style="border-width: 1px 0px 1px 1px; border-top-style: solid; border-top-color: rgb(183, 182, 180); border-left-style: solid; border-left-color: rgb(183, 182, 180); border-bottom-style: solid; border-bottom-color: rgb(183, 182, 180);"><input type="button" title="" class="mybutton button1" style="margin:0;" value="选择"></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="hidden" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e"><input type="text" type1="flow_org" id="TempTest.DeptID_text" name="TempTest.DeptID_text" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mytext text1" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid="" readonly="" style="border-width: 1px 0px 1px 1px; border-top-style: solid; border-top-color: rgb(183, 182, 180); border-left-style: solid; border-left-color: rgb(183, 182, 180); border-bottom-style: solid; border-bottom-color: rgb(183, 182, 180);"><input type="button" title="" class="mybutton button1" style="margin:0;" value="选择"></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="2015-12-03 15:45" defaultvalue="%3C%25=RoadFlow.Utility.DateTimeNew.ShortDateTime%25%3E" istime="1" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mytext text1" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="1" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mytext text1" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext text1" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><span style="display:inline-block;"><div><input type="text" style="display:none;" id="TempTest.Type" name="TempTest.Type" isflow="1" type1="flow_combox" datasource="0" listmode="0" tagname="select"><input type="text" autocomplete="off" class="comboxtext1" style="undefined" id="TempTest.Type_text" name="TempTest.Type_text" value="" readonly="" title=""></div><div id="TempTest.Type_selectdiv" style="width: 150px; height: auto; white-space: nowrap; display: none; left: 138px;" class="comboxdiv"><div class="comboxoption1" value="a1e92887-8230-4aba-8a06-bebffdee8043"><label style="vertical-align:middle;">事假</label></div><div class="comboxoption" value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4"><label style="vertical-align:middle;">病假</label></div><div class="comboxoption" value="88f884d7-4b8e-441a-a3f5-b9192629d4e0"><label style="vertical-align:middle;">年假</label></div><div class="comboxoption" value="d2122199-23a7-4b59-87d4-b9b60e17735b"><label style="vertical-align:middle;">产假</label></div><div class="comboxoption" value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d"><label style="vertical-align:middle;">陪护假</label></div><div class="comboxoption" value="1cc3d849-b755-4f2c-8fc7-d47610030373"><label style="vertical-align:middle;">探亲假</label></div></div></span></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext text1" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="hidden" id="TempTest.test" name="TempTest.test" value=""><input type="text" type1="flow_files" id="TempTest.test_text" name="TempTest.test_text" value="" style="width: 200px; border-width: 1px 0px 1px 1px; border-top-style: solid; border-top-color: rgb(183, 182, 180); border-left-style: solid; border-left-color: rgb(183, 182, 180); border-bottom-style: solid; border-bottom-color: rgb(183, 182, 180);" filetype="" isflow="1" class="mytext text1" title="" readonly="readonly"><input type="button" class="mybutton button1" style="margin:0;" value="附件">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A5630103B219 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'efc920ae-5154-420b-9516-e0f54fb664b1', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'27180112-f5a5-4877-895a-c2fe30fe1320', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A4D7015E4C09 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'98884963-84c4-4128-9363-e2d24036292b', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'ab3c8ae2-ba77-430e-a530-27abc6d52f9e', N'583f4eae-cacb-44bf-b680-fef181b766ac', N'b9718db3-f1c7-410a-b532-793b5b8a1794', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"b9718db3-f1c7-410a-b532-793b5b8a1794","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015/9/24 8:15:00","TempTest_Date2":"2015/10/2 10:45:00","TempTest_Type":"d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4","TempTest_Reason":"5555","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":""};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="1" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="1" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-09-17 11:30:18</th>
        <th style="width:25%;">&nbsp;完成时间：2015-09-17 14:26:30</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：不同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A51600FC1DED AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'8d33398c-b614-44fb-86a2-e800f463c4e4', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'27180112-f5a5-4877-895a-c2fe30fe1320', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A4D7015E4C09 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'833ba2a6-db20-48b0-8652-e84a6bdd1f74', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'27180112-f5a5-4877-895a-c2fe30fe1320', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A4D7015E4C09 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'0a01a2a5-89a4-440d-b1cc-ea6d16d06b91', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'04a41e2e-0426-44a5-a307-54456820a417', N'c98fd80c-23c9-4947-82aa-305b89009be3', N'8542c297-39fe-4622-b537-fdc54f58c0e9', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"8542c297-39fe-4622-b537-fdc54f58c0e9","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015-07-22 00:00:00","TempTest_Date2":"2015-07-31 00:00:00","TempTest_Type":"a1e92887-8230-4aba-8a06-bebffdee8043","TempTest_Reason":"6hhhh","TempTest_WriteTime":"","TempTest_Days":"6","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":""};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：人事部备案</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-07 20:42:35</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-07 20:42:51</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：人事部备案</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-07 20:42:59</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-07 20:43:52</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:25:25</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-09 20:38:27</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:38:39</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-09 20:39:19</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:39:28</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-09 20:46:23</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:46:37</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-09 20:47:13</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-09 20:50:02</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:05:49</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：人事部备案</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-10 12:05:49</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:07:16</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-10 12:07:16</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:07:23</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-10 12:07:54</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:10:34</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-07-10 12:10:49</th>
        <th style="width:25%;">&nbsp;完成时间：2015-07-10 12:14:12</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A4D100C9B0A6 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'7b3c6593-6017-42f1-8f40-f0199042bfc6', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'27180112-f5a5-4877-895a-c2fe30fe1320', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {};
    var fieldStatus = "1"==""?{}: {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="0" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width: 700px; height: 80px;" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    ', CAST(0x0000A4D7015E4C09 AS DateTime))
INSERT [WorkFlowArchives] ([ID], [FlowID], [StepID], [FlowName], [StepName], [TaskID], [GroupID], [InstanceID], [Title], [Contents], [Comments], [WriteTime]) VALUES (N'6ce3a29c-1106-4c61-b709-f197c3ea22c6', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'请假申请', N'填写请假单', N'ab3c8ae2-ba77-430e-a530-27abc6d52f9e', N'583f4eae-cacb-44bf-b680-fef181b766ac', N'b9718db3-f1c7-410a-b532-793b5b8a1794', N'徐洪的请假申请', N'<link href="/Platform/WorkFlowRun/Scripts/Forms/flowform_print.css" rel="stylesheet" />        <style type="text/css" media="print">            .Noprint { display: none; }        </style>        <link href="/Platform/WorkFlowRun/Scripts/Forms/flowform.css" rel="stylesheet" type="text/css" />        <script src="/Platform/WorkFlowRun/Scripts/Forms/common.js" type="text/javascript" ></script><div style="width:98%; margin:-10px auto 0 auto;">
    
<link href="Scripts/Forms/flowform.css" rel="stylesheet" type="text/css">
<script src="Scripts/Forms/common.js" type="text/javascript"></script>
<input type="hidden" id="Form_ValidateAlertType" name="Form_ValidateAlertType" value="1">
<input type="hidden" id="Form_TitleField" name="Form_TitleField" value="TempTest.Title">
<input type="hidden" id="Form_DBConnID" name="Form_DBConnID" value="06075250-30dc-4d32-bf97-e922cb30fac8">
<input type="hidden" id="Form_DBTable" name="Form_DBTable" value="TempTest">
<input type="hidden" id="Form_DBTablePk" name="Form_DBTablePk" value="ID">
<input type="hidden" id="Form_DBTableTitle" name="Form_DBTableTitle" value="Title">
<input type="hidden" id="Form_AutoSaveData" name="Form_AutoSaveData" value="1">
<script type="text/javascript">
	var initData = {"TempTest_ID":"b9718db3-f1c7-410a-b532-793b5b8a1794","TempTest_Title":"\u5F90\u6D2A\u7684\u8BF7\u5047\u7533\u8BF7","TempTest_UserID":"u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe","TempTest_UserID_text":"\u5F90\u6D2A","TempTest_DeptID":"96f75a51-779b-491a-9773-cb5f90cef11e","TempTest_DeptName":"","TempTest_Date1":"2015/9/24 8:15:00","TempTest_Date2":"2015/10/2 10:45:00","TempTest_Type":"d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4","TempTest_Reason":"5555","TempTest_WriteTime":"","TempTest_Days":"1","TempTest_test":"","TempTest_test1":"","TempTest_test2":"","TempTest_test2_text":"","TempTest_flowcompleted":""};
	var fieldStatus = "1"==""? {} : {"TempTest_ID":"0_0","TempTest_Title":"0_2","TempTest_UserID":"0_2","TempTest_UserID_text":"0_0","TempTest_DeptID":"0_2","TempTest_DeptName":"0_2","TempTest_Date1":"0_2","TempTest_Date2":"0_2","TempTest_Type":"0_2","TempTest_Reason":"0_0","TempTest_WriteTime":"0_0","TempTest_Days":"0_2","TempTest_test":"0_0","TempTest_test1":"0_0","TempTest_test2":"0_0","TempTest_test2_text":"0_0","TempTest_flowcompleted":"0_0"};
	var displayModel = ''0'';
	$(window).load(function (){
		formrun.initData(initData, "TempTest", fieldStatus, displayModel);
	});
</script>
<p><br></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="徐洪的请假申请" style="width:80%" isflow="1" class="mytext" title=""><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="96f75a51-779b-491a-9773-cb5f90cef11e" more="0" isflow="1" class="mymember" title="" dept="0" station="0" user="0" workgroup="0" unit="0" rootid=""></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="" defaultvalue="" istime="1" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title="">&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="" defaultvalue="" istime="1" daybefor="0" dayafter="1" currentmonth="0" isflow="1" class="mycalendar" title=""></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="" valuetype="3" isflow="1" class="mytext" title="">&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><select class="mycombox" id="TempTest.Type" name="TempTest.Type" width1="150" datasource="0" listmode="0" isflow="1" type1="flow_combox"><option value="a1e92887-8230-4aba-8a06-bebffdee8043">事假</option>0<option value="d0b8d5f6-b708-4bec-ba2f-f4bd15d274e4">病假</option>0<option value="88f884d7-4b8e-441a-a3f5-b9192629d4e0">年假</option>0<option value="d2122199-23a7-4b59-87d4-b9b60e17735b">产假</option>0<option value="f594d6d0-4ad7-4695-ad2e-6a06c870b25d">陪护假</option>0<option value="1cc3d849-b755-4f2c-8fc7-d47610030373">探亲假</option>0</select></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><textarea isflow="1" type1="flow_textarea" id="TempTest.Reason" name="TempTest.Reason" class="mytext" style="width:700px;height:80px" maxlength="500"></textarea></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="" style="width:200px" filetype="" isflow="1" class="myfile" title="">&nbsp;</td></tr></tbody></table><p>&nbsp;</p>
    <script type="text/javascript">fieldStatus ={};</script></div>', N'
    
    <style type="text/css">
        .commenttable { margin:12px auto 0 auto; width:96%; background:#ededee; }
        .commenttable tr th { text-align:left; height:25px; background:#ffffff; font-weight:normal;}
        .commenttable tr td { height:28px; background:#ffffff;}
    </style>
    
    <table cellpadding="0" cellspacing="1" border="0" class="commenttable">
    <tbody><tr>
        <th style="width:30%;">&nbsp;步骤：领导审批</th>
        <th style="width:20%;">&nbsp;处理人：徐洪</th>
        <th style="width:25%;">&nbsp;收件时间：2015-09-17 11:30:18</th>
        <th style="width:25%;">&nbsp;完成时间：2015-09-17 14:26:30</th>
    </tr>
    <tr>
        <td colspan="4" style="">
        <div style="float:left; height:26px; padding:9px 0 0 6px; ">
        处理意见：不同意
        </div>
        <div style="float:left; height:26px; width:77px; margin:5px 20px 0 20px; background:url(../../Files/UserSigns/eb03262c-ab60-4bc6-a4c0-96e66a4229fe.gif) no-repeat left center;">&nbsp;</div>
        </td>
    </tr>
    </tbody></table>
    
    ', CAST(0x0000A51600FC1DED AS DateTime))
INSERT [WorkFlowButtons] ([ID], [Title], [Ico], [Script], [Note], [Sort]) VALUES (N'29b358e1-ad64-4f09-846c-4554ae6b85c4', N'打印', N'/Images/ico/printer.gif', N'formPrint();', N'打印当前表单', 10)
INSERT [WorkFlowButtons] ([ID], [Title], [Ico], [Script], [Note], [Sort]) VALUES (N'7217b1b1-663d-4f7a-83ff-5b89047ace51', N'查看主流程表单', N'/Images/ico/topic.gif', N'showMainFlowForm()', NULL, 13)
INSERT [WorkFlowButtons] ([ID], [Title], [Ico], [Script], [Note], [Sort]) VALUES (N'da7c699c-3c55-4657-8781-6881ac9117b7', N'刷新', N'/Images/ico/Refresh.png', N'window.location=window.location;', N'刷新当前流程页面', 6)
INSERT [WorkFlowButtons] ([ID], [Title], [Ico], [Script], [Note], [Sort]) VALUES (N'347b811c-7568-4472-9a61-6c31f66980ae', N'转交', N'/Images/ico/arrow_medium_lower_right.png', N'flowRedirect();', N'将当前任务转交给其他人处理', 9)
INSERT [WorkFlowButtons] ([ID], [Title], [Ico], [Script], [Note], [Sort]) VALUES (N'86b7fa6c-891f-4565-9309-81672d3ba80a', N'退回', N'/Images/ico/arrow_medium_left.png', N'flowBack();', N'退回到上一步或某一步', 2)
INSERT [WorkFlowButtons] ([ID], [Title], [Ico], [Script], [Note], [Sort]) VALUES (N'954effa8-03b8-461a-aaa8-8727d090dcb9', N'完成', N'/Images/ico/role.gif', N'flowCompleted();', N'完成流程', 3)
INSERT [WorkFlowButtons] ([ID], [Title], [Ico], [Script], [Note], [Sort]) VALUES (N'fd768e2b-5739-4bc1-b397-8a151bc0881d', N'查看子流程', N'/Images/ico/rgb.png', N'showSubFlow();', N'查看子流程表单及处理过程', 12)
INSERT [WorkFlowButtons] ([ID], [Title], [Ico], [Script], [Note], [Sort]) VALUES (N'3b271f67-0433-4082-ad1a-8df1b967b879', N'保存', N'/Images/ico/save.gif', N'flowSave();', N'保存当前任务，下次继续处理', 4)
INSERT [WorkFlowButtons] ([ID], [Title], [Ico], [Script], [Note], [Sort]) VALUES (N'8982b97c-adba-4a3a-afd9-9a3ef6ff12d8', N'发送', N'/Images/ico/arrow_medium_right.png', N'flowSend();', N'发送到下一步', 1)
INSERT [WorkFlowButtons] ([ID], [Title], [Ico], [Script], [Note], [Sort]) VALUES (N'c40fb454-4e1a-414f-9a3a-ac66a998c8a7', N'流程图', N'/Images/ico/shape_aling_left.png', N'showFlowDesign();', N'显示当前流程设计图', 11)
INSERT [WorkFlowButtons] ([ID], [Title], [Ico], [Script], [Note], [Sort]) VALUES (N'da606ff2-cdf2-4363-8212-cc7c633fb2f2', N'关闭', N'/Images/ico/application_osx_remove.png', N'if(confirm("您真的关闭窗口吗?"))
{
      top.mainTab.closeTab();
}', N'关闭窗口', 5)
INSERT [WorkFlowButtons] ([ID], [Title], [Ico], [Script], [Note], [Sort]) VALUES (N'b47b6455-ebbc-493d-9e8a-cfd8ea7d95f4', N'保存', N'/Images/ico/saveas.gif', N'flowSaveIframe();', N'保存自定义表单', 14)
INSERT [WorkFlowButtons] ([ID], [Title], [Ico], [Script], [Note], [Sort]) VALUES (N'b8a7af17-7ad5-4699-b679-d421691dd737', N'过程查看', N'/Images/ico/search.png', N'showProcess();', N'查看流程处理过程', 8)
INSERT [WorkFlowComment] ([ID], [MemberID], [Comment], [Type], [Sort]) VALUES (N'53faa4e2-1396-48ae-8153-087101ee0d5c', N'', N'不同意', 0, 2)
INSERT [WorkFlowComment] ([ID], [MemberID], [Comment], [Type], [Sort]) VALUES (N'3390261f-ea83-46ef-b53e-35ac154bd0a9', N'u_eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'同意', 1, 3)
INSERT [WorkFlowComment] ([ID], [MemberID], [Comment], [Type], [Sort]) VALUES (N'6ea44f47-8f2a-4eb6-bf34-dfd4c12d420a', N'', N'同意', 0, 1)
INSERT [WorkFlowDelegation] ([ID], [UserID], [StartTime], [EndTime], [FlowID], [ToUserID], [WriteTime], [Note]) VALUES (N'6d622104-88c2-494d-8d6c-2f608bfd6114', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', CAST(0x0000A544016E1E90 AS DateTime), CAST(0x0000A560016E1E90 AS DateTime), N'f35d0b4a-b1f9-4fdc-b552-3720953b889f', N'8086d01f-7ae3-402e-b543-d34f1059f79a', CAST(0x0000A545015AFC14 AS DateTime), NULL)
INSERT [WorkFlowForm] ([ID], [Name], [Type], [CreateUserID], [CreateUserName], [CreateTime], [LastModifyTime], [Html], [SubTableJson], [EventsJson], [Attribute], [Status]) VALUES (N'8d5b11a7-4f3d-ebc6-b182-11e632df4819', N'物资采购申请子表', N'626480b3-eaa9-4705-acbb-82901db4fda4', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A4DE01702EB8 AS DateTime), CAST(0x0000A4DF0101F5B0 AS DateTime), N'<p><br/></p><p><br/></p><table class="flowformtable" cellpadding="0" cellspacing="1" data-sort="sortDisabled"><tbody><tr class="firstRow"><td width="152" valign="top" style="word-break: break-all;">物资名称：<br/></td><td width="366" valign="top"><input type="text" id="TempTest_PurchaseList.Name" type1="flow_text" name="TempTest_PurchaseList.Name" value="文本框" defaultvalue="" valuetype="0"/></td><td width="98" valign="top" style="word-break: break-all;">型号：<br/></td><td width="420" valign="top"><input type="text" id="TempTest_PurchaseList.Model" type1="flow_text" name="TempTest_PurchaseList.Model" value="文本框" defaultvalue="" valuetype="0"/></td></tr><tr><td width="152" valign="top" style="word-break: break-all;">单位：<br/></td><td width="366" valign="top"><input type="text" id="TempTest_PurchaseList.Unit" type1="flow_text" name="TempTest_PurchaseList.Unit" value="文本框" defaultvalue="" valuetype="0"/></td><td width="98" valign="top" style="word-break: break-all;">数量：<br/></td><td width="420" valign="top"><input type="text" id="TempTest_PurchaseList.Quantity" type1="flow_text" name="TempTest_PurchaseList.Quantity" value="文本框" defaultvalue="" valuetype="4"/></td></tr><tr><td width="152" valign="top" style="word-break: break-all;">要求日期：</td><td width="366" valign="top"><input type="text" type1="flow_datetime" id="TempTest_PurchaseList.Date" name="TempTest_PurchaseList.Date" value="日期时间选择" defaultvalue="" istime="0" daybefor="0" dayafter="0" currentmonth="0"/></td><td width="98" valign="top" style="word-break: break-all;">类型：<br/></td><td width="420" valign="top"><input type="text" type1="flow_select" id="TempTest_PurchaseList.Type" name="TempTest_PurchaseList.Type" datasource="1" dictid="" value="下拉列表框" defaultvalue="" hasempty="0" customopts="[{&quot;title&quot;:&quot;办公用品&quot;,&quot;value&quot;:&quot;办公用品&quot;},{&quot;title&quot;:&quot;办公家具&quot;,&quot;value&quot;:&quot;办公家具&quot;},{&quot;title&quot;:&quot;电器&quot;,&quot;value&quot;:&quot;电器&quot;}]"/></td></tr><tr><td width="152" valign="top" style="word-break: break-all;">备注说明：</td><td valign="top" colspan="3" width="107"><input type="text" type1="flow_files" id="TempTest_PurchaseList.Note" name="TempTest_PurchaseList.Note" value="附件上传" filetype=""/></td></tr></tbody></table><p><br/></p>', N'[{"secondtable":"TempTest_PurchaseList","primarytablefiled":"ID","secondtableprimarykey":"ID","secondtablerelationfield":"PurchaseID","editmodel":"1","editformtype":"2a1070f6-af14-45b3-8292-fe0962701c04","editform":"63a2da04-fbfc-42e8-9b6b-3e5ad2299eca","colnums":[{"name":"TempTest_PurchaseList_Note","fieldname":"Note","isshow":"1","showname":"备注","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"0","text_maxlength":"","text_width":"100px","title":"文本框"},"displaymode":null,"issum":"0","index":"8"},{"name":"TempTest_PurchaseList_Type","fieldname":"Type","isshow":"1","showname":"类型","editmode":{"editmode":"select","select_width":"","select_ds":"select_dsstring","select_ds_dict":"","select_ds_dbconn":"06075250-30dc-4d32-bf97-e922cb30fac8","select_ds_sql":"","select_ds_string":"办公用品,办公用品;办公家具,办公家具;耗材,耗材","select_hasempty":"0","select_default":"","title":"下拉列表"},"displaymode":null,"issum":"0","index":"7"},{"name":"TempTest_PurchaseList_Date","fieldname":"Date","isshow":"1","showname":"日期","editmode":{"editmode":"datetime","datetime_defaultvalue":"","datetime_width":"80px","datetime_min":"","datetime_max":"","datetime_istime":"0","title":"日期时间"},"displaymode":"normal","issum":"0","index":"6"},{"name":"TempTest_PurchaseList_Sum1","fieldname":"Sum1","isshow":"1","showname":"金额","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"2","text_maxlength":"","text_width":"100px","title":"文本框"},"displaymode":"normal","issum":"1","index":"5"},{"name":"TempTest_PurchaseList_Quantity","fieldname":"Quantity","isshow":"1","showname":"数量","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"1","text_maxlength":"","text_width":"100px","title":"文本框"},"displaymode":null,"issum":"1","index":"4"},{"name":"TempTest_PurchaseList_Unit","fieldname":"Unit","isshow":"1","showname":"单位","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"0","text_maxlength":"","text_width":"100px","title":"文本框"},"displaymode":"normal","issum":"0","index":"3"},{"name":"TempTest_PurchaseList_Model","fieldname":"Model","isshow":"1","showname":"型号","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"0","text_maxlength":"","text_width":"100px","title":"文本框"},"displaymode":null,"issum":"0","index":"2"},{"name":"TempTest_PurchaseList_Name","fieldname":"Name","isshow":"1","showname":"名称","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"0","text_maxlength":"","text_width":"100px","title":"文本框"},"displaymode":"normal","issum":"0","index":"1"},{"name":"TempTest_PurchaseList_ID","fieldname":"ID","isshow":"0","showname":"","editmode":{},"displaymode":"normal","issum":"0","index":""},{"name":"TempTest_PurchaseList_PurchaseID","fieldname":"PurchaseID","isshow":"0","showname":"","editmode":{},"displaymode":null,"issum":"0","index":""}],"id":"TempTest_PurchaseList_ID_ID_PurchaseID"},{"secondtable":"TempTest_PurchaseList","primarytablefiled":"ID","secondtableprimarykey":"ID","secondtablerelationfield":"","colnums":[{"name":"TempTest_PurchaseList_ID","isshow":"0","showname":"","editmode":{},"issum":"0","index":""},{"name":"TempTest_PurchaseList_PurchaseID","isshow":"0","showname":"","editmode":{},"issum":"0","index":""},{"name":"TempTest_PurchaseList_Name","isshow":"1","showname":"名称","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"0","text_maxlength":"","text_width":"100px","title":"文本框"},"issum":"0","index":"1"},{"name":"TempTest_PurchaseList_Model","isshow":"1","showname":"型号","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"0","text_maxlength":"","text_width":"100px","title":"文本框"},"issum":"0","index":"2"},{"name":"TempTest_PurchaseList_Unit","isshow":"1","showname":"单位","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"0","text_maxlength":"","text_width":"100px","title":"文本框"},"issum":"0","index":"3"},{"name":"TempTest_PurchaseList_Quantity","isshow":"1","showname":"数量","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"1","text_maxlength":"","text_width":"100px","title":"文本框"},"issum":"1","index":"4"},{"name":"TempTest_PurchaseList_Sum1","isshow":"1","showname":"金额","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"2","text_maxlength":"","text_width":"100px","title":"文本框"},"issum":"1","index":"5"},{"name":"TempTest_PurchaseList_Date","isshow":"1","showname":"日期","editmode":{"editmode":"datetime","datetime_defaultvalue":"","datetime_width":"80px","datetime_min":"","datetime_max":"","datetime_istime":"0","title":"日期时间"},"issum":"0","index":"6"},{"name":"TempTest_PurchaseList_Type","isshow":"1","showname":"类型","editmode":{"editmode":"dict","dict_width":"","dict_rang":"a8b9101f-4f8b-4830-9de1-c86ad89405c3","dict_more":"1","title":"数据字典"},"issum":"0","index":"7"},{"name":"TempTest_PurchaseList_Note","isshow":"1","showname":"备注","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"0","text_maxlength":"","text_width":"100px","title":"文本框"},"issum":"0","index":"8"}],"id":"TempTest_PurchaseList_ID_ID_"}]', N'[{"id":"31414dcceba792ae7555cf547c5f2469","events":[{"name":"onchange","script":"alert(\"adfasdfddd2222222sadf\");"},{"name":"onfocus","script":""}]},{"id":"1b7e41dc8ab59a77a1e4a9b3d85c1248","events":[{"name":"onchange","script":""}]},{"id":"9f46a3064bc951942e3e3df980a7032f","events":[{"name":"onchange","script":""}]},{"id":"e8d991bd40d3f33a6cdc0cfc4c6ca63e","events":[{"name":"onchange","script":"alert(srcObj.value);"}]},{"id":"ce88fe006610731bf4317391c89d00a6","events":[{"name":"onchange","script":"alert(srcObj.value);"},{"name":"onclick","script":""}]},{"id":"92ad5da414c2ce523256b541c30021a9","events":[{"name":"onclick","script":"alert(''sfd'');"}]},{"id":"d9582031bd11d53e3e674f13d8a4e0ac","events":[{"name":"onclick","script":""}]},{"id":"3217c33fac83d16dd3b5daa7a2f2f6a3","events":[{"name":"onclick","script":"alert(srcObj.value);"}]},{"id":"72ffb3faf5e8ebecad7d45f7acef9b67","events":[{"name":"onchange","script":"$(\"#TempTest_Purchase\\\\.Note\").val(srcObj.value);"}]}]', N'{"hasEditor":"0","name":"物资采购申请子表","dbconn":"06075250-30dc-4d32-bf97-e922cb30fac8","dbtable":"TempTest_PurchaseList","dbtablepk":"ID","dbtabletitle":"Name","apptype":"626480b3-eaa9-4705-acbb-82901db4fda4","autotitle":false,"validatealerttype":"1","id":"8d5b11a7-4f3d-ebc6-b182-11e632df4819"}', 1)
INSERT [WorkFlowForm] ([ID], [Name], [Type], [CreateUserID], [CreateUserName], [CreateTime], [LastModifyTime], [Html], [SubTableJson], [EventsJson], [Attribute], [Status]) VALUES (N'53ebb42f-22e4-9bbb-7ad1-2e619ab43bb2', N'综合测试', N'7283b92f-21b4-4b0a-8b00-72cc9656f4dc', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A567016A66BA AS DateTime), CAST(0x0000A56E015A3375 AS DateTime), N'<p><br/></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0"><tbody><tr class="firstRow"><td width="173" valign="top" style="-ms-word-break: break-all;">标题：<br/></td><td width="908" valign="top" style="word-break: break-all;"><input type="text" id="TempTest_CustomForm.Title" type1="flow_text" name="TempTest_CustomForm.Title" value="文本框" defaultvalue="" valuetype="2" format="###.00"/></td></tr><tr><td width="173" valign="top" style="-ms-word-break: break-all;">类型：<br/></td><td width="908" valign="top"><input name="TempTest_CustomForm.Type" id="TempTest_CustomForm.Type" type="text" value="下拉列表框" dbconn="06075250-30dc-4d32-bf97-e922cb30fac8" defaultvalue="" type1="flow_select" hasempty="0" datasource="2" sql="select * from users" dictid=""/></td></tr><tr><td valign="top" colspan="1" rowspan="1" style="word-break: break-all;">时间：</td><td valign="top" colspan="1" rowspan="1"><input type="text" type1="flow_datetime" id="TempTest_CustomForm.wdate" name="TempTest_CustomForm.wdate" value="日期时间选择" format="yyyy-MM-dd" defaultvalue="" istime="0" daybefor="0" dayafter="0" currentmonth="0"/></td></tr></tbody></table><p>&nbsp;</p>', N'[]', N'[]', N'{"hasEditor":"0","name":"综合测试","dbconn":"06075250-30dc-4d32-bf97-e922cb30fac8","dbtable":"TempTest_CustomForm","dbtablepk":"ID","dbtabletitle":"Title","apptype":"7283b92f-21b4-4b0a-8b00-72cc9656f4dc","autotitle":false,"validatealerttype":"1","id":"53ebb42f-22e4-9bbb-7ad1-2e619ab43bb2"}', 1)
INSERT [WorkFlowForm] ([ID], [Name], [Type], [CreateUserID], [CreateUserName], [CreateTime], [LastModifyTime], [Html], [SubTableJson], [EventsJson], [Attribute], [Status]) VALUES (N'2e114e74-f21e-06dd-9474-535551c30a3e', N'报告请示', N'626480b3-eaa9-4705-acbb-82901db4fda4', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A3CC00FFD0CC AS DateTime), CAST(0x0000A457011A8D48 AS DateTime), N'<p>&nbsp;</p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 20px;">报 告 请 示</span></strong></p><p>&nbsp;&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0"><tbody><tr class="firstRow"><td width="79" height="16" valign="top" style="-ms-word-break: break-all;">标题：<br/></td><td width="1038" height="16" valign="top"><input type="text" id="TempTest_CustomForm.Title" type1="flow_text" name="TempTest_CustomForm.Title" value="文本框" style="width:70%" width1="70%" defaultvalue="&lt;%=RoadFlow.Platform.Users.CurrentUserName%&gt;的报告请示" maxlength="200" valuetype="0"/></td></tr><tr><td width="79" height="9" valign="top" style="-ms-word-break: break-all;">内容：<br/></td><td width="1038" height="9" valign="top"><input name="TempTest_CustomForm.Contents" id="TempTest_CustomForm.Contents" style="width: 70%; height: 100px;" type="text" maxlength="1000" value="文本域" type1="flow_textarea" width1="70%" defaultvalue="" valuetype="0" isflow="1" height1="100px"/></td></tr></tbody></table><p>&nbsp;</p>', N'[]', N'[]', N'{"hasEditor":"0","name":"报告请示","dbconn":"06075250-30dc-4d32-bf97-e922cb30fac8","dbtable":"TempTest_CustomForm","dbtablepk":"ID","dbtabletitle":"Title","apptype":"626480b3-eaa9-4705-acbb-82901db4fda4","autotitle":false,"validatealerttype":"1","id":"2e114e74-f21e-06dd-9474-535551c30a3e"}', 1)
INSERT [WorkFlowForm] ([ID], [Name], [Type], [CreateUserID], [CreateUserName], [CreateTime], [LastModifyTime], [Html], [SubTableJson], [EventsJson], [Attribute], [Status]) VALUES (N'475bda65-9c5f-5fcc-a008-9d65d0c1a533', N'信息发布', N'626480b3-eaa9-4705-acbb-82901db4fda4', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A3CC014A8AC2 AS DateTime), CAST(0x0000A50B015F90DA AS DateTime), N'<p><br/></p><p>&nbsp;<span style="text-align: center;">&nbsp;</span></p><p style="text-align: center;"><span style="font-size: 24px;"></span></p><p style="text-align: center;"><span style="font-size: 24px;"><strong>信 息 发 布</strong></span></p><p style="text-align: center;">&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0"><tbody><tr class="firstRow"><td width="81" valign="top" style="-ms-word-break: break-all;">标题：<br/></td><td width="1036" valign="top"><input type="text" id="TempTest_News.Title" type1="flow_text" name="TempTest_News.Title" value="文本框" style="width:80%" width1="80%" defaultvalue="" maxlength="500" valuetype="0" eventsid="6fc5d3f50712aa3c96ed16552e155f60"/></td></tr><tr><td width="81" valign="top" style="-ms-word-break: break-all;">副标题：<br/></td><td width="1036" valign="top" style="-ms-word-break: break-all;"><input name="TempTest_News.Title1" id="TempTest_News.Title1" style="width: 80%; height: 70px;" type="text" maxlength="1000" value="文本域" isflow="1" valuetype="0" type1="flow_textarea" defaultvalue="" width1="80%" height1="70px"/>&nbsp;<span style="font-size: 24px;"></span></td></tr><tr><td width="81" valign="top" style="-ms-word-break: break-all;">分类：<br/></td><td width="1036" valign="top" style="word-break: break-all;"><input type="text" type1="flow_select" id="TempTest_News.Type" name="TempTest_News.Type" datasource="0" dictid="a8b9101f-4f8b-4830-9de1-c86ad89405c3" value="下拉列表框" defaultvalue="" hasempty="1"/></td></tr><tr><td width="81" valign="top" style="-ms-word-break: break-all;">内容：<br/></td><td width="1036" valign="top" style="-ms-word-break: break-all;"><input type="text" isflow="1" type1="flow_html" id="TempTest_News.Contents" name="TempTest_News.Contents" value="HTML编辑器" style="width:99%;height:350px" width1="99%" height1="350px"/></td></tr></tbody></table><p>&nbsp;</p>', N'[]', N'[{"id":"6fc5d3f50712aa3c96ed16552e155f60","events":[{"name":"onblur","script":""}]}]', N'{"hasEditor":"1","name":"信息发布","dbconn":"06075250-30dc-4d32-bf97-e922cb30fac8","dbtable":"TempTest_News","dbtablepk":"ID","dbtabletitle":"Title","apptype":"626480b3-eaa9-4705-acbb-82901db4fda4","autotitle":false,"validatealerttype":"1","id":"475bda65-9c5f-5fcc-a008-9d65d0c1a533"}', 1)
INSERT [WorkFlowForm] ([ID], [Name], [Type], [CreateUserID], [CreateUserName], [CreateTime], [LastModifyTime], [Html], [SubTableJson], [EventsJson], [Attribute], [Status]) VALUES (N'59137107-1594-1f6c-9d7d-ca7e912acec8', N'请假申请', N'626480b3-eaa9-4705-acbb-82901db4fda4', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A3C700F55C66 AS DateTime), CAST(0x0000A516010B3EA5 AS DateTime), N'<p><br/></p><p>&nbsp;</p><p style="text-align: center;"><strong><span style="font-size: 24px;">请&nbsp; 假&nbsp; 单</span></strong></p><p>&nbsp;</p><table class="flowformtable" cellspacing="1" cellpadding="0" data-sort="sortDisabled"><tbody><tr class="firstRow"><td valign="top" style="ms-word-break: break-all;">标题：</td><td valign="top" colspan="3"><input type="text" id="TempTest.Title" type1="flow_text" name="TempTest.Title" value="文本框" style="width:80%" width1="80%" defaultvalue="&lt;%=RoadFlow.Platform.Users.CurrentUserName%&gt;的请假申请"/><script type="text/javascript">function onchange_31414dcceba792ae7555cf547c5f2469(srcObj){alert("adfasdfddd2222222sadf");}</script></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假人：<br/></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest.UserID" name="TempTest.UserID" value="组织机构选择框" defaultvalue="u_&lt;%=RoadFlow.Platform.Users.CurrentUserID.ToString()%&gt;" more="0" org_type=","/></td><td width="89" valign="top" style="ms-word-break: break-all;">所在部门：<br/></td><td width="449" valign="top"><input type="text" type1="flow_org" id="TempTest.DeptID" name="TempTest.DeptID" value="组织机构选择框" defaultvalue="&lt;%=RoadFlow.Platform.Users.CurrentDeptID%&gt;" more="0" org_type=","/></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假日期：<br/></td><td width="428" valign="top" style="ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest.Date1" name="TempTest.Date1" value="日期时间选择" defaultvalue="%3C%25=RoadFlow.Utility.DateTimeNew.ShortDateTime%25%3E" istime="1" daybefor="0" dayafter="1" currentmonth="0"/>&nbsp; 至 &nbsp;<input type="text" type1="flow_datetime" id="TempTest.Date2" name="TempTest.Date2" value="日期时间选择" defaultvalue="" istime="1" daybefor="0" dayafter="1" currentmonth="0"/></td><td width="89" valign="top" style="ms-word-break: break-all;">请假天数：<br/></td><td width="449" valign="top" style="ms-word-break: break-all;"><input type="text" id="TempTest.Days" type1="flow_text" name="TempTest.Days" value="文本框" defaultvalue="" valuetype="3"/>&nbsp; 天</td></tr><tr><td valign="top" style="ms-word-break: break-all;">请假类型：</td><td valign="top" style="word-break: break-all;" colspan="3"><input type="text" type1="flow_combox" id="TempTest.Type" name="TempTest.Type" datasource="0" dictid="e7f836be-f091-460f-86e1-f0b6cdceba39" value="下拉组合框" defaultvalue="" width2="150" listmode="0" ismultiple="0"/></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">请假事由：<br/></td><td width="23" valign="top" style="word-break: break-all;" colspan="3"><input type="text" id="TempTest.Reason" name="TempTest.Reason" type1="flow_textarea" isflow="1" value="文本域" style="width:700px;height:80px" width1="700px" height1="80px" valuetype="0" defaultvalue="" maxlength="500" eventsid="1b7e41dc8ab59a77a1e4a9b3d85c1248"/></td></tr><tr><td width="110" valign="top" style="ms-word-break: break-all;">相关附件：<br/></td><td valign="top" style="-ms-word-break: break-all;" colspan="3"><input type="text" type1="flow_files" id="TempTest.test" name="TempTest.test" value="附件上传" style="width:200px" width1="200px" filetype=""/>&nbsp;</td></tr></tbody></table><p>&nbsp;</p>', N'[]', N'[{"id":"31414dcceba792ae7555cf547c5f2469","events":[{"name":"onchange","script":"alert(\"adfasdfddd2222222sadf\");"},{"name":"onfocus","script":""}]},{"id":"1b7e41dc8ab59a77a1e4a9b3d85c1248","events":[{"name":"onchange","script":""}]},{"id":"9f46a3064bc951942e3e3df980a7032f","events":[{"name":"onchange","script":""}]},{"id":"e8d991bd40d3f33a6cdc0cfc4c6ca63e","events":[{"name":"onchange","script":"alert(srcObj.value);"}]},{"id":"ce88fe006610731bf4317391c89d00a6","events":[{"name":"onchange","script":"alert(srcObj.value);"},{"name":"onclick","script":""}]},{"id":"92ad5da414c2ce523256b541c30021a9","events":[{"name":"onclick","script":"alert(''sfd'');"}]},{"id":"d9582031bd11d53e3e674f13d8a4e0ac","events":[{"name":"onclick","script":""}]},{"id":"3217c33fac83d16dd3b5daa7a2f2f6a3","events":[{"name":"onclick","script":"alert(srcObj.value);"}]},{"id":"db870b430be524dc09f5799f3c00f34e","events":[{"name":"onchange","script":""}]},{"id":"c35e2cedc0c184ed51431930ef43288c","events":[{"name":"onchange","script":"alert(srcObj.value);"}]},{"id":"6570cfa31cdb0aefbcf6a47e04efe4af","events":[{"name":"onchange","script":""}]},{"id":"0ab7b46a4adacc57f2bb1b331bbe683a","events":[{"name":"onchange","script":""}]}]', N'{"hasEditor":"0","name":"请假申请","dbconn":"06075250-30dc-4d32-bf97-e922cb30fac8","dbtable":"TempTest","dbtablepk":"ID","dbtabletitle":"Title","apptype":"626480b3-eaa9-4705-acbb-82901db4fda4","autotitle":false,"validatealerttype":"1","id":"59137107-1594-1f6c-9d7d-ca7e912acec8"}', 1)
INSERT [WorkFlowForm] ([ID], [Name], [Type], [CreateUserID], [CreateUserName], [CreateTime], [LastModifyTime], [Html], [SubTableJson], [EventsJson], [Attribute], [Status]) VALUES (N'37355170-bda6-8217-3a34-ffce9c8aae24', N'物资采购申请', N'626480b3-eaa9-4705-acbb-82901db4fda4', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A3D60150EE00 AS DateTime), CAST(0x0000A53201340C60 AS DateTime), N'<p><br/></p><p><br/></p><p style="text-align: center;"><span style="font-size: 20px;"><strong>物资采购申请</strong></span><br/></p><table class="flowformtable" cellspacing="1" cellpadding="0" uetable="null" data-sort="sortDisabled"><tbody><tr class="firstRow"><td width="102" valign="top" style="-ms-word-break: break-all;">申请人：<br/></td><td width="434" valign="top" style="word-break: break-all;"><input type="text" type1="flow_org" id="TempTest_Purchase.UserID" name="TempTest_Purchase.UserID" value="组织机构选择框" defaultvalue="u_&lt;%=new RoadFlow.Platform.WorkFlowTask().GetFirstSnderID(FlowID.ToGuid(), GroupID.ToGuid(), true)%&gt;" more="0" org_type=",2,"/></td><td width="97" valign="top" style="-ms-word-break: break-all;">部门：</td><td width="439" valign="top" style="-ms-word-break: break-all;"><input type="text" type1="flow_org" id="TempTest_Purchase.UserDept" name="TempTest_Purchase.UserDept" value="组织机构选择框" defaultvalue="%3C%25=new%20RoadFlow.Platform.WorkFlowTask().GetFirstSnderDeptID(FlowID.ToGuid(),%20GroupID.ToGuid())%25%3E" more="0" org_type=",0,"/></td></tr><tr><td width="102" valign="top" style="-ms-word-break: break-all;">申请日期：<br/></td><td width="434" valign="top" style="-ms-word-break: break-all;"><input type="text" type1="flow_datetime" id="TempTest_Purchase.SqDateTime" name="TempTest_Purchase.SqDateTime" value="日期时间选择" defaultvalue="&lt;%=RoadFlow.Utility.DateTimeNew.ShortDate%&gt;" istime="0" daybefor="0" dayafter="0" currentmonth="0"/></td><td width="97" valign="top" style="-ms-word-break: break-all;">备注：</td><td width="439" valign="top" style="-ms-word-break: break-all;"><input type="text" id="TempTest_Purchase.Note" type1="flow_text" name="TempTest_Purchase.Note" value="文本框" style="width:80%" width1="80%" defaultvalue="" valuetype="0"/></td></tr><tr><td valign="top" style="word-break: break-all;" colspan="4">申请明细： &nbsp;</td></tr><tr><td valign="top" style="-ms-word-break: break-all;" colspan="4"><input type="text" isflow="1" readonly="readonly" type1="flow_subtable" id="TempTest_PurchaseList_ID_ID_PurchaseID" style="width:99%;height:50px;" value="子表"/></td></tr></tbody></table><p><br/></p>', N'[{"secondtable":"TempTest_PurchaseList","primarytablefiled":"ID","secondtableprimarykey":"ID","secondtablerelationfield":"PurchaseID","editmodel":"0","editformtype":"626480b3-eaa9-4705-acbb-82901db4fda4","editform":"b334e5fd-e995-4d5b-bfd6-feb9ac14122a","displaymodewidth":"700","displaymodeheight":"370","colnums":[{"name":"TempTest_PurchaseList_ID","fieldname":"ID","isshow":"0","showname":"","editmode":{},"displaymode":"normal","issum":"0","index":""},{"name":"TempTest_PurchaseList_PurchaseID","fieldname":"PurchaseID","isshow":"0","showname":"","editmode":{},"displaymode":null,"issum":"0","index":""},{"name":"TempTest_PurchaseList_Name","fieldname":"Name","isshow":"1","showname":"名称","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"0","text_maxlength":"","text_width":"100px","title":"文本框"},"displaymode":"normal","issum":"0","index":"1"},{"name":"TempTest_PurchaseList_Model","fieldname":"Model","isshow":"1","showname":"型号","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"0","text_maxlength":"","text_width":"100px","title":"文本框"},"displaymode":null,"issum":"0","index":"2"},{"name":"TempTest_PurchaseList_Unit","fieldname":"Unit","isshow":"1","showname":"单位","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"0","text_maxlength":"","text_width":"100px","title":"文本框"},"displaymode":"normal","issum":"0","index":"3"},{"name":"TempTest_PurchaseList_Quantity","fieldname":"Quantity","isshow":"1","showname":"数量","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"1","text_maxlength":"","text_width":"100px","title":"文本框"},"displaymode":"number_format","displaymodeformat":"0,000.00","issum":"1","index":"4"},{"name":"TempTest_PurchaseList_Sum1","fieldname":"Sum1","isshow":"0","showname":"金额","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"2","text_maxlength":"","text_width":"100px","title":"文本框"},"displaymode":"normal","issum":"1","index":"5"},{"name":"TempTest_PurchaseList_Date","fieldname":"Date","isshow":"1","showname":"日期","editmode":{"editmode":"datetime","datetime_defaultvalue":"","datetime_width":"80px","datetime_min":"","datetime_max":"","datetime_istime":"0","datetime_format":"","title":"日期时间"},"displaymode":"datetime_format","displaymodeformat":"yyyy-MM-dd","issum":"0","index":"6"},{"name":"TempTest_PurchaseList_Type","fieldname":"Type","isshow":"1","showname":"类型","editmode":{"editmode":"select","select_width":"","select_ds":"select_dsstring","select_ds_dict":"","select_ds_dbconn":"06075250-30dc-4d32-bf97-e922cb30fac8","select_ds_sql":"","select_ds_string":"办公用品,办公用品;办公家具,办公家具;耗材,耗材","select_hasempty":"0","select_default":"","title":"下拉列表"},"displaymode":null,"issum":"0","index":"7"},{"name":"TempTest_PurchaseList_Note","fieldname":"Note","isshow":"1","showname":"备注","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"0","text_maxlength":"","text_width":"100px","title":"文本框"},"displaymode":"files_img","issum":"0","index":"8"}],"id":"TempTest_PurchaseList_ID_ID_PurchaseID"},{"secondtable":"TempTest_PurchaseList","primarytablefiled":"ID","secondtableprimarykey":"ID","secondtablerelationfield":"","colnums":[{"name":"TempTest_PurchaseList_ID","isshow":"0","showname":"","editmode":{},"issum":"0","index":""},{"name":"TempTest_PurchaseList_PurchaseID","isshow":"0","showname":"","editmode":{},"issum":"0","index":""},{"name":"TempTest_PurchaseList_Name","isshow":"1","showname":"名称","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"0","text_maxlength":"","text_width":"100px","title":"文本框"},"issum":"0","index":"1"},{"name":"TempTest_PurchaseList_Model","isshow":"1","showname":"型号","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"0","text_maxlength":"","text_width":"100px","title":"文本框"},"issum":"0","index":"2"},{"name":"TempTest_PurchaseList_Unit","isshow":"1","showname":"单位","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"0","text_maxlength":"","text_width":"100px","title":"文本框"},"issum":"0","index":"3"},{"name":"TempTest_PurchaseList_Quantity","isshow":"1","showname":"数量","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"1","text_maxlength":"","text_width":"100px","title":"文本框"},"issum":"1","index":"4"},{"name":"TempTest_PurchaseList_Sum1","isshow":"1","showname":"金额","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"2","text_maxlength":"","text_width":"100px","title":"文本框"},"issum":"1","index":"5"},{"name":"TempTest_PurchaseList_Date","isshow":"1","showname":"日期","editmode":{"editmode":"datetime","datetime_defaultvalue":"","datetime_width":"80px","datetime_min":"","datetime_max":"","datetime_istime":"0","title":"日期时间"},"issum":"0","index":"6"},{"name":"TempTest_PurchaseList_Type","isshow":"1","showname":"类型","editmode":{"editmode":"dict","dict_width":"","dict_rang":"a8b9101f-4f8b-4830-9de1-c86ad89405c3","dict_more":"1","title":"数据字典"},"issum":"0","index":"7"},{"name":"TempTest_PurchaseList_Note","isshow":"1","showname":"备注","editmode":{"editmode":"text","text_defaultvalue":"","text_valuetype":"0","text_maxlength":"","text_width":"100px","title":"文本框"},"issum":"0","index":"8"}],"id":"TempTest_PurchaseList_ID_ID_"}]', N'[{"id":"31414dcceba792ae7555cf547c5f2469","events":[{"name":"onchange","script":"alert(\"adfasdfddd2222222sadf\");"},{"name":"onfocus","script":""}]},{"id":"1b7e41dc8ab59a77a1e4a9b3d85c1248","events":[{"name":"onchange","script":""}]},{"id":"9f46a3064bc951942e3e3df980a7032f","events":[{"name":"onchange","script":""}]},{"id":"e8d991bd40d3f33a6cdc0cfc4c6ca63e","events":[{"name":"onchange","script":"alert(srcObj.value);"}]},{"id":"ce88fe006610731bf4317391c89d00a6","events":[{"name":"onchange","script":"alert(srcObj.value);"},{"name":"onclick","script":""}]},{"id":"92ad5da414c2ce523256b541c30021a9","events":[{"name":"onclick","script":"alert(''sfd'');"}]},{"id":"d9582031bd11d53e3e674f13d8a4e0ac","events":[{"name":"onclick","script":""}]},{"id":"3217c33fac83d16dd3b5daa7a2f2f6a3","events":[{"name":"onclick","script":"alert(srcObj.value);"}]},{"id":"72ffb3faf5e8ebecad7d45f7acef9b67","events":[{"name":"onchange","script":"$(\"#TempTest_Purchase\\\\.Note\").val(srcObj.value);"}]}]', N'{"hasEditor":"0","name":"物资采购申请","dbconn":"06075250-30dc-4d32-bf97-e922cb30fac8","dbtable":"TempTest_Purchase","dbtablepk":"ID","dbtabletitle":"Title","apptype":"626480b3-eaa9-4705-acbb-82901db4fda4","autotitle":false,"validatealerttype":"2","id":"37355170-bda6-8217-3a34-ffce9c8aae24"}', 1)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'cd984fce-31b6-49c2-83ab-049a0261add4', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'6f24065c-18e5-443b-8935-3a531678a842', N'19dfdd62-4e3a-4d00-bc74-fe2764bd32e6', N'发起', N'46', N'6536ac19-68a5-4eb9-b091-9b93f58f9df9', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E0106C85F AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E0106C85F AS DateTime), NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'464fd74d-cf7d-4316-9056-099ada1596eb', N'da80b4a3-83eb-43c6-ab6a-a17471746d6a', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'ce0c165a-778b-4817-a9c5-21f862f1c96e', N'领导审批', N'b9718db3-f1c7-410a-b532-793b5b8a1794', N'583f4eae-cacb-44bf-b680-fef181b766ac', 0, N'徐洪的请假申请', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A51600BD98F0 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A51600BD98F0 AS DateTime), CAST(0x0000A51600BD9A86 AS DateTime), CAST(0x0000A51600E6CBCF AS DateTime), CAST(0x0000A51600EDFE4B AS DateTime), N'不同意', 1, 3, NULL, 2, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'4e6ee083-ab70-4916-9998-0b872a606043', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'6f24065c-18e5-443b-8935-3a531678a842', N'19dfdd62-4e3a-4d00-bc74-fe2764bd32e6', N'发起', N'45', N'96b107a4-91d3-4176-b983-640aacc6f80c', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E00FD9CB1 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E00FD9CB1 AS DateTime), CAST(0x0000A50E00FD9DE5 AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'095b2fe3-4050-4171-9115-11065005d469', N'8d238e07-7ac6-400c-bd90-dc0a1740560c', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'a3890463-3268-49a9-be46-c56d527c257f', N'审核', N'74', N'17019038-46e0-40cb-90e8-46d06c91faa7', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A563010E0AC8 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A563010E0AC8 AS DateTime), CAST(0x0000A563010E0BD7 AS DateTime), NULL, CAST(0x0000A563010E8CCE AS DateTime), NULL, 0, 3, NULL, 2, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'5290e93e-9992-4fb8-9ca7-185a62148645', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'04018979-6810-456a-9e15-396c4849e31a', N'd6f56e83-0e7b-4928-92c4-207e65b3d271', N'新步骤', N'78', N'7ff5621b-3840-414c-8a8b-f4bca78036c0', 0, N'王', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A568014BC333 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A568014BC333 AS DateTime), CAST(0x0000A568014BC47B AS DateTime), NULL, CAST(0x0000A568014BC6CB AS DateTime), NULL, 0, 2, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'308e30f5-d2a3-4115-8ab3-199e29b87711', N'1b8cf802-e3d6-4f43-97e6-538d1dcf38d6', N'19dfdd62-4e3a-4d00-bc74-fe2764bd32e6', N'6f24065c-18e5-443b-8935-3a531678a842', N'6480a6aa-2bde-417d-bcfc-550bee483b3e', N'自由流程测试-审核', N'62', N'7d1a4c4e-7df6-4d1e-9183-750208ca6d2a', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E011617BF AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E011617BF AS DateTime), CAST(0x0000A50E01161A0B AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, 2, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'b4b06ae1-cb92-46de-80fc-1a5fc7e52352', N'1162acc1-d133-4d46-a566-b2c36c8954ed', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'a3890463-3268-49a9-be46-c56d527c257f', N'审核', N'74', N'17019038-46e0-40cb-90e8-46d06c91faa7', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A563010EAA07 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A563010EAA07 AS DateTime), CAST(0x0000A563010EAB19 AS DateTime), NULL, CAST(0x0000A563010EDC4F AS DateTime), NULL, 0, 3, NULL, 4, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'0a687e4e-a182-4556-9460-1de651d9b84d', N'f25e596c-70dc-4ef7-9e31-abbe54f89777', N'a292842c-3041-4492-b098-82092a3dd651', N'86875775-2f25-443d-ac42-57124f3479a5', N'18337d9c-be91-4963-8d0a-ae188829a3b6', N'审核', N'4072', N'a5c07f74-78e7-4138-8a31-1c05293710db', 5, N'999', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E011CD484 AS DateTime), N'0362149c-af22-491f-baef-37bffcc1fd5c', N'毛明明', CAST(0x0000A50E011CD484 AS DateTime), NULL, NULL, NULL, NULL, NULL, 0, N'该任务由毛明明指派', 2, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'cfb94c47-e12c-4282-a7f3-20b43e8bf8f0', N'e24b98ab-d5bf-4b0a-84fe-922d71d11884', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'e65d4b59-c1f7-4262-bf84-bb5268609182', N'请假子流程', N'69', N'cbf8f35b-4ae6-4f19-9230-40031d10a956', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A5620112CA75 AS DateTime), N'0362149c-af22-491f-baef-37bffcc1fd5c', N'毛明明', CAST(0x0000A5620112CA75 AS DateTime), CAST(0x0000A5680157222C AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, 2, N'c564db6a-3abe-423c-b733-48186abf34b9')
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'593e847b-16de-4540-9c42-214b1ecf81a4', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'6f24065c-18e5-443b-8935-3a531678a842', N'19dfdd62-4e3a-4d00-bc74-fe2764bd32e6', N'发起', N'47', N'ac759241-f4fd-4296-8a6e-94322da139cf', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E0106CF15 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E0106CF15 AS DateTime), NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'252fcac6-c42b-47fe-bc81-27814d4daf5d', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'04018979-6810-456a-9e15-396c4849e31a', N'd6f56e83-0e7b-4928-92c4-207e65b3d271', N'新步骤', N'83', N'49654e6e-cbd2-49d8-a1b7-de69716d777e', 0, N'12341234', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56E010B478F AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56E010B478F AS DateTime), NULL, NULL, CAST(0x0000A56E010B479F AS DateTime), NULL, 0, 2, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'af62e785-bcfa-4758-9c38-278b0a85ead6', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'04018979-6810-456a-9e15-396c4849e31a', N'd6f56e83-0e7b-4928-92c4-207e65b3d271', N'新步骤', N'84', N'd7d2d390-3df2-4d7e-8a83-5784ad91834d', 0, N'xxxxx', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56E0153A2E0 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56E0153A2E0 AS DateTime), CAST(0x0000A56E0153A44B AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'ab3c8ae2-ba77-430e-a530-27abc6d52f9e', N'464fd74d-cf7d-4316-9056-099ada1596eb', N'00000000-0000-0000-0000-000000000000', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'填写请假单', N'b9718db3-f1c7-410a-b532-793b5b8a1794', N'583f4eae-cacb-44bf-b680-fef181b766ac', 4, N'徐洪的请假申请', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A51600EDFE4F AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A51600EDFE4F AS DateTime), CAST(0x0000A51600EDFF8C AS DateTime), CAST(0x0000A5160117312F AS DateTime), CAST(0x0000A51600FC1DDE AS DateTime), NULL, 0, 2, N'退回任务', 3, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'7f17e97f-0641-43d3-989c-28238278410f', N'b9003e84-7cd6-4a71-ac3d-7e646587648c', N'd6f56e83-0e7b-4928-92c4-207e65b3d271', N'04018979-6810-456a-9e15-396c4849e31a', N'bd1eb25a-835f-4a4a-91b6-47a20b69620d', N'新步骤', N'82', N'8ab1aeec-9c10-4a04-8840-851c89284f7e', 0, N'的', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A568015675BE AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A568015675BE AS DateTime), CAST(0x0000A568015676CA AS DateTime), NULL, CAST(0x0000A56801567956 AS DateTime), NULL, 0, 2, NULL, 4, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'a9eab53a-47ba-43ac-9ed3-2e58c08c21f5', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'6f24065c-18e5-443b-8935-3a531678a842', N'19dfdd62-4e3a-4d00-bc74-fe2764bd32e6', N'发起', N'50', N'400cf0bd-942f-4668-aaa3-726d66f468a5', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E0106DEB9 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E0106DEB9 AS DateTime), NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'4d4aac6d-f069-4097-b27a-2e6df08b84fc', N'd8d8027b-fc20-432f-b22d-6c8cc9f648be', N'a292842c-3041-4492-b098-82092a3dd651', N'86875775-2f25-443d-ac42-57124f3479a5', N'18337d9c-be91-4963-8d0a-ae188829a3b6', N'审核', N'4071', N'e0d4fefe-6bed-4cf2-80b7-b6cb1ba10b54', 0, N'gggggg', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50D0115F0D0 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50D0115F0D0 AS DateTime), CAST(0x0000A50D0115F1E0 AS DateTime), NULL, CAST(0x0000A50D0151EA26 AS DateTime), N'同意', 1, 3, NULL, 6, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'fb5ab5d7-0354-4b89-a027-346307aa9cf8', N'58694362-f508-41f7-8e64-9237eb824d54', N'a292842c-3041-4492-b098-82092a3dd651', N'86875775-2f25-443d-ac42-57124f3479a5', N'18337d9c-be91-4963-8d0a-ae188829a3b6', N'审核', N'4071', N'e0d4fefe-6bed-4cf2-80b7-b6cb1ba10b54', 0, N'gggggg', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50D010DC9F0 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50D010DC9F0 AS DateTime), CAST(0x0000A50D010DCB43 AS DateTime), NULL, CAST(0x0000A50D0115E12D AS DateTime), N'同意', 1, 3, NULL, 4, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'4cb80d41-ee71-44fe-9210-361e820c50d1', N'b6f282e1-0d45-4d13-910d-c64d5b853cc7', N'a3890463-3268-49a9-be46-c56d527c257f', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'e65d4b59-c1f7-4262-bf84-bb5268609182', N'请假子流程', N'74', N'17019038-46e0-40cb-90e8-46d06c91faa7', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A5630119614E AS DateTime), N'0362149c-af22-491f-baef-37bffcc1fd5c', N'毛明明', CAST(0x0000A5630119614E AS DateTime), NULL, NULL, NULL, NULL, NULL, -1, NULL, 7, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'32c8ab3d-c5ca-4f13-be42-39fc19589ce5', N'62b0cfae-2cb9-4d36-94c5-7995f707415e', N'00000000-0000-0000-0000-000000000000', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'填写请假单', N'52103a3b-115c-4417-8e92-fe7a52212db5', N'5bdba827-5c79-47c5-b134-da9de5a8571e', 4, N'徐洪的请假申请', N'8086d01f-7ae3-402e-b543-d34f1059f79a', N'李晨新', CAST(0x0000A5630103F673 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A5630103F673 AS DateTime), CAST(0x0000A56301040518 AS DateTime), CAST(0x0000A563012D2953 AS DateTime), NULL, N'', 0, 1, N'退回任务', 3, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'19754242-4b57-4f0d-9359-3a032e79eaac', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'请示', N'71', N'a90700be-04ac-4374-ad91-5852e5708661', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56201136A2A AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56201136A2A AS DateTime), NULL, NULL, CAST(0x0000A56201136A2A AS DateTime), NULL, 0, 2, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'edf88daa-a59b-4ef2-b07d-3f08842c81d3', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'6f24065c-18e5-443b-8935-3a531678a842', N'19dfdd62-4e3a-4d00-bc74-fe2764bd32e6', N'发起', N'55', N'01812dff-564b-40be-80a7-d98c4b9bb130', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E0112503D AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E0112503D AS DateTime), NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'6ddad795-5a20-4fdc-aeaf-3f43879bc11d', N'8d238e07-7ac6-400c-bd90-dc0a1740560c', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'a3890463-3268-49a9-be46-c56d527c257f', N'审核', N'74', N'17019038-46e0-40cb-90e8-46d06c91faa7', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A563010E0AC6 AS DateTime), N'c2d3012a-c816-4149-ac04-9da0b60e3867', N'王中平', CAST(0x0000A563010E0AC6 AS DateTime), NULL, NULL, CAST(0x0000A563010E8CCD AS DateTime), NULL, 0, 5, NULL, 2, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'fd3fbc88-c472-4c12-a530-44f0b9d1382b', N'1162acc1-d133-4d46-a566-b2c36c8954ed', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'a3890463-3268-49a9-be46-c56d527c257f', N'审核', N'74', N'17019038-46e0-40cb-90e8-46d06c91faa7', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A563010EAA04 AS DateTime), N'c2d3012a-c816-4149-ac04-9da0b60e3867', N'王中平', CAST(0x0000A563010EAA04 AS DateTime), CAST(0x0000A563010F0B50 AS DateTime), NULL, CAST(0x0000A563010F0F5C AS DateTime), NULL, 0, 3, NULL, 4, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'7fe04dd4-e9ad-4e37-9b40-47b0de59ebb7', N'7edc5afc-5480-4c63-aecd-8584162b418f', N'a292842c-3041-4492-b098-82092a3dd651', N'86875775-2f25-443d-ac42-57124f3479a5', N'18337d9c-be91-4963-8d0a-ae188829a3b6', N'审核', N'4071', N'e0d4fefe-6bed-4cf2-80b7-b6cb1ba10b54', 0, N'gggggg', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50D010D7443 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50D010D7443 AS DateTime), CAST(0x0000A50D010D75EC AS DateTime), NULL, CAST(0x0000A50D010DA33A AS DateTime), N'同意', 1, 3, NULL, 2, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'1dd6796d-154d-4eb3-800a-4e26923aa6d7', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'填写请假单', N'52103a3b-115c-4417-8e92-fe7a52212db5', N'5bdba827-5c79-47c5-b134-da9de5a8571e', 0, N'徐洪的请假申请', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A5630103B1FB AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A5630103B1FB AS DateTime), NULL, NULL, CAST(0x0000A5630103B206 AS DateTime), NULL, 0, 2, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'9da6c95c-bd18-4d89-9ec4-4ee2508cc81b', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'填写请假单', N'', N'07177fd7-b274-4d1e-a915-ea5d048265b9', 0, N'请假申请', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56201130278 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56201130278 AS DateTime), CAST(0x0000A5620113252F AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'45b43fbc-a903-4fd6-8f7c-4eff441b2bcc', N'b759410e-99d9-4da3-954e-7f148bbf58a2', N'a3890463-3268-49a9-be46-c56d527c257f', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'e65d4b59-c1f7-4262-bf84-bb5268609182', N'请假子流程', N'73', N'e8a126d3-eae1-4f24-aa0d-f86d58e0b64c', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56300AA7240 AS DateTime), N'0362149c-af22-491f-baef-37bffcc1fd5c', N'毛明明', CAST(0x0000A56300AA7240 AS DateTime), NULL, NULL, NULL, NULL, NULL, 0, NULL, 3, N'5e00a885-b38d-45a6-9711-75a0bfe98ea2')
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'15d0c793-a416-4dbe-bf70-5321481d2e06', N'b9003e84-7cd6-4a71-ac3d-7e646587648c', N'd6f56e83-0e7b-4928-92c4-207e65b3d271', N'04018979-6810-456a-9e15-396c4849e31a', N'bd1eb25a-835f-4a4a-91b6-47a20b69620d', N'新步骤', N'82', N'8ab1aeec-9c10-4a04-8840-851c89284f7e', 0, N'的', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A568015675BF AS DateTime), N'0362149c-af22-491f-baef-37bffcc1fd5c', N'毛明明', CAST(0x0000A568015675BF AS DateTime), CAST(0x0000A56801568BFE AS DateTime), NULL, CAST(0x0000A56801571766 AS DateTime), NULL, 0, 2, NULL, 4, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'1b8cf802-e3d6-4f43-97e6-538d1dcf38d6', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'6f24065c-18e5-443b-8935-3a531678a842', N'19dfdd62-4e3a-4d00-bc74-fe2764bd32e6', N'发起', N'62', N'7d1a4c4e-7df6-4d1e-9183-750208ca6d2a', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E01142152 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E01142152 AS DateTime), CAST(0x0000A50E011422D4 AS DateTime), NULL, CAST(0x0000A50E011617BD AS DateTime), NULL, 0, 2, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'22d7b703-e102-40e5-adbd-53f792d8d4c7', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'填写请假单', N'', N'a71050b3-a84f-48a1-832d-472afa94b0e6', 0, N'请假申请', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56300AA7246 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56300AA7246 AS DateTime), NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'32bbe67e-87b3-4f8e-93c2-5710ff2e0f08', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'04018979-6810-456a-9e15-396c4849e31a', N'd6f56e83-0e7b-4928-92c4-207e65b3d271', N'新步骤', N'82', N'8ab1aeec-9c10-4a04-8840-851c89284f7e', 0, N'的', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56801566238 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56801566238 AS DateTime), NULL, NULL, CAST(0x0000A56801566248 AS DateTime), NULL, 0, 2, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'd1a03e4d-92c5-40d1-b658-586eaef3c40e', N'7edc5afc-5480-4c63-aecd-8584162b418f', N'a292842c-3041-4492-b098-82092a3dd651', N'86875775-2f25-443d-ac42-57124f3479a5', N'18337d9c-be91-4963-8d0a-ae188829a3b6', N'审核', N'4071', N'e0d4fefe-6bed-4cf2-80b7-b6cb1ba10b54', 5, N'gggggg', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50D010D744E AS DateTime), N'0362149c-af22-491f-baef-37bffcc1fd5c', N'毛明明', CAST(0x0000A50D010D744E AS DateTime), CAST(0x0000A50D010F45A6 AS DateTime), NULL, CAST(0x0000A50D01136E80 AS DateTime), NULL, 0, 2, NULL, 2, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'cf5eeeb2-ee1b-42f4-b729-5980a62dd40a', N'8d238e07-7ac6-400c-bd90-dc0a1740560c', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'a3890463-3268-49a9-be46-c56d527c257f', N'审核', N'74', N'17019038-46e0-40cb-90e8-46d06c91faa7', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A563010E0AC9 AS DateTime), N'fded2b24-e7a0-41e4-90ed-aab7148ae113', N'王磊', CAST(0x0000A563010E0AC9 AS DateTime), NULL, NULL, CAST(0x0000A563010E8CCD AS DateTime), NULL, 0, 5, NULL, 2, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'd8ff03f5-389e-4b72-881e-5ae04a694b44', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'04018979-6810-456a-9e15-396c4849e31a', N'd6f56e83-0e7b-4928-92c4-207e65b3d271', N'新步骤', N'85', N'75748c28-d2b4-456d-a5c0-78406dd6934c', 0, N'111', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56E0158A988 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56E0158A988 AS DateTime), CAST(0x0000A56E0158AAB1 AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'778fd512-0a71-44a5-b450-5c7017351581', N'b759410e-99d9-4da3-954e-7f148bbf58a2', N'a3890463-3268-49a9-be46-c56d527c257f', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'e65d4b59-c1f7-4262-bf84-bb5268609182', N'请假子流程', N'73', N'e8a126d3-eae1-4f24-aa0d-f86d58e0b64c', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56300AA7246 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56300AA7246 AS DateTime), CAST(0x0000A56300AA74AF AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, 3, N'a71050b3-a84f-48a1-832d-472afa94b0e6')
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'd8d8027b-fc20-432f-b22d-6c8cc9f648be', N'fb5ab5d7-0354-4b89-a027-346307aa9cf8', N'00000000-0000-0000-0000-000000000000', N'86875775-2f25-443d-ac42-57124f3479a5', N'a292842c-3041-4492-b098-82092a3dd651', N'编辑', N'4071', N'e0d4fefe-6bed-4cf2-80b7-b6cb1ba10b54', 4, N'gggggg', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50D0115E131 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50D0115E131 AS DateTime), CAST(0x0000A50D0115E28D AS DateTime), NULL, CAST(0x0000A50D0115F0CF AS DateTime), NULL, 0, 2, N'退回任务', 5, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'f76a9bee-38c0-400d-99d5-708cad866f09', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'请示', N'73', N'e8a126d3-eae1-4f24-aa0d-f86d58e0b64c', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56300AA67E0 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56300AA67E0 AS DateTime), NULL, NULL, CAST(0x0000A56300AA67E0 AS DateTime), NULL, 0, 2, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'a3e0f3c8-7551-4bcc-9749-70f6ae772207', N'1788fa07-0f1c-4e9e-8427-d378edb2e60e', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'a3890463-3268-49a9-be46-c56d527c257f', N'审核', N'74', N'17019038-46e0-40cb-90e8-46d06c91faa7', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A5630118B141 AS DateTime), N'c2d3012a-c816-4149-ac04-9da0b60e3867', N'王中平', CAST(0x0000A5630118B141 AS DateTime), CAST(0x0000A56301194A28 AS DateTime), NULL, CAST(0x0000A563011968A9 AS DateTime), NULL, 0, 3, NULL, 6, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'30a27768-74b5-4906-88b8-714e7b214f14', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'6f24065c-18e5-443b-8935-3a531678a842', N'19dfdd62-4e3a-4d00-bc74-fe2764bd32e6', N'发起', N'49', N'384ca939-2f95-4698-b621-580f92fb33bd', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E0106D8B4 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E0106D8B4 AS DateTime), NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'baca3cca-5910-4a7b-ae74-72d08fc26b2b', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'538beb68-4e56-439e-b50f-be6b3b9f4957', N'1844d7a6-5f8f-445e-b4b8-ec2ea2c0e2f7', N'填写表单', N'76', N'5d538d0e-8785-44bc-931f-58708f61b105', 0, N'12342314)', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A567016223A9 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A567016223A9 AS DateTime), CAST(0x0000A5670162255C AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'182652b4-b301-418b-945e-72d5b4317d8f', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'填写请假单', N'8542C297-39FE-4622-B537-FDC54F58C0E9', N'5de91fdc-9717-4a9e-86f7-97c9cf36902a', 0, N'xxxxxxxxxxxxxxxxxxxxxx', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A563011BA700 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A563011BA700 AS DateTime), CAST(0x0000A56801533540 AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'8d46c291-3351-47b7-833c-761ae010f0bd', N'a5dcc124-40b6-48f7-a204-b2a17a7b2831', N'a3890463-3268-49a9-be46-c56d527c257f', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'e65d4b59-c1f7-4262-bf84-bb5268609182', N'请假子流程', N'71', N'a90700be-04ac-4374-ad91-5852e5708661', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56201139456 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56201139456 AS DateTime), CAST(0x0000A562011395C7 AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, 3, N'7161f0a5-9ae5-4761-80b6-85e205887093')
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'62b0cfae-2cb9-4d36-94c5-7995f707415e', N'1dd6796d-154d-4eb3-800a-4e26923aa6d7', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'ce0c165a-778b-4817-a9c5-21f862f1c96e', N'领导审批', N'52103a3b-115c-4417-8e92-fe7a52212db5', N'5bdba827-5c79-47c5-b134-da9de5a8571e', 0, N'徐洪的请假申请', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A5630103B209 AS DateTime), N'8086d01f-7ae3-402e-b543-d34f1059f79a', N'李晨新', CAST(0x0000A5630103B209 AS DateTime), CAST(0x0000A5630103C7E5 AS DateTime), CAST(0x0000A563012CE4E8 AS DateTime), CAST(0x0000A5630103F671 AS DateTime), N'同意', 1, 3, NULL, 2, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'b9003e84-7cd6-4a71-ac3d-7e646587648c', N'edae9d86-14bf-4298-ae70-8ab4b1aa61c9', N'00000000-0000-0000-0000-000000000000', N'04018979-6810-456a-9e15-396c4849e31a', N'd6f56e83-0e7b-4928-92c4-207e65b3d271', N'新步骤', N'82', N'8ab1aeec-9c10-4a04-8840-851c89284f7e', 4, N'的', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56801566ABD AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56801566ABD AS DateTime), CAST(0x0000A56801566BF6 AS DateTime), NULL, CAST(0x0000A568015675BE AS DateTime), NULL, 0, 2, N'退回任务', 3, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'b759410e-99d9-4da3-954e-7f148bbf58a2', N'f76a9bee-38c0-400d-99d5-708cad866f09', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'a3890463-3268-49a9-be46-c56d527c257f', N'审核', N'73', N'e8a126d3-eae1-4f24-aa0d-f86d58e0b64c', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56300AA67E0 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56300AA67E0 AS DateTime), CAST(0x0000A56300AA6936 AS DateTime), NULL, CAST(0x0000A56300AA723F AS DateTime), NULL, 0, 2, NULL, 2, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'7edc5afc-5480-4c63-aecd-8584162b418f', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'86875775-2f25-443d-ac42-57124f3479a5', N'a292842c-3041-4492-b098-82092a3dd651', N'编辑', N'4071', N'e0d4fefe-6bed-4cf2-80b7-b6cb1ba10b54', 0, N'gggggg', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50D010D7437 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50D010D7437 AS DateTime), NULL, NULL, CAST(0x0000A50D010D7443 AS DateTime), NULL, 0, 2, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'edae9d86-14bf-4298-ae70-8ab4b1aa61c9', N'32bbe67e-87b3-4f8e-93c2-5710ff2e0f08', N'd6f56e83-0e7b-4928-92c4-207e65b3d271', N'04018979-6810-456a-9e15-396c4849e31a', N'bd1eb25a-835f-4a4a-91b6-47a20b69620d', N'新步骤', N'82', N'8ab1aeec-9c10-4a04-8840-851c89284f7e', 0, N'的', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56801566249 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56801566249 AS DateTime), CAST(0x0000A56801566387 AS DateTime), NULL, CAST(0x0000A56801566ABA AS DateTime), NULL, 0, 3, NULL, 2, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'71986483-4663-42af-aed5-8ce003845bdb', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'6f24065c-18e5-443b-8935-3a531678a842', N'19dfdd62-4e3a-4d00-bc74-fe2764bd32e6', N'发起', N'51', N'62c1bc4c-bc57-44b5-a2a2-48c80e697c5a', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E0106E40A AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E0106E40A AS DateTime), NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'1a64b7dc-bfad-4646-98a3-8d093e472122', N'd7e50790-a977-445c-b181-d019c1dcc886', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'ce0c165a-778b-4817-a9c5-21f862f1c96e', N'领导审批', N'e725a8b5-2a0d-4683-ad55-844b67ed0d6a', N'2dfd3d21-896a-49b3-85aa-e02372e527d3', 0, N'徐洪的请假申请', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A516010B5F5F AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A516010B5F5F AS DateTime), CAST(0x0000A516010B60FD AS DateTime), CAST(0x0000A5160134923F AS DateTime), NULL, NULL, NULL, 1, NULL, 2, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'57c040ea-cc87-41d3-9078-8e33b310b4f7', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'04018979-6810-456a-9e15-396c4849e31a', N'd6f56e83-0e7b-4928-92c4-207e65b3d271', N'新步骤', N'86', N'72abce24-96ba-4edf-961b-28e90d73fd08', 0, N'111', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56E015A626B AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56E015A626B AS DateTime), CAST(0x0000A56E015A637B AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'13085ade-94db-4fdb-ab0b-91d5f0390508', N'0580fd1f-ddf2-4be4-ad41-d43969dddc63', N'bd1eb25a-835f-4a4a-91b6-47a20b69620d', N'04018979-6810-456a-9e15-396c4849e31a', N'c53824ca-dacb-49bc-9dae-bebb596f6f55', N'新步骤2', N'83', N'49654e6e-cbd2-49d8-a1b7-de69716d777e', 0, N'12341234', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56E010B52FF AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56E010B52FF AS DateTime), CAST(0x0000A56E010B5456 AS DateTime), NULL, CAST(0x0000A56E010B5751 AS DateTime), NULL, 0, 3, NULL, 3, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'f3e10c81-c03e-4480-8ccd-91f6aa95c681', N'97514b7f-9d0c-4a5b-8dc2-a85972374c2a', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'a3890463-3268-49a9-be46-c56d527c257f', N'审核', N'72', N'921ace9c-eb5a-47b8-9630-0532309df31c', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56300AA479F AS DateTime), N'1acf9c22-bfb6-4673-a698-a58233747b92', N'周丽', CAST(0x0000A56300AA479F AS DateTime), NULL, NULL, NULL, NULL, NULL, 0, NULL, 2, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'e24b98ab-d5bf-4b0a-84fe-922d71d11884', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'请示', N'69', N'cbf8f35b-4ae6-4f19-9230-40031d10a956', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A5620112CA64 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A5620112CA64 AS DateTime), NULL, NULL, CAST(0x0000A5620112CA72 AS DateTime), NULL, 0, 2, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'58694362-f508-41f7-8e64-9237eb824d54', N'7fe04dd4-e9ad-4e37-9b40-47b0de59ebb7', N'00000000-0000-0000-0000-000000000000', N'86875775-2f25-443d-ac42-57124f3479a5', N'a292842c-3041-4492-b098-82092a3dd651', N'编辑', N'4071', N'e0d4fefe-6bed-4cf2-80b7-b6cb1ba10b54', 4, N'gggggg', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50D010DA33D AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50D010DA33D AS DateTime), CAST(0x0000A50D010DA481 AS DateTime), NULL, CAST(0x0000A50D010DC9EF AS DateTime), NULL, 0, 2, N'退回任务', 3, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'78c7949e-d970-4439-9706-926f559cd927', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'填写请假单', N'', N'7161f0a5-9ae5-4761-80b6-85e205887093', 0, N'请假申请', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56201139456 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56201139456 AS DateTime), NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'53c932f2-9b37-43d8-b067-9556cc213f65', N'13085ade-94db-4fdb-ab0b-91d5f0390508', N'd6f56e83-0e7b-4928-92c4-207e65b3d271', N'04018979-6810-456a-9e15-396c4849e31a', N'bd1eb25a-835f-4a4a-91b6-47a20b69620d', N'新步骤1', N'83', N'49654e6e-cbd2-49d8-a1b7-de69716d777e', 4, N'12341234', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56E010B5756 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56E010B5756 AS DateTime), CAST(0x0000A56E010B582D AS DateTime), NULL, NULL, N'', 0, 1, N'退回任务', 4, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'2f549ca1-43c6-4682-9f51-97179e9f274c', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'6f24065c-18e5-443b-8935-3a531678a842', N'19dfdd62-4e3a-4d00-bc74-fe2764bd32e6', N'发起', N'63', N'4aae4852-be92-465c-aee9-ad5a63d4a894', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E011C6A96 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E011C6A96 AS DateTime), NULL, NULL, CAST(0x0000A50E011C6AA1 AS DateTime), NULL, 0, 2, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'3c79e872-7e8d-4611-a4f5-9add62dd1d1b', N'f25e596c-70dc-4ef7-9e31-abbe54f89777', N'a292842c-3041-4492-b098-82092a3dd651', N'86875775-2f25-443d-ac42-57124f3479a5', N'18337d9c-be91-4963-8d0a-ae188829a3b6', N'审核', N'4072', N'a5c07f74-78e7-4138-8a31-1c05293710db', 0, N'999', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E011CD480 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E011CD480 AS DateTime), CAST(0x0000A50E011CD5DD AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, 2, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'c86ec2a4-ee55-4947-a506-9b1eee8b8ac6', N'ca81caff-cd04-46c5-8797-df13a06f7ab1', N'1844d7a6-5f8f-445e-b4b8-ec2ea2c0e2f7', N'538beb68-4e56-439e-b50f-be6b3b9f4957', N'51ebcb52-b939-432f-b6f3-4f9543cb3255', N'审核', N'64', N'abcd227d-0e74-4abd-9bb3-0463041833ce', 0, N'u)', N'0362149c-af22-491f-baef-37bffcc1fd5c', N'毛明明', CAST(0x0000A56801573804 AS DateTime), N'0362149c-af22-491f-baef-37bffcc1fd5c', N'毛明明', CAST(0x0000A56801573804 AS DateTime), CAST(0x0000A56801573962 AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, 2, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'da80b4a3-83eb-43c6-ab6a-a17471746d6a', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'填写请假单', N'b9718db3-f1c7-410a-b532-793b5b8a1794', N'583f4eae-cacb-44bf-b680-fef181b766ac', 0, N'徐洪的请假申请', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A51600BD98DA AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A51600BD98DA AS DateTime), NULL, NULL, CAST(0x0000A51600BD98EC AS DateTime), NULL, 0, 2, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'abd5977d-390d-44d1-99f6-a1d8fe9dac95', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'538beb68-4e56-439e-b50f-be6b3b9f4957', N'1844d7a6-5f8f-445e-b4b8-ec2ea2c0e2f7', N'填写表单', N'75', N'3f38b7fd-77a9-47a2-b62e-21dd465db503', 0, N'1234321)', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56701618462 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56701618462 AS DateTime), CAST(0x0000A567016185B0 AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'3f795576-7011-48a6-81ca-a6177d0a1939', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'6f24065c-18e5-443b-8935-3a531678a842', N'19dfdd62-4e3a-4d00-bc74-fe2764bd32e6', N'发起', N'53', N'df97e793-91a0-4a12-a7ca-0863626f1c30', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E01124225 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E01124225 AS DateTime), NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'97514b7f-9d0c-4a5b-8dc2-a85972374c2a', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'请示', N'72', N'921ace9c-eb5a-47b8-9630-0532309df31c', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56300AA4799 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56300AA4799 AS DateTime), NULL, NULL, CAST(0x0000A56300AA479B AS DateTime), NULL, 0, 2, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'f25e596c-70dc-4ef7-9e31-abbe54f89777', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'86875775-2f25-443d-ac42-57124f3479a5', N'a292842c-3041-4492-b098-82092a3dd651', N'编辑', N'4072', N'a5c07f74-78e7-4138-8a31-1c05293710db', 0, N'999', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E011CD480 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E011CD480 AS DateTime), NULL, NULL, CAST(0x0000A50E011CD480 AS DateTime), NULL, 0, 2, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'a5dcc124-40b6-48f7-a204-b2a17a7b2831', N'19754242-4b57-4f0d-9359-3a032e79eaac', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'a3890463-3268-49a9-be46-c56d527c257f', N'审核', N'71', N'a90700be-04ac-4374-ad91-5852e5708661', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56201136A2A AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56201136A2A AS DateTime), CAST(0x0000A56201136B6F AS DateTime), NULL, CAST(0x0000A56201139456 AS DateTime), NULL, 0, 2, NULL, 2, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'1162acc1-d133-4d46-a566-b2c36c8954ed', N'095b2fe3-4050-4171-9115-11065005d469', N'00000000-0000-0000-0000-000000000000', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'请示', N'74', N'17019038-46e0-40cb-90e8-46d06c91faa7', 4, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A563010E8CCF AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A563010E8CCF AS DateTime), CAST(0x0000A563010E8DE7 AS DateTime), NULL, CAST(0x0000A563010EAA04 AS DateTime), NULL, 0, 2, N'退回任务', 3, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'56a82293-8cf5-45e5-9c7f-bbc39f3058ce', N'1162acc1-d133-4d46-a566-b2c36c8954ed', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'a3890463-3268-49a9-be46-c56d527c257f', N'审核', N'74', N'17019038-46e0-40cb-90e8-46d06c91faa7', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A563010EAA06 AS DateTime), N'1acf9c22-bfb6-4673-a698-a58233747b92', N'周丽', CAST(0x0000A563010EAA06 AS DateTime), CAST(0x0000A563010F24F6 AS DateTime), NULL, CAST(0x0000A563010F28B7 AS DateTime), NULL, 0, 3, NULL, 4, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'8f8f53b5-622a-43ba-9304-bbcaa51b1928', N'97514b7f-9d0c-4a5b-8dc2-a85972374c2a', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'a3890463-3268-49a9-be46-c56d527c257f', N'审核', N'72', N'921ace9c-eb5a-47b8-9630-0532309df31c', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56300AA479D AS DateTime), N'c2d3012a-c816-4149-ac04-9da0b60e3867', N'王中平', CAST(0x0000A56300AA479D AS DateTime), NULL, NULL, NULL, NULL, NULL, 0, NULL, 2, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'3b1cacfb-2e61-4962-abf2-bf5348bb94db', N'ab3c8ae2-ba77-430e-a530-27abc6d52f9e', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'ce0c165a-778b-4817-a9c5-21f862f1c96e', N'领导审批', N'b9718db3-f1c7-410a-b532-793b5b8a1794', N'583f4eae-cacb-44bf-b680-fef181b766ac', 0, N'徐洪的请假申请', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A51600FC1DE0 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A51600FC1DE0 AS DateTime), CAST(0x0000A51600FC1F1B AS DateTime), CAST(0x0000A516012550C0 AS DateTime), NULL, NULL, NULL, 1, NULL, 4, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'97c04ac5-d8f2-4fe6-b42d-c50e9b222d2f', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'04018979-6810-456a-9e15-396c4849e31a', N'd6f56e83-0e7b-4928-92c4-207e65b3d271', N'新步骤', N'81', N'a9d8e56e-e8eb-4b92-a2cb-3d0838af1396', 0, N'未命名任务', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A568014BDA4E AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A568014BDA4E AS DateTime), CAST(0x0000A568014BDB9C AS DateTime), NULL, CAST(0x0000A568014BDE8A AS DateTime), NULL, 0, 2, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'b6f282e1-0d45-4d13-910d-c64d5b853cc7', N'1788fa07-0f1c-4e9e-8427-d378edb2e60e', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'a3890463-3268-49a9-be46-c56d527c257f', N'审核', N'74', N'17019038-46e0-40cb-90e8-46d06c91faa7', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A5630118B14C AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A5630118B14C AS DateTime), CAST(0x0000A5630118B25C AS DateTime), NULL, CAST(0x0000A5630119614A AS DateTime), NULL, 0, 2, NULL, 6, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'efbf453a-8a5f-4b16-b41c-c6e6e054ca03', N'd8d8027b-fc20-432f-b22d-6c8cc9f648be', N'a292842c-3041-4492-b098-82092a3dd651', N'86875775-2f25-443d-ac42-57124f3479a5', N'18337d9c-be91-4963-8d0a-ae188829a3b6', N'审核', N'4071', N'e0d4fefe-6bed-4cf2-80b7-b6cb1ba10b54', 5, N'gggggg', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50D0115F0D8 AS DateTime), N'0362149c-af22-491f-baef-37bffcc1fd5c', N'毛明明', CAST(0x0000A50D0115F0D8 AS DateTime), CAST(0x0000A50D0115FF6A AS DateTime), NULL, CAST(0x0000A50D01160131 AS DateTime), NULL, 0, 2, N'抄送任务', 6, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'a527de09-b16b-4e3c-9d39-ca9961892e07', N'4d4aac6d-f069-4097-b27a-2e6df08b84fc', N'00000000-0000-0000-0000-000000000000', N'86875775-2f25-443d-ac42-57124f3479a5', N'a292842c-3041-4492-b098-82092a3dd651', N'编辑', N'4071', N'e0d4fefe-6bed-4cf2-80b7-b6cb1ba10b54', 4, N'gggggg', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50D0151EA2C AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50D0151EA2C AS DateTime), CAST(0x0000A50D0151EB5D AS DateTime), NULL, NULL, N'', 0, 1, N'退回任务', 7, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'982e8046-5acf-4561-ae29-cf221f5031f4', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'04018979-6810-456a-9e15-396c4849e31a', N'd6f56e83-0e7b-4928-92c4-207e65b3d271', N'新步骤', N'79', N'a87c9889-4754-4ea8-a121-0ad1aff92e5f', 0, N'王', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A568014BCE0F AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A568014BCE0F AS DateTime), NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'd7e50790-a977-445c-b181-d019c1dcc886', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'填写请假单', N'e725a8b5-2a0d-4683-ad55-844b67ed0d6a', N'2dfd3d21-896a-49b3-85aa-e02372e527d3', 0, N'徐洪的请假申请', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A516010B5F54 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A516010B5F54 AS DateTime), NULL, NULL, CAST(0x0000A516010B5F5D AS DateTime), NULL, 0, 2, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'9ab791b6-51fe-47d6-8449-d040ee1213d6', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'6f24065c-18e5-443b-8935-3a531678a842', N'19dfdd62-4e3a-4d00-bc74-fe2764bd32e6', N'发起', N'54', N'0d27e30c-f1d2-4fe6-b693-706cc75a747b', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E0112447B AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E0112447B AS DateTime), CAST(0x0000A50E011C5C55 AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'98d9a46d-5f90-4528-8d27-d2bf8ee45f08', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'填写请假单', N'', N'5e00a885-b38d-45a6-9711-75a0bfe98ea2', 0, N'请假申请', N'0362149c-af22-491f-baef-37bffcc1fd5c', N'毛明明', CAST(0x0000A56300AA7245 AS DateTime), N'0362149c-af22-491f-baef-37bffcc1fd5c', N'毛明明', CAST(0x0000A56300AA7245 AS DateTime), CAST(0x0000A56801571BB3 AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'1788fa07-0f1c-4e9e-8427-d378edb2e60e', N'56a82293-8cf5-45e5-9c7f-bbc39f3058ce', N'00000000-0000-0000-0000-000000000000', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'请示', N'74', N'17019038-46e0-40cb-90e8-46d06c91faa7', 4, N'徐洪的报告请示', N'1acf9c22-bfb6-4673-a698-a58233747b92', N'周丽', CAST(0x0000A563010F28BC AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A563010F28BC AS DateTime), CAST(0x0000A563010F3A64 AS DateTime), NULL, CAST(0x0000A5630118B13E AS DateTime), NULL, 0, 2, N'退回任务', 5, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'0580fd1f-ddf2-4be4-ad41-d43969dddc63', N'252fcac6-c42b-47fe-bc81-27814d4daf5d', N'd6f56e83-0e7b-4928-92c4-207e65b3d271', N'04018979-6810-456a-9e15-396c4849e31a', N'bd1eb25a-835f-4a4a-91b6-47a20b69620d', N'新步骤1', N'83', N'49654e6e-cbd2-49d8-a1b7-de69716d777e', 0, N'12341234', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56E010B47A2 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56E010B47A2 AS DateTime), CAST(0x0000A56E010B487E AS DateTime), NULL, CAST(0x0000A56E010B52FF AS DateTime), NULL, 0, 2, NULL, 2, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'd573c73a-3903-4881-b676-d452796dd397', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'04018979-6810-456a-9e15-396c4849e31a', N'd6f56e83-0e7b-4928-92c4-207e65b3d271', N'新步骤', N'80', N'980e57e4-cc17-4c62-86b4-c2c7862d0f0e', 0, N'王', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A568014BD21B AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A568014BD21B AS DateTime), CAST(0x0000A568014E8803 AS DateTime), NULL, CAST(0x0000A56801532CEF AS DateTime), NULL, 0, 2, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'9894cb43-1c9f-4803-b694-db2aef82a2ca', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'04018979-6810-456a-9e15-396c4849e31a', N'd6f56e83-0e7b-4928-92c4-207e65b3d271', N'新步骤', N'77', N'96862b8d-2758-41ae-b12a-c37a6e2c812b', 0, N'2352435435', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A567016F6C0D AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A567016F6C0D AS DateTime), CAST(0x0000A567016F6D7C AS DateTime), NULL, CAST(0x0000A56801533161 AS DateTime), NULL, 0, 2, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'8d238e07-7ac6-400c-bd90-dc0a1740560c', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'请示', N'74', N'17019038-46e0-40cb-90e8-46d06c91faa7', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A563010E0ABA AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A563010E0ABA AS DateTime), NULL, NULL, CAST(0x0000A563010E0AC4 AS DateTime), NULL, 0, 2, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'912c3ccd-9e58-4760-a5c2-dc4965eb9d2a', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'6f24065c-18e5-443b-8935-3a531678a842', N'19dfdd62-4e3a-4d00-bc74-fe2764bd32e6', N'发起', N'52', N'44660a6d-4133-48e4-8897-fac360f349e4', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E01123F68 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E01123F68 AS DateTime), NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'ca81caff-cd04-46c5-8797-df13a06f7ab1', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'538beb68-4e56-439e-b50f-be6b3b9f4957', N'1844d7a6-5f8f-445e-b4b8-ec2ea2c0e2f7', N'填写表单', N'64', N'abcd227d-0e74-4abd-9bb3-0463041833ce', 0, N'u)', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A51201476D53 AS DateTime), N'0362149c-af22-491f-baef-37bffcc1fd5c', N'毛明明', CAST(0x0000A51201476D53 AS DateTime), CAST(0x0000A56801572F47 AS DateTime), NULL, CAST(0x0000A568015737FD AS DateTime), NULL, 0, 2, N'该任务由徐洪指派', 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'1e6c0e50-4d81-42b2-809d-ef3394f6389e', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'a6509c1b-f49f-47a6-829d-ec43b9210eb2', N'6421e3b1-a2bc-4418-b6d8-d38b4456bc9e', N'填写请假单', N'', N'c564db6a-3abe-423c-b733-48186abf34b9', 0, N'请假申请', N'0362149c-af22-491f-baef-37bffcc1fd5c', N'毛明明', CAST(0x0000A5620112CA79 AS DateTime), N'0362149c-af22-491f-baef-37bffcc1fd5c', N'毛明明', CAST(0x0000A5620112CA79 AS DateTime), NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'e3348f1c-0855-4cd7-a37a-efcfa802d136', N'75d35356-2181-46f4-bf06-f63581ccc7be', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'e65d4b59-c1f7-4262-bf84-bb5268609182', N'请假子流程', N'70', N'd9f17511-30b8-4116-9ddb-972e9ed7d616', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56201130278 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56201130278 AS DateTime), CAST(0x0000A56201131A16 AS DateTime), NULL, NULL, NULL, NULL, 1, NULL, 2, N'07177fd7-b274-4d1e-a915-ea5d048265b9')
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'017f5f88-439b-4fbb-a9ee-f0d75d8704d7', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'6f24065c-18e5-443b-8935-3a531678a842', N'19dfdd62-4e3a-4d00-bc74-fe2764bd32e6', N'发起', N'48', N'f3d6a4e5-2358-49e3-8432-ba5975a75209', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E0106D3B8 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A50E0106D3B8 AS DateTime), NULL, NULL, NULL, NULL, NULL, 0, NULL, 1, NULL)
INSERT [WorkFlowTask] ([ID], [PrevID], [PrevStepID], [FlowID], [StepID], [StepName], [InstanceID], [GroupID], [Type], [Title], [SenderID], [SenderName], [SenderTime], [ReceiveID], [ReceiveName], [ReceiveTime], [OpenTime], [CompletedTime], [CompletedTime1], [Comment], [IsSign], [Status], [Note], [Sort], [SubFlowGroupID]) VALUES (N'75d35356-2181-46f4-bf06-f63581ccc7be', N'00000000-0000-0000-0000-000000000000', N'00000000-0000-0000-0000-000000000000', N'8434dd1c-3e75-4877-b379-72df38d79bf7', N'0b296b11-c5ae-41e6-8e78-d3730a4982a4', N'请示', N'70', N'd9f17511-30b8-4116-9ddb-972e9ed7d616', 0, N'徐洪的报告请示', N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56201130277 AS DateTime), N'eb03262c-ab60-4bc6-a4c0-96e66a4229fe', N'徐洪', CAST(0x0000A56201130277 AS DateTime), NULL, NULL, CAST(0x0000A56201130278 AS DateTime), NULL, 0, 2, NULL, 1, NULL)
INSERT [WorkGroup] ([ID], [Name], [Members], [Note]) VALUES (N'53ba1155-8739-4353-af76-8b65d77cfcfa', N'测试', N'96f75a51-779b-491a-9773-cb5f90cef11e,82682cf5-50e1-4901-911b-1a935b5ddb6c', N'qwer')






IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Log_WriteTime]') AND type = 'D')
BEGIN
ALTER TABLE [Log] ADD  CONSTRAINT [DF_Log_WriteTime]  DEFAULT (getdate()) FOR [WriteTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TempTest_DeptID]') AND type = 'D')
BEGIN
ALTER TABLE [TempTest] ADD  CONSTRAINT [DF_TempTest_DeptID]  DEFAULT (newid()) FOR [DeptID]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TempTest_WriteTime]') AND type = 'D')
BEGIN
ALTER TABLE [TempTest] ADD  CONSTRAINT [DF_TempTest_WriteTime]  DEFAULT (getdate()) FOR [WriteTime]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TempTest_News_State]') AND type = 'D')
BEGIN
ALTER TABLE [TempTest_News] ADD  CONSTRAINT [DF_TempTest_News_State]  DEFAULT ((0)) FOR [State]
END

/*对应最上面 DF_TempTest_PurchaseList_ID
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TempTest_PurchaseList_ID]') AND type = 'D')
BEGIN
ALTER TABLE [TempTest_PurchaseList] DROP CONSTRAINT [DF_TempTest_PurchaseList_ID]
END
*/
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TempTest_PurchaseList_ID]') AND type = 'D')
BEGIN
ALTER TABLE [TempTest_PurchaseList] ADD  CONSTRAINT [DF_TempTest_PurchaseList_ID]  DEFAULT (newid()) FOR [ID]
END

GO