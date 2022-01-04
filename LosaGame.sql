USE [master]
GO
/****** Object:  Database [LosaGame]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE DATABASE [LosaGame]
 CONTAINMENT = NONE

GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LosaGame].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LosaGame] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LosaGame] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LosaGame] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LosaGame] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LosaGame] SET ARITHABORT OFF 
GO
ALTER DATABASE [LosaGame] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [LosaGame] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LosaGame] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LosaGame] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LosaGame] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LosaGame] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LosaGame] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LosaGame] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LosaGame] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LosaGame] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LosaGame] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LosaGame] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LosaGame] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LosaGame] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LosaGame] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LosaGame] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LosaGame] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LosaGame] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [LosaGame] SET  MULTI_USER 
GO
ALTER DATABASE [LosaGame] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LosaGame] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LosaGame] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LosaGame] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LosaGame] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LosaGame] SET QUERY_STORE = OFF
GO
USE [LosaGame]
GO

ALTER ROLE [db_owner] ADD MEMBER [lostzero]
GO
ALTER ROLE [db_owner] ADD MEMBER [losa]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [losa]
GO
ALTER ROLE [db_datareader] ADD MEMBER [losa]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [losa]
GO
/****** Object:  UserDefinedFunction [dbo].[DEFINE_REGION_LIMIT_RENSPOINT]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[DEFINE_REGION_LIMIT_RENSPOINT]
(
)
RETURNS int
AS

BEGIN

DECLARE @returnVal int
SET @returnVal = 10

RETURN @returnVal

END
GO
/****** Object:  UserDefinedFunction [dbo].[DEFINE_REGION_LIMIT_SE_RENSPOINT]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[DEFINE_REGION_LIMIT_SE_RENSPOINT]
(
)
RETURNS int
As
BEGIN

	DECLARE @returnVal int
	SET @returnVal = 10

	RETURN @returnVal

	END
GO
/****** Object:  UserDefinedFunction [dbo].[DEFINE_SERVER_CONNECTION_MAX_COUNT]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[DEFINE_SERVER_CONNECTION_MAX_COUNT]
(
)
RETURNS int
AS
	BEGIN

	DECLARE @maxcount int
	SET @maxcount = 2000

	RETURN @maxcount

	END
GO
/****** Object:  UserDefinedFunction [dbo].[SELECT_GEAR_CODE]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[SELECT_GEAR_CODE]
(
	@accountIDX INT
,	@slotIndex INT
)
RETURNS INT
AS

BEGIN

DECLARE @returnVal INT
DECLARE @userGearDB table (itemType int, slotIndex int)

INSERT INTO @userGearDB (itemType, slotIndex)
SELECT item1_type, item1_slotindex FROM dbo.userItemExtraDB WITH(NOLOCK) WHERE accountIDX = @accountIDX

INSERT INTO @userGearDB (itemType, slotIndex)
SELECT item2_type, item2_slotindex FROM dbo.userItemExtraDB WITH(NOLOCK) WHERE accountIDX = @accountIDX

INSERT INTO @userGearDB (itemType, slotIndex)
SELECT item3_type, item3_slotindex FROM dbo.userItemExtraDB WITH(NOLOCK) WHERE accountIDX = @accountIDX

INSERT INTO @userGearDB (itemType, slotIndex)
SELECT item4_type, item4_slotindex FROM dbo.userItemExtraDB WITH(NOLOCK) WHERE accountIDX = @accountIDX

INSERT INTO @userGearDB (itemType, slotIndex)
SELECT item5_type, item5_slotindex FROM dbo.userItemExtraDB WITH(NOLOCK) WHERE accountIDX = @accountIDX

INSERT INTO @userGearDB (itemType, slotIndex)
SELECT item6_type, item6_slotindex FROM dbo.userItemExtraDB WITH(NOLOCK) WHERE accountIDX = @accountIDX

INSERT INTO @userGearDB (itemType, slotIndex)
SELECT item7_type, item7_slotindex FROM dbo.userItemExtraDB WITH(NOLOCK) WHERE accountIDX = @accountIDX

INSERT INTO @userGearDB (itemType, slotIndex)
SELECT item8_type, item8_slotindex FROM dbo.userItemExtraDB WITH(NOLOCK) WHERE accountIDX = @accountIDX

INSERT INTO @userGearDB (itemType, slotIndex)
SELECT item9_type, item9_slotindex FROM dbo.userItemExtraDB WITH(NOLOCK) WHERE accountIDX = @accountIDX

INSERT INTO @userGearDB (itemType, slotIndex)
SELECT item10_type, item10_slotindex FROM dbo.userItemExtraDB WITH(NOLOCK) WHERE accountIDX = @accountIDX

SET @returnVal = (
	SELECT itemType
	  FROM @userGearDB
	 WHERE slotIndex=@slotIndex
)

RETURN @returnVal

END
GO
/****** Object:  UserDefinedFunction [dbo].[udf_Split]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[udf_Split] 
(
 @Words nvarchar(MAX)
, @splitStr varchar(50)
)
RETURNS @Result_Table TABLE
	   (
		 [word] nvarchar(max) NULL
	   )
BEGIN 
    Declare @TempStr nvarchar(MAX)
    
    WHILE (CHARINDEX(@splitStr,@Words)>0)
	BEGIN
		Set @TempStr=SUBSTRING(@Words,1,CHARINDEX(@splitStr,@Words)-1)
		Insert into @Result_Table (word) Values (@TempStr)
		
		Set @Words = REPLACE(@Words,@TempStr+@splitStr,'')
	END
	
	IF(LEN(RTRIM(LTRIM(@Words)))>0 And CHARINDEX(@splitStr,RTRIM(LTRIM(@Words)))=0)
	Begin
	    Set @TempStr=@Words
	    
		Insert into @Result_Table (word) Values (@TempStr)
	    
	End

   RETURN
END
GO
/****** Object:  Table [dbo].[define_class]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[define_class](
	[idx] [smallint] NOT NULL,
	[classHanName] [varchar](32) NOT NULL,
	[classEngName] [varchar](32) NOT NULL,
	[movieorderby] [smallint] NOT NULL,
	[limitrankingLevel] [tinyint] NOT NULL,
	[limituseLevel] [smallint] NOT NULL,
	[premiumType] [tinyint] NOT NULL,
	[classFullName] [varchar](50) NULL,
	[rareType] [tinyint] NULL,
	[attackType] [tinyint] NULL,
	[powerupType] [tinyint] NULL,
	[display] [tinyint] NULL,
	[description] [varchar](2000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[define_class_price]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[define_class_price](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[class1_price] [int] NOT NULL,
	[class2_price] [int] NOT NULL,
	[class3_price] [int] NOT NULL,
	[class4_price] [int] NOT NULL,
	[class5_price] [int] NOT NULL,
	[class6_price] [int] NOT NULL,
	[class7_price] [int] NOT NULL,
	[class8_price] [int] NOT NULL,
	[class9_price] [int] NOT NULL,
	[class10_price] [int] NOT NULL,
	[class11_price] [int] NOT NULL,
	[class12_price] [int] NOT NULL,
	[class13_price] [int] NOT NULL,
	[class14_price] [int] NOT NULL,
	[class15_price] [int] NOT NULL,
	[class16_price] [int] NOT NULL,
	[class17_price] [int] NOT NULL,
	[class18_price] [int] NOT NULL,
	[class19_price] [int] NOT NULL,
	[class20_price] [int] NOT NULL,
	[class21_price] [int] NOT NULL,
	[class22_price] [int] NOT NULL,
	[class23_price] [int] NOT NULL,
	[class24_price] [int] NOT NULL,
	[class25_price] [int] NOT NULL,
	[class26_price] [int] NOT NULL,
	[class27_price] [int] NOT NULL,
	[class28_price] [int] NOT NULL,
	[class29_price] [int] NOT NULL,
	[class30_price] [int] NOT NULL,
	[class31_price] [int] NOT NULL,
	[class32_price] [int] NOT NULL,
	[class33_price] [int] NOT NULL,
	[class34_price] [int] NOT NULL,
	[class35_price] [int] NOT NULL,
	[class36_price] [int] NOT NULL,
	[class37_price] [int] NOT NULL,
	[class38_price] [int] NOT NULL,
	[class39_price] [int] NOT NULL,
	[class40_price] [int] NOT NULL,
	[class41_price] [int] NOT NULL,
	[class42_price] [int] NOT NULL,
	[class43_price] [int] NOT NULL,
	[class44_price] [int] NOT NULL,
	[class45_price] [int] NOT NULL,
	[class46_price] [int] NOT NULL,
	[class47_price] [int] NOT NULL,
	[class48_price] [int] NOT NULL,
	[class49_price] [int] NOT NULL,
	[class50_price] [int] NOT NULL,
	[class51_price] [int] NOT NULL,
	[class52_price] [int] NOT NULL,
	[class53_price] [int] NOT NULL,
	[class54_price] [int] NOT NULL,
	[class55_price] [int] NOT NULL,
	[class56_price] [int] NOT NULL,
	[class57_price] [int] NOT NULL,
	[class58_price] [int] NOT NULL,
	[class59_price] [int] NOT NULL,
	[class60_price] [int] NOT NULL,
	[class61_price] [int] NOT NULL,
	[class62_price] [int] NOT NULL,
	[class63_price] [int] NOT NULL,
	[class64_price] [int] NOT NULL,
	[class65_price] [int] NOT NULL,
	[class66_price] [int] NOT NULL,
	[class67_price] [int] NOT NULL,
	[class68_price] [int] NOT NULL,
	[class69_price] [int] NOT NULL,
	[class70_price] [int] NOT NULL,
	[class71_price] [int] NOT NULL,
	[class72_price] [int] NOT NULL,
	[class73_price] [int] NOT NULL,
	[class74_price] [int] NOT NULL,
	[class75_price] [int] NOT NULL,
	[class76_price] [int] NOT NULL,
	[class77_price] [int] NOT NULL,
	[class78_price] [int] NOT NULL,
	[class79_price] [int] NOT NULL,
	[class80_price] [int] NOT NULL,
	[class81_price] [int] NOT NULL,
	[class82_price] [int] NOT NULL,
	[class83_price] [int] NOT NULL,
	[class84_price] [int] NOT NULL,
	[class85_price] [int] NOT NULL,
	[class86_price] [int] NOT NULL,
	[class87_price] [int] NOT NULL,
	[class88_price] [int] NOT NULL,
	[class89_price] [int] NOT NULL,
	[class90_price] [int] NOT NULL,
	[class91_price] [int] NOT NULL,
	[class92_price] [int] NOT NULL,
	[class93_price] [int] NOT NULL,
	[class94_price] [int] NOT NULL,
	[class95_price] [int] NOT NULL,
	[class96_price] [int] NOT NULL,
	[class97_price] [int] NOT NULL,
	[class98_price] [int] NOT NULL,
	[class99_price] [int] NOT NULL,
	[class100_price] [int] NOT NULL,
	[class101_price] [int] NOT NULL,
	[class102_price] [int] NOT NULL,
	[class103_price] [int] NOT NULL,
	[class104_price] [int] NOT NULL,
	[class105_price] [int] NOT NULL,
	[class106_price] [int] NOT NULL,
	[class107_price] [int] NOT NULL,
	[class108_price] [int] NOT NULL,
	[class109_price] [int] NOT NULL,
	[class110_price] [int] NOT NULL,
	[class111_price] [int] NOT NULL,
	[class112_price] [int] NOT NULL,
	[class113_price] [int] NOT NULL,
	[class114_price] [int] NOT NULL,
	[class115_price] [int] NOT NULL,
	[class116_price] [int] NOT NULL,
	[class117_price] [int] NOT NULL,
	[class118_price] [int] NOT NULL,
	[class119_price] [int] NOT NULL,
	[class120_price] [int] NOT NULL,
	[class121_price] [int] NOT NULL,
	[class122_price] [int] NOT NULL,
	[class123_price] [int] NOT NULL,
	[class124_price] [int] NOT NULL,
	[class125_price] [int] NOT NULL,
	[class126_price] [int] NOT NULL,
	[class127_price] [int] NOT NULL,
	[class128_price] [int] NOT NULL,
	[class129_price] [int] NOT NULL,
	[class130_price] [int] NOT NULL,
	[class131_price] [int] NOT NULL,
	[class132_price] [int] NOT NULL,
	[class133_price] [int] NOT NULL,
	[class134_price] [int] NOT NULL,
	[class135_price] [int] NOT NULL,
	[class136_price] [int] NOT NULL,
	[class137_price] [int] NOT NULL,
	[class138_price] [int] NOT NULL,
	[class139_price] [int] NOT NULL,
	[class140_price] [int] NOT NULL,
	[class141_price] [int] NOT NULL,
	[class142_price] [int] NOT NULL,
	[class143_price] [int] NOT NULL,
	[class144_price] [int] NOT NULL,
	[class145_price] [int] NOT NULL,
	[class146_price] [int] NOT NULL,
	[class147_price] [int] NOT NULL,
	[class148_price] [int] NOT NULL,
	[class149_price] [int] NOT NULL,
	[class150_price] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[define_custom_customidx]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[define_custom_customidx](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
 CONSTRAINT [pk_define_custom_customidx_idx] PRIMARY KEY CLUSTERED 
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[define_encode_key]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[define_encode_key](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[encodeKey] [char](15) NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[define_game_server]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[define_game_server](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[serverID] [bigint] NOT NULL,
	[serverIP] [varchar](15) NOT NULL,
	[serverPort] [int] NOT NULL,
	[serverName] [varchar](50) NULL,
	[clientPort] [int] NOT NULL,
	[connNumber] [int] NOT NULL,
	[status] [tinyint] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_define_game_server] PRIMARY KEY CLUSTERED 
(
	[serverID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[define_gear_customidx]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[define_gear_customidx](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[define_hero_price]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[define_hero_price](
	[HeroCode] [int] NOT NULL,
	[HeroPrice] [int] NOT NULL,
 CONSTRAINT [PK_define_hero_price] PRIMARY KEY CLUSTERED 
(
	[HeroCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[event_chuchun]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[event_chuchun](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[friendIDX] [int] NOT NULL,
	[flag] [tinyint] NOT NULL,
	[userIP] [varchar](15) NOT NULL,
	[userType] [tinyint] NOT NULL,
	[itemFlag] [tinyint] NOT NULL,
	[cpID] [nvarchar](32) NOT NULL,
	[cpType] [int] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [idx_event_chuchun_idx] PRIMARY KEY CLUSTERED 
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[event_item_limited]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[event_item_limited](
	[AccountIDX] [int] NOT NULL,
	[EventType] [tinyint] NOT NULL,
	[GoodsIndex] [int] NOT NULL,
	[GoodsCount] [tinyint] NOT NULL,
 CONSTRAINT [PK_event_item_limited_AccountIDX] PRIMARY KEY CLUSTERED 
(
	[AccountIDX] ASC,
	[EventType] ASC,
	[GoodsIndex] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_LTS_WEEKTIME_PARENT_CHILD_INFO]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_LTS_WEEKTIME_PARENT_CHILD_INFO](
	[PARENT_ID] [varchar](25) NOT NULL,
	[CHILD_ID] [varchar](25) NOT NULL,
	[Agree_Type] [char](1) NULL,
	[AgreeDate] [datetime] NULL,
	[RegIP] [varchar](15) NULL,
	[RegDate] [datetime] NULL,
 CONSTRAINT [PK_TB_LTS_WEEKTIME_PARENT_CHILD_INFO] PRIMARY KEY NONCLUSTERED 
(
	[PARENT_ID] ASC,
	[CHILD_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_migration_error_log]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_migration_error_log](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[AsiasoftID] [nvarchar](128) NOT NULL,
	[GarenaUID] [varchar](20) NOT NULL,
	[GarenaID] [nvarchar](32) NOT NULL,
	[errorCode] [int] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TBL_migration_error_log] PRIMARY KEY CLUSTERED 
(
	[idx] ASC,
	[GarenaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_migration_mapping_log]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_migration_mapping_log](
	[accountIDX] [int] NOT NULL,
	[GarenaID] [nvarchar](32) NOT NULL,
	[GarenaUID] [varchar](20) NOT NULL,
	[AsiasoftID] [nvarchar](128) NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TBL_migration_mapping_log] PRIMARY KEY CLUSTERED 
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_obt_event_bug_reporting]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_obt_event_bug_reporting](
	[accountIDX] [int] NOT NULL,
	[brType] [tinyint] NOT NULL,
 CONSTRAINT [PK_TBL_obt_event_bug_reporting] PRIMARY KEY CLUSTERED 
(
	[accountIDX] ASC,
	[brType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_obt_event_log]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_obt_event_log](
	[accountIDX] [int] NOT NULL,
	[eventType] [tinyint] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TBL_obt_event_log] PRIMARY KEY CLUSTERED 
(
	[accountIDX] ASC,
	[eventType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_RANKING_AWARD]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_RANKING_AWARD](
	[accountIDX] [int] NULL,
	[awardType] [int] NULL,
	[prevRanking] [int] NULL,
	[nowRanking] [int] NULL,
	[point] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userAbilityDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userAbilityDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[class1_type] [int] NOT NULL,
	[class1_basic01] [tinyint] NOT NULL,
	[class1_basic02] [tinyint] NOT NULL,
	[class1_basic03] [tinyint] NOT NULL,
	[class1_basic04] [tinyint] NOT NULL,
	[class1_skill1_sd] [tinyint] NOT NULL,
	[class1_skill1_asd] [tinyint] NOT NULL,
	[class1_skill1_ad] [tinyint] NOT NULL,
	[class1_skill1_as] [tinyint] NOT NULL,
	[class1_timeslot] [int] NOT NULL,
	[class1_limitdate] [datetime] NOT NULL,
	[class2_type] [int] NOT NULL,
	[class2_basic01] [tinyint] NOT NULL,
	[class2_basic02] [tinyint] NOT NULL,
	[class2_basic03] [tinyint] NOT NULL,
	[class2_basic04] [tinyint] NOT NULL,
	[class2_skill1_sd] [tinyint] NOT NULL,
	[class2_skill1_asd] [tinyint] NOT NULL,
	[class2_skill1_ad] [tinyint] NOT NULL,
	[class2_skill1_as] [tinyint] NOT NULL,
	[class2_timeslot] [int] NOT NULL,
	[class2_limitdate] [datetime] NOT NULL,
	[class3_type] [int] NOT NULL,
	[class3_basic01] [tinyint] NOT NULL,
	[class3_basic02] [tinyint] NOT NULL,
	[class3_basic03] [tinyint] NOT NULL,
	[class3_basic04] [tinyint] NOT NULL,
	[class3_skill1_sd] [tinyint] NOT NULL,
	[class3_skill1_asd] [tinyint] NOT NULL,
	[class3_skill1_ad] [tinyint] NOT NULL,
	[class3_skill1_as] [tinyint] NOT NULL,
	[class3_timeslot] [int] NOT NULL,
	[class3_limitdate] [datetime] NOT NULL,
	[class4_type] [int] NOT NULL,
	[class4_basic01] [tinyint] NOT NULL,
	[class4_basic02] [tinyint] NOT NULL,
	[class4_basic03] [tinyint] NOT NULL,
	[class4_basic04] [tinyint] NOT NULL,
	[class4_skill1_sd] [tinyint] NOT NULL,
	[class4_skill1_asd] [tinyint] NOT NULL,
	[class4_skill1_ad] [tinyint] NOT NULL,
	[class4_skill1_as] [tinyint] NOT NULL,
	[class4_timeslot] [int] NOT NULL,
	[class4_limitdate] [datetime] NOT NULL,
	[class5_type] [int] NOT NULL,
	[class5_basic01] [tinyint] NOT NULL,
	[class5_basic02] [tinyint] NOT NULL,
	[class5_basic03] [tinyint] NOT NULL,
	[class5_basic04] [tinyint] NOT NULL,
	[class5_skill1_sd] [tinyint] NOT NULL,
	[class5_skill1_asd] [tinyint] NOT NULL,
	[class5_skill1_ad] [tinyint] NOT NULL,
	[class5_skill1_as] [tinyint] NOT NULL,
	[class5_timeslot] [int] NOT NULL,
	[class5_limitdate] [datetime] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userAccessoryDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userAccessoryDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[AccountIDX] [int] NOT NULL,
	[ItemCode] [int] NOT NULL,
	[PeriodType] [tinyint] NOT NULL,
	[PeriodDate] [datetime] NOT NULL,
	[StatValue] [int] NOT NULL,
	[ClassType] [int] NOT NULL,
	[RegDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userAccessoryDB] PRIMARY KEY CLUSTERED 
(
	[AccountIDX] ASC,
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userAttendanceDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userAttendanceDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[checkDate] [datetime] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userAttendDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userAttendDB](
	[AccountIDX] [int] NOT NULL,
	[AttendCount] [int] NOT NULL,
	[RewardTable] [int] NOT NULL,
	[ConnectDate] [datetime] NOT NULL,
	[RegDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userAttendDB_LogIndex] PRIMARY KEY CLUSTERED 
(
	[AccountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userAwardDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userAwardDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[award1_type] [int] NOT NULL,
	[award1_number] [int] NOT NULL,
	[award1_point] [int] NOT NULL,
	[award2_type] [int] NOT NULL,
	[award2_number] [int] NOT NULL,
	[award2_point] [int] NOT NULL,
	[award3_type] [int] NOT NULL,
	[award3_number] [int] NOT NULL,
	[award3_point] [int] NOT NULL,
	[award4_type] [int] NOT NULL,
	[award4_number] [int] NOT NULL,
	[award4_point] [int] NOT NULL,
	[award5_type] [int] NOT NULL,
	[award5_number] [int] NOT NULL,
	[award5_point] [int] NOT NULL,
	[award6_type] [int] NOT NULL,
	[award6_number] [int] NOT NULL,
	[award6_point] [int] NOT NULL,
	[award7_type] [int] NOT NULL,
	[award7_number] [int] NOT NULL,
	[award7_point] [int] NOT NULL,
	[award8_type] [int] NOT NULL,
	[award8_number] [int] NOT NULL,
	[award8_point] [int] NOT NULL,
	[award9_type] [int] NOT NULL,
	[award9_number] [int] NOT NULL,
	[award9_point] [int] NOT NULL,
	[award10_type] [int] NOT NULL,
	[award10_number] [int] NOT NULL,
	[award10_point] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userCharacterDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userCharacterDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[ClassType] [int] NOT NULL,
	[CI_type] [int] NOT NULL,
	[CI_gender] [int] NOT NULL,
	[CI_beard] [int] NOT NULL,
	[CI_face] [int] NOT NULL,
	[CI_hair] [int] NOT NULL,
	[CI_skinColor] [int] NOT NULL,
	[CI_hairColor] [int] NOT NULL,
	[CI_trinket] [int] NOT NULL,
	[CI_position] [int] NOT NULL,
	[CI_underwear] [int] NOT NULL,
	[EI1_type] [int] NOT NULL,
	[EI2_type] [int] NOT NULL,
	[EI3_type] [int] NOT NULL,
	[EI4_type] [int] NOT NULL,
	[limitTime] [int] NOT NULL,
	[limitType] [int] NOT NULL,
	[leaderType] [smallint] NOT NULL,
	[rentalType] [smallint] NOT NULL,
	[rentalTime] [int] NOT NULL,
	[awakeType] [tinyint] NOT NULL,
	[awakeTime] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userClassDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userClassDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[class1_type] [int] NOT NULL,
	[class1_level] [int] NOT NULL,
	[class1_expert] [int] NOT NULL,
	[class1_stat] [tinyint] NOT NULL,
	[class2_type] [int] NOT NULL,
	[class2_level] [int] NOT NULL,
	[class2_expert] [int] NOT NULL,
	[class2_stat] [tinyint] NOT NULL,
	[class3_type] [int] NOT NULL,
	[class3_level] [int] NOT NULL,
	[class3_expert] [int] NOT NULL,
	[class3_stat] [tinyint] NOT NULL,
	[class4_type] [int] NOT NULL,
	[class4_level] [int] NOT NULL,
	[class4_expert] [int] NOT NULL,
	[class4_stat] [tinyint] NOT NULL,
	[class5_type] [int] NOT NULL,
	[class5_level] [int] NOT NULL,
	[class5_expert] [int] NOT NULL,
	[class5_stat] [tinyint] NOT NULL,
	[class6_type] [int] NOT NULL,
	[class6_level] [int] NOT NULL,
	[class6_expert] [int] NOT NULL,
	[class6_stat] [tinyint] NOT NULL,
	[class7_type] [int] NOT NULL,
	[class7_level] [int] NOT NULL,
	[class7_expert] [int] NOT NULL,
	[class7_stat] [tinyint] NOT NULL,
	[class8_type] [int] NOT NULL,
	[class8_level] [int] NOT NULL,
	[class8_expert] [int] NOT NULL,
	[class8_stat] [tinyint] NOT NULL,
	[class9_type] [int] NOT NULL,
	[class9_level] [int] NOT NULL,
	[class9_expert] [int] NOT NULL,
	[class9_stat] [tinyint] NOT NULL,
	[class10_type] [int] NOT NULL,
	[class10_level] [int] NOT NULL,
	[class10_expert] [int] NOT NULL,
	[class10_stat] [tinyint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userCloverDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userCloverDB](
	[accountIDX] [int] NOT NULL,
	[CloverCnt] [int] NOT NULL,
	[LastChargeDate] [int] NOT NULL,
	[RemainTime] [smallint] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userCloverDB] PRIMARY KEY CLUSTERED 
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userCoinDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userCoinDB](
	[AccountIDX] [int] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[CoinType] [tinyint] NOT NULL,
	[RegDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userCoinDB] PRIMARY KEY CLUSTERED 
(
	[AccountIDX] ASC,
	[CoinType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userConfigDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userConfigDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[keyvalue] [varchar](200) NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userCooperationDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userCooperationDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[userID] [varchar](12) NOT NULL,
	[cpIDX] [bigint] NULL,
	[cpID] [varchar](32) NOT NULL,
	[cpType] [int] NOT NULL,
	[note] [varchar](100) NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [pk_idx_accountIDX] PRIMARY KEY NONCLUSTERED 
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userCostumeDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userCostumeDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[itemCode] [int] NOT NULL,
	[mcustom] [int] NOT NULL,
	[fcustom] [int] NOT NULL,
	[periodType] [tinyint] NOT NULL,
	[periodDate] [datetime] NOT NULL,
	[classType] [int] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userCostumeDB] PRIMARY KEY CLUSTERED 
(
	[idx] ASC,
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userEventBingo_Number]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userEventBingo_Number](
	[accountIDX] [int] NOT NULL,
	[number1] [tinyint] NOT NULL,
	[number2] [tinyint] NOT NULL,
	[number3] [tinyint] NOT NULL,
	[number4] [tinyint] NOT NULL,
	[number5] [tinyint] NOT NULL,
	[number6] [tinyint] NOT NULL,
	[number7] [tinyint] NOT NULL,
	[number8] [tinyint] NOT NULL,
	[number9] [tinyint] NOT NULL,
	[number10] [tinyint] NOT NULL,
	[number11] [tinyint] NOT NULL,
	[number12] [tinyint] NOT NULL,
	[number13] [tinyint] NOT NULL,
	[number14] [tinyint] NOT NULL,
	[number15] [tinyint] NOT NULL,
	[number16] [tinyint] NOT NULL,
	[number17] [tinyint] NOT NULL,
	[number18] [tinyint] NOT NULL,
	[number19] [tinyint] NOT NULL,
	[number20] [tinyint] NOT NULL,
	[number21] [tinyint] NOT NULL,
	[number22] [tinyint] NOT NULL,
	[number23] [tinyint] NOT NULL,
	[number24] [tinyint] NOT NULL,
	[number25] [tinyint] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userEventBingo_Number] PRIMARY KEY CLUSTERED 
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userEventBingo_Present]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userEventBingo_Present](
	[accountIDX] [int] NOT NULL,
	[item1] [tinyint] NOT NULL,
	[item2] [tinyint] NOT NULL,
	[item3] [tinyint] NOT NULL,
	[item4] [tinyint] NOT NULL,
	[item5] [tinyint] NOT NULL,
	[item6] [tinyint] NOT NULL,
	[item7] [tinyint] NOT NULL,
	[item8] [tinyint] NOT NULL,
	[item9] [tinyint] NOT NULL,
	[item10] [tinyint] NOT NULL,
	[item11] [tinyint] NOT NULL,
	[item12] [tinyint] NOT NULL,
	[item13] [tinyint] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userEventBingo_Present] PRIMARY KEY CLUSTERED 
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userEventDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userEventDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[value1] [int] NOT NULL,
	[value2] [int] NOT NULL,
	[eventType] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userEventPirateRoulette_Number]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userEventPirateRoulette_Number](
	[accountidx] [int] NOT NULL,
	[HP] [int] NOT NULL,
	[slot1] [tinyint] NOT NULL,
	[slot2] [tinyint] NOT NULL,
	[slot3] [tinyint] NOT NULL,
	[slot4] [tinyint] NOT NULL,
	[slot5] [tinyint] NOT NULL,
	[slot6] [tinyint] NOT NULL,
	[slot7] [tinyint] NOT NULL,
	[slot8] [tinyint] NOT NULL,
	[slot9] [tinyint] NOT NULL,
	[slot10] [tinyint] NOT NULL,
	[slot11] [tinyint] NOT NULL,
	[slot12] [tinyint] NOT NULL,
	[slot13] [tinyint] NOT NULL,
	[slot14] [tinyint] NOT NULL,
	[slot15] [tinyint] NOT NULL,
	[slot16] [tinyint] NOT NULL,
	[slot17] [tinyint] NOT NULL,
	[slot18] [tinyint] NOT NULL,
	[slot19] [tinyint] NOT NULL,
	[slot20] [tinyint] NOT NULL,
	[slot21] [tinyint] NOT NULL,
	[slot22] [tinyint] NOT NULL,
	[slot23] [tinyint] NOT NULL,
	[slot24] [tinyint] NOT NULL,
	[slot25] [tinyint] NOT NULL,
	[slot26] [tinyint] NOT NULL,
	[slot27] [tinyint] NOT NULL,
	[slot28] [tinyint] NOT NULL,
	[slot29] [tinyint] NOT NULL,
	[slot30] [tinyint] NOT NULL,
	[slot31] [tinyint] NOT NULL,
	[slot32] [tinyint] NOT NULL,
	[slot33] [tinyint] NOT NULL,
	[slot34] [tinyint] NOT NULL,
	[slot35] [tinyint] NOT NULL,
	[slot36] [tinyint] NOT NULL,
	[slot37] [tinyint] NOT NULL,
	[slot38] [tinyint] NOT NULL,
	[slot39] [tinyint] NOT NULL,
	[slot40] [tinyint] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userEventPirateRoulette_Number] PRIMARY KEY CLUSTERED 
(
	[accountidx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userEventPirateRoulette_Present]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userEventPirateRoulette_Present](
	[accountidx] [int] NOT NULL,
	[reward1] [tinyint] NOT NULL,
	[reward2] [tinyint] NOT NULL,
	[reward3] [tinyint] NOT NULL,
	[reward4] [tinyint] NOT NULL,
	[reward5] [tinyint] NOT NULL,
	[reward6] [tinyint] NOT NULL,
	[reward7] [tinyint] NOT NULL,
	[reward8] [tinyint] NOT NULL,
	[reward9] [tinyint] NOT NULL,
	[reward10] [tinyint] NOT NULL,
	[reward11] [tinyint] NOT NULL,
	[reward12] [tinyint] NOT NULL,
	[reward13] [tinyint] NOT NULL,
	[reward14] [tinyint] NOT NULL,
	[reward15] [tinyint] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userEventPirateRoulette_Present] PRIMARY KEY CLUSTERED 
(
	[accountidx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userFishDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userFishDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[fish1_type] [tinyint] NOT NULL,
	[fish1_an] [int] NOT NULL,
	[fish2_type] [tinyint] NOT NULL,
	[fish2_an] [int] NOT NULL,
	[fish3_type] [tinyint] NOT NULL,
	[fish3_an] [int] NOT NULL,
	[fish4_type] [tinyint] NOT NULL,
	[fish4_an] [int] NOT NULL,
	[fish5_type] [tinyint] NOT NULL,
	[fish5_an] [int] NOT NULL,
	[fish6_type] [tinyint] NOT NULL,
	[fish6_an] [int] NOT NULL,
	[fish7_type] [tinyint] NOT NULL,
	[fish7_an] [int] NOT NULL,
	[fish8_type] [tinyint] NOT NULL,
	[fish8_an] [int] NOT NULL,
	[fish9_type] [tinyint] NOT NULL,
	[fish9_an] [int] NOT NULL,
	[fish10_type] [tinyint] NOT NULL,
	[fish10_an] [int] NOT NULL,
	[fish11_type] [tinyint] NOT NULL,
	[fish11_an] [int] NOT NULL,
	[fish12_type] [tinyint] NOT NULL,
	[fish12_an] [int] NOT NULL,
	[fish13_type] [tinyint] NOT NULL,
	[fish13_an] [int] NOT NULL,
	[fish14_type] [tinyint] NOT NULL,
	[fish14_an] [int] NOT NULL,
	[fish15_type] [tinyint] NOT NULL,
	[fish15_an] [int] NOT NULL,
	[fish16_type] [tinyint] NOT NULL,
	[fish16_an] [int] NOT NULL,
	[fish17_type] [tinyint] NOT NULL,
	[fish17_an] [int] NOT NULL,
	[fish18_type] [tinyint] NOT NULL,
	[fish18_an] [int] NOT NULL,
	[fish19_type] [tinyint] NOT NULL,
	[fish19_an] [int] NOT NULL,
	[fish20_type] [tinyint] NOT NULL,
	[fish20_an] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userFriendBestDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userFriendBestDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[friendIDX] [int] NOT NULL,
	[flag] [int] NOT NULL,
	[flagTime] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userFriendDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userFriendDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[userAccIDX] [int] NOT NULL,
	[friendAccIDX] [int] NOT NULL,
	[sendCloverCnt] [int] NOT NULL,
	[sendCloverDate] [int] NOT NULL,
	[receiveCloverCnt] [int] NOT NULL,
	[receiveCloverDate] [int] NOT NULL,
	[receiveBCloverCnt] [int] NOT NULL,
	[flag] [tinyint] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userGameDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userGameDB](
	[accountIDX] [int] NOT NULL,
	[userState] [int] NOT NULL,
	[gameMoney] [bigint] NOT NULL,
	[playTime] [int] NOT NULL,
	[conn_count] [int] NOT NULL,
	[userLevel] [int] NOT NULL,
	[userEXP] [int] NOT NULL,
	[userFishingLevel] [int] NOT NULL,
	[userFishingEXP] [int] NOT NULL,
	[userExcavationLevel] [int] NOT NULL,
	[userExcavationEXP] [int] NOT NULL,
	[userHerocEXP] [int] NOT NULL,
	[userHerosEXP] [int] NOT NULL,
	[rencpoint] [int] NOT NULL,
	[renspoint] [int] NOT NULL,
	[relateLevel] [int] NOT NULL,
	[regionType] [int] NOT NULL,
	[refillData] [int] NOT NULL,
	[connDate] [datetime] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userGameDB] PRIMARY KEY CLUSTERED 
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userGuildAttendDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userGuildAttendDB](
	[InitDate] [datetime] NOT NULL,
	[AccountIDX] [int] NOT NULL,
	[GuildIDX] [int] NOT NULL,
	[RegDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userGuildAttendDB_RegDate_AccountIDX] PRIMARY KEY NONCLUSTERED 
(
	[InitDate] ASC,
	[AccountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userGuildDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userGuildDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[guildName] [varchar](20) NOT NULL,
	[aboutguild] [varchar](110) NOT NULL,
	[guildmark] [int] NOT NULL,
	[ranking] [int] NOT NULL,
	[point] [int] NOT NULL,
	[todaypoint] [int] NOT NULL,
	[guildLevel] [int] NOT NULL,
	[maxcount] [int] NOT NULL,
	[membercount] [int] NOT NULL,
	[today_vc] [int] NOT NULL,
	[total_vc] [int] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userGuildDB] PRIMARY KEY CLUSTERED 
(
	[guildName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userGuildHQDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userGuildHQDB](
	[GuildIDX] [int] NOT NULL,
	[ItemSerial] [bigint] IDENTITY(1,1) NOT NULL,
	[ItemCode] [int] NOT NULL,
	[ItemXZ] [int] NOT NULL,
	[ItemY] [int] NOT NULL,
	[ItemRotate] [tinyint] NOT NULL,
	[ItemDecoScore] [int] NOT NULL,
	[ItemStatus] [tinyint] NOT NULL,
 CONSTRAINT [PK_userGuildHQDB] PRIMARY KEY CLUSTERED 
(
	[GuildIDX] ASC,
	[ItemSerial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userGuildHQVerDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userGuildHQVerDB](
	[GuildIDX] [int] NOT NULL,
	[VerStatus] [bigint] NOT NULL,
	[UptDate] [datetime] NOT NULL,
	[RegDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userGuildHQVerDB] PRIMARY KEY CLUSTERED 
(
	[GuildIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userGuildInfoDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userGuildInfoDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[guildIDX] [int] NOT NULL,
	[guildPosition] [varchar](20) NULL,
	[guildJoinType] [int] NOT NULL,
	[msg] [int] NOT NULL,
	[regDate] [datetime] NOT NULL,
	[AttendDate] [datetime] NOT NULL,
	[GuildRankDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userHqDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userHqDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[class1_type] [int] NOT NULL,
	[class1_posx] [int] NOT NULL,
	[class1_posy] [int] NOT NULL,
	[class2_type] [int] NOT NULL,
	[class2_posx] [int] NOT NULL,
	[class2_posy] [int] NOT NULL,
	[class3_type] [int] NOT NULL,
	[class3_posx] [int] NOT NULL,
	[class3_posy] [int] NOT NULL,
	[class4_type] [int] NOT NULL,
	[class4_posx] [int] NOT NULL,
	[class4_posy] [int] NOT NULL,
	[class5_type] [int] NOT NULL,
	[class5_posx] [int] NOT NULL,
	[class5_posy] [int] NOT NULL,
	[class6_type] [int] NOT NULL,
	[class6_posx] [int] NOT NULL,
	[class6_posy] [int] NOT NULL,
	[class7_type] [int] NOT NULL,
	[class7_posx] [int] NOT NULL,
	[class7_posy] [int] NOT NULL,
	[class8_type] [int] NOT NULL,
	[class8_posx] [int] NOT NULL,
	[class8_posy] [int] NOT NULL,
	[class9_type] [int] NOT NULL,
	[class9_posx] [int] NOT NULL,
	[class9_posy] [int] NOT NULL,
	[class10_type] [int] NOT NULL,
	[class10_posx] [int] NOT NULL,
	[class10_posy] [int] NOT NULL,
	[lockType] [smallint] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userHqDB] PRIMARY KEY CLUSTERED 
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userItemDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userItemDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[item1_type] [int] NOT NULL,
	[item1_code] [int] NOT NULL,
	[item2_type] [int] NOT NULL,
	[item2_code] [int] NOT NULL,
	[item3_type] [int] NOT NULL,
	[item3_code] [int] NOT NULL,
	[item4_type] [int] NOT NULL,
	[item4_code] [int] NOT NULL,
	[item5_type] [int] NOT NULL,
	[item5_code] [int] NOT NULL,
	[item6_type] [int] NOT NULL,
	[item6_code] [int] NOT NULL,
	[item7_type] [int] NOT NULL,
	[item7_code] [int] NOT NULL,
	[item8_type] [int] NOT NULL,
	[item8_code] [int] NOT NULL,
	[item9_type] [int] NOT NULL,
	[item9_code] [int] NOT NULL,
	[item10_type] [int] NOT NULL,
	[item10_code] [int] NOT NULL,
	[item11_type] [int] NOT NULL,
	[item11_code] [int] NOT NULL,
	[item12_type] [int] NOT NULL,
	[item12_code] [int] NOT NULL,
	[item13_type] [int] NOT NULL,
	[item13_code] [int] NOT NULL,
	[item14_type] [int] NOT NULL,
	[item14_code] [int] NOT NULL,
	[item15_type] [int] NOT NULL,
	[item15_code] [int] NOT NULL,
	[item16_type] [int] NOT NULL,
	[item16_code] [int] NOT NULL,
	[item17_type] [int] NOT NULL,
	[item17_code] [int] NOT NULL,
	[item18_type] [int] NOT NULL,
	[item18_code] [int] NOT NULL,
	[item19_type] [int] NOT NULL,
	[item19_code] [int] NOT NULL,
	[item20_type] [int] NOT NULL,
	[item20_code] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userItemDB_Temp]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userItemDB_Temp](
	[idx] [int] NULL,
	[accountIDX] [int] NULL,
	[item1_type] [int] NULL,
	[item1_code] [int] NULL,
	[item2_type] [int] NULL,
	[item2_code] [int] NULL,
	[item3_type] [int] NULL,
	[item3_code] [int] NULL,
	[item4_type] [int] NULL,
	[item4_code] [int] NULL,
	[item5_type] [int] NULL,
	[item5_code] [int] NULL,
	[item6_type] [int] NULL,
	[item6_code] [int] NULL,
	[item7_type] [int] NULL,
	[item7_code] [int] NULL,
	[item8_type] [int] NULL,
	[item8_code] [int] NULL,
	[item9_type] [int] NULL,
	[item9_code] [int] NULL,
	[item10_type] [int] NULL,
	[item10_code] [int] NULL,
	[item11_type] [int] NULL,
	[item11_code] [int] NULL,
	[item12_type] [int] NULL,
	[item12_code] [int] NULL,
	[item13_type] [int] NULL,
	[item13_code] [int] NULL,
	[item14_type] [int] NULL,
	[item14_code] [int] NULL,
	[item15_type] [int] NULL,
	[item15_code] [int] NULL,
	[item16_type] [int] NULL,
	[item16_code] [int] NULL,
	[item17_type] [int] NULL,
	[item17_code] [int] NULL,
	[item18_type] [int] NULL,
	[item18_code] [int] NULL,
	[item19_type] [int] NULL,
	[item19_code] [int] NULL,
	[item20_type] [int] NULL,
	[item20_code] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userItemEtcDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userItemEtcDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[item1_type] [int] NOT NULL,
	[item1_value1] [int] NOT NULL,
	[item1_value2] [int] NOT NULL,
	[item2_type] [int] NOT NULL,
	[item2_value1] [int] NOT NULL,
	[item2_value2] [int] NOT NULL,
	[item3_type] [int] NOT NULL,
	[item3_value1] [int] NOT NULL,
	[item3_value2] [int] NOT NULL,
	[item4_type] [int] NOT NULL,
	[item4_value1] [int] NOT NULL,
	[item4_value2] [int] NOT NULL,
	[item5_type] [int] NOT NULL,
	[item5_value1] [int] NOT NULL,
	[item5_value2] [int] NOT NULL,
	[item6_type] [int] NOT NULL,
	[item6_value1] [int] NOT NULL,
	[item6_value2] [int] NOT NULL,
	[item7_type] [int] NOT NULL,
	[item7_value1] [int] NOT NULL,
	[item7_value2] [int] NOT NULL,
	[item8_type] [int] NOT NULL,
	[item8_value1] [int] NOT NULL,
	[item8_value2] [int] NOT NULL,
	[item9_type] [int] NOT NULL,
	[item9_value1] [int] NOT NULL,
	[item9_value2] [int] NOT NULL,
	[item10_type] [int] NOT NULL,
	[item10_value1] [int] NOT NULL,
	[item10_value2] [int] NOT NULL,
	[item11_type] [int] NOT NULL,
	[item11_value1] [int] NOT NULL,
	[item11_value2] [int] NOT NULL,
	[item12_type] [int] NOT NULL,
	[item12_value1] [int] NOT NULL,
	[item12_value2] [int] NOT NULL,
	[item13_type] [int] NOT NULL,
	[item13_value1] [int] NOT NULL,
	[item13_value2] [int] NOT NULL,
	[item14_type] [int] NOT NULL,
	[item14_value1] [int] NOT NULL,
	[item14_value2] [int] NOT NULL,
	[item15_type] [int] NOT NULL,
	[item15_value1] [int] NOT NULL,
	[item15_value2] [int] NOT NULL,
	[item16_type] [int] NOT NULL,
	[item16_value1] [int] NOT NULL,
	[item16_value2] [int] NOT NULL,
	[item17_type] [int] NOT NULL,
	[item17_value1] [int] NOT NULL,
	[item17_value2] [int] NOT NULL,
	[item18_type] [int] NOT NULL,
	[item18_value1] [int] NOT NULL,
	[item18_value2] [int] NOT NULL,
	[item19_type] [int] NOT NULL,
	[item19_value1] [int] NOT NULL,
	[item19_value2] [int] NOT NULL,
	[item20_type] [int] NOT NULL,
	[item20_value1] [int] NOT NULL,
	[item20_value2] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userItemExtraDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userItemExtraDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[item1_type] [int] NOT NULL,
	[item1_reinforce] [int] NOT NULL,
	[item1_slotindex] [int] NOT NULL,
	[item1_tradetype] [int] NOT NULL,
	[item1_mcustom] [int] NOT NULL,
	[item1_fcustom] [int] NOT NULL,
	[item1_failexp] [smallint] NOT NULL,
	[item1_limitType] [int] NOT NULL,
	[item1_limitDate] [datetime] NOT NULL,
	[item2_type] [int] NOT NULL,
	[item2_reinforce] [int] NOT NULL,
	[item2_slotindex] [int] NOT NULL,
	[item2_tradetype] [int] NOT NULL,
	[item2_mcustom] [int] NOT NULL,
	[item2_fcustom] [int] NOT NULL,
	[item2_failexp] [smallint] NOT NULL,
	[item2_limitType] [int] NOT NULL,
	[item2_limitDate] [datetime] NOT NULL,
	[item3_type] [int] NOT NULL,
	[item3_reinforce] [int] NOT NULL,
	[item3_slotindex] [int] NOT NULL,
	[item3_tradetype] [int] NOT NULL,
	[item3_mcustom] [int] NOT NULL,
	[item3_fcustom] [int] NOT NULL,
	[item3_failexp] [smallint] NOT NULL,
	[item3_limitType] [int] NOT NULL,
	[item3_limitDate] [datetime] NOT NULL,
	[item4_type] [int] NOT NULL,
	[item4_reinforce] [int] NOT NULL,
	[item4_slotindex] [int] NOT NULL,
	[item4_tradetype] [int] NOT NULL,
	[item4_mcustom] [int] NOT NULL,
	[item4_fcustom] [int] NOT NULL,
	[item4_failexp] [smallint] NOT NULL,
	[item4_limitType] [int] NOT NULL,
	[item4_limitDate] [datetime] NOT NULL,
	[item5_type] [int] NOT NULL,
	[item5_reinforce] [int] NOT NULL,
	[item5_slotindex] [int] NOT NULL,
	[item5_tradetype] [int] NOT NULL,
	[item5_mcustom] [int] NOT NULL,
	[item5_fcustom] [int] NOT NULL,
	[item5_failexp] [smallint] NOT NULL,
	[item5_limitType] [int] NOT NULL,
	[item5_limitDate] [datetime] NOT NULL,
	[item6_type] [int] NOT NULL,
	[item6_reinforce] [int] NOT NULL,
	[item6_slotindex] [int] NOT NULL,
	[item6_tradetype] [int] NOT NULL,
	[item6_mcustom] [int] NOT NULL,
	[item6_fcustom] [int] NOT NULL,
	[item6_failexp] [smallint] NOT NULL,
	[item6_limitType] [int] NOT NULL,
	[item6_limitDate] [datetime] NOT NULL,
	[item7_type] [int] NOT NULL,
	[item7_reinforce] [int] NOT NULL,
	[item7_slotindex] [int] NOT NULL,
	[item7_tradetype] [int] NOT NULL,
	[item7_mcustom] [int] NOT NULL,
	[item7_fcustom] [int] NOT NULL,
	[item7_failexp] [smallint] NOT NULL,
	[item7_limitType] [int] NOT NULL,
	[item7_limitDate] [datetime] NOT NULL,
	[item8_type] [int] NOT NULL,
	[item8_reinforce] [int] NOT NULL,
	[item8_slotindex] [int] NOT NULL,
	[item8_tradetype] [int] NOT NULL,
	[item8_mcustom] [int] NOT NULL,
	[item8_fcustom] [int] NOT NULL,
	[item8_failexp] [smallint] NOT NULL,
	[item8_limitType] [int] NOT NULL,
	[item8_limitDate] [datetime] NOT NULL,
	[item9_type] [int] NOT NULL,
	[item9_reinforce] [int] NOT NULL,
	[item9_slotindex] [int] NOT NULL,
	[item9_tradetype] [int] NOT NULL,
	[item9_mcustom] [int] NOT NULL,
	[item9_fcustom] [int] NOT NULL,
	[item9_failexp] [smallint] NOT NULL,
	[item9_limitType] [int] NOT NULL,
	[item9_limitDate] [datetime] NOT NULL,
	[item10_type] [int] NOT NULL,
	[item10_reinforce] [int] NOT NULL,
	[item10_slotindex] [int] NOT NULL,
	[item10_tradetype] [int] NOT NULL,
	[item10_mcustom] [int] NOT NULL,
	[item10_fcustom] [int] NOT NULL,
	[item10_failexp] [smallint] NOT NULL,
	[item10_limitType] [int] NOT NULL,
	[item10_limitDate] [datetime] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userItemMedalDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userItemMedalDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[item1_type] [int] NOT NULL,
	[item1_class] [int] NOT NULL,
	[item1_limitType] [int] NOT NULL,
	[item1_limitDate] [datetime] NOT NULL,
	[item2_type] [int] NOT NULL,
	[item2_class] [int] NOT NULL,
	[item2_limitType] [int] NOT NULL,
	[item2_limitDate] [datetime] NOT NULL,
	[item3_type] [int] NOT NULL,
	[item3_class] [int] NOT NULL,
	[item3_limitType] [int] NOT NULL,
	[item3_limitDate] [datetime] NOT NULL,
	[item4_type] [int] NOT NULL,
	[item4_class] [int] NOT NULL,
	[item4_limitType] [int] NOT NULL,
	[item4_limitDate] [datetime] NOT NULL,
	[item5_type] [int] NOT NULL,
	[item5_class] [int] NOT NULL,
	[item5_limitType] [int] NOT NULL,
	[item5_limitDate] [datetime] NOT NULL,
	[item6_type] [int] NOT NULL,
	[item6_class] [int] NOT NULL,
	[item6_limitType] [int] NOT NULL,
	[item6_limitDate] [datetime] NOT NULL,
	[item7_type] [int] NOT NULL,
	[item7_class] [int] NOT NULL,
	[item7_limitType] [int] NOT NULL,
	[item7_limitDate] [datetime] NOT NULL,
	[item8_type] [int] NOT NULL,
	[item8_class] [int] NOT NULL,
	[item8_limitType] [int] NOT NULL,
	[item8_limitDate] [datetime] NOT NULL,
	[item9_type] [int] NOT NULL,
	[item9_class] [int] NOT NULL,
	[item9_limitType] [int] NOT NULL,
	[item9_limitDate] [datetime] NOT NULL,
	[item10_type] [int] NOT NULL,
	[item10_class] [int] NOT NULL,
	[item10_limitType] [int] NOT NULL,
	[item10_limitDate] [datetime] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userItemMedalExtendDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userItemMedalExtendDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[medal1_class] [int] NOT NULL,
	[medal1_slot] [tinyint] NOT NULL,
	[medal1_period] [int] NOT NULL,
	[medal2_class] [int] NOT NULL,
	[medal2_slot] [tinyint] NOT NULL,
	[medal2_period] [int] NOT NULL,
	[medal3_class] [int] NOT NULL,
	[medal3_slot] [tinyint] NOT NULL,
	[medal3_period] [int] NOT NULL,
	[medal4_class] [int] NOT NULL,
	[medal4_slot] [tinyint] NOT NULL,
	[medal4_period] [int] NOT NULL,
	[medal5_class] [int] NOT NULL,
	[medal5_slot] [tinyint] NOT NULL,
	[medal5_period] [int] NOT NULL,
	[medal6_class] [int] NOT NULL,
	[medal6_slot] [tinyint] NOT NULL,
	[medal6_period] [int] NOT NULL,
	[medal7_class] [int] NOT NULL,
	[medal7_slot] [tinyint] NOT NULL,
	[medal7_period] [int] NOT NULL,
	[medal8_class] [int] NOT NULL,
	[medal8_slot] [tinyint] NOT NULL,
	[medal8_period] [int] NOT NULL,
	[medal9_class] [int] NOT NULL,
	[medal9_slot] [tinyint] NOT NULL,
	[medal9_period] [int] NOT NULL,
	[medal10_class] [int] NOT NULL,
	[medal10_slot] [tinyint] NOT NULL,
	[medal10_period] [int] NOT NULL,
	[regDate] [nchar](10) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userLeagueAuthDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userLeagueAuthDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[leagueIDX] [int] NOT NULL,
	[accountIDX] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userLeagueCheerDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userLeagueCheerDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[leagueIDX] [int] NOT NULL,
	[teamIDX] [int] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userLeagueCheerDB] PRIMARY KEY CLUSTERED 
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userLeagueInfoDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userLeagueInfoDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[leagueIDX] [int] NOT NULL,
	[leagueName] [nvarchar](20) NOT NULL,
	[maxRound] [smallint] NOT NULL,
	[bannerA] [int] NOT NULL,
	[bannerB] [int] NOT NULL,
	[modeType] [int] NOT NULL,
	[maxcount] [tinyint] NOT NULL,
	[autoType] [tinyint] NOT NULL,
	[announce] [nvarchar](512) NOT NULL,
	[recruitDate] [int] NOT NULL,
	[waitDate] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userLeagueListDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userLeagueListDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[startDate] [int] NOT NULL,
	[endDate] [int] NOT NULL,
	[leagueType] [tinyint] NOT NULL,
	[leagueState] [tinyint] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userLeagueListDB] PRIMARY KEY CLUSTERED 
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userLeagueRewardCheerDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userLeagueRewardCheerDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[rewardPeso] [int] NOT NULL,
	[startDate] [int] NOT NULL,
	[flag] [tinyint] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userLeagueRewardDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userLeagueRewardDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[startDate] [int] NOT NULL,
	[currentRound] [tinyint] NOT NULL,
	[userFactionType] [int] NOT NULL,
	[winnerFactionType] [int] NOT NULL,
	[rewardPeso] [int] NOT NULL,
	[factionRank] [int] NOT NULL,
	[factionPoint] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userLeagueRewardUserDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userLeagueRewardUserDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[leagueIDX] [int] NOT NULL,
	[sendNickname] [nvarchar](20) NOT NULL,
	[leagueName] [nvarchar](20) NOT NULL,
	[roundnum] [int] NOT NULL,
	[maxRound] [smallint] NOT NULL,
	[presentCode1] [int] NOT NULL,
	[presentCode2] [int] NOT NULL,
	[presentCode3] [int] NOT NULL,
	[presentCode4] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userLeagueRoundDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userLeagueRoundDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[infoIDX] [int] NOT NULL,
	[roundType1_playDate] [int] NOT NULL,
	[roundType1_presentCode1] [int] NOT NULL,
	[roundType1_presentCode2] [int] NOT NULL,
	[roundType1_presentCode3] [int] NOT NULL,
	[roundType1_presentCode4] [int] NOT NULL,
	[roundType2_playDate] [int] NOT NULL,
	[roundType2_presentCode1] [int] NOT NULL,
	[roundType2_presentCode2] [int] NOT NULL,
	[roundType2_presentCode3] [int] NOT NULL,
	[roundType2_presentCode4] [int] NOT NULL,
	[roundType3_playDate] [int] NOT NULL,
	[roundType3_presentCode1] [int] NOT NULL,
	[roundType3_presentCode2] [int] NOT NULL,
	[roundType3_presentCode3] [int] NOT NULL,
	[roundType3_presentCode4] [int] NOT NULL,
	[roundType4_playDate] [int] NOT NULL,
	[roundType4_presentCode1] [int] NOT NULL,
	[roundType4_presentCode2] [int] NOT NULL,
	[roundType4_presentCode3] [int] NOT NULL,
	[roundType4_presentCode4] [int] NOT NULL,
	[roundType5_playDate] [int] NOT NULL,
	[roundType5_presentCode1] [int] NOT NULL,
	[roundType5_presentCode2] [int] NOT NULL,
	[roundType5_presentCode3] [int] NOT NULL,
	[roundType5_presentCode4] [int] NOT NULL,
	[roundType6_playDate] [int] NOT NULL,
	[roundType6_presentCode1] [int] NOT NULL,
	[roundType6_presentCode2] [int] NOT NULL,
	[roundType6_presentCode3] [int] NOT NULL,
	[roundType6_presentCode4] [int] NOT NULL,
	[roundType7_playDate] [int] NOT NULL,
	[roundType7_presentCode1] [int] NOT NULL,
	[roundType7_presentCode2] [int] NOT NULL,
	[roundType7_presentCode3] [int] NOT NULL,
	[roundType7_presentCode4] [int] NOT NULL,
	[roundType8_playDate] [int] NOT NULL,
	[roundType8_presentCode1] [int] NOT NULL,
	[roundType8_presentCode2] [int] NOT NULL,
	[roundType8_presentCode3] [int] NOT NULL,
	[roundType8_presentCode4] [int] NOT NULL,
	[roundType9_playDate] [int] NOT NULL,
	[roundType9_presentCode1] [int] NOT NULL,
	[roundType9_presentCode2] [int] NOT NULL,
	[roundType9_presentCode3] [int] NOT NULL,
	[roundType9_presentCode4] [int] NOT NULL,
	[roundType10_playDate] [int] NOT NULL,
	[roundType10_presentCode1] [int] NOT NULL,
	[roundType10_presentCode2] [int] NOT NULL,
	[roundType10_presentCode3] [int] NOT NULL,
	[roundType10_presentCode4] [int] NOT NULL,
	[roundType11_playDate] [int] NOT NULL,
	[roundType11_presentCode1] [int] NOT NULL,
	[roundType11_presentCode2] [int] NOT NULL,
	[roundType11_presentCode3] [int] NOT NULL,
	[roundType11_presentCode4] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userLeagueTeamDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userLeagueTeamDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[leagueIDX] [int] NOT NULL,
	[teamName] [nvarchar](20) NOT NULL,
	[leaderIDX] [int] NOT NULL,
	[leagueStartPosition] [smallint] NOT NULL,
	[leaguePosition] [smallint] NOT NULL,
	[maxcount] [tinyint] NOT NULL,
	[cheerPoint] [int] NOT NULL,
	[currentRound] [tinyint] NOT NULL,
	[factionPoint] [int] NOT NULL,
	[factionType] [tinyint] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userLeagueTeamDB] PRIMARY KEY CLUSTERED 
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userLeagueTeamMemberDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userLeagueTeamMemberDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[leagueIDX] [int] NOT NULL,
	[teamIDX] [int] NOT NULL,
	[joinType] [tinyint] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userLeagueTeamMemberDB] PRIMARY KEY CLUSTERED 
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userLeagueWinnerHistoryDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userLeagueWinnerHistoryDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[leagueTitle] [nvarchar](20) NOT NULL,
	[startDate] [int] NOT NULL,
	[endDate] [int] NOT NULL,
	[teamIDX] [int] NOT NULL,
	[teamName] [nvarchar](20) NULL,
	[factionName] [nvarchar](20) NULL,
	[factionType] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userLeagueWinnerInfoDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userLeagueWinnerInfoDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[nickName] [nvarchar](20) NOT NULL,
	[userLevel] [int] NOT NULL,
	[historyIDX] [int] NOT NULL,
	[teamIDX] [int] NOT NULL,
	[classType] [int] NOT NULL,
	[classGender] [int] NOT NULL,
	[classFace] [int] NOT NULL,
	[classHair] [int] NOT NULL,
	[classSkinColor] [int] NOT NULL,
	[classHairColor] [int] NOT NULL,
	[classUnderwear] [int] NOT NULL,
	[classGear1] [int] NOT NULL,
	[classGear2] [int] NOT NULL,
	[classGear3] [int] NOT NULL,
	[classGear4] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userLoginDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userLoginDB](
	[accountIDX] [int] NOT NULL,
	[encodeKey] [char](15) NOT NULL,
	[gameServerID] [bigint] NOT NULL,
	[userIP] [varchar](15) NULL,
	[connDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userLoginDB] PRIMARY KEY CLUSTERED 
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userMemberDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userMemberDB](
	[accountIDX] [int] IDENTITY(1,1) NOT NULL,
	[userID] [varchar](20) NOT NULL,
	[nickName] [varchar](20) NOT NULL,
	[userPWD] [varchar](24) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[mailling] [tinyint] NOT NULL,
	[userType] [smallint] NOT NULL,
	[joinType] [smallint] NOT NULL,
	[eventType] [int] NOT NULL,
	[cpType] [smallint] NOT NULL,
	[limitType] [smallint] NOT NULL,
	[limitDate] [datetime] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userMemberDB] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_userMemberDB] UNIQUE NONCLUSTERED 
(
	[nickName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userMissionDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userMissionDB](
	[AccountIDX] [int] NOT NULL,
	[MissionType] [tinyint] NOT NULL,
	[MissionCode] [int] NOT NULL,
	[MissionValue] [int] NOT NULL,
	[MissionStatus] [tinyint] NOT NULL,
	[RegDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userMissionDB_AccountIDX] PRIMARY KEY CLUSTERED 
(
	[AccountIDX] ASC,
	[MissionType] ASC,
	[MissionCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userMoneyDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userMoneyDB](
	[accountIDX] [int] NOT NULL,
	[realCash] [int] NOT NULL,
	[bonusCash] [int] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userMoneyDB] PRIMARY KEY CLUSTERED 
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userNameDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userNameDB](
	[accountIDX] [int] NOT NULL,
	[userName] [varchar](10) NOT NULL,
	[userBirthday] [char](6) NOT NULL,
	[userJumin1] [char](12) NULL,
	[userJumin2] [char](14) NULL,
	[virtualJumin] [varchar](13) NULL,
	[ipinCI] [varchar](88) NULL,
	[ipinDI] [varchar](64) NULL,
	[userEnCode] [varchar](64) NOT NULL,
	[userNumber] [tinyint] NOT NULL,
	[userGender] [tinyint] NOT NULL,
	[returnValue] [tinyint] NOT NULL,
	[userIP] [varchar](15) NULL,
	[realType] [tinyint] NOT NULL,
	[certType] [char](1) NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userNameDB] PRIMARY KEY CLUSTERED 
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userPersonalHQDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userPersonalHQDB](
	[AccountIDX] [int] NOT NULL,
	[ItemSerial] [bigint] IDENTITY(1,1) NOT NULL,
	[ItemCode] [int] NOT NULL,
	[ItemXZ] [int] NOT NULL,
	[ItemY] [int] NOT NULL,
	[ItemRotate] [tinyint] NOT NULL,
	[ItemDecoScore] [int] NOT NULL,
	[ItemStatus] [tinyint] NOT NULL,
 CONSTRAINT [PK_userPersonalHQDB] PRIMARY KEY CLUSTERED 
(
	[AccountIDX] ASC,
	[ItemSerial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userPetDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userPetDB](
	[accountIDX] [int] NOT NULL,
	[petIDX] [int] IDENTITY(1,1) NOT NULL,
	[petCode] [int] NOT NULL,
	[petRank] [tinyint] NOT NULL,
	[petLevel] [int] NOT NULL,
	[petExp] [int] NOT NULL,
	[petEquip] [tinyint] NOT NULL,
	[petStatus] [tinyint] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userPetDB_accountIDX_PetIDX] PRIMARY KEY CLUSTERED 
(
	[accountIDX] ASC,
	[petIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userPieceDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userPieceDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[piece1_type] [int] NOT NULL,
	[piece1_value1] [int] NOT NULL,
	[piece1_value2] [int] NOT NULL,
	[piece1_cnt] [int] NOT NULL,
	[piece2_type] [int] NOT NULL,
	[piece2_value1] [int] NOT NULL,
	[piece2_value2] [int] NOT NULL,
	[piece2_cnt] [int] NOT NULL,
	[piece3_type] [int] NOT NULL,
	[piece3_value1] [int] NOT NULL,
	[piece3_value2] [int] NOT NULL,
	[piece3_cnt] [int] NOT NULL,
	[piece4_type] [int] NOT NULL,
	[piece4_value1] [int] NOT NULL,
	[piece4_value2] [int] NOT NULL,
	[piece4_cnt] [int] NOT NULL,
	[piece5_type] [int] NOT NULL,
	[piece5_value1] [int] NOT NULL,
	[piece5_value2] [int] NOT NULL,
	[piece5_cnt] [int] NOT NULL,
	[piece6_type] [int] NOT NULL,
	[piece6_value1] [int] NOT NULL,
	[piece6_value2] [int] NOT NULL,
	[piece6_cnt] [int] NOT NULL,
	[piece7_type] [int] NOT NULL,
	[piece7_value1] [int] NOT NULL,
	[piece7_value2] [int] NOT NULL,
	[piece7_cnt] [int] NOT NULL,
	[piece8_type] [int] NOT NULL,
	[piece8_value1] [int] NOT NULL,
	[piece8_value2] [int] NOT NULL,
	[piece8_cnt] [int] NOT NULL,
	[piece9_type] [int] NOT NULL,
	[piece9_value1] [int] NOT NULL,
	[piece9_value2] [int] NOT NULL,
	[piece9_cnt] [int] NOT NULL,
	[piece10_type] [int] NOT NULL,
	[piece10_value1] [int] NOT NULL,
	[piece10_value2] [int] NOT NULL,
	[piece10_cnt] [int] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userPieceDB] PRIMARY KEY CLUSTERED 
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userPopStoreDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userPopStoreDB](
	[AccountIDX] [int] NOT NULL,
	[PopupSlot] [int] NOT NULL,
	[RegDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userPopStoreDB_AccountIDX] PRIMARY KEY CLUSTERED 
(
	[AccountIDX] ASC,
	[PopupSlot] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userPresentDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userPresentDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[sendIDX] [int] NOT NULL,
	[receiveIDX] [int] NOT NULL,
	[presentType] [smallint] NOT NULL,
	[value1] [int] NOT NULL,
	[value2] [int] NOT NULL,
	[value3] [int] NOT NULL,
	[value4] [int] NOT NULL,
	[msgType] [smallint] NOT NULL,
	[flag] [smallint] NOT NULL,
	[limitDate] [datetime] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userQuestCompleteDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userQuestCompleteDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[quest1_type] [int] NOT NULL,
	[quest1_time] [int] NOT NULL,
	[quest2_type] [int] NOT NULL,
	[quest2_time] [int] NOT NULL,
	[quest3_type] [int] NOT NULL,
	[quest3_time] [int] NOT NULL,
	[quest4_type] [int] NOT NULL,
	[quest4_time] [int] NOT NULL,
	[quest5_type] [int] NOT NULL,
	[quest5_time] [int] NOT NULL,
	[quest6_type] [int] NOT NULL,
	[quest6_time] [int] NOT NULL,
	[quest7_type] [int] NOT NULL,
	[quest7_time] [int] NOT NULL,
	[quest8_type] [int] NOT NULL,
	[quest8_time] [int] NOT NULL,
	[quest9_type] [int] NOT NULL,
	[quest9_time] [int] NOT NULL,
	[quest10_type] [int] NOT NULL,
	[quest10_time] [int] NOT NULL,
	[quest11_type] [int] NOT NULL,
	[quest11_time] [int] NOT NULL,
	[quest12_type] [int] NOT NULL,
	[quest12_time] [int] NOT NULL,
	[quest13_type] [int] NOT NULL,
	[quest13_time] [int] NOT NULL,
	[quest14_type] [int] NOT NULL,
	[quest14_time] [int] NOT NULL,
	[quest15_type] [int] NOT NULL,
	[quest15_time] [int] NOT NULL,
	[quest16_type] [int] NOT NULL,
	[quest16_time] [int] NOT NULL,
	[quest17_type] [int] NOT NULL,
	[quest17_time] [int] NOT NULL,
	[quest18_type] [int] NOT NULL,
	[quest18_time] [int] NOT NULL,
	[quest19_type] [int] NOT NULL,
	[quest19_time] [int] NOT NULL,
	[quest20_type] [int] NOT NULL,
	[quest20_time] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userQuestDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userQuestDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[quest1_type] [int] NOT NULL,
	[quest1_value1] [int] NOT NULL,
	[quest1_value2] [int] NOT NULL,
	[quest1_time] [int] NOT NULL,
	[quest2_type] [int] NOT NULL,
	[quest2_value1] [int] NOT NULL,
	[quest2_value2] [int] NOT NULL,
	[quest2_time] [int] NOT NULL,
	[quest3_type] [int] NOT NULL,
	[quest3_value1] [int] NOT NULL,
	[quest3_value2] [int] NOT NULL,
	[quest3_time] [int] NOT NULL,
	[quest4_type] [int] NOT NULL,
	[quest4_value1] [int] NOT NULL,
	[quest4_value2] [int] NOT NULL,
	[quest4_time] [int] NOT NULL,
	[quest5_type] [int] NOT NULL,
	[quest5_value1] [int] NOT NULL,
	[quest5_value2] [int] NOT NULL,
	[quest5_time] [int] NOT NULL,
	[quest6_type] [int] NOT NULL,
	[quest6_value1] [int] NOT NULL,
	[quest6_value2] [int] NOT NULL,
	[quest6_time] [int] NOT NULL,
	[quest7_type] [int] NOT NULL,
	[quest7_value1] [int] NOT NULL,
	[quest7_value2] [int] NOT NULL,
	[quest7_time] [int] NOT NULL,
	[quest8_type] [int] NOT NULL,
	[quest8_value1] [int] NOT NULL,
	[quest8_value2] [int] NOT NULL,
	[quest8_time] [int] NOT NULL,
	[quest9_type] [int] NOT NULL,
	[quest9_value1] [int] NOT NULL,
	[quest9_value2] [int] NOT NULL,
	[quest9_time] [int] NOT NULL,
	[quest10_type] [int] NOT NULL,
	[quest10_value1] [int] NOT NULL,
	[quest10_value2] [int] NOT NULL,
	[quest10_time] [int] NOT NULL,
	[quest11_type] [int] NOT NULL,
	[quest11_value1] [int] NOT NULL,
	[quest11_value2] [int] NOT NULL,
	[quest11_time] [int] NOT NULL,
	[quest12_type] [int] NOT NULL,
	[quest12_value1] [int] NOT NULL,
	[quest12_value2] [int] NOT NULL,
	[quest12_time] [int] NOT NULL,
	[quest13_type] [int] NOT NULL,
	[quest13_value1] [int] NOT NULL,
	[quest13_value2] [int] NOT NULL,
	[quest13_time] [int] NOT NULL,
	[quest14_type] [int] NOT NULL,
	[quest14_value1] [int] NOT NULL,
	[quest14_value2] [int] NOT NULL,
	[quest14_time] [int] NOT NULL,
	[quest15_type] [int] NOT NULL,
	[quest15_value1] [int] NOT NULL,
	[quest15_value2] [int] NOT NULL,
	[quest15_time] [int] NOT NULL,
	[quest16_type] [int] NOT NULL,
	[quest16_value1] [int] NOT NULL,
	[quest16_value2] [int] NOT NULL,
	[quest16_time] [int] NOT NULL,
	[quest17_type] [int] NOT NULL,
	[quest17_value1] [int] NOT NULL,
	[quest17_value2] [int] NOT NULL,
	[quest17_time] [int] NOT NULL,
	[quest18_type] [int] NOT NULL,
	[quest18_value1] [int] NOT NULL,
	[quest18_value2] [int] NOT NULL,
	[quest18_time] [int] NOT NULL,
	[quest19_type] [int] NOT NULL,
	[quest19_value1] [int] NOT NULL,
	[quest19_value2] [int] NOT NULL,
	[quest19_time] [int] NOT NULL,
	[quest20_type] [int] NOT NULL,
	[quest20_value1] [int] NOT NULL,
	[quest20_value2] [int] NOT NULL,
	[quest20_time] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userRankingDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userRankingDB](
	[accountIDX] [int] NOT NULL,
	[class] [int] NOT NULL,
	[battle] [int] NOT NULL,
	[training] [int] NOT NULL,
	[award] [int] NOT NULL,
	[medal] [int] NOT NULL,
	[tester] [int] NOT NULL,
	[region] [int] NOT NULL,
	[regDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_userRankingDB] PRIMARY KEY CLUSTERED 
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userRankingDB_award]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userRankingDB_award](
	[accountIDX] [int] NOT NULL,
	[awardLevel] [int] NOT NULL,
	[expert] [int] NOT NULL,
	[award1_prev] [int] NOT NULL,
	[award1_now] [int] NOT NULL,
	[award1_point] [int] NOT NULL,
	[award2_prev] [int] NOT NULL,
	[award2_now] [int] NOT NULL,
	[award2_point] [int] NOT NULL,
	[award3_prev] [int] NOT NULL,
	[award3_now] [int] NOT NULL,
	[award3_point] [int] NOT NULL,
	[award4_prev] [int] NOT NULL,
	[award4_now] [int] NOT NULL,
	[award4_point] [int] NOT NULL,
	[award5_prev] [int] NOT NULL,
	[award5_now] [int] NOT NULL,
	[award5_point] [int] NOT NULL,
	[award6_prev] [int] NOT NULL,
	[award6_now] [int] NOT NULL,
	[award6_point] [int] NOT NULL,
	[award7_prev] [int] NOT NULL,
	[award7_now] [int] NOT NULL,
	[award7_point] [int] NOT NULL,
	[award8_prev] [int] NOT NULL,
	[award8_now] [int] NOT NULL,
	[award8_point] [int] NOT NULL,
	[award9_prev] [int] NOT NULL,
	[award9_now] [int] NOT NULL,
	[award9_point] [int] NOT NULL,
	[award10_prev] [int] NOT NULL,
	[award10_now] [int] NOT NULL,
	[award10_point] [int] NOT NULL,
	[award11_prev] [int] NOT NULL,
	[award11_now] [int] NOT NULL,
	[award11_point] [int] NOT NULL,
	[award12_prev] [int] NOT NULL,
	[award12_now] [int] NOT NULL,
	[award12_point] [int] NOT NULL,
	[award13_prev] [int] NOT NULL,
	[award13_now] [int] NOT NULL,
	[award13_point] [int] NOT NULL,
	[award14_prev] [int] NOT NULL,
	[award14_now] [int] NOT NULL,
	[award14_point] [int] NOT NULL,
	[award15_prev] [int] NOT NULL,
	[award15_now] [int] NOT NULL,
	[award15_point] [int] NOT NULL,
	[award16_prev] [int] NOT NULL,
	[award16_now] [int] NOT NULL,
	[award16_point] [int] NOT NULL,
	[award17_prev] [int] NOT NULL,
	[award17_now] [int] NOT NULL,
	[award17_point] [int] NOT NULL,
	[award18_prev] [int] NOT NULL,
	[award18_now] [int] NOT NULL,
	[award18_point] [int] NOT NULL,
	[award19_prev] [int] NOT NULL,
	[award19_now] [int] NOT NULL,
	[award19_point] [int] NOT NULL,
	[award20_prev] [int] NOT NULL,
	[award20_now] [int] NOT NULL,
	[award20_point] [int] NOT NULL,
	[award21_prev] [int] NOT NULL,
	[award21_now] [int] NOT NULL,
	[award21_point] [int] NOT NULL,
	[award22_prev] [int] NOT NULL,
	[award22_now] [int] NOT NULL,
	[award22_point] [int] NOT NULL,
	[award23_prev] [int] NOT NULL,
	[award23_now] [int] NOT NULL,
	[award23_point] [int] NOT NULL,
	[award24_prev] [int] NOT NULL,
	[award24_now] [int] NOT NULL,
	[award24_point] [int] NOT NULL,
	[award25_prev] [int] NOT NULL,
	[award25_now] [int] NOT NULL,
	[award25_point] [int] NOT NULL,
	[award26_prev] [int] NOT NULL,
	[award26_now] [int] NOT NULL,
	[award26_point] [int] NOT NULL,
	[award27_prev] [int] NOT NULL,
	[award27_now] [int] NOT NULL,
	[award27_point] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userRankingDB_class]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userRankingDB_class](
	[accountIDX] [int] NULL,
	[classType] [int] NULL,
	[prevRanking] [int] NULL,
	[nowRanking] [int] NULL,
	[userLevel] [int] NULL,
	[expert] [int] NULL,
	[TEST] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Index [CL_userRankingDB_class]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE CLUSTERED INDEX [CL_userRankingDB_class] ON [dbo].[userRankingDB_class]
(
	[nowRanking] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userRankingDB_class_backup]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userRankingDB_class_backup](
	[accountIDX] [int] NULL,
	[classType] [int] NULL,
	[nowRanking] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userRankingDB_hero]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userRankingDB_hero](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[title] [int] NOT NULL,
	[daily] [int] NOT NULL,
	[dailyB] [int] NOT NULL,
	[season1] [int] NOT NULL,
	[season2] [int] NOT NULL,
	[season3] [int] NOT NULL,
	[season4] [int] NOT NULL,
	[season5] [int] NOT NULL,
	[season6] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userRankingDB_medal]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userRankingDB_medal](
	[accountIDX] [int] NOT NULL,
	[medalLevel] [int] NOT NULL,
	[expert] [int] NOT NULL,
	[ranking_prev] [int] NOT NULL,
	[ranking_now] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userRankingDB_temp]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userRankingDB_temp](
	[accountIDX] [int] NOT NULL,
	[rank] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userRankingDB_temp_old]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userRankingDB_temp_old](
	[accountIDX] [int] NOT NULL,
	[rank] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userRecordBattleDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userRecordBattleDB](
	[accountIDX] [int] NOT NULL,
	[type1_win] [int] NOT NULL,
	[type1_lose] [int] NOT NULL,
	[type1_kill] [int] NOT NULL,
	[type1_death] [int] NOT NULL,
	[type2_win] [int] NOT NULL,
	[type2_lose] [int] NOT NULL,
	[type2_kill] [int] NOT NULL,
	[type2_death] [int] NOT NULL,
	[type3_win] [int] NOT NULL,
	[type3_lose] [int] NOT NULL,
	[type3_kill] [int] NOT NULL,
	[type3_death] [int] NOT NULL,
	[type4_win] [int] NOT NULL,
	[type4_lose] [int] NOT NULL,
	[type4_kill] [int] NOT NULL,
	[type4_death] [int] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userRecordBattleDB] PRIMARY KEY CLUSTERED 
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userRecordGuildDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userRecordGuildDB](
	[guildIDX] [int] NOT NULL,
	[type1_win] [int] NOT NULL,
	[type1_lose] [int] NOT NULL,
	[type1_kill] [int] NOT NULL,
	[type1_death] [int] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userRecordGuildDB] PRIMARY KEY CLUSTERED 
(
	[guildIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userRegionDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userRegionDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[rt1point] [int] NOT NULL,
	[rt1point_bonus] [int] NOT NULL,
	[rt1point_today] [int] NOT NULL,
	[rt2point] [int] NOT NULL,
	[rt2point_bonus] [int] NOT NULL,
	[rt2point_today] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userRegionDB_compen]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userRegionDB_compen](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[rt1point] [int] NOT NULL,
	[rt1point_bonus] [int] NOT NULL,
	[rt1count] [int] NOT NULL,
	[rt2point] [int] NOT NULL,
	[rt2point_bonus] [int] NOT NULL,
	[rt2count] [int] NOT NULL,
	[regionType] [int] NOT NULL,
	[renspoint] [int] NOT NULL,
	[regionRanking] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userRegionDB_history]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userRegionDB_history](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[point] [int] NOT NULL,
	[point_bonus] [int] NOT NULL,
	[membercount] [int] NOT NULL,
	[regionType] [tinyint] NOT NULL,
	[season] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userRelativeLevelDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userRelativeLevelDB](
	[accountIDX] [int] NOT NULL,
	[weekend_BackupLevel] [int] NOT NULL,
	[weekend_BackupExp] [int] NOT NULL,
	[init_time] [int] NOT NULL,
	[reward_State] [tinyint] NOT NULL,
	[regDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userRelativeLevelDB] PRIMARY KEY CLUSTERED 
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userSBoxDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userSBoxDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[presentType] [smallint] NOT NULL,
	[value1] [int] NOT NULL,
	[value2] [int] NOT NULL,
	[amount] [int] NOT NULL,
	[flag] [smallint] NOT NULL,
	[billingID] [varchar](64) NOT NULL,
	[limitDate] [datetime] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userSpentGoldDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userSpentGoldDB](
	[AccountIDX] [int] NOT NULL,
	[UserSpentGold] [int] NOT NULL,
	[RegDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userSpentGoldDB_AccountIDX] PRIMARY KEY CLUSTERED 
(
	[AccountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userSpentGoldLogDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userSpentGoldLogDB](
	[RegDate] [datetime] NOT NULL,
	[AccountIDX] [int] NOT NULL,
	[UserSpentGold] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userSpRankDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userSpRankDB](
	[AccountIDX] [int] NOT NULL,
	[SpRank] [int] NOT NULL,
	[RegDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userSpRank] PRIMARY KEY CLUSTERED 
(
	[AccountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userTitleDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userTitleDB](
	[AccountIDX] [int] NOT NULL,
	[TitleCode] [int] NOT NULL,
	[TitleValue] [bigint] NOT NULL,
	[TitleLevel] [int] NOT NULL,
	[TitlePremium] [tinyint] NOT NULL,
	[TitleEquip] [tinyint] NOT NULL,
	[TitleStatus] [tinyint] NOT NULL,
	[UpdDate] [datetime] NOT NULL,
	[RegDate] [datetime] NOT NULL,
 CONSTRAINT [PK_userTitleDB_AccountIDX] PRIMARY KEY CLUSTERED 
(
	[AccountIDX] ASC,
	[TitleCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userTradeDB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userTradeDB](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[accountIDX] [int] NOT NULL,
	[itemType] [int] NOT NULL,
	[value1] [int] NOT NULL,
	[value2] [int] NOT NULL,
	[price] [bigint] NOT NULL,
	[mcustom] [int] NOT NULL,
	[fcustom] [int] NOT NULL,
	[userIP] [varchar](16) NULL,
	[periodDate] [int] NOT NULL,
	[regDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebBlock]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebBlock](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Hash] [varchar](32) NOT NULL,
	[Reason] [nvarchar](255) NOT NULL,
	[BlockDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebBlockException]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebBlockException](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [varchar](20) NOT NULL,
 CONSTRAINT [PK_WebBlockException] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebConnectLog]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebConnectLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](20) NOT NULL,
	[IP] [varchar](15) NULL,
	[Hash] [varchar](32) NULL,
	[LogDate] [datetime] NULL,
 CONSTRAINT [PK_WebBlock] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebCoupon]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebCoupon](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](16) NOT NULL,
	[GroupId] [int] NOT NULL,
	[Used] [bit] NOT NULL,
	[UsedUser] [varchar](20) NULL,
	[UsedDate] [datetime] NULL,
	[ExpiryDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebCouponItem]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebCouponItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupId] [int] NOT NULL,
	[PresentType] [smallint] NOT NULL,
	[Value1] [int] NOT NULL,
	[Value2] [int] NOT NULL,
	[ItemType] [int] NOT NULL,
 CONSTRAINT [PK_WebCouponItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebEvent]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebEvent](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[PresentType] [smallint] NOT NULL,
	[Value1] [int] NOT NULL,
	[Value2] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
 CONSTRAINT [PK_WebEvent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebEventLog]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebEventLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountIdx] [int] NOT NULL,
	[PresentId] [int] NOT NULL,
	[CompleteDate] [datetime] NOT NULL,
 CONSTRAINT [PK_WebEventLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebEventValentineDailyLog]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebEventValentineDailyLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountIdx] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[Amount] [int] NOT NULL,
	[CompleteDate] [datetime] NOT NULL,
 CONSTRAINT [PK_WebEventValentineDailyLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebEventValentineGoal]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebEventValentineGoal](
	[Id] [int] NOT NULL,
	[Plant] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[PresentType] [smallint] NOT NULL,
	[Value1] [int] NOT NULL,
	[Value2] [int] NOT NULL,
	[RewardName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_WebEventValentineGoal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebEventValentineGoalLog]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebEventValentineGoalLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountIdx] [int] NOT NULL,
	[GoalId] [int] NOT NULL,
	[CompleteDate] [datetime] NOT NULL,
 CONSTRAINT [PK_WebEventValentineGoalLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebEventValentineHistory]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebEventValentineHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SendIdx] [int] NOT NULL,
	[ReceiveIdx] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[Amount] [int] NOT NULL,
 CONSTRAINT [PK_WebEventValentineHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebEventValentineRanking]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebEventValentineRanking](
	[AccountIdx] [int] NOT NULL,
	[RankType] [int] NOT NULL,
	[Point] [int] NOT NULL,
	[LastUpdate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebEventValentineUserItem]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebEventValentineUserItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountIdx] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[Amount] [int] NOT NULL,
 CONSTRAINT [PK_WebEventValentineUserItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebGallery]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebGallery](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Description] [varchar](1000) NULL,
	[Path] [varchar](255) NOT NULL,
	[Width] [int] NOT NULL,
	[Height] [int] NOT NULL,
 CONSTRAINT [PK_WebGallery2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebHardware]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebHardware](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CpuNo] [varchar](128) NOT NULL,
	[MotherBoardNo] [varchar](128) NOT NULL,
	[IP] [varchar](15) NOT NULL,
	[Code] [varchar](10) NOT NULL,
	[ActiveDate] [datetime] NULL,
	[BannedDate] [datetime] NULL,
	[UUID] [varchar](128) NULL,
	[ActiveUser] [varchar](20) NULL,
 CONSTRAINT [PK_WebHardware2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebHardwareLog]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebHardwareLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CpuNo] [varchar](128) NULL,
	[MotherboardNo] [varchar](128) NULL,
	[IP] [varchar](15) NULL,
	[Time] [datetime] NULL,
	[ErrorCode] [int] NULL,
	[UUID] [varchar](128) NULL,
 CONSTRAINT [PK_WebHardwareLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebLogin]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebLogin](
	[Id] [int] NOT NULL,
	[Username] [varchar](20) NOT NULL,
	[Password] [varchar](128) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[RegDate] [datetime] NULL,
	[RegisterIP] [varchar](15) NULL,
	[Verify] [bit] NULL,
	[Banned] [bit] NULL,
 CONSTRAINT [PK_WebLogin] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebLogin_Confirm]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebLogin_Confirm](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](128) NOT NULL,
	[SendDate] [datetime] NULL,
	[Email] [varchar](50) NOT NULL,
	[Username] [varchar](20) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebNotice]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebNotice](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TypeId] [int] NOT NULL,
	[Subject] [nvarchar](255) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[NoticeUser] [nvarchar](30) NOT NULL,
	[NoticeDate] [datetime] NOT NULL,
	[Status] [int] NOT NULL,
	[ContentPlain] [nvarchar](max) NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_WebNotice] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebNoticeType]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebNoticeType](
	[Id] [int] NOT NULL,
	[Name] [varchar](20) NOT NULL,
	[ColorId] [int] NULL,
 CONSTRAINT [PK_WebNoticeType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebQuest]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebQuest](
	[Id] [int] NOT NULL,
	[QuestName] [varchar](255) NULL,
	[PlayType] [int] NOT NULL,
	[Mode] [int] NOT NULL,
	[Sub1] [int] NOT NULL,
	[Sub2] [int] NOT NULL,
	[QuestType] [int] NOT NULL,
	[QuestTarget] [int] NOT NULL,
	[QuestRepeat] [bit] NOT NULL,
	[QuestRepeatDay] [int] NOT NULL,
	[QuestStartDate] [datetime] NOT NULL,
	[QuestEndDate] [datetime] NOT NULL,
	[RewardEndDate] [datetime] NULL,
 CONSTRAINT [PK_WebQuest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebQuestReward]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebQuestReward](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QId] [int] NOT NULL,
	[PresentType] [smallint] NOT NULL,
	[Value1] [int] NOT NULL,
	[Value2] [int] NOT NULL,
	[ItemType] [int] NOT NULL,
 CONSTRAINT [PK_WebQuestReward] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebQuestUser]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebQuestUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QId] [int] NOT NULL,
	[UserID] [varchar](20) NOT NULL,
	[CompleteDate] [datetime] NULL,
 CONSTRAINT [PK_WebQuestUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebRecovery]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebRecovery](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](128) NOT NULL,
	[SendDate] [datetime] NULL,
	[Email] [varchar](50) NOT NULL,
	[Username] [varchar](20) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebRoulette]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebRoulette](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](1000) NOT NULL,
	[CostItem] [int] NOT NULL,
	[Cost] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
 CONSTRAINT [PK_WebRoulette] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebRouletteItem]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebRouletteItem](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_WebRouletteItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebRouletteMission]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebRouletteMission](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](1000) NOT NULL,
	[RewardItem] [int] NOT NULL,
	[Amount] [int] NOT NULL,
	[Flag] [int] NOT NULL,
 CONSTRAINT [PK_WebRouletteMission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebRoulettePayLog]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebRoulettePayLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountIdx] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[Amount] [int] NOT NULL,
	[Paid] [int] NOT NULL,
	[PaidDate] [datetime] NOT NULL,
 CONSTRAINT [PK_WebRoulettePayLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebRouletteReward]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebRouletteReward](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RId] [int] NOT NULL,
	[PresentType] [smallint] NOT NULL,
	[Value1] [int] NOT NULL,
	[Value2] [int] NOT NULL,
	[ItemType] [int] NOT NULL,
	[Flag] [int] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Rate] [int] NOT NULL,
	[Image] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_WebRouletteReward] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebRouletteRewardLog]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebRouletteRewardLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountIdx] [int] NOT NULL,
	[Nickname] [nvarchar](20) NOT NULL,
	[RouletteId] [int] NOT NULL,
	[RewardName] [nvarchar](255) NOT NULL,
	[RewardDate] [datetime] NOT NULL,
	[Flag] [int] NOT NULL,
 CONSTRAINT [PK_WebRouletteRewardLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebRouletteSetting]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebRouletteSetting](
	[Id] [int] NOT NULL,
	[RouletteId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[Lucky] [int] NOT NULL,
	[NextRoulette] [int] NULL,
 CONSTRAINT [PK_WebRouletteSetting] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebRouletteSPMission]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebRouletteSPMission](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](1000) NOT NULL,
	[Spin] [int] NOT NULL,
	[PresentType] [smallint] NOT NULL,
	[Value1] [int] NOT NULL,
	[Value2] [int] NOT NULL,
	[RewardName] [nvarchar](255) NOT NULL,
	[Enabled] [bit] NOT NULL,
	[DateFrom] [datetime] NOT NULL,
	[DateTo] [datetime] NOT NULL,
 CONSTRAINT [PK_WebRouletteSPMission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebRouletteSPMissionLog]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebRouletteSPMissionLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountIdx] [int] NOT NULL,
	[MissionId] [int] NOT NULL,
	[CompleteDate] [datetime] NOT NULL,
 CONSTRAINT [PK_WebRouletteSPMissionLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebRouletteUserItem]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebRouletteUserItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountIdx] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[Amount] [int] NOT NULL,
 CONSTRAINT [PK_WebRouletteUserItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebRouletteUserItemDeleteLog]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebRouletteUserItemDeleteLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountIdx] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[Amount] [int] NOT NULL,
	[DeletedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_WebRouletteUserItemDeleteLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebRouletteUserLucky]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebRouletteUserLucky](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountIdx] [int] NOT NULL,
	[RouletteId] [int] NOT NULL,
	[Lucky] [int] NOT NULL,
 CONSTRAINT [PK_WebRouletteUserLucky] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebRouletteUserMission]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebRouletteUserMission](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountIdx] [int] NOT NULL,
	[MissionId] [int] NOT NULL,
	[CompleteDate] [datetime] NOT NULL,
 CONSTRAINT [PK_WebRouletteUserMission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebTicket]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebTicket](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](20) NOT NULL,
	[Subject] [varchar](255) NOT NULL,
	[TypeId] [int] NOT NULL,
	[TicketDate] [datetime] NOT NULL,
	[Status] [int] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_WebTicket] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebTicketDetail]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebTicketDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Tid] [int] NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[UserID] [varchar](20) NOT NULL,
	[ReplyDate] [datetime] NULL,
	[IP] [varchar](15) NULL,
 CONSTRAINT [PK_WebTicketDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebTicketType]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebTicketType](
	[Id] [int] NOT NULL,
	[Name] [varchar](20) NOT NULL,
 CONSTRAINT [PK_WebTicketType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebTransaction]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebTransaction](
	[Id] [int] NOT NULL,
	[Uid] [varchar](20) NOT NULL,
	[Oid] [int] NOT NULL,
	[New] [int] NOT NULL,
	[Total] [int] NOT NULL,
	[Time] [datetime] NOT NULL,
	[ClientIP] [varchar](15) NULL,
	[AppId] [varchar](50) NULL,
	[ClientCountryCode] [varchar](20) NULL,
	[ClientPayout] [decimal](18, 0) NULL,
	[OfferName] [varchar](50) NULL,
 CONSTRAINT [PK_WebTransaction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_serverIP]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_serverIP] ON [dbo].[define_game_server]
(
	[serverIP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_accountIDX] ON [dbo].[event_chuchun]
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_cpID]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_cpID] ON [dbo].[event_chuchun]
(
	[cpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_friendIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_friendIDX] ON [dbo].[event_chuchun]
(
	[friendIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_TB_LTS_WEEKTIME_PARENT_CHILD_INFO__CHILD_UIDSEQ_Agree_Type]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [IX_TB_LTS_WEEKTIME_PARENT_CHILD_INFO__CHILD_UIDSEQ_Agree_Type] ON [dbo].[TB_LTS_WEEKTIME_PARENT_CHILD_INFO]
(
	[CHILD_ID] ASC,
	[Agree_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_TB_LTS_WEEKTIME_PARENT_CHILD_INFO__PSEQ_CSEQ_Agree_Type]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [IX_TB_LTS_WEEKTIME_PARENT_CHILD_INFO__PSEQ_CSEQ_Agree_Type] ON [dbo].[TB_LTS_WEEKTIME_PARENT_CHILD_INFO]
(
	[PARENT_ID] ASC,
	[CHILD_ID] ASC,
	[Agree_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [NC_TBL_migration_mapping_log_AsiasoftID]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [NC_TBL_migration_mapping_log_AsiasoftID] ON [dbo].[TBL_migration_mapping_log]
(
	[AsiasoftID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [NC_TBL_migration_mapping_log_GarenaUID]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [NC_TBL_migration_mapping_log_GarenaUID] ON [dbo].[TBL_migration_mapping_log]
(
	[GarenaUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [NC_TBL_RANKING_AWARD_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [NC_TBL_RANKING_AWARD_accountIDX] ON [dbo].[TBL_RANKING_AWARD]
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [NC_TBL_RANKING_AWARD_awardType]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [NC_TBL_RANKING_AWARD_awardType] ON [dbo].[TBL_RANKING_AWARD]
(
	[awardType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_idx] ON [dbo].[userAbilityDB]
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_accountIDX] ON [dbo].[userAttendanceDB]
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_idx] ON [dbo].[userAwardDB]
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_idx] ON [dbo].[userCharacterDB]
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_idx] ON [dbo].[userClassDB]
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_accountIDX] ON [dbo].[userCooperationDB]
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_cpID]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_cpID] ON [dbo].[userCooperationDB]
(
	[cpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_userCooperationDB__note]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [IX_userCooperationDB__note] ON [dbo].[userCooperationDB]
(
	[note] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_eventType]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_eventType] ON [dbo].[userEventDB]
(
	[accountIDX] ASC,
	[eventType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_idx] ON [dbo].[userEventDB]
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_idx] ON [dbo].[userFishDB]
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_accountIDX] ON [dbo].[userFriendBestDB]
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_flag]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_flag] ON [dbo].[userFriendBestDB]
(
	[flag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_friendIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_friendIDX] ON [dbo].[userFriendBestDB]
(
	[friendIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_accIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_accIDX] ON [dbo].[userFriendDB]
(
	[userAccIDX] ASC,
	[friendAccIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_idx] ON [dbo].[userFriendDB]
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_userAccIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_userAccIDX] ON [dbo].[userFriendDB]
(
	[userAccIDX] ASC,
	[friendAccIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_idx] ON [dbo].[userGuildDB]
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_accountIDX] ON [dbo].[userGuildInfoDB]
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_idx] ON [dbo].[userGuildInfoDB]
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_idx] ON [dbo].[userItemDB]
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_idx] ON [dbo].[userItemEtcDB]
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_idx] ON [dbo].[userItemExtraDB]
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_idx] ON [dbo].[userItemMedalDB]
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_accountIDX] ON [dbo].[userItemMedalExtendDB]
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_accountIDX] ON [dbo].[userLeagueAuthDB]
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_leagueIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_leagueIDX] ON [dbo].[userLeagueAuthDB]
(
	[leagueIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_accountIDX] ON [dbo].[userLeagueCheerDB]
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_leagueIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_leagueIDX] ON [dbo].[userLeagueCheerDB]
(
	[leagueIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_leagueIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_leagueIDX] ON [dbo].[userLeagueInfoDB]
(
	[leagueIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_accountIDX] ON [dbo].[userLeagueListDB]
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_idx] ON [dbo].[userLeagueRewardCheerDB]
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_accountIDX] ON [dbo].[userLeagueRewardDB]
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_accountIDX] ON [dbo].[userLeagueRewardUserDB]
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_idx] ON [dbo].[userLeagueRewardUserDB]
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_infoIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_infoIDX] ON [dbo].[userLeagueRoundDB]
(
	[infoIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_leaderIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_leaderIDX] ON [dbo].[userLeagueTeamDB]
(
	[leaderIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_leagueIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_leagueIDX] ON [dbo].[userLeagueTeamDB]
(
	[leagueIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_accountIDX] ON [dbo].[userLeagueTeamMemberDB]
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_leagueIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_leagueIDX] ON [dbo].[userLeagueTeamMemberDB]
(
	[leagueIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_teamIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_teamIDX] ON [dbo].[userLeagueTeamMemberDB]
(
	[teamIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_endDate]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_endDate] ON [dbo].[userLeagueWinnerHistoryDB]
(
	[endDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_startDate]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_startDate] ON [dbo].[userLeagueWinnerHistoryDB]
(
	[startDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_accountIDX] ON [dbo].[userLeagueWinnerInfoDB]
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_historyIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_historyIDX] ON [dbo].[userLeagueWinnerInfoDB]
(
	[historyIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_accountIDX] ON [dbo].[userMemberDB]
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_jumin]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_jumin] ON [dbo].[userNameDB]
(
	[userJumin1] ASC,
	[userJumin2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_userencode]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_userencode] ON [dbo].[userNameDB]
(
	[userEnCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_userName]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_userName] ON [dbo].[userNameDB]
(
	[userName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_TB_userNameDB__ipinCI]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [IX_TB_userNameDB__ipinCI] ON [dbo].[userNameDB]
(
	[ipinCI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_accountIDX] ON [dbo].[userPieceDB]
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_receiveIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_receiveIDX] ON [dbo].[userPresentDB]
(
	[receiveIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_idx] ON [dbo].[userQuestCompleteDB]
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_idx] ON [dbo].[userQuestDB]
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [NC_userRankingDB_class_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [NC_userRankingDB_class_accountIDX] ON [dbo].[userRankingDB_class]
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [NC_userRankingDB_class_classType]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [NC_userRankingDB_class_classType] ON [dbo].[userRankingDB_class]
(
	[classType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_daily]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_daily] ON [dbo].[userRankingDB_hero]
(
	[daily] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_idx] ON [dbo].[userRegionDB_compen]
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_accountIDX] ON [dbo].[userSBoxDB]
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
CREATE NONCLUSTERED INDEX [idx_accountIDX] ON [dbo].[userTradeDB]
(
	[accountIDX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[define_class] ADD  DEFAULT ((0)) FOR [limitrankingLevel]
GO
ALTER TABLE [dbo].[define_class] ADD  DEFAULT ((0)) FOR [limituseLevel]
GO
ALTER TABLE [dbo].[define_class] ADD  DEFAULT ((0)) FOR [premiumType]
GO
ALTER TABLE [dbo].[define_class] ADD  DEFAULT ((0)) FOR [rareType]
GO
ALTER TABLE [dbo].[define_class] ADD  DEFAULT ((1)) FOR [attackType]
GO
ALTER TABLE [dbo].[define_class] ADD  DEFAULT ((0)) FOR [powerupType]
GO
ALTER TABLE [dbo].[define_class] ADD  DEFAULT ((1)) FOR [display]
GO
ALTER TABLE [dbo].[define_class] ADD  DEFAULT ('No Introduction') FOR [description]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class1_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class2_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class3_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class4_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class5_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class6_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class7_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class8_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class9_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class10_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class11_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class12_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class13_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class14_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class15_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class16_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class17_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class18_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class19_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class20_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class21_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class22_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class23_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class24_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class25_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class26_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class27_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class28_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class29_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class30_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class31_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class32_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class33_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class34_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class35_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class36_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class37_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class38_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class39_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class40_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class41_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class42_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class43_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class44_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class45_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class46_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class47_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class48_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class49_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class50_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class51_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class52_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class53_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class54_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class55_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class56_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class57_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class58_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class59_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class60_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class61_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class62_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class63_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class64_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class65_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class66_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class67_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class68_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class69_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class70_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class71_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class72_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class73_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class74_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class75_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class76_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class77_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class78_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class79_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class80_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class81_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class82_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class83_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class84_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class85_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class86_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class87_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class88_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class89_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class90_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class91_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class92_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class93_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class94_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class95_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class96_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class97_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class98_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class99_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class100_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class101_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class102_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class103_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class104_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class105_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class106_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class107_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class108_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class109_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class110_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class111_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class112_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class113_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class114_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class115_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class116_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class117_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class118_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class119_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class120_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class121_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class122_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class123_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class124_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class125_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class126_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class127_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class128_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class129_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class130_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class131_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class132_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class133_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class134_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class135_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class136_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class137_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class138_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class139_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class140_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class141_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class142_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class143_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class144_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class145_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class146_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class147_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class148_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class149_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT ((0)) FOR [class150_price]
GO
ALTER TABLE [dbo].[define_class_price] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[define_custom_customidx] ADD  DEFAULT ((0)) FOR [accountIDX]
GO
ALTER TABLE [dbo].[define_encode_key] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[define_game_server] ADD  DEFAULT ((0)) FOR [serverID]
GO
ALTER TABLE [dbo].[define_game_server] ADD  DEFAULT ((0)) FOR [connNumber]
GO
ALTER TABLE [dbo].[define_game_server] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[define_game_server] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[define_gear_customidx] ADD  DEFAULT ((0)) FOR [accountIDX]
GO
ALTER TABLE [dbo].[define_hero_price] ADD  DEFAULT ((0)) FOR [HeroCode]
GO
ALTER TABLE [dbo].[define_hero_price] ADD  DEFAULT ((0)) FOR [HeroPrice]
GO
ALTER TABLE [dbo].[event_chuchun] ADD  DEFAULT ((0)) FOR [flag]
GO
ALTER TABLE [dbo].[event_chuchun] ADD  DEFAULT ((0)) FOR [userType]
GO
ALTER TABLE [dbo].[event_chuchun] ADD  DEFAULT ((0)) FOR [itemFlag]
GO
ALTER TABLE [dbo].[event_chuchun] ADD  DEFAULT ((0)) FOR [cpType]
GO
ALTER TABLE [dbo].[event_chuchun] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[TB_LTS_WEEKTIME_PARENT_CHILD_INFO] ADD  DEFAULT ('N') FOR [Agree_Type]
GO
ALTER TABLE [dbo].[TB_LTS_WEEKTIME_PARENT_CHILD_INFO] ADD  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[TBL_migration_error_log] ADD  DEFAULT ((0)) FOR [AsiasoftID]
GO
ALTER TABLE [dbo].[TBL_migration_error_log] ADD  DEFAULT ((0)) FOR [GarenaUID]
GO
ALTER TABLE [dbo].[TBL_migration_error_log] ADD  DEFAULT ((0)) FOR [GarenaID]
GO
ALTER TABLE [dbo].[TBL_migration_error_log] ADD  DEFAULT ((0)) FOR [errorCode]
GO
ALTER TABLE [dbo].[TBL_migration_error_log] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[TBL_migration_mapping_log] ADD  DEFAULT ((0)) FOR [GarenaID]
GO
ALTER TABLE [dbo].[TBL_migration_mapping_log] ADD  DEFAULT ((0)) FOR [GarenaUID]
GO
ALTER TABLE [dbo].[TBL_migration_mapping_log] ADD  DEFAULT ((0)) FOR [AsiasoftID]
GO
ALTER TABLE [dbo].[TBL_migration_mapping_log] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[TBL_obt_event_bug_reporting] ADD  DEFAULT ((0)) FOR [brType]
GO
ALTER TABLE [dbo].[TBL_obt_event_log] ADD  DEFAULT ((0)) FOR [eventType]
GO
ALTER TABLE [dbo].[TBL_obt_event_log] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class1_type]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class1_basic01]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class1_basic02]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class1_basic03]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class1_basic04]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class1_skill1_sd]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class1_skill1_asd]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class1_skill1_ad]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class1_skill1_as]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class1_timeslot]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT (getdate()) FOR [class1_limitdate]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class2_type]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class2_basic01]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class2_basic02]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class2_basic03]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class2_basic04]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class2_skill1_sd]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class2_skill1_asd]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class2_skill1_ad]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class2_skill1_as]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class2_timeslot]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT (getdate()) FOR [class2_limitdate]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class3_type]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class3_basic01]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class3_basic02]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class3_basic03]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class3_basic04]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class3_skill1_sd]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class3_skill1_asd]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class3_skill1_ad]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class3_skill1_as]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class3_timeslot]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT (getdate()) FOR [class3_limitdate]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class4_type]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class4_basic01]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class4_basic02]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class4_basic03]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class4_basic04]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class4_skill1_sd]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class4_skill1_asd]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class4_skill1_ad]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class4_skill1_as]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class4_timeslot]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT (getdate()) FOR [class4_limitdate]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class5_type]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class5_basic01]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class5_basic02]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class5_basic03]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class5_basic04]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class5_skill1_sd]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class5_skill1_asd]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class5_skill1_ad]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class5_skill1_as]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT ((0)) FOR [class5_timeslot]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT (getdate()) FOR [class5_limitdate]
GO
ALTER TABLE [dbo].[userAbilityDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userAccessoryDB] ADD  DEFAULT ((0)) FOR [ItemCode]
GO
ALTER TABLE [dbo].[userAccessoryDB] ADD  DEFAULT ((0)) FOR [PeriodType]
GO
ALTER TABLE [dbo].[userAccessoryDB] ADD  DEFAULT ('1999-01-01') FOR [PeriodDate]
GO
ALTER TABLE [dbo].[userAccessoryDB] ADD  DEFAULT ((0)) FOR [StatValue]
GO
ALTER TABLE [dbo].[userAccessoryDB] ADD  DEFAULT ((0)) FOR [ClassType]
GO
ALTER TABLE [dbo].[userAccessoryDB] ADD  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[userAttendanceDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [accountIDX]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award1_type]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award1_number]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award1_point]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award2_type]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award2_number]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award2_point]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award3_type]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award3_number]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award3_point]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award4_type]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award4_number]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award4_point]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award5_type]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award5_number]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award5_point]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award6_type]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award6_number]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award6_point]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award7_type]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award7_number]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award7_point]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award8_type]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award8_number]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award8_point]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award9_type]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award9_number]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award9_point]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award10_type]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award10_number]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT ((0)) FOR [award10_point]
GO
ALTER TABLE [dbo].[userAwardDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [ClassType]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [CI_type]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [CI_gender]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [CI_beard]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [CI_face]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [CI_hair]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [CI_skinColor]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [CI_hairColor]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [CI_trinket]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((-1)) FOR [CI_position]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [CI_underwear]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [EI1_type]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [EI2_type]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [EI3_type]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [EI4_type]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [limitTime]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [limitType]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [leaderType]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [rentalType]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [rentalTime]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [awakeType]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT ((0)) FOR [awakeTime]
GO
ALTER TABLE [dbo].[userCharacterDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class1_type]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class1_level]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class1_expert]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class1_stat]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class2_type]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class2_level]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class2_expert]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class2_stat]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class3_type]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class3_level]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class3_expert]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class3_stat]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class4_type]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class4_level]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class4_expert]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class4_stat]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class5_type]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class5_level]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class5_expert]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class5_stat]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class6_type]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class6_level]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class6_expert]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class6_stat]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class7_type]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class7_level]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class7_expert]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class7_stat]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class8_type]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class8_level]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class8_expert]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class8_stat]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class9_type]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class9_level]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class9_expert]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class9_stat]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class10_type]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class10_level]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class10_expert]
GO
ALTER TABLE [dbo].[userClassDB] ADD  DEFAULT ((0)) FOR [class10_stat]
GO
ALTER TABLE [dbo].[userCloverDB] ADD  DEFAULT ((0)) FOR [CloverCnt]
GO
ALTER TABLE [dbo].[userCloverDB] ADD  DEFAULT ((0)) FOR [LastChargeDate]
GO
ALTER TABLE [dbo].[userCloverDB] ADD  DEFAULT ((0)) FOR [RemainTime]
GO
ALTER TABLE [dbo].[userCloverDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userCoinDB] ADD  DEFAULT ((0)) FOR [CoinType]
GO
ALTER TABLE [dbo].[userCoinDB] ADD  DEFAULT ((0)) FOR [RegDate]
GO
ALTER TABLE [dbo].[userConfigDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userCooperationDB] ADD  DEFAULT ((0)) FOR [cpIDX]
GO
ALTER TABLE [dbo].[userCooperationDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userCostumeDB] ADD  DEFAULT ((0)) FOR [itemCode]
GO
ALTER TABLE [dbo].[userCostumeDB] ADD  DEFAULT ((0)) FOR [mcustom]
GO
ALTER TABLE [dbo].[userCostumeDB] ADD  DEFAULT ((0)) FOR [fcustom]
GO
ALTER TABLE [dbo].[userCostumeDB] ADD  DEFAULT ((0)) FOR [periodType]
GO
ALTER TABLE [dbo].[userCostumeDB] ADD  DEFAULT ((0)) FOR [periodDate]
GO
ALTER TABLE [dbo].[userCostumeDB] ADD  DEFAULT ((0)) FOR [classType]
GO
ALTER TABLE [dbo].[userCostumeDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number1]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number2]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number3]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number4]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number5]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number6]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number7]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number8]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number9]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number10]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number11]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number12]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number13]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number14]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number15]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number16]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number17]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number18]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number19]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number20]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number21]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number22]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number23]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number24]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT ((0)) FOR [number25]
GO
ALTER TABLE [dbo].[userEventBingo_Number] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userEventBingo_Present] ADD  DEFAULT ((0)) FOR [item1]
GO
ALTER TABLE [dbo].[userEventBingo_Present] ADD  DEFAULT ((0)) FOR [item2]
GO
ALTER TABLE [dbo].[userEventBingo_Present] ADD  DEFAULT ((0)) FOR [item3]
GO
ALTER TABLE [dbo].[userEventBingo_Present] ADD  DEFAULT ((0)) FOR [item4]
GO
ALTER TABLE [dbo].[userEventBingo_Present] ADD  DEFAULT ((0)) FOR [item5]
GO
ALTER TABLE [dbo].[userEventBingo_Present] ADD  DEFAULT ((0)) FOR [item6]
GO
ALTER TABLE [dbo].[userEventBingo_Present] ADD  DEFAULT ((0)) FOR [item7]
GO
ALTER TABLE [dbo].[userEventBingo_Present] ADD  DEFAULT ((0)) FOR [item8]
GO
ALTER TABLE [dbo].[userEventBingo_Present] ADD  DEFAULT ((0)) FOR [item9]
GO
ALTER TABLE [dbo].[userEventBingo_Present] ADD  DEFAULT ((0)) FOR [item10]
GO
ALTER TABLE [dbo].[userEventBingo_Present] ADD  DEFAULT ((0)) FOR [item11]
GO
ALTER TABLE [dbo].[userEventBingo_Present] ADD  DEFAULT ((0)) FOR [item12]
GO
ALTER TABLE [dbo].[userEventBingo_Present] ADD  DEFAULT ((0)) FOR [item13]
GO
ALTER TABLE [dbo].[userEventBingo_Present] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userEventDB] ADD  DEFAULT ((0)) FOR [value1]
GO
ALTER TABLE [dbo].[userEventDB] ADD  DEFAULT ((0)) FOR [value2]
GO
ALTER TABLE [dbo].[userEventDB] ADD  DEFAULT ((0)) FOR [eventType]
GO
ALTER TABLE [dbo].[userEventDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot1]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot2]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot3]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot4]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot5]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot6]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot7]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot8]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot9]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot10]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot11]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot12]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot13]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot14]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot15]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot16]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot17]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot18]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot19]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot20]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot21]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot22]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot23]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot24]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot25]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot26]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot27]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot28]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot29]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot30]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot31]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot32]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot33]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot34]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot35]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot36]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot37]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot38]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot39]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Number] ADD  DEFAULT ((0)) FOR [slot40]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Present] ADD  DEFAULT ((0)) FOR [reward1]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Present] ADD  DEFAULT ((0)) FOR [reward2]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Present] ADD  DEFAULT ((0)) FOR [reward3]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Present] ADD  DEFAULT ((0)) FOR [reward4]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Present] ADD  DEFAULT ((0)) FOR [reward5]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Present] ADD  DEFAULT ((0)) FOR [reward6]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Present] ADD  DEFAULT ((0)) FOR [reward7]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Present] ADD  DEFAULT ((0)) FOR [reward8]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Present] ADD  DEFAULT ((0)) FOR [reward9]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Present] ADD  DEFAULT ((0)) FOR [reward10]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Present] ADD  DEFAULT ((0)) FOR [reward11]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Present] ADD  DEFAULT ((0)) FOR [reward12]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Present] ADD  DEFAULT ((0)) FOR [reward13]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Present] ADD  DEFAULT ((0)) FOR [reward14]
GO
ALTER TABLE [dbo].[userEventPirateRoulette_Present] ADD  DEFAULT ((0)) FOR [reward15]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish1_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish1_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish2_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish2_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish3_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish3_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish4_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish4_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish5_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish5_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish6_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish6_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish7_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish7_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish8_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish8_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish9_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish9_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish10_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish10_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish11_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish11_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish12_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish12_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish13_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish13_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish14_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish14_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish15_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish15_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish16_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish16_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish17_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish17_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish18_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish18_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish19_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish19_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish20_type]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT ((0)) FOR [fish20_an]
GO
ALTER TABLE [dbo].[userFishDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userFriendBestDB] ADD  DEFAULT ((0)) FOR [flag]
GO
ALTER TABLE [dbo].[userFriendBestDB] ADD  DEFAULT ((0)) FOR [flagTime]
GO
ALTER TABLE [dbo].[userFriendBestDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userFriendDB] ADD  DEFAULT ((0)) FOR [sendCloverCnt]
GO
ALTER TABLE [dbo].[userFriendDB] ADD  DEFAULT ((0)) FOR [sendCloverDate]
GO
ALTER TABLE [dbo].[userFriendDB] ADD  DEFAULT ((0)) FOR [receiveCloverCnt]
GO
ALTER TABLE [dbo].[userFriendDB] ADD  DEFAULT ((0)) FOR [receiveCloverDate]
GO
ALTER TABLE [dbo].[userFriendDB] ADD  DEFAULT ((0)) FOR [receiveBCloverCnt]
GO
ALTER TABLE [dbo].[userFriendDB] ADD  DEFAULT ((0)) FOR [flag]
GO
ALTER TABLE [dbo].[userFriendDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userGameDB] ADD  DEFAULT ((0)) FOR [userState]
GO
ALTER TABLE [dbo].[userGameDB] ADD  DEFAULT ((0)) FOR [gameMoney]
GO
ALTER TABLE [dbo].[userGameDB] ADD  DEFAULT ((0)) FOR [playTime]
GO
ALTER TABLE [dbo].[userGameDB] ADD  DEFAULT ((0)) FOR [conn_count]
GO
ALTER TABLE [dbo].[userGameDB] ADD  DEFAULT ((0)) FOR [userLevel]
GO
ALTER TABLE [dbo].[userGameDB] ADD  DEFAULT ((0)) FOR [userEXP]
GO
ALTER TABLE [dbo].[userGameDB] ADD  DEFAULT ((0)) FOR [userFishingLevel]
GO
ALTER TABLE [dbo].[userGameDB] ADD  DEFAULT ((0)) FOR [userFishingEXP]
GO
ALTER TABLE [dbo].[userGameDB] ADD  DEFAULT ((0)) FOR [userExcavationLevel]
GO
ALTER TABLE [dbo].[userGameDB] ADD  DEFAULT ((0)) FOR [userExcavationEXP]
GO
ALTER TABLE [dbo].[userGameDB] ADD  DEFAULT ((0)) FOR [userHerocEXP]
GO
ALTER TABLE [dbo].[userGameDB] ADD  DEFAULT ((0)) FOR [userHerosEXP]
GO
ALTER TABLE [dbo].[userGameDB] ADD  DEFAULT ((0)) FOR [rencpoint]
GO
ALTER TABLE [dbo].[userGameDB] ADD  DEFAULT ((0)) FOR [renspoint]
GO
ALTER TABLE [dbo].[userGameDB] ADD  DEFAULT ((0)) FOR [relateLevel]
GO
ALTER TABLE [dbo].[userGameDB] ADD  DEFAULT ((0)) FOR [regionType]
GO
ALTER TABLE [dbo].[userGameDB] ADD  DEFAULT ((0)) FOR [refillData]
GO
ALTER TABLE [dbo].[userGameDB] ADD  DEFAULT (getdate()) FOR [connDate]
GO
ALTER TABLE [dbo].[userGameDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userGuildDB] ADD  DEFAULT ((0)) FOR [ranking]
GO
ALTER TABLE [dbo].[userGuildDB] ADD  DEFAULT ((0)) FOR [point]
GO
ALTER TABLE [dbo].[userGuildDB] ADD  DEFAULT ((0)) FOR [todaypoint]
GO
ALTER TABLE [dbo].[userGuildDB] ADD  DEFAULT ((0)) FOR [guildLevel]
GO
ALTER TABLE [dbo].[userGuildDB] ADD  DEFAULT ((0)) FOR [maxcount]
GO
ALTER TABLE [dbo].[userGuildDB] ADD  DEFAULT ((0)) FOR [membercount]
GO
ALTER TABLE [dbo].[userGuildDB] ADD  DEFAULT ((0)) FOR [today_vc]
GO
ALTER TABLE [dbo].[userGuildDB] ADD  DEFAULT ((0)) FOR [total_vc]
GO
ALTER TABLE [dbo].[userGuildDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userGuildHQDB] ADD  DEFAULT ((0)) FOR [ItemXZ]
GO
ALTER TABLE [dbo].[userGuildHQDB] ADD  DEFAULT ((0)) FOR [ItemY]
GO
ALTER TABLE [dbo].[userGuildHQDB] ADD  DEFAULT ((0)) FOR [ItemRotate]
GO
ALTER TABLE [dbo].[userGuildHQDB] ADD  DEFAULT ((0)) FOR [ItemDecoScore]
GO
ALTER TABLE [dbo].[userGuildHQDB] ADD  DEFAULT ((0)) FOR [ItemStatus]
GO
ALTER TABLE [dbo].[userGuildHQVerDB] ADD  DEFAULT ((0)) FOR [VerStatus]
GO
ALTER TABLE [dbo].[userGuildHQVerDB] ADD  DEFAULT ((0)) FOR [UptDate]
GO
ALTER TABLE [dbo].[userGuildHQVerDB] ADD  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[userGuildInfoDB] ADD  DEFAULT ((0)) FOR [guildJoinType]
GO
ALTER TABLE [dbo].[userGuildInfoDB] ADD  DEFAULT ((0)) FOR [msg]
GO
ALTER TABLE [dbo].[userGuildInfoDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userGuildInfoDB] ADD  DEFAULT ((0)) FOR [AttendDate]
GO
ALTER TABLE [dbo].[userGuildInfoDB] ADD  DEFAULT ((0)) FOR [GuildRankDate]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class1_type]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class1_posx]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class1_posy]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class2_type]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class2_posx]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class2_posy]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class3_type]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class3_posx]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class3_posy]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class4_type]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class4_posx]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class4_posy]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class5_type]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class5_posx]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class5_posy]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class6_type]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class6_posx]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class6_posy]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class7_type]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class7_posx]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class7_posy]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class8_type]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class8_posx]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class8_posy]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class9_type]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class9_posx]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class9_posy]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class10_type]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class10_posx]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [class10_posy]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT ((0)) FOR [lockType]
GO
ALTER TABLE [dbo].[userHqDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item1_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item1_code]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item2_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item2_code]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item3_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item3_code]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item4_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item4_code]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item5_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item5_code]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item6_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item6_code]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item7_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item7_code]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item8_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item8_code]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item9_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item9_code]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item10_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item10_code]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item11_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item11_code]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item12_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item12_code]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item13_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item13_code]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item14_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item14_code]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item15_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item15_code]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item16_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item16_code]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item17_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item17_code]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item18_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item18_code]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item19_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item19_code]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item20_type]
GO
ALTER TABLE [dbo].[userItemDB] ADD  DEFAULT ((0)) FOR [item20_code]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item1_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item1_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item1_value2]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item2_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item2_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item2_value2]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item3_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item3_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item3_value2]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item4_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item4_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item4_value2]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item5_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item5_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item5_value2]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item6_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item6_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item6_value2]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item7_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item7_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item7_value2]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item8_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item8_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item8_value2]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item9_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item9_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item9_value2]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item10_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item10_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item10_value2]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item11_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item11_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item11_value2]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item12_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item12_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item12_value2]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item13_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item13_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item13_value2]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item14_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item14_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item14_value2]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item15_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item15_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item15_value2]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item16_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item16_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item16_value2]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item17_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item17_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item17_value2]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item18_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item18_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item18_value2]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item19_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item19_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item19_value2]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item20_type]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item20_value1]
GO
ALTER TABLE [dbo].[userItemEtcDB] ADD  DEFAULT ((0)) FOR [item20_value2]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item1_type]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item1_reinforce]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item1_slotindex]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item1_tradetype]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item1_mcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item1_fcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item1_failexp]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item1_limitType]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item2_type]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item2_reinforce]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item2_slotindex]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item2_tradetype]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item2_mcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item2_fcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item2_failexp]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item2_limitType]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item3_type]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item3_reinforce]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item3_slotindex]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item3_tradetype]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item3_mcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item3_fcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item3_failexp]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item3_limitType]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item4_type]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item4_reinforce]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item4_slotindex]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item4_tradetype]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item4_mcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item4_fcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item4_failexp]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item4_limitType]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item5_type]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item5_reinforce]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item5_slotindex]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item5_tradetype]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item5_mcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item5_fcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item5_failexp]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item5_limitType]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item6_type]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item6_reinforce]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item6_slotindex]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item6_tradetype]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item6_mcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item6_fcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item6_failexp]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item6_limitType]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item7_type]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item7_reinforce]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item7_slotindex]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item7_tradetype]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item7_mcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item7_fcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item7_failexp]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item7_limitType]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item8_type]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item8_reinforce]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item8_slotindex]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item8_tradetype]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item8_mcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item8_fcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item8_failexp]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item8_limitType]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item9_type]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item9_reinforce]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item9_slotindex]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item9_tradetype]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item9_mcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item9_fcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item9_failexp]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item9_limitType]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item10_type]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item10_reinforce]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item10_slotindex]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item10_tradetype]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item10_mcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item10_fcustom]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item10_failexp]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT ((0)) FOR [item10_limitType]
GO
ALTER TABLE [dbo].[userItemExtraDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item1_type]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item1_class]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item1_limitType]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item2_type]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item2_class]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item2_limitType]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item3_type]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item3_class]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item3_limitType]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item4_type]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item4_class]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item4_limitType]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item5_type]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item5_class]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item5_limitType]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item6_type]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item6_class]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item6_limitType]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item7_type]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item7_class]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item7_limitType]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item8_type]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item8_class]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item8_limitType]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item9_type]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item9_class]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item9_limitType]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item10_type]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item10_class]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT ((0)) FOR [item10_limitType]
GO
ALTER TABLE [dbo].[userItemMedalDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal1_class]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal1_slot]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal1_period]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal2_class]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal2_slot]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal2_period]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal3_class]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal3_slot]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal3_period]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal4_class]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal4_slot]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal4_period]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal5_class]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal5_slot]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal5_period]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal6_class]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal6_slot]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal6_period]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal7_class]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal7_slot]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal7_period]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal8_class]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal8_slot]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal8_period]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal9_class]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal9_slot]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal9_period]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal10_class]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal10_slot]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT ((0)) FOR [medal10_period]
GO
ALTER TABLE [dbo].[userItemMedalExtendDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userLeagueAuthDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userLeagueInfoDB] ADD  DEFAULT ((0)) FOR [leagueIDX]
GO
ALTER TABLE [dbo].[userLeagueInfoDB] ADD  DEFAULT ((0)) FOR [bannerA]
GO
ALTER TABLE [dbo].[userLeagueInfoDB] ADD  DEFAULT ((0)) FOR [bannerB]
GO
ALTER TABLE [dbo].[userLeagueInfoDB] ADD  DEFAULT ((0)) FOR [modeType]
GO
ALTER TABLE [dbo].[userLeagueInfoDB] ADD  DEFAULT ((0)) FOR [maxcount]
GO
ALTER TABLE [dbo].[userLeagueInfoDB] ADD  DEFAULT ((0)) FOR [autoType]
GO
ALTER TABLE [dbo].[userLeagueInfoDB] ADD  DEFAULT ((0)) FOR [recruitDate]
GO
ALTER TABLE [dbo].[userLeagueInfoDB] ADD  DEFAULT ((0)) FOR [waitDate]
GO
ALTER TABLE [dbo].[userLeagueInfoDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userLeagueListDB] ADD  DEFAULT ((0)) FOR [leagueType]
GO
ALTER TABLE [dbo].[userLeagueListDB] ADD  DEFAULT ((0)) FOR [leagueState]
GO
ALTER TABLE [dbo].[userLeagueListDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userLeagueRewardCheerDB] ADD  DEFAULT ((0)) FOR [flag]
GO
ALTER TABLE [dbo].[userLeagueRewardDB] ADD  DEFAULT ((0)) FOR [currentRound]
GO
ALTER TABLE [dbo].[userLeagueRewardDB] ADD  DEFAULT ((0)) FOR [userFactionType]
GO
ALTER TABLE [dbo].[userLeagueRewardDB] ADD  DEFAULT ((0)) FOR [winnerFactionType]
GO
ALTER TABLE [dbo].[userLeagueRewardDB] ADD  DEFAULT ((0)) FOR [rewardPeso]
GO
ALTER TABLE [dbo].[userLeagueRewardDB] ADD  DEFAULT ((0)) FOR [factionRank]
GO
ALTER TABLE [dbo].[userLeagueRewardDB] ADD  DEFAULT ((0)) FOR [factionPoint]
GO
ALTER TABLE [dbo].[userLeagueRewardDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userLeagueRewardUserDB] ADD  DEFAULT ((0)) FOR [leagueIDX]
GO
ALTER TABLE [dbo].[userLeagueRewardUserDB] ADD  DEFAULT ((0)) FOR [roundnum]
GO
ALTER TABLE [dbo].[userLeagueRewardUserDB] ADD  DEFAULT ((0)) FOR [maxRound]
GO
ALTER TABLE [dbo].[userLeagueRewardUserDB] ADD  DEFAULT ((0)) FOR [presentCode1]
GO
ALTER TABLE [dbo].[userLeagueRewardUserDB] ADD  DEFAULT ((0)) FOR [presentCode2]
GO
ALTER TABLE [dbo].[userLeagueRewardUserDB] ADD  DEFAULT ((0)) FOR [presentCode3]
GO
ALTER TABLE [dbo].[userLeagueRewardUserDB] ADD  DEFAULT ((0)) FOR [presentCode4]
GO
ALTER TABLE [dbo].[userLeagueRewardUserDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [infoIDX]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType1_playDate]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType1_presentCode1]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType1_presentCode2]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType1_presentCode3]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType1_presentCode4]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType2_playDate]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType2_presentCode1]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType2_presentCode2]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType2_presentCode3]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType2_presentCode4]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType3_playDate]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType3_presentCode1]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType3_presentCode2]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType3_presentCode3]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType3_presentCode4]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType4_playDate]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType4_presentCode1]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType4_presentCode2]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType4_presentCode3]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType4_presentCode4]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType5_playDate]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType5_presentCode1]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType5_presentCode2]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType5_presentCode3]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType5_presentCode4]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType6_playDate]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType6_presentCode1]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType6_presentCode2]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType6_presentCode3]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType6_presentCode4]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType7_playDate]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType7_presentCode1]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType7_presentCode2]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType7_presentCode3]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType7_presentCode4]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType8_playDate]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType8_presentCode1]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType8_presentCode2]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType8_presentCode3]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType8_presentCode4]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType9_playDate]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType9_presentCode1]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType9_presentCode2]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType9_presentCode3]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType9_presentCode4]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType10_playDate]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType10_presentCode1]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType10_presentCode2]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType10_presentCode3]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType10_presentCode4]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType11_playDate]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType11_presentCode1]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType11_presentCode2]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType11_presentCode3]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT ((0)) FOR [roundType11_presentCode4]
GO
ALTER TABLE [dbo].[userLeagueRoundDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userLeagueTeamDB] ADD  DEFAULT ((0)) FOR [leagueStartPosition]
GO
ALTER TABLE [dbo].[userLeagueTeamDB] ADD  DEFAULT ((0)) FOR [leaguePosition]
GO
ALTER TABLE [dbo].[userLeagueTeamDB] ADD  DEFAULT ((0)) FOR [maxcount]
GO
ALTER TABLE [dbo].[userLeagueTeamDB] ADD  DEFAULT ((0)) FOR [cheerPoint]
GO
ALTER TABLE [dbo].[userLeagueTeamDB] ADD  DEFAULT ((0)) FOR [currentRound]
GO
ALTER TABLE [dbo].[userLeagueTeamDB] ADD  DEFAULT ((0)) FOR [factionPoint]
GO
ALTER TABLE [dbo].[userLeagueTeamDB] ADD  DEFAULT ((0)) FOR [factionType]
GO
ALTER TABLE [dbo].[userLeagueTeamDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userLeagueTeamMemberDB] ADD  DEFAULT ((0)) FOR [leagueIDX]
GO
ALTER TABLE [dbo].[userLeagueTeamMemberDB] ADD  DEFAULT ((0)) FOR [teamIDX]
GO
ALTER TABLE [dbo].[userLeagueTeamMemberDB] ADD  DEFAULT ((0)) FOR [joinType]
GO
ALTER TABLE [dbo].[userLeagueTeamMemberDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userLeagueWinnerHistoryDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userLeagueWinnerInfoDB] ADD  DEFAULT ((0)) FOR [historyIDX]
GO
ALTER TABLE [dbo].[userLeagueWinnerInfoDB] ADD  DEFAULT ((0)) FOR [teamIDX]
GO
ALTER TABLE [dbo].[userLeagueWinnerInfoDB] ADD  DEFAULT ((0)) FOR [classType]
GO
ALTER TABLE [dbo].[userLeagueWinnerInfoDB] ADD  DEFAULT ((0)) FOR [classGender]
GO
ALTER TABLE [dbo].[userLeagueWinnerInfoDB] ADD  DEFAULT ((0)) FOR [classFace]
GO
ALTER TABLE [dbo].[userLeagueWinnerInfoDB] ADD  DEFAULT ((0)) FOR [classHair]
GO
ALTER TABLE [dbo].[userLeagueWinnerInfoDB] ADD  DEFAULT ((0)) FOR [classSkinColor]
GO
ALTER TABLE [dbo].[userLeagueWinnerInfoDB] ADD  DEFAULT ((0)) FOR [classHairColor]
GO
ALTER TABLE [dbo].[userLeagueWinnerInfoDB] ADD  DEFAULT ((0)) FOR [classUnderwear]
GO
ALTER TABLE [dbo].[userLeagueWinnerInfoDB] ADD  DEFAULT ((0)) FOR [classGear1]
GO
ALTER TABLE [dbo].[userLeagueWinnerInfoDB] ADD  DEFAULT ((0)) FOR [classGear2]
GO
ALTER TABLE [dbo].[userLeagueWinnerInfoDB] ADD  DEFAULT ((0)) FOR [classGear3]
GO
ALTER TABLE [dbo].[userLeagueWinnerInfoDB] ADD  DEFAULT ((0)) FOR [classGear4]
GO
ALTER TABLE [dbo].[userLeagueWinnerInfoDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userLoginDB] ADD  DEFAULT ('111111111111111') FOR [encodeKey]
GO
ALTER TABLE [dbo].[userLoginDB] ADD  DEFAULT ((0)) FOR [gameServerID]
GO
ALTER TABLE [dbo].[userLoginDB] ADD  DEFAULT (getdate()) FOR [connDate]
GO
ALTER TABLE [dbo].[userMemberDB] ADD  DEFAULT ((100)) FOR [userType]
GO
ALTER TABLE [dbo].[userMemberDB] ADD  DEFAULT ((1)) FOR [joinType]
GO
ALTER TABLE [dbo].[userMemberDB] ADD  DEFAULT ((0)) FOR [eventType]
GO
ALTER TABLE [dbo].[userMemberDB] ADD  DEFAULT ((0)) FOR [cpType]
GO
ALTER TABLE [dbo].[userMemberDB] ADD  DEFAULT ((0)) FOR [limitType]
GO
ALTER TABLE [dbo].[userMemberDB] ADD  DEFAULT ((0)) FOR [limitDate]
GO
ALTER TABLE [dbo].[userMemberDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userMissionDB] ADD  DEFAULT ((1)) FOR [MissionStatus]
GO
ALTER TABLE [dbo].[userMissionDB] ADD  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[userMoneyDB] ADD  DEFAULT ((0)) FOR [realCash]
GO
ALTER TABLE [dbo].[userMoneyDB] ADD  DEFAULT ((0)) FOR [bonusCash]
GO
ALTER TABLE [dbo].[userMoneyDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userNameDB] ADD  DEFAULT ((0)) FOR [realType]
GO
ALTER TABLE [dbo].[userNameDB] ADD  DEFAULT ('J') FOR [certType]
GO
ALTER TABLE [dbo].[userNameDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userPersonalHQDB] ADD  DEFAULT ((0)) FOR [ItemXZ]
GO
ALTER TABLE [dbo].[userPersonalHQDB] ADD  DEFAULT ((0)) FOR [ItemY]
GO
ALTER TABLE [dbo].[userPersonalHQDB] ADD  DEFAULT ((0)) FOR [ItemRotate]
GO
ALTER TABLE [dbo].[userPersonalHQDB] ADD  DEFAULT ((0)) FOR [ItemDecoScore]
GO
ALTER TABLE [dbo].[userPersonalHQDB] ADD  DEFAULT ((0)) FOR [ItemStatus]
GO
ALTER TABLE [dbo].[userPetDB] ADD  DEFAULT ((0)) FOR [petCode]
GO
ALTER TABLE [dbo].[userPetDB] ADD  DEFAULT ((0)) FOR [petRank]
GO
ALTER TABLE [dbo].[userPetDB] ADD  DEFAULT ((0)) FOR [petLevel]
GO
ALTER TABLE [dbo].[userPetDB] ADD  DEFAULT ((0)) FOR [petExp]
GO
ALTER TABLE [dbo].[userPetDB] ADD  DEFAULT ((0)) FOR [petEquip]
GO
ALTER TABLE [dbo].[userPetDB] ADD  DEFAULT ((1)) FOR [petStatus]
GO
ALTER TABLE [dbo].[userPetDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece1_type]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece1_value1]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece1_value2]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece1_cnt]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece2_type]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece2_value1]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece2_value2]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece2_cnt]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece3_type]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece3_value1]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece3_value2]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece3_cnt]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece4_type]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece4_value1]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece4_value2]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece4_cnt]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece5_type]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece5_value1]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece5_value2]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece5_cnt]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece6_type]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece6_value1]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece6_value2]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece6_cnt]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece7_type]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece7_value1]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece7_value2]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece7_cnt]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece8_type]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece8_value1]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece8_value2]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece8_cnt]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece9_type]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece9_value1]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece9_value2]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece9_cnt]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece10_type]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece10_value1]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece10_value2]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT ((0)) FOR [piece10_cnt]
GO
ALTER TABLE [dbo].[userPieceDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userPopStoreDB] ADD  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[userPresentDB] ADD  DEFAULT ((0)) FOR [presentType]
GO
ALTER TABLE [dbo].[userPresentDB] ADD  DEFAULT ((0)) FOR [value1]
GO
ALTER TABLE [dbo].[userPresentDB] ADD  DEFAULT ((0)) FOR [value2]
GO
ALTER TABLE [dbo].[userPresentDB] ADD  DEFAULT ((0)) FOR [value3]
GO
ALTER TABLE [dbo].[userPresentDB] ADD  DEFAULT ((0)) FOR [value4]
GO
ALTER TABLE [dbo].[userPresentDB] ADD  DEFAULT ((0)) FOR [msgType]
GO
ALTER TABLE [dbo].[userPresentDB] ADD  DEFAULT ((0)) FOR [flag]
GO
ALTER TABLE [dbo].[userPresentDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest1_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest1_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest2_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest2_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest3_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest3_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest4_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest4_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest5_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest5_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest6_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest6_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest7_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest7_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest8_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest8_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest9_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest9_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest10_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest10_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest11_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest11_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest12_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest12_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest13_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest13_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest14_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest14_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest15_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest15_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest16_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest16_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest17_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest17_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest18_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest18_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest19_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest19_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest20_type]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT ((0)) FOR [quest20_time]
GO
ALTER TABLE [dbo].[userQuestCompleteDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest1_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest1_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest1_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest1_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest2_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest2_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest2_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest2_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest3_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest3_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest3_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest3_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest4_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest4_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest4_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest4_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest5_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest5_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest5_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest5_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest6_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest6_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest6_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest6_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest7_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest7_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest7_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest7_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest8_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest8_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest8_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest8_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest9_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest9_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest9_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest9_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest10_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest10_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest10_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest10_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest11_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest11_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest11_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest11_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest12_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest12_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest12_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest12_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest13_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest13_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest13_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest13_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest14_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest14_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest14_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest14_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest15_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest15_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest15_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest15_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest16_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest16_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest16_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest16_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest17_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest17_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest17_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest17_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest18_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest18_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest18_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest18_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest19_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest19_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest19_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest19_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest20_type]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest20_value1]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest20_value2]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT ((0)) FOR [quest20_time]
GO
ALTER TABLE [dbo].[userQuestDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userRankingDB] ADD  DEFAULT ((0)) FOR [class]
GO
ALTER TABLE [dbo].[userRankingDB] ADD  DEFAULT ((0)) FOR [battle]
GO
ALTER TABLE [dbo].[userRankingDB] ADD  DEFAULT ((0)) FOR [training]
GO
ALTER TABLE [dbo].[userRankingDB] ADD  DEFAULT ((0)) FOR [award]
GO
ALTER TABLE [dbo].[userRankingDB] ADD  DEFAULT ((0)) FOR [medal]
GO
ALTER TABLE [dbo].[userRankingDB] ADD  DEFAULT ((0)) FOR [tester]
GO
ALTER TABLE [dbo].[userRankingDB] ADD  DEFAULT ((0)) FOR [region]
GO
ALTER TABLE [dbo].[userRankingDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [awardLevel]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [expert]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award1_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award1_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award1_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award2_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award2_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award2_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award3_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award3_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award3_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award4_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award4_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award4_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award5_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award5_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award5_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award6_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award6_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award6_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award7_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award7_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award7_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award8_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award8_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award8_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award9_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award9_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award9_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award10_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award10_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award10_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award11_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award11_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award11_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award12_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award12_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award12_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award13_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award13_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award13_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award14_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award14_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award14_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award15_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award15_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award15_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award16_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award16_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award16_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award17_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award17_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award17_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award18_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award18_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award18_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award19_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award19_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award19_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award20_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award20_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award20_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award21_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award21_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award21_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award22_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award22_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award22_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award23_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award23_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award23_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award24_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award24_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award24_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award25_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award25_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award25_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award26_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award26_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award26_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award27_prev]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award27_now]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT ((0)) FOR [award27_point]
GO
ALTER TABLE [dbo].[userRankingDB_award] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userRankingDB_hero] ADD  DEFAULT ((0)) FOR [title]
GO
ALTER TABLE [dbo].[userRankingDB_hero] ADD  DEFAULT ((0)) FOR [daily]
GO
ALTER TABLE [dbo].[userRankingDB_hero] ADD  DEFAULT ((0)) FOR [dailyB]
GO
ALTER TABLE [dbo].[userRankingDB_hero] ADD  DEFAULT ((0)) FOR [season1]
GO
ALTER TABLE [dbo].[userRankingDB_hero] ADD  DEFAULT ((0)) FOR [season2]
GO
ALTER TABLE [dbo].[userRankingDB_hero] ADD  DEFAULT ((0)) FOR [season3]
GO
ALTER TABLE [dbo].[userRankingDB_hero] ADD  DEFAULT ((0)) FOR [season4]
GO
ALTER TABLE [dbo].[userRankingDB_hero] ADD  DEFAULT ((0)) FOR [season5]
GO
ALTER TABLE [dbo].[userRankingDB_hero] ADD  DEFAULT ((0)) FOR [season6]
GO
ALTER TABLE [dbo].[userRankingDB_hero] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userRankingDB_medal] ADD  DEFAULT ((0)) FOR [medalLevel]
GO
ALTER TABLE [dbo].[userRankingDB_medal] ADD  DEFAULT ((0)) FOR [expert]
GO
ALTER TABLE [dbo].[userRankingDB_medal] ADD  DEFAULT ((0)) FOR [ranking_prev]
GO
ALTER TABLE [dbo].[userRankingDB_medal] ADD  DEFAULT ((0)) FOR [ranking_now]
GO
ALTER TABLE [dbo].[userRankingDB_medal] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userRecordBattleDB] ADD  DEFAULT ((0)) FOR [type1_win]
GO
ALTER TABLE [dbo].[userRecordBattleDB] ADD  DEFAULT ((0)) FOR [type1_lose]
GO
ALTER TABLE [dbo].[userRecordBattleDB] ADD  DEFAULT ((0)) FOR [type1_kill]
GO
ALTER TABLE [dbo].[userRecordBattleDB] ADD  DEFAULT ((0)) FOR [type1_death]
GO
ALTER TABLE [dbo].[userRecordBattleDB] ADD  DEFAULT ((0)) FOR [type2_win]
GO
ALTER TABLE [dbo].[userRecordBattleDB] ADD  DEFAULT ((0)) FOR [type2_lose]
GO
ALTER TABLE [dbo].[userRecordBattleDB] ADD  DEFAULT ((0)) FOR [type2_kill]
GO
ALTER TABLE [dbo].[userRecordBattleDB] ADD  DEFAULT ((0)) FOR [type2_death]
GO
ALTER TABLE [dbo].[userRecordBattleDB] ADD  DEFAULT ((0)) FOR [type3_win]
GO
ALTER TABLE [dbo].[userRecordBattleDB] ADD  DEFAULT ((0)) FOR [type3_lose]
GO
ALTER TABLE [dbo].[userRecordBattleDB] ADD  DEFAULT ((0)) FOR [type3_kill]
GO
ALTER TABLE [dbo].[userRecordBattleDB] ADD  DEFAULT ((0)) FOR [type3_death]
GO
ALTER TABLE [dbo].[userRecordBattleDB] ADD  DEFAULT ((0)) FOR [type4_win]
GO
ALTER TABLE [dbo].[userRecordBattleDB] ADD  DEFAULT ((0)) FOR [type4_lose]
GO
ALTER TABLE [dbo].[userRecordBattleDB] ADD  DEFAULT ((0)) FOR [type4_kill]
GO
ALTER TABLE [dbo].[userRecordBattleDB] ADD  DEFAULT ((0)) FOR [type4_death]
GO
ALTER TABLE [dbo].[userRecordBattleDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userRecordGuildDB] ADD  DEFAULT ((0)) FOR [type1_win]
GO
ALTER TABLE [dbo].[userRecordGuildDB] ADD  DEFAULT ((0)) FOR [type1_lose]
GO
ALTER TABLE [dbo].[userRecordGuildDB] ADD  DEFAULT ((0)) FOR [type1_kill]
GO
ALTER TABLE [dbo].[userRecordGuildDB] ADD  DEFAULT ((0)) FOR [type1_death]
GO
ALTER TABLE [dbo].[userRecordGuildDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userRegionDB] ADD  DEFAULT ((0)) FOR [rt1point]
GO
ALTER TABLE [dbo].[userRegionDB] ADD  DEFAULT ((0)) FOR [rt1point_bonus]
GO
ALTER TABLE [dbo].[userRegionDB] ADD  DEFAULT ((0)) FOR [rt1point_today]
GO
ALTER TABLE [dbo].[userRegionDB] ADD  DEFAULT ((0)) FOR [rt2point]
GO
ALTER TABLE [dbo].[userRegionDB] ADD  DEFAULT ((0)) FOR [rt2point_bonus]
GO
ALTER TABLE [dbo].[userRegionDB] ADD  DEFAULT ((0)) FOR [rt2point_today]
GO
ALTER TABLE [dbo].[userRegionDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userRegionDB_compen] ADD  DEFAULT ((0)) FOR [rt1point]
GO
ALTER TABLE [dbo].[userRegionDB_compen] ADD  DEFAULT ((0)) FOR [rt1point_bonus]
GO
ALTER TABLE [dbo].[userRegionDB_compen] ADD  DEFAULT ((0)) FOR [rt1count]
GO
ALTER TABLE [dbo].[userRegionDB_compen] ADD  DEFAULT ((0)) FOR [rt2point]
GO
ALTER TABLE [dbo].[userRegionDB_compen] ADD  DEFAULT ((0)) FOR [rt2point_bonus]
GO
ALTER TABLE [dbo].[userRegionDB_compen] ADD  DEFAULT ((0)) FOR [rt2count]
GO
ALTER TABLE [dbo].[userRegionDB_compen] ADD  DEFAULT ((0)) FOR [regionType]
GO
ALTER TABLE [dbo].[userRegionDB_compen] ADD  DEFAULT ((0)) FOR [renspoint]
GO
ALTER TABLE [dbo].[userRegionDB_compen] ADD  DEFAULT ((0)) FOR [regionRanking]
GO
ALTER TABLE [dbo].[userRegionDB_compen] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userRegionDB_history] ADD  DEFAULT ((0)) FOR [point]
GO
ALTER TABLE [dbo].[userRegionDB_history] ADD  DEFAULT ((0)) FOR [point_bonus]
GO
ALTER TABLE [dbo].[userRegionDB_history] ADD  DEFAULT ((0)) FOR [membercount]
GO
ALTER TABLE [dbo].[userRegionDB_history] ADD  DEFAULT ((0)) FOR [regionType]
GO
ALTER TABLE [dbo].[userRegionDB_history] ADD  DEFAULT ((0)) FOR [season]
GO
ALTER TABLE [dbo].[userRegionDB_history] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userRelativeLevelDB] ADD  DEFAULT ((0)) FOR [weekend_BackupLevel]
GO
ALTER TABLE [dbo].[userRelativeLevelDB] ADD  DEFAULT ((0)) FOR [weekend_BackupExp]
GO
ALTER TABLE [dbo].[userRelativeLevelDB] ADD  DEFAULT ((0)) FOR [init_time]
GO
ALTER TABLE [dbo].[userRelativeLevelDB] ADD  DEFAULT ((0)) FOR [reward_State]
GO
ALTER TABLE [dbo].[userRelativeLevelDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userSBoxDB] ADD  DEFAULT ((0)) FOR [presentType]
GO
ALTER TABLE [dbo].[userSBoxDB] ADD  DEFAULT ((0)) FOR [value1]
GO
ALTER TABLE [dbo].[userSBoxDB] ADD  DEFAULT ((0)) FOR [value2]
GO
ALTER TABLE [dbo].[userSBoxDB] ADD  DEFAULT ((0)) FOR [amount]
GO
ALTER TABLE [dbo].[userSBoxDB] ADD  DEFAULT ((0)) FOR [flag]
GO
ALTER TABLE [dbo].[userSBoxDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[userSpentGoldDB] ADD  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[userSpRankDB] ADD  DEFAULT ((0)) FOR [SpRank]
GO
ALTER TABLE [dbo].[userSpRankDB] ADD  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[userTitleDB] ADD  DEFAULT ((1)) FOR [TitleLevel]
GO
ALTER TABLE [dbo].[userTitleDB] ADD  DEFAULT ((0)) FOR [TitlePremium]
GO
ALTER TABLE [dbo].[userTitleDB] ADD  DEFAULT ((0)) FOR [TitleEquip]
GO
ALTER TABLE [dbo].[userTitleDB] ADD  DEFAULT ((0)) FOR [TitleStatus]
GO
ALTER TABLE [dbo].[userTitleDB] ADD  DEFAULT ((0)) FOR [UpdDate]
GO
ALTER TABLE [dbo].[userTitleDB] ADD  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[userTradeDB] ADD  DEFAULT ((0)) FOR [itemType]
GO
ALTER TABLE [dbo].[userTradeDB] ADD  DEFAULT ((0)) FOR [value1]
GO
ALTER TABLE [dbo].[userTradeDB] ADD  DEFAULT ((0)) FOR [value2]
GO
ALTER TABLE [dbo].[userTradeDB] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[userTradeDB] ADD  DEFAULT ((0)) FOR [mcustom]
GO
ALTER TABLE [dbo].[userTradeDB] ADD  DEFAULT ((0)) FOR [fcustom]
GO
ALTER TABLE [dbo].[userTradeDB] ADD  DEFAULT ((0)) FOR [periodDate]
GO
ALTER TABLE [dbo].[userTradeDB] ADD  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[WebBlock] ADD  DEFAULT (getdate()) FOR [BlockDate]
GO
ALTER TABLE [dbo].[WebBlock] ADD  DEFAULT (NULL) FOR [EndDate]
GO
ALTER TABLE [dbo].[WebConnectLog] ADD  DEFAULT (getdate()) FOR [LogDate]
GO
ALTER TABLE [dbo].[WebCoupon] ADD  DEFAULT ((0)) FOR [Used]
GO
ALTER TABLE [dbo].[WebEventLog] ADD  DEFAULT (getdate()) FOR [CompleteDate]
GO
ALTER TABLE [dbo].[WebEventValentineGoalLog] ADD  DEFAULT (getdate()) FOR [CompleteDate]
GO
ALTER TABLE [dbo].[WebEventValentineRanking] ADD  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[WebHardwareLog] ADD  DEFAULT (getdate()) FOR [Time]
GO
ALTER TABLE [dbo].[WebLogin] ADD  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[WebLogin] ADD  DEFAULT ((0)) FOR [Verify]
GO
ALTER TABLE [dbo].[WebLogin] ADD  DEFAULT ((0)) FOR [Banned]
GO
ALTER TABLE [dbo].[WebLogin_Confirm] ADD  DEFAULT (getdate()) FOR [SendDate]
GO
ALTER TABLE [dbo].[WebNotice] ADD  DEFAULT (getdate()) FOR [NoticeDate]
GO
ALTER TABLE [dbo].[WebNotice] ADD  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[WebQuestUser] ADD  DEFAULT (getdate()) FOR [CompleteDate]
GO
ALTER TABLE [dbo].[WebRecovery] ADD  DEFAULT (getdate()) FOR [SendDate]
GO
ALTER TABLE [dbo].[WebRouletteMission] ADD  DEFAULT ((0)) FOR [Flag]
GO
ALTER TABLE [dbo].[WebRoulettePayLog] ADD  DEFAULT (getdate()) FOR [PaidDate]
GO
ALTER TABLE [dbo].[WebRouletteRewardLog] ADD  DEFAULT (getdate()) FOR [RewardDate]
GO
ALTER TABLE [dbo].[WebRouletteRewardLog] ADD  DEFAULT ((0)) FOR [Flag]
GO
ALTER TABLE [dbo].[WebRouletteSPMissionLog] ADD  DEFAULT (getdate()) FOR [CompleteDate]
GO
ALTER TABLE [dbo].[WebRouletteUserItemDeleteLog] ADD  DEFAULT (getdate()) FOR [DeletedDate]
GO
ALTER TABLE [dbo].[WebRouletteUserLucky] ADD  DEFAULT ((0)) FOR [Lucky]
GO
ALTER TABLE [dbo].[WebRouletteUserMission] ADD  DEFAULT (getdate()) FOR [CompleteDate]
GO
ALTER TABLE [dbo].[WebTicket] ADD  DEFAULT (getdate()) FOR [TicketDate]
GO
ALTER TABLE [dbo].[WebTicket] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[WebTicket] ADD  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[WebTicketDetail] ADD  DEFAULT (getdate()) FOR [ReplyDate]
GO
/****** Object:  StoredProcedure [dbo].[AGENT_RANKING_AWARD]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AGENT_RANKING_AWARD]

AS

	SET NOCOUNT ON;

	DECLARE @strSQL			VARCHAR(1000)
	DECLARE @i				TINYINT
	DECLARE @minPoint		INT
	
	SET @i = 1
	SET @minPoint = 1000;

	IF OBJECT_ID('tempdb..#TBL_RANKING_AWARD_TEMP') IS NOT NULL
	BEGIN
		DROP TABLE #TBL_RANKING_AWARD_TEMP;
	END

	CREATE TABLE #TBL_RANKING_AWARD_TEMP
	(
		accountIDX		INT,
		awardType		INT,
		point			INT
	);
	CREATE CLUSTERED INDEX CL_TBL_RANKING_AWARD_TEMP ON dbo.#TBL_RANKING_AWARD_TEMP (awardType);

	-- TBL_RANKING_AWARD 테이블 백업
	SELECT accountIDX, awardType, nowRanking
	  INTO #TBL_RANKING_AWARD_BACKUP
	  FROM dbo.TBL_RANKING_AWARD WITH (NOLOCK);

	-- TBL_RANKING_AWARD 삭제 & 생성
	IF EXISTS(SELECT * FROM information_schema.tables WHERE table_name = 'TBL_RANKING_AWARD')
	BEGIN
		DROP TABLE TBL_RANKING_AWARD;
	END

	-- 인덱스 조정 할 것.
	CREATE TABLE dbo.TBL_RANKING_AWARD
	(
		accountIDX		INT,
		awardType		INT,
		prevRanking		INT,
		nowRanking		INT,
		point			INT
	);
	CREATE CLUSTERED INDEX CL_TBL_RANKING_AWARD ON dbo.TBL_RANKING_AWARD (nowRanking);
	CREATE INDEX NC_TBL_RANKING_AWARD_accountIDX ON dbo.TBL_RANKING_AWARD (accountIDX);
	CREATE INDEX NC_TBL_RANKING_AWARD_awardType ON dbo.TBL_RANKING_AWARD (awardType);

	WHILE (@i <= 10)
	BEGIN
		SET @strSQL = ''
		SET @strSQL = @strSQL + ' INSERT INTO #TBL_RANKING_AWARD_TEMP (accountIDX, awardType, point) '
		SET @strSQL = @strSQL + ' SELECT A.accountIDX, A.award' + CAST(@i AS VARCHAR(4)) + '_type, A.award' + CAST(@i AS VARCHAR(4)) + '_point '
		SET @strSQL = @strSQL + '   FROM dbo.userAwardDB A WITH (NOLOCK) '
		SET @strSQL = @strSQL + '   left JOIN dbo.userMemberDB B WITH (NOLOCK) '
		SET @strSQL = @strSQL + '     ON A.accountIDX = B.accountIDX '
		SET @strSQL = @strSQL + '  WHERE A.award' + CAST(@i AS VARCHAR(4)) + '_type > 0 AND A.award' + CAST(@i AS VARCHAR(4)) + '_point > ' + CAST(@minPoint AS VARCHAR(4)) + ' '
		SET @strSQL = @strSQL + '    AND B.userType = 100 AND (B.limitDate < GETDATE() OR limitType <> 100) '

		EXEC (@strSQL)
		SET @i = @i + 1
	END

	SET @i = 1
	WHILE (@i <= 27)
	BEGIN
		INSERT INTO dbo.TBL_RANKING_AWARD
		SELECT TOP 50000 accountIDX, awardType, 0, RANK() OVER(ORDER BY point DESC) AS 'nowRanking', point
		  FROM #TBL_RANKING_AWARD_TEMP WITH (NOLOCK)
		 WHERE awardType = @i;

		SET @i = @i + 1
	END

	-- 이전 랭킹 업데이트
	UPDATE AR
	   SET prevRanking = BR.nowRanking
	  FROM (
		SELECT accountIDX, awardType, nowRanking
		  FROM #TBL_RANKING_AWARD_BACKUP WITH (NOLOCK)
	  ) AS BR
	  JOIN dbo.TBL_RANKING_AWARD AR
	    ON AR.accountIDX = BR.accountIDX AND AR.awardType = BR.awardType;

	DROP TABLE #TBL_RANKING_AWARD_TEMP;
	DROP TABLE #TBL_RANKING_AWARD_BACKUP;
GO
/****** Object:  StoredProcedure [dbo].[AGENT_RANKING_CLASS]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AGENT_RANKING_CLASS]

AS

	SET NOCOUNT ON;

	DECLARE @strSQL			VARCHAR(1000)
	DECLARE @i				TINYINT
	DECLARE @minLevel		INT
	
	SET @i = 1
	SET @minLevel = 10;

	IF EXISTS(SELECT * FROM information_schema.tables WHERE table_name = 'userRankingDB_class_temp')
	BEGIN
		DROP TABLE userRankingDB_class_temp;
	END

	IF EXISTS(SELECT * FROM information_schema.tables WHERE table_name = 'userRankingDB_class_backup')
	BEGIN
		DROP TABLE userRankingDB_class_backup;
	END

	CREATE TABLE userRankingDB_class_temp
	(
		accountIDX		INT,
		classType		INT,
		userLevel		INT,
		expert			INT
	);
	CREATE CLUSTERED INDEX CL_userRankingDB_class_temp ON dbo.userRankingDB_class_temp (classType);
	CREATE INDEX NC_userRankingDB_class_temp ON dbo.userRankingDB_class_temp (userLevel, expert);

	-- userRankingDB_class 테이블 백업
	SELECT accountIDX, classType, nowRanking
	  INTO dbo.userRankingDB_class_backup
	  FROM dbo.userRankingDB_class WITH (NOLOCK);

	-- userRankingDB_class 삭제 & 생성
	IF EXISTS(SELECT * FROM information_schema.tables WHERE table_name = 'userRankingDB_class')
	BEGIN
		DROP TABLE userRankingDB_class;
	END

	-- 인덱스 조정 할 것.
	CREATE TABLE userRankingDB_class
	(
		accountIDX		INT,
		classType		INT,
		prevRanking		INT,
		nowRanking		INT,
		userLevel		INT,
		expert			INT
	);
	CREATE CLUSTERED INDEX CL_userRankingDB_class ON dbo.userRankingDB_class (nowRanking);
	CREATE INDEX NC_userRankingDB_class_accountIDX ON dbo.userRankingDB_class (accountIDX);
	CREATE INDEX NC_userRankingDB_class_classType ON dbo.userRankingDB_class (classType);


	WHILE (@i <= 10)
	BEGIN
		SET @strSQL = ''
		SET @strSQL = @strSQL + ' INSERT INTO userRankingDB_class_temp (accountIDX, classType, userLevel, expert) '
		SET @strSQL = @strSQL + ' SELECT A.accountIDX, A.class' + CAST(@i AS VARCHAR(4)) + '_type, A.class' + CAST(@i AS VARCHAR(4)) + '_level, A.class' + CAST(@i AS VARCHAR(4)) + '_expert '
		SET @strSQL = @strSQL + '   FROM dbo.userClassDB A WITH(NOLOCK) '
		SET @strSQL = @strSQL + '   JOIN dbo.userMemberDB B WITH (NOLOCK) '
		SET @strSQL = @strSQL + '     ON A.accountIDX = B.accountIDX '
		SET @strSQL = @strSQL + '  WHERE (A.class' + CAST(@i AS VARCHAR(4)) + '_type > 0 AND A.class' + CAST(@i AS VARCHAR(4)) + '_type < 1000) AND A.class' + CAST(@i AS VARCHAR(4)) + '_level >= ' + CAST(@minLevel AS VARCHAR(4)) + ' '
		SET @strSQL = @strSQL + '    AND B.userType = 100 AND (B.limitDate < GETDATE() OR limitType <> 100); '

		EXEC (@strSQL)
		SET @i = @i + 1
	END



	DECLARE selecHero CURSOR
	FOR
	SELECT DISTINCT idx FROM dbo.define_class WITH (NOLOCK)
	FOR READ ONLY	

	OPEN selecHero

	DECLARE @HeroIDX INT
	FETCH NEXT FROM selecHero INTO @HeroIDX

	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO dbo.userRankingDB_class
		SELECT TOP 25000 accountIDX, classType, 0, RANK() OVER(ORDER BY userLevel DESC, expert DESC) AS 'nowRanking', userLevel, expert
		  FROM userRankingDB_class_temp WITH (NOLOCK)
		 WHERE classType = @HeroIDX;

		FETCH NEXT FROM selecHero INTO @HeroIDX
	END

	CLOSE selecHero
	DEALLOCATE selecHero


	UPDATE a SET prevRanking = b.nowRanking
	FROM (
		SELECT accountIDX, classType, nowRanking FROM userRankingDB_class_backup
	) b INNER JOIN userRankingDB_class a ON a.accountIDX = b.accountIDX and a.classType = b.classType;

	DROP TABLE userRankingDB_class_temp;
GO
/****** Object:  StoredProcedure [dbo].[AGENT_RANKING_FACTION]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AGENT_RANKING_FACTION]

AS

SET NOCOUNT ON

	INSERT INTO userRankingDB (accountIDX)
	SELECT accountIDX
	  FROM dbo.userGameDB WITH(NOLOCK)
	 WHERE accountIDX NOT IN (
		SELECT accountIDX
		  FROM dbo.userRankingDB WITH(NOLOCK)
		)
	   AND renspoint > 0

	IF EXISTS(SELECT table_name FROM information_schema.tables WHERE table_name = 'userRankingDB_temp')
	DROP TABLE userRankingDB_temp

	SELECT a.accountIDX, RANK() OVER(ORDER BY a.renspoint DESC) AS 'rank'
	  INTO userRankingDB_temp 
	  FROM (
		SELECT accountIDX, renspoint
		  FROM dbo.userGameDB WITH(NOLOCK)
		 WHERE renspoint > 0
	) a, (
		SELECT accountIDX
		  FROM dbo.userMemberDB WITH(NOLOCK) 
		 WHERE userType > 20
	) b 
	 WHERE a.accountIDX = b.accountIDX

	UPDATE a
	   SET region = b.rank 
	  FROM (
		SELECT accountIDX, rank
		  FROM userRankingDB_temp WITH(NOLOCK)
	) b
	 INNER JOIN userRankingDB a
	    ON a.accountIDX = b.accountIDX

	DROP TABLE userRankingDB_temp
GO
/****** Object:  StoredProcedure [dbo].[AGENT_RANKING_LADDER_DAILY]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AGENT_RANKING_LADDER_DAILY]

AS

SET NOCOUNT ON

UPDATE dbo.userRankingDB_hero
   SET title=0,
	   daily=0
 WHERE daily > 0

IF EXISTS(SELECT table_name FROM information_schema.tables WHERE table_name = 'userRankingDB_temp')
DROP TABLE userRankingDB_temp

SELECT a.accountIDX, ROW_NUMBER() OVER(ORDER BY a.ladderEXP DESC, a.accountIDX ASC) AS 'rank' 
  INTO userRankingDB_temp 
  FROM (
	SELECT c.accountIDX, (c.userHerocEXP + c.userHerosEXP) * ((d.type3_win/30) + 1) / ((d.type3_lose/10) + 1) AS 'ladderEXP' 
	  FROM dbo.userGameDB c WITH(NOLOCK)
	 INNER JOIN dbo.userRecordBattleDB d WITH(NOLOCK)
	    ON c.accountIDX=d.accountIDX
	 WHERE c.userHerocEXP + c.userHerosEXP > 30
) a, (
	SELECT accountIDX
	  FROM dbo.userMemberDB WITH(NOLOCK) 
	 WHERE userType > 20 
) b
 WHERE a.accountIDX = b.accountIDX

INSERT INTO dbo.userRankingDB_hero (
	accountIDX, title, daily, dailyB, season1, season2, season3, season4, season5, season6, regDate
)
SELECT accountIDX, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE()
  FROM userRankingDB_temp WITH(NOLOCK)
 WHERE accountIDX NOT IN (
	SELECT accountIDX
	  FROM dbo.userRankingDB_hero WITH(NOLOCK)
 )

UPDATE a
   SET daily = b.rank
  FROM (
	SELECT accountIDX, rank
	  FROM userRankingDB_temp WITH(NOLOCK)
) b
 INNER JOIN userRankingDB_hero a
    ON a.accountIDX = b.accountIDX


DELETE FROM dbo.userRankingDB_hero
 WHERE daily=0
   AND dailyB=0
   AND season1=0
   AND season2=0
   AND season3=0
   AND season4=0
   AND season5=0
   AND season6=0
GO
/****** Object:  StoredProcedure [dbo].[AGENT_RANKING_LADDER_DAILYB]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AGENT_RANKING_LADDER_DAILYB]

AS

SET NOCOUNT ON

UPDATE dbo.userRankingDB_hero
   SET dailyB = 0
 WHERE dailyB > 0

IF EXISTS(SELECT table_name FROM information_schema.tables WHERE table_name = 'userRankingDB_temp')
DROP TABLE userRankingDB_temp

SELECT a.accountIDX, ROW_NUMBER() OVER(ORDER BY a.ladderEXP DESC, a.accountIDX ASC) AS 'rank' 
  INTO userRankingDB_temp 
  FROM (
	SELECT c.accountIDX, (c.userHerosEXP) * ((d.type4_win/30) + 1) / ((d.type4_lose/10) + 1) AS 'ladderEXP' 
	  FROM dbo.userGameDB c WITH(NOLOCK)
	 INNER JOIN dbo.userRecordBattleDB d WITH(NOLOCK)
	    ON c.accountIDX=d.accountIDX
	 WHERE c.userHerosEXP > 0
) a, (
	SELECT accountIDX
	  FROM dbo.userMemberDB WITH(NOLOCK) 
	 WHERE userType > 20 
) b
 WHERE a.accountIDX = b.accountIDX

INSERT INTO dbo.userRankingDB_hero (
	accountIDX, title, daily, dailyB, season1, season2, season3, season4, season5, season6, regDate
)
SELECT accountIDX, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE()
  FROM userRankingDB_temp WITH(NOLOCK)
 WHERE accountIDX NOT IN (
	SELECT accountIDX
	  FROM dbo.userRankingDB_hero WITH(NOLOCK)
 )

UPDATE a
   SET dailyB = b.rank
  FROM (
	SELECT accountIDX, rank
	  FROM userRankingDB_temp WITH(NOLOCK)
) b
 INNER JOIN dbo.userRankingDB_hero a
    ON a.accountIDX = b.accountIDX
GO
/****** Object:  StoredProcedure [dbo].[AGENT_RANKING_LADDER_SEASON]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AGENT_RANKING_LADDER_SEASON]

AS

SET NOCOUNT ON

UPDATE dbo.userRankingDB_hero
   SET season6 = season5
,	   season5 = season4
,	   season4 = season3
,	   season3 = season2
,	   season2 = season1
,	   season1 = daily
GO
/****** Object:  StoredProcedure [dbo].[AGENT_RANKING_LADDER_TITLE]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AGENT_RANKING_LADDER_TITLE]

AS

SET NOCOUNT ON

DECLARE @cnt int
DECLARE @4nd int
DECLARE @5nd int
DECLARE @6nd int
DECLARE @7nd int
DECLARE @8nd int

SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userRankingDB_hero WITH(NOLOCK)
)

SET @5nd = @cnt * (10/CONVERT(float, 100))
SET @6nd = @cnt * (25/CONVERT(float, 100))
SET @7nd = @cnt * (50/CONVERT(float, 100))
SET @8nd = @cnt * (100/CONVERT(float, 100))

UPDATE dbo.userRankingDB_hero
   SET title = 8
 WHERE daily <= @8nd
   AND daily > 0

UPDATE dbo.userRankingDB_hero
   SET title = 7
 WHERE daily <= @7nd
   AND daily > 0

UPDATE dbo.userRankingDB_hero
   SET title = 6
 WHERE daily <= @6nd
   AND daily > 0

UPDATE dbo.userRankingDB_hero
   SET title = 5
 WHERE daily <= @5nd
   AND daily > 0

UPDATE dbo.userRankingDB_hero
   SET title = 4
 WHERE daily >= 21
   AND daily <= 100

UPDATE dbo.userRankingDB_hero
   SET title = 3
 WHERE daily >= 6
   AND daily <= 20

UPDATE dbo.userRankingDB_hero
   SET title = 2
 WHERE daily >= 2
   AND daily <= 5

UPDATE dbo.userRankingDB_hero
   SET title = 1
 WHERE daily = 1
GO
/****** Object:  StoredProcedure [dbo].[event_item_limited_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[event_item_limited_get_data]

	@PAGE_SIZE	INT,  
	@PAGE		INT	  

AS
SET NOCOUNT ON
	SET LOCK_TIMEOUT 10000
	
	SELECT AccountIDX, EventType, GoodsIndex, GoodsCount FROM (
		SELECT ROW_NUMBER() OVER (ORDER BY AccountIDX) as RowNumber, AccountIDX, EventType, GoodsIndex, GoodsCount 
		FROM dbo.event_item_limited WITH (READUNCOMMITTED)
		WHERE AccountIDX>0 and EventType=0
	) as A WHERE RowNumber BETWEEN ((@PAGE - 1) * @PAGE_SIZE + 1) And (@PAGE * @PAGE_SIZE) 
	
	IF (@@ERROR<>0)
	BEGIN		
		RETURN;
	END	

	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[event_item_limited_set_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[event_item_limited_set_data]

	@ACCOUNT_IDX		INT,
	@EVENT_TYPE			TINYINT,
	@GOODS_INDEX		INT,
	@GOODS_COUNT		TINYINT

AS
SET NOCOUNT ON
	SET LOCK_TIMEOUT 10000

	DECLARE @nReturn			INT	
	SET @nReturn=0			-- True

	BEGIN TRAN

		UPDATE dbo.event_item_limited WITH (XLOCK, ROWLOCK) SET GoodsCount=@GOODS_COUNT
		WHERE AccountIDX=@ACCOUNT_IDX and EventType=@EVENT_TYPE and GoodsIndex=@GOODS_INDEX

		IF (@@ROWCOUNT=0)
		BEGIN	

			INSERT dbo.event_item_limited WITH (XLOCK, ROWLOCK) (AccountIDX, EventType, GoodsIndex, GoodsCount)	VALUES (@ACCOUNT_IDX, @EVENT_TYPE, @GOODS_INDEX, @GOODS_COUNT)
			IF (@@ROWCOUNT=0) or (@@ERROR<>0)
			BEGIN
				ROLLBACK TRAN				
				SELECT -1
				RETURN;
			END
		END

	COMMIT TRAN

	SELECT @nReturn
	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[event_item_limited_set_init]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[event_item_limited_set_init]

	@EVENT_TYPE			TINYINT

AS
SET NOCOUNT ON
	SET LOCK_TIMEOUT 10000
	
	IF EXISTS (SELECT * FROM dbo.event_item_limited WHERE AccountIDX>0 and EventType=@EVENT_TYPE)
	BEGIN
		BEGIN TRAN

			DELETE dbo.event_item_limited WHERE AccountIDX>0 and EventType=@EVENT_TYPE
			IF (@@ERROR<>0)
			BEGIN
				ROLLBACK TRAN
				SELECT -1
				RETURN;
			END

		COMMIT TRAN
	END

	SELECT 0
	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_ability_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_ability_add]
(
	@accountIDX int
,	@class1_type int
,	@class1_basic01 tinyint
,	@class1_basic02 tinyint
,	@class1_basic03 tinyint
,	@class1_basic04 tinyint
,	@class1_skill1_sd tinyint
,	@class1_skill1_asd tinyint
,	@class1_skill1_ad tinyint
,	@class1_skill1_as tinyint
,	@class1_timeslot int
,	@class1_limitdate datetime
,	@class2_type int
,	@class2_basic01 tinyint
,	@class2_basic02 tinyint
,	@class2_basic03 tinyint
,	@class2_basic04 tinyint
,	@class2_skill1_sd tinyint
,	@class2_skill1_asd tinyint
,	@class2_skill1_ad tinyint
,	@class2_skill1_as tinyint
,	@class2_timeslot int
,	@class2_limitdate datetime
,	@class3_type int
,	@class3_basic01 tinyint
,	@class3_basic02 tinyint
,	@class3_basic03 tinyint
,	@class3_basic04 tinyint
,	@class3_skill1_sd tinyint
,	@class3_skill1_asd tinyint
,	@class3_skill1_ad tinyint
,	@class3_skill1_as tinyint
,	@class3_timeslot int
,	@class3_limitdate datetime
,	@class4_type int
,	@class4_basic01 tinyint
,	@class4_basic02 tinyint
,	@class4_basic03 tinyint
,	@class4_basic04 tinyint
,	@class4_skill1_sd tinyint
,	@class4_skill1_asd tinyint
,	@class4_skill1_ad tinyint
,	@class4_skill1_as tinyint
,	@class4_timeslot int
,	@class4_limitdate datetime
,	@class5_type int
,	@class5_basic01 tinyint
,	@class5_basic02 tinyint
,	@class5_basic03 tinyint
,	@class5_basic04 tinyint
,	@class5_skill1_sd tinyint
,	@class5_skill1_asd tinyint
,	@class5_skill1_ad tinyint
,	@class5_skill1_as tinyint
,	@class5_timeslot int
,	@class5_limitdate datetime
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userAbilityDB (
	accountIDX,
	class1_type, class1_basic01, class1_basic02, class1_basic03, class1_basic04, class1_skill1_sd, class1_skill1_asd, class1_skill1_ad, class1_skill1_as, class1_timeslot, class1_limitdate,
	class2_type, class2_basic01, class2_basic02, class2_basic03, class2_basic04, class2_skill1_sd, class2_skill1_asd, class2_skill1_ad, class2_skill1_as, class2_timeslot, class2_limitdate,
	class3_type, class3_basic01, class3_basic02, class3_basic03, class3_basic04, class3_skill1_sd, class3_skill1_asd, class3_skill1_ad, class3_skill1_as, class3_timeslot, class3_limitdate,
	class4_type, class4_basic01, class4_basic02, class4_basic03, class4_basic04, class4_skill1_sd, class4_skill1_asd, class4_skill1_ad, class4_skill1_as, class4_timeslot, class4_limitdate,
	class5_type, class5_basic01, class5_basic02, class5_basic03, class5_basic04, class5_skill1_sd, class5_skill1_asd, class5_skill1_ad, class5_skill1_as, class5_timeslot, class5_limitdate,
	regDate
)
VALUES (
	@accountIDX,
	@class1_type, @class1_basic01, @class1_basic02, @class1_basic03, @class1_basic04, @class1_skill1_sd, @class1_skill1_asd, @class1_skill1_ad, @class1_skill1_as, @class1_timeslot, @class1_limitdate,
	@class2_type, @class2_basic01, @class2_basic02, @class2_basic03, @class2_basic04, @class2_skill1_sd, @class2_skill1_asd, @class2_skill1_ad, @class2_skill1_as, @class2_timeslot, @class2_limitdate,
	@class3_type, @class3_basic01, @class3_basic02, @class3_basic03, @class3_basic04, @class3_skill1_sd, @class3_skill1_asd, @class3_skill1_ad, @class3_skill1_as, @class3_timeslot, @class3_limitdate,
	@class4_type, @class4_basic01, @class4_basic02, @class4_basic03, @class4_basic04, @class4_skill1_sd, @class4_skill1_asd, @class4_skill1_ad, @class4_skill1_as, @class4_timeslot, @class4_limitdate,
	@class5_type, @class5_basic01, @class5_basic02, @class5_basic03, @class5_basic04, @class5_skill1_sd, @class5_skill1_asd, @class5_skill1_ad, @class5_skill1_as, @class5_timeslot, @class5_limitdate,
	GETDATE()
)
GO
/****** Object:  StoredProcedure [dbo].[game_ability_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_ability_get_list]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT idx,
	   class1_type, class1_basic01, class1_basic02, class1_basic03, class1_basic04, class1_skill1_sd, class1_skill1_asd, class1_skill1_ad, class1_skill1_as, class1_timeslot, class1_limitdate,
	   class2_type, class2_basic01, class2_basic02, class2_basic03, class2_basic04, class2_skill1_sd, class2_skill1_asd, class2_skill1_ad, class2_skill1_as, class2_timeslot, class2_limitdate,
	   class3_type, class3_basic01, class3_basic02, class3_basic03, class3_basic04, class3_skill1_sd, class3_skill1_asd, class3_skill1_ad, class3_skill1_as, class3_timeslot, class3_limitdate,
	   class4_type, class4_basic01, class4_basic02, class4_basic03, class4_basic04, class4_skill1_sd, class4_skill1_asd, class4_skill1_ad, class4_skill1_as, class4_timeslot, class4_limitdate,
	   class5_type, class5_basic01, class5_basic02, class5_basic03, class5_basic04, class5_skill1_sd, class5_skill1_asd, class5_skill1_ad, class5_skill1_as, class5_timeslot, class5_limitdate 
  FROM dbo.userAbilityDB WITH(NOLOCK)
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_ability_get_self_index]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_ability_get_self_index]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT TOP 1 idx
  FROM dbo.userAbilityDB
 WHERE accountIDX = @accountIDX
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_ability_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_ability_save]
(
	@idx int
,	@class1_type int
,	@class1_basic01 tinyint
,	@class1_basic02 tinyint
,	@class1_basic03 tinyint
,	@class1_basic04 tinyint
,	@class1_skill1_sd tinyint
,	@class1_skill1_asd tinyint
,	@class1_skill1_ad tinyint
,	@class1_skill1_as tinyint
,	@class1_timeslot int
,	@class1_limitdate datetime
,	@class2_type int
,	@class2_basic01 tinyint
,	@class2_basic02 tinyint
,	@class2_basic03 tinyint
,	@class2_basic04 tinyint
,	@class2_skill1_sd tinyint
,	@class2_skill1_asd tinyint
,	@class2_skill1_ad tinyint
,	@class2_skill1_as tinyint
,	@class2_timeslot int
,	@class2_limitdate datetime
,	@class3_type int
,	@class3_basic01 tinyint
,	@class3_basic02 tinyint
,	@class3_basic03 tinyint
,	@class3_basic04 tinyint
,	@class3_skill1_sd tinyint
,	@class3_skill1_asd tinyint
,	@class3_skill1_ad tinyint
,	@class3_skill1_as tinyint
,	@class3_timeslot int
,	@class3_limitdate datetime
,	@class4_type int
,	@class4_basic01 tinyint
,	@class4_basic02 tinyint
,	@class4_basic03 tinyint
,	@class4_basic04 tinyint
,	@class4_skill1_sd tinyint
,	@class4_skill1_asd tinyint
,	@class4_skill1_ad tinyint
,	@class4_skill1_as tinyint
,	@class4_timeslot int
,	@class4_limitdate datetime
,	@class5_type int
,	@class5_basic01 tinyint
,	@class5_basic02 tinyint
,	@class5_basic03 tinyint
,	@class5_basic04 tinyint
,	@class5_skill1_sd tinyint
,	@class5_skill1_asd tinyint
,	@class5_skill1_ad tinyint
,	@class5_skill1_as tinyint
,	@class5_timeslot int
,	@class5_limitdate datetime
)
AS

SET NOCOUNT ON

UPDATE dbo.userAbilityDB
   SET class1_type = @class1_type
,	   class1_basic01 = @class1_basic01
,	   class1_basic02 = @class1_basic02
,	   class1_basic03 = @class1_basic03
,	   class1_basic04 = @class1_basic04
,	   class1_skill1_sd = @class1_skill1_sd
,	   class1_skill1_asd = @class1_skill1_asd
,	   class1_skill1_ad = @class1_skill1_ad
,	   class1_skill1_as = @class1_skill1_as
,	   class1_timeslot = @class1_timeslot
,	   class1_limitdate = @class1_limitdate
,	   class2_type = @class2_type
,	   class2_basic01 = @class2_basic01
,	   class2_basic02 = @class2_basic02
,	   class2_basic03 = @class2_basic03
,	   class2_basic04 = @class2_basic04
,	   class2_skill1_sd = @class2_skill1_sd
,	   class2_skill1_asd = @class2_skill1_asd
,	   class2_skill1_ad = @class2_skill1_ad
,	   class2_skill1_as = @class2_skill1_as
,	   class2_timeslot = @class2_timeslot
,	   class2_limitdate = @class2_limitdate
,	   class3_type = @class3_type
,	   class3_basic01 = @class3_basic01
,	   class3_basic02 = @class3_basic02
,	   class3_basic03 = @class3_basic03
,	   class3_basic04 = @class3_basic04
,	   class3_skill1_sd = @class3_skill1_sd
,	   class3_skill1_asd = @class3_skill1_asd
,	   class3_skill1_ad = @class3_skill1_ad
,	   class3_skill1_as = @class3_skill1_as
,	   class3_timeslot = @class3_timeslot
,	   class3_limitdate = @class3_limitdate
,	   class4_type = @class4_type
,	   class4_basic01 = @class4_basic01
,	   class4_basic02 = @class4_basic02
,	   class4_basic03 = @class4_basic03
,	   class4_basic04 = @class4_basic04
,	   class4_skill1_sd = @class4_skill1_sd
,	   class4_skill1_asd = @class4_skill1_asd
,	   class4_skill1_ad = @class4_skill1_ad
,	   class4_skill1_as = @class4_skill1_as
,	   class4_timeslot = @class4_timeslot
,	   class4_limitdate = @class4_limitdate
,	   class5_type = @class5_type
,	   class5_basic01 = @class5_basic01
,	   class5_basic02 = @class5_basic02
,	   class5_basic03 = @class5_basic03
,	   class5_basic04 = @class5_basic04
,	   class5_skill1_sd = @class5_skill1_sd
,	   class5_skill1_asd = @class5_skill1_asd
,	   class5_skill1_ad = @class5_skill1_ad
,	   class5_skill1_as = @class5_skill1_as
,	   class5_timeslot = @class5_timeslot
,	   class5_limitdate = @class5_limitdate
 WHERE idx = @idx
GO
/****** Object:  StoredProcedure [dbo].[game_accessory_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_accessory_get_list]

	@TABLE_IDX			INT,
	@ACCOUNT_IDX		INT,
	@TOP_NUM			INT

AS

	SET NOCOUNT ON;
	SET LOCK_TIMEOUT 10000;
	
	SELECT TOP (@TOP_NUM) idx, ItemCode, PeriodType, PeriodDate, StatValue, ClassType
	  FROM dbo.userAccessoryDB WITH (NOLOCK)
	 WHERE AccountIDX = @ACCOUNT_IDX
	   AND idx > @TABLE_IDX
	 ORDER BY idx ASC
GO
/****** Object:  StoredProcedure [dbo].[game_accessory_set_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_accessory_set_add]

	@ACCOUNT_IDX		INT,
	@ITEM_CODE			INT,
	@PERIOD_TYPE		TINYINT,
	@PERIOD_DATE		DATETIME,
	@STAT_VALUE			INT,
	@CLASS_TYPE			INT

AS

	SET NOCOUNT ON;
	SET LOCK_TIMEOUT 10000;
	
	DECLARE @TABLE_INDEX	INT
	SET @TABLE_INDEX = 0

	BEGIN TRAN

		INSERT INTO dbo.userAccessoryDB (AccountIDX, ItemCode, PeriodType, PeriodDate, StatValue, ClassType, RegDate)
		VALUES (@ACCOUNT_IDX, @ITEM_CODE, @PERIOD_TYPE, @PERIOD_DATE, @STAT_VALUE, @CLASS_TYPE, GETDATE())

		IF (@@ROWCOUNT = 0) OR (@@ERROR <> 0)
		BEGIN
			SELECT -1
			ROLLBACK TRAN
			RETURN;
		END

		SET @TABLE_INDEX = @@IDENTITY
	
	COMMIT TRAN
	
	SELECT @TABLE_INDEX AS idx;
GO
/****** Object:  StoredProcedure [dbo].[game_accessory_set_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_accessory_set_delete]

	@TABLE_IDX			INT,
	@ACCOUNT_IDX		INT

AS

	SET NOCOUNT ON;
	SET LOCK_TIMEOUT 10000;
	
	BEGIN TRAN

		DELETE FROM dbo.userAccessoryDB
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX;

		IF (@@ROWCOUNT = 0) OR (@@ERROR <> 0)
		BEGIN
			SELECT -1
			ROLLBACK TRAN
			RETURN;
		END

	COMMIT TRAN

	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_accessory_set_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_accessory_set_save]

	@TABLE_IDX			INT,
	@ACCOUNT_IDX		INT,
	@ITEM_CODE			INT,
	@PERIOD_TYPE		TINYINT,
	@PERIOD_DATE		DATETIME,
	@STAT_VALUE			INT,
	@CLASS_TYPE			INT

AS

	SET NOCOUNT ON;
	SET LOCK_TIMEOUT 10000;
	
	BEGIN TRAN
		
		UPDATE dbo.userAccessoryDB
		   SET ItemCode = @ITEM_CODE,
			   PeriodType = @PERIOD_TYPE,
			   PeriodDate = @PERIOD_DATE,
			   StatValue = @STAT_VALUE,
			   ClassType = @CLASS_TYPE
		 WHERE AccountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX

		IF (@@ROWCOUNT = 0) OR (@@ERROR <> 0)
		BEGIN
			SELECT -1
			ROLLBACK TRAN
			RETURN;
		END

	COMMIT TRAN

	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_accountIDX_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_accountIDX_get]
(
	@GARENA_UID		VARCHAR(130)		-- garena uid
)
AS

SET NOCOUNT ON;

SELECT accountIdx FROM dbo.userMemberDB WITH(NOLOCK) WHERE userID = @GARENA_UID
GO
/****** Object:  StoredProcedure [dbo].[game_attend_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_attend_get_data]

	@ACCOUNT_IDX		INT

AS
SET NOCOUNT ON
	SET LOCK_TIMEOUT 10000
		
	SELECT AttendCount, RewardTable, ConnectDate FROM dbo.userAttendDB WITH (READUNCOMMITTED)
	WHERE AccountIDX=@ACCOUNT_IDX

	IF (@@ERROR<>0)
	BEGIN	
		SELECT -1
		RETURN;
	END	

	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_attend_set_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_attend_set_data]

	@ACCOUNT_IDX		INT,
	@ATTEND_COUNT		INT,
	@REWARD_TABLE		INT

AS

	SET NOCOUNT ON
	SET LOCK_TIMEOUT 10000

	DECLARE @nReturn			INT	
	DECLARE @CONNECT_DATE		DATETIME
	
	SET @CONNECT_DATE = GETDATE();	
	SET @nReturn=0			-- True


	BEGIN TRAN

		

		--	MERGE dbo.userAttendDB as TARGET
		--	USING (SELECT @ACCOUNT_IDX, @ATTEND_COUNT, @REWARD_TABLE) AS SOURCE (AccountIDX, AttendCount, RewardTable)
		--	ON (TARGET.AccountIDX=SOURCE.AccountIDX)
		--	WHEN MATCHED THEN
		--		UPDATE SET AttendCount=SOURCE.AttendCount, RewardTable=SOURCE.RewardTable, ConnectDate=@CONNECT_DATE
		--	WHEN NOT MATCHED THEN
		--		INSERT (AccountIDX, AttendCount, RewardTable, ConnectDate, RegDate) VALUES (SOURCE.AccountIDX, SOURCE.AttendCount, SOURCE.RewardTable, @CONNECT_DATE, GETDATE());

		UPDATE dbo.userAttendDB WITH (XLOCK, ROWLOCK) SET AttendCount=@ATTEND_COUNT, RewardTable=@REWARD_TABLE, ConnectDate=@CONNECT_DATE
		WHERE AccountIDX=@ACCOUNT_IDX

		IF (@@ROWCOUNT=0)
		BEGIN	

			INSERT dbo.userAttendDB WITH (XLOCK, ROWLOCK)  (AccountIDX, AttendCount, RewardTable, ConnectDate, RegDate)
			VALUES (@ACCOUNT_IDX, @ATTEND_COUNT, @REWARD_TABLE, @CONNECT_DATE, GETDATE())
			IF (@@ROWCOUNT=0) or (@@ERROR<>0)
			BEGIN
				ROLLBACK TRAN				
				SELECT -1
				RETURN;
			END
		END

	COMMIT TRAN

	SELECT 0, @CONNECT_DATE as ConnectDate;
	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_attendance_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_attendance_add]
(
	@accountIDX INT
,	@checkDate DATETIME
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userAttendanceDB (accountIDX, checkDate, regDate)
VALUES (@accountIDX, @checkDate, GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[game_attendance_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_attendance_delete]
(
	@accountIDX INT
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userAttendanceDB
 WHERE accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_attendance_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_attendance_list]
(
	@accountIDX INT
)
AS

SET NOCOUNT ON

SELECT idx, accountIDX, checkDate
  FROM dbo.userAttendanceDB WITH(NOLOCK)
 WHERE accountIDX=@accountIDX
 ORDER BY idx ASC
GO
/****** Object:  StoredProcedure [dbo].[game_award_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_award_add]
(
	@accountIDX int
,	@award1_type int
,	@award1_number int
,	@award1_point int
,	@award2_type int
,	@award2_number int
,	@award2_point int
,	@award3_type int
,	@award3_number int
,	@award3_point int
,	@award4_type int
,	@award4_number int
,	@award4_point int
,	@award5_type int
,	@award5_number int
,	@award5_point int
,	@award6_type int
,	@award6_number int
,	@award6_point int
,	@award7_type int
,	@award7_number int
,	@award7_point int
,	@award8_type int
,	@award8_number int
,	@award8_point int
,	@award9_type int
,	@award9_number int
,	@award9_point int
,	@award10_type int
,	@award10_number int
,	@award10_point int
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userAwardDB (
	accountIDX,
	award1_type, award1_number, award1_point, award2_type, award2_number, award2_point, award3_type, award3_number, award3_point,
	award4_type, award4_number, award4_point, award5_type, award5_number, award5_point, award6_type, award6_number, award6_point,
	award7_type, award7_number, award7_point, award8_type, award8_number, award8_point, award9_type, award9_number, award9_point,
	award10_type, award10_number, award10_point, regDate
)
VALUES (
	@accountIDX,
	@award1_type, @award1_number, @award1_point, @award2_type, @award2_number, @award2_point, @award3_type, @award3_number, @award3_point,
	@award4_type, @award4_number, @award4_point, @award5_type, @award5_number, @award5_point, @award6_type, @award6_number, @award6_point,
	@award7_type, @award7_number, @award7_point, @award8_type, @award8_number, @award8_point, @award9_type, @award9_number, @award9_point,
	@award10_type, @award10_number, @award10_point, GETDATE()
)
GO
/****** Object:  StoredProcedure [dbo].[game_award_get_level]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_award_get_level]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT awardLevel, expert
  FROM dbo.userRankingDB_award WITH(NOLOCK)
 WHERE accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_award_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_award_get_list]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT idx, award1_type, award1_number, award1_point, award2_type, award2_number, award2_point, award3_type, award3_number, award3_point,
	   award4_type, award4_number, award4_point, award5_type, award5_number, award5_point, award6_type, award6_number, award6_point,
	   award7_type, award7_number, award7_point, award8_type, award8_number, award8_point, award9_type, award9_number, award9_point,
	   award10_type, award10_number, award10_point 
  FROM dbo.userAwardDB WITH(NOLOCK)
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_award_get_self_index]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_award_get_self_index]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT MAX(idx)
  FROM dbo.userAwardDB
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_award_level_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_award_level_save]
(
	@accountIDX int
,	@awardLevel int
,	@expert int
)
AS

SET NOCOUNT ON

If (EXISTS(SELECT * FROM dbo.userRankingDB_award WHERE accountIDX=@accountIDX))
BEGIN
	UPDATE dbo.userRankingDB_award
	   SET awardLevel=@awardLevel,
		   expert=@expert
	 WHERE accountIDX=@accountIDX
END
ELSE
BEGIN
	INSERT INTO dbo.userRankingDB_award (accountIDX, awardLevel, expert, regDate)
	VALUES (@accountIDX, @awardLevel, @expert, GETDATE())
END
GO
/****** Object:  StoredProcedure [dbo].[game_award_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_award_save]
(
	@idx int
,	@award1_type int
,	@award1_number int
,	@award1_point int
,	@award2_type int
,	@award2_number int
,	@award2_point int
,	@award3_type int
,	@award3_number int
,	@award3_point int
,	@award4_type int
,	@award4_number int
,	@award4_point int
,	@award5_type int
,	@award5_number int
,	@award5_point int
,	@award6_type int
,	@award6_number int
,	@award6_point int
,	@award7_type int
,	@award7_number int
,	@award7_point int
,	@award8_type int
,	@award8_number int
,	@award8_point int
,	@award9_type int
,	@award9_number int
,	@award9_point int
,	@award10_type int
,	@award10_number int
,	@award10_point int
)
AS

SET NOCOUNT ON

UPDATE dbo.userAwardDB
   SET award1_type = @award1_type
,	   award1_number = @award1_number
,	   award1_point = @award1_point
,	   award2_type = @award2_type
,	   award2_number = @award2_number
,	   award2_point = @award2_point
,	   award3_type = @award3_type
,	   award3_number = @award3_number
,	   award3_point = @award3_point
,	   award4_type = @award4_type
,	   award4_number = @award4_number
,	   award4_point = @award4_point
,	   award5_type = @award5_type
,	   award5_number = @award5_number
,	   award5_point = @award5_point
,	   award6_type = @award6_type
,	   award6_number = @award6_number
,	   award6_point = @award6_point
,	   award7_type = @award7_type
,	   award7_number = @award7_number
,	   award7_point = @award7_point
,	   award8_type = @award8_type
,	   award8_number = @award8_number
,	   award8_point = @award8_point
,	   award9_type = @award9_type
,	   award9_number = @award9_number
,	   award9_point = @award9_point
,	   award10_type = @award10_type
,	   award10_number = @award10_number
,	   award10_point = @award10_point
 WHERE idx=@idx
GO
/****** Object:  StoredProcedure [dbo].[game_character_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_character_add]
(
	@accountIDX int
,	@ClassType int
,	@CI_type int
,	@CI_gender int
,	@CI_beard int
,	@CI_face int
,	@CI_hair int
,	@CI_skinColor int
,	@CI_hairColor int
,	@CI_trinket int
,	@CI_underwear int
,	@EI1_type int
,	@EI2_type int
,	@EI3_type int
,	@EI4_type int
,	@limitTime int
,	@limitType int
,	@leaderType smallint
,	@rentalType smallint
,	@rentalTime int
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userCharacterDB (
	accountIDX, ClassType,
	CI_type, CI_gender, CI_beard, CI_face, CI_hair, CI_skinColor, CI_hairColor, CI_trinket, CI_underwear,
	EI1_type, EI2_type, EI3_type, EI4_type,
	limitTime, limitType, leaderType, rentalType, rentalTime
)
VALUES (
	@accountIDX, @ClassType,
	@CI_type, @CI_gender, @CI_beard, @CI_face, @CI_hair, @CI_skinColor, @CI_hairColor, @CI_trinket, @CI_underwear,
	@EI1_type, @EI2_type, @EI3_type, @EI4_type,
	@limitTime, @limitType, @leaderType, @rentalType, @rentalTime
)
GO
/****** Object:  StoredProcedure [dbo].[game_character_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_character_delete]
(
	@idx int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userCharacterDB
 WHERE idx=@idx
GO
/****** Object:  StoredProcedure [dbo].[game_character_delete_limitdate]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_character_delete_limitdate]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userCharacterDB
 WHERE accountIDX = @accountIDX
   AND limitTime=0
   AND limitType=0
   AND GETDATE() > DATEADD(d,1,regDate)
GO
/****** Object:  StoredProcedure [dbo].[game_character_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_character_get_data]
(
	@idx INT
)
AS

SET NOCOUNT ON

SELECT accountIDX,
	   ClassType, CI_type, CI_gender, CI_beard, CI_face, CI_hair, CI_skinColor, CI_hairColor, CI_trinket, CI_underwear,
	   EI1_type, EI2_type, EI3_type, EI4_type, CI_position,
	   limitTime, limitType, leaderType, rentalType, rentalTime, awakeType, awakeTime 
  FROM dbo.userCharacterDB WITH(NOLOCK)
 WHERE idx = @idx
GO
/****** Object:  StoredProcedure [dbo].[game_character_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_character_get_list]
(
	@accountIDX INT
)
AS

SET NOCOUNT ON

SELECT idx, ClassType,
       CI_type, CI_gender, CI_beard, CI_face, CI_hair, CI_skinColor, CI_hairColor, CI_trinket, CI_underwear,
       EI1_type, EI2_type, EI3_type, EI4_type, CI_position,
       limitTime, limitType, leaderType, rentalType, rentalTime, awakeType, awakeTime 
  FROM dbo.userCharacterDB WITH(NOLOCK)
 WHERE accountIDX = @accountIDX
 ORDER BY idx ASC
GO
/****** Object:  StoredProcedure [dbo].[game_character_get_self_index]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_character_get_self_index]
(
	@accountIDX int
,	@getCount int
)
As

SET NOCOUNT ON

SELECT TOP (@getCount) idx
  FROM dbo.userCharacterDB
 WHERE accountIDX = @accountIDX
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_character_regdate_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_character_regdate_save]
(
	@idx int
)
AS

SET NOCOUNT ON

UPDATE dbo.userCharacterDB
   SET regDate=GETDATE()
 WHERE idx=@idx
GO
/****** Object:  StoredProcedure [dbo].[game_character_rental_history]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_character_rental_history]
(
	@accountIDX int
,	@friendIDX int
,	@classType int
)
AS

SET NOCOUNT ON

INSERT INTO LosaGame_log.DBO.log_class_rental_history (accountIDX, friendIDX, classType, regDate)
VALUES (@accountIDX, @friendIDX, @classType, GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[game_character_rental_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_character_rental_list]
(
	@accountIDX int
,	@selectDate datetime
)
AS

SET NOCOUNT ON

SELECT friendIDX, regDate
  FROM LosaGame_log.DBO.log_class_rental_history WITH(NOLOCK)
 WHERE accountIDX=@accountIDX
   AND regDate >= @selectDate
GO
/****** Object:  StoredProcedure [dbo].[game_character_rentaltime_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_character_rentaltime_save]
(
	@idx int
,	@rentalTime int
)
AS

SET NOCOUNT ON

UPDATE dbo.userCharacterDB
   SET rentalTime=@rentalTime
 WHERE idx=@idx
GO
/****** Object:  StoredProcedure [dbo].[game_character_sava]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_character_sava]
(
	@idx				INT
,	@ClassType			INT
,	@CI_type			INT
,	@CI_gender			INT
,	@CI_beard			INT
,	@CI_face			INT
,	@CI_hair			INT
,	@CI_skinColor		INT
,	@CI_hairColor		INT
,	@CI_trinket			INT
,	@CI_underwear		INT
,	@EI1_type			INT
,	@EI2_type			INT
,	@EI3_type			INT
,	@EI4_type			INT
,	@CI_position		INT
,	@limitTime			INT
,	@limitType			INT
,	@leaderType			SMALLINT
,	@rentalType			SMALLINT
,	@rentalTime			INT
,	@awakeType			TINYINT
,	@awakeTime			INT
)
AS

SET NOCOUNT ON

UPDATE dbo.userCharacterDB
   SET ClassType = @ClassType,
       CI_type = @CI_type,
       CI_gender = @CI_gender,
       CI_beard = @CI_beard,
       CI_face = @CI_face,
       CI_hair = @CI_hair,
       CI_skinColor = @CI_skinColor,
       CI_hairColor = @CI_hairColor,
       CI_trinket = @CI_trinket,
       CI_position = @CI_position,
       CI_underwear = @CI_underwear,
       EI1_type = @EI1_type,
       EI2_type = @EI2_type,
       EI3_type = @EI3_type,
       EI4_type = @EI4_type,
       limitTime = @limitTime,
       limitType = @limitType,
       leaderType = @leaderType,
       rentalType = @rentalType,
       rentalTime = @rentalTime,
       awakeType = @awakeType,
       awakeTime =	@awakeTime
 WHERE idx = @idx
GO
/****** Object:  StoredProcedure [dbo].[game_class_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_class_add]
(
	@accountIDX INT
,	@class1_type INT
,	@class1_level INT
,	@class1_expert INT
,	@class1_stat TINYINT
,	@class2_type INT
,	@class2_level INT
,	@class2_expert INT
,	@class2_stat TINYINT
,	@class3_type INT
,	@class3_level INT
,	@class3_expert INT
,	@class3_stat TINYINT
,	@class4_type INT
,	@class4_level INT
,	@class4_expert INT
,	@class4_stat TINYINT
,	@class5_type INT
,	@class5_level INT
,	@class5_expert INT
,	@class5_stat TINYINT
,	@class6_type INT
,	@class6_level INT
,	@class6_expert INT
,	@class6_stat TINYINT
,	@class7_type INT
,	@class7_level INT
,	@class7_expert INT
,	@class7_stat TINYINT
,	@class8_type INT
,	@class8_level INT
,	@class8_expert INT
,	@class8_stat TINYINT
,	@class9_type INT
,	@class9_level INT
,	@class9_expert INT
,	@class9_stat TINYINT
,	@class10_type INT
,	@class10_level INT
,	@class10_expert INT
,	@class10_stat TINYINT
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userClassDB (
	accountIDX,
	class1_type, class1_level, class1_expert, class1_stat, class2_type, class2_level, class2_expert, class2_stat,
 	class3_type, class3_level, class3_expert, class3_stat, class4_type, class4_level, class4_expert, class4_stat,
	class5_type, class5_level, class5_expert, class5_stat, class6_type, class6_level, class6_expert, class6_stat,
	class7_type, class7_level, class7_expert, class7_stat, class8_type, class8_level, class8_expert, class8_stat,
	class9_type, class9_level, class9_expert, class9_stat, class10_type, class10_level, class10_expert, class10_stat
)
VALUES (
	@accountIDX,
	@class1_type, @class1_level, @class1_expert, @class1_stat, @class2_type, @class2_level, @class2_expert, @class2_stat,
	@class3_type, @class3_level, @class3_expert, @class3_stat, @class4_type, @class4_level, @class4_expert, @class4_stat,
	@class5_type, @class5_level, @class5_expert, @class5_stat, @class6_type, @class6_level, @class6_expert, @class6_stat,
	@class7_type, @class7_level, @class7_expert, @class7_stat, @class8_type, @class8_level, @class8_expert, @class8_stat,
	@class9_type, @class9_level, @class9_expert, @class9_stat, @class10_type, @class10_level, @class10_expert, @class10_stat
)
GO
/****** Object:  StoredProcedure [dbo].[game_class_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_class_get_list]
(
	@accountIDX INT
)
AS

SET NOCOUNT ON

SELECT idx,
       class1_type, class1_level, class1_expert, class1_stat, class2_type, class2_level, class2_expert, class2_stat,
       class3_type, class3_level, class3_expert, class3_stat, class4_type, class4_level, class4_expert, class4_stat,
       class5_type, class5_level, class5_expert, class5_stat, class6_type, class6_level, class6_expert, class6_stat,
       class7_type, class7_level, class7_expert, class7_stat, class8_type, class8_level, class8_expert, class8_stat,
       class9_type, class9_level, class9_expert, class9_stat, class10_type, class10_level, class10_expert, class10_stat
  FROM dbo.userClassDB WITH(NOLOCK)
 WHERE accountIDX = @accountIDX
 ORDER BY idx ASC
GO
/****** Object:  StoredProcedure [dbo].[game_class_get_self_index]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_class_get_self_index]
(
	@accountIDX INT
)
AS

SET NOCOUNT ON

SELECT MAX(idx)
  FROM dbo.userClassDB
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_class_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_class_save]
(
	@idx INT
,	@class1_type INT
,	@class1_level INT
,	@class1_expert INT
,	@class1_stat TINYINT
,	@class2_type INT
,	@class2_level INT
,	@class2_expert INT
,	@class2_stat TINYINT
,	@class3_type INT
,	@class3_level INT
,	@class3_expert INT
,	@class3_stat TINYINT
,	@class4_type INT
,	@class4_level INT
,	@class4_expert INT
,	@class4_stat TINYINT
,	@class5_type INT
,	@class5_level INT
,	@class5_expert INT
,	@class5_stat TINYINT
,	@class6_type INT
,	@class6_level INT
,	@class6_expert INT
,	@class6_stat TINYINT
,	@class7_type INT
,	@class7_level INT
,	@class7_expert INT
,	@class7_stat TINYINT
,	@class8_type INT
,	@class8_level INT
,	@class8_expert INT
,	@class8_stat TINYINT
,	@class9_type INT
,	@class9_level INT
,	@class9_expert INT
,	@class9_stat TINYINT
,	@class10_type INT
,	@class10_level INT
,	@class10_expert INT
,	@class10_stat TINYINT
)
AS

SET NOCOUNT ON

UPDATE dbo.userClassDB
   SET class1_type = @class1_type,
       class1_level = @class1_level,
       class1_expert = @class1_expert,
       class1_stat = @class1_stat,
       class2_type = @class2_type,
       class2_level = @class2_level,
       class2_expert = @class2_expert,
       class2_stat = @class2_stat,
       class3_type = @class3_type,
       class3_level = @class3_level,
       class3_expert = @class3_expert,
       class3_stat = @class3_stat,
       class4_type = @class4_type,
       class4_level = @class4_level,
       class4_expert = @class4_expert,
       class4_stat = @class4_stat,
       class5_type = @class5_type,
       class5_level = @class5_level,
       class5_expert = @class5_expert,
       class5_stat = @class5_stat,
       class6_type = @class6_type,
       class6_level = @class6_level,
       class6_expert = @class6_expert,
       class6_stat = @class6_stat,
       class7_type = @class7_type,
       class7_level = @class7_level,
       class7_expert = @class7_expert,
       class7_stat = @class7_stat,
       class8_type = @class8_type,
       class8_level = @class8_level,
       class8_expert = @class8_expert,
       class8_stat = @class8_stat,
       class9_type = @class9_type,
       class9_level = @class9_level,
       class9_expert = @class9_expert,
       class9_stat = @class9_stat,
       class10_type = @class10_type,
       class10_level = @class10_level,
       class10_expert = @class10_expert,
       class10_stat = @class10_stat
 WHERE idx = @idx
GO
/****** Object:  StoredProcedure [dbo].[game_clover_friend_receive_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_clover_friend_receive_save]
(
	@UserIndex		int
,	@FriendIndex	int
,	@receiveDate	int
,	@receiveCount	int
)
AS

SET NOCOUNT ON

DECLARE	@Index INT

SET @Index = ISNULL((
	SELECT idx
	  FROM dbo.userFriendDB WITH( NOLOCK )
	 WHERE userAccIDX = @FriendIndex
	   AND FriendAccIDX = @UserIndex
), 0 )


IF ( @Index > 0 )
BEGIN

	-- update
	UPDATE dbo.userFriendDB
	   SET receiveBCloverCnt = receiveBCloverCnt + @receiveCount,
		   receiveCloverDate = @receiveDate
	 WHERE idx = @Index

	-- select
	SELECT idx, userAccIDX, receiveCloverDate, receiveBCloverCnt
	  FROM dbo.userFriendDB WITH( nolock )
	 WHERE idx = @Index

END
ELSE
BEGIN
	SELECT 0 as idx, 0 as userAccIDX, 0 as receiveCloverDate, 0 as receiveBCloverCnt
END
GO
/****** Object:  StoredProcedure [dbo].[game_clover_info]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_clover_info]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

IF ( EXISTS(SELECT * FROM dbo.userCloverDB WITH( NOLOCK ) WHERE accountIDX = @accountIDX) )
BEGIN
	SELECT CloverCnt, LastChargeDate, RemainTime
	  FROM dbo.userCloverDB WITH( NOLOCK )
	 WHERE accountIDX = @accountIDX
END
ELSE
BEGIN
	INSERT INTO dbo.userCloverDB( accountIDX, CloverCnt, LastChargeDate, RemainTime, regDate )
	VALUES( @accountIDX, 0, 0, 0, GETDATE() )

	SELECT 0 AS CloverCnt, 0 AS LastChargeDate, 0 AS RemainTime
END
GO
/****** Object:  StoredProcedure [dbo].[game_clover_info_update]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_clover_info_update]
(
	@accountIDX int
,	@CloverCount int
,	@UpdateTime int
,	@RemainTime	smallint
)
AS

SET NOCOUNT ON

UPDATE dbo.userCloverDB
   SET CloverCnt = @CloverCount,
	   LastChargeDate = @UpdateTime,
	   RemainTime = @RemainTime,
	   regDate = GETDATE()
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_coin_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_coin_get_data]

	@ACCOUNT_IDX	INT

AS

	SET NOCOUNT ON;
	SET LOCK_TIMEOUT 10000;

	SELECT UpdateDate, CoinType
	  FROM dbo.userCoinDB WITH (NOLOCK)
	 WHERE AccountIDX = @ACCOUNT_IDX;
GO
/****** Object:  StoredProcedure [dbo].[game_coin_set_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_coin_set_add]

	@ACCOUNT_IDX	INT,		-- 유저인덱스
	@COIN_TYPE		TINYINT		-- 1: 래이드 코인

AS

	SET NOCOUNT ON;
	SET LOCK_TIMEOUT 10000;

	DECLARE @NOW_DATE DATETIME
	SET @NOW_DATE = GETDATE()

	BEGIN TRAN

		INSERT INTO dbo.userCoinDB WITH (XLOCK, ROWLOCK) (AccountIDX, UpdateDate, CoinType, RegDate)
		VALUES (@ACCOUNT_IDX, @NOW_DATE, @COIN_TYPE, @NOW_DATE);

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN
			RETURN;
		END

	COMMIT TRAN
	
	SELECT @NOW_DATE;

	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_coin_set_updatedate]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_coin_set_updatedate]

	@ACCOUNT_IDX		INT,		-- 유저인덱스
	@COIN_TYPE			TINYINT		-- 1: 래이드 코인

AS

	SET NOCOUNT ON;
	SET LOCK_TIMEOUT 10000;
	
	DECLARE @NOW_DATE DATETIME
	SET @NOW_DATE = GETDATE()

	BEGIN TRAN		
		
		UPDATE dbo.userCoinDB WITH (XLOCK, ROWLOCK)
		   SET UpdateDate = @NOW_DATE
		 WHERE AccountIDX = @ACCOUNT_IDX
		   AND CoinType = @COIN_TYPE;

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN
			RETURN;
		END

	COMMIT TRAN
	
	SELECT @NOW_DATE;

	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_config_keyboard_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_config_keyboard_get_data]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT keyvalue
  FROM dbo.userConfigDB WITH(NOLOCK)
 WHERE accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_config_keyboard_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_config_keyboard_save]
(
	@accountIDX int
,	@keyvalue varchar(200)
)
AS

SET NOCOUNT ON

If (EXISTS(SELECT * FROM userConfigDB WITH(NOLOCK) WHERE accountIDX=@accountIDX))
BEGIN
	UPDATE dbo.userConfigDB
	   SET keyvalue=@keyvalue
	 WHERE accountIDX=@accountIDX
END
ELSE
BEGIN
	INSERT INTO dbo.userConfigDB (accountIDX, keyvalue, regDate)
	VALUES (@accountIDX, @keyvalue, GETDATE())
END
GO
/****** Object:  StoredProcedure [dbo].[game_costume_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_costume_add]  
(  
 @accountIDX INT,  
 @itemCode INT,  
 @periodType TINYINT,  
 @periodDate DATETIME,  
 @classType INT  
)  
AS  
  
SET NOCOUNT ON  
SET LOCK_TIMEOUT 10000  
  
DECLARE @itemCodeIDX INT  
SET @itemCodeIDX = 0  
  
BEGIN TRAN  
  
 INSERT INTO dbo.userCostumeDB (  
  accountIDX, itemCode, mcustom, fcustom, periodType, periodDate, classType, regDate  
 )  
 VALUES (  
  @accountIDX, @itemCode, 0, 0, @periodType, @periodDate, @classType, GETDATE()  
 )  
  
 IF (@@ROWCOUNT = 0) OR (@@ERROR <> 0)  
 BEGIN  
  ROLLBACK TRAN  
 END  
  
 SET @itemCodeIDX = @@IDENTITY  
   
COMMIT TRAN  
   
SELECT @itemCodeIDX AS idx;
GO
/****** Object:  StoredProcedure [dbo].[game_costume_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_costume_delete]  
(  
 @idx INT,  
 @accountIDX INT  
)  
AS  
  
SET NOCOUNT ON  
SET LOCK_TIMEOUT 10000  
  
DELETE FROM dbo.userCostumeDB  
 WHERE accountIDX = @accountIDX  
   AND idx = @idx
GO
/****** Object:  StoredProcedure [dbo].[game_costume_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_costume_get_list]    
(    
 @idx INT,    
 @accountIDX INT,    
 @topNum INT    
)    
AS    
SET NOCOUNT ON    
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED     
    
SELECT TOP (@topNum) idx, itemCode, mcustom, fcustom,  periodType, periodDate, classType    
  FROM dbo.userCostumeDB WITH (INDEX (PK_userCostumeDB))    
 WHERE accountIDX = @accountIDX    
   AND idx > @idx    
 ORDER BY idx ASC
GO
/****** Object:  StoredProcedure [dbo].[game_costume_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_costume_save]      
(      
 @idx INT,      
 @itemCode INT,      
 @mcostume INT,    
 @fcostume INT,    
 @periodType TINYINT,      
 @periodDate DATETIME,      
 @classType INT      
)      
AS      
      
SET NOCOUNT ON      
SET LOCK_TIMEOUT 10000      
      
UPDATE dbo.userCostumeDB      
   SET itemCode = @itemCode,      
    mcustom = @mcostume,    
    fcustom = @fcostume,    
    periodType = @periodType,      
    periodDate = @periodDate,      
    classType = @classType      
 WHERE idx = @idx
GO
/****** Object:  StoredProcedure [dbo].[game_costume_skin_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_costume_skin_delete]        
(        
 @idx INT,        
 @accountIDX INT,        
  @gender INT      
)        
AS        
        
SET NOCOUNT ON        
SET LOCK_TIMEOUT 10000        
        
      
IF ( @gender = 1 )      
 BEGIN       
   UPDATE dbo.userCostumeDB SET mcustom = 0 WHERE idx = @idx and accountIDX = @accountIDX  
 END       
ELSE      
 BEGIN       
   UPDATE dbo.userCostumeDB SET fcustom = 0 WHERE idx = @idx and accountIDX = @accountIDX       
 END
GO
/****** Object:  StoredProcedure [dbo].[game_create_nickname]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_create_nickname]
(
	@accountIDX int
,	@chageNickname varchar(20)
)
AS

SET NOCOUNT ON

DECLARE @cnt1 int

SET @cnt1 = (
	SELECT COUNT(*)
	  FROM dbo.userMemberDB
	 WHERE nickName=@chageNickname
)

If (@cnt1 = 0)
BEGIN
	UPDATE dbo.userMemberDB
	   SET nickName=@chageNickname
	 WHERE accountIDX=@accountIDX
END
GO
/****** Object:  StoredProcedure [dbo].[game_custom_get_customidx]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_custom_get_customidx]  
(  
 @accountIDX int  
)  
AS  
  
SET NOCOUNT ON  
  
BEGIN TRAN  
  
SELECT MAX(idx)  
  FROM dbo.define_custom_customidx  
  
INSERT INTO dbo.define_custom_customidx (accountIDX)  
VALUES (@accountIDX)  
  
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[game_encode_get_fix_key]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_encode_get_fix_key]

AS

SET NOCOUNT ON

SELECT encodeKey
  FROM dbo.define_encode_key WITH(NOLOCK)
 WHERE idx = (
	SELECT MAX(idx)
	  FROM dbo.define_encode_key WITH(NOLOCK)
	)
GO
/****** Object:  StoredProcedure [dbo].[game_event_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_event_add]
(
	@accountIDX int
,	@value1 int
,	@value2 int
,	@eventType int
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userEventDB (accountIDX, value1, value2, eventType, regDate)
VALUES (@accountIDX, @value1, @value2, @eventType, GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[game_event_bingo_number_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_event_bingo_number_add]
(
	@accountIDX int
,	@num1 tinyint
,	@num2 tinyint
,	@num3 tinyint
,	@num4 tinyint
,	@num5 tinyint
,	@num6 tinyint
,	@num7 tinyint
,	@num8 tinyint
,	@num9 tinyint
,	@num10 tinyint
,	@num11 tinyint
,	@num12 tinyint
,	@num13 tinyint
,	@num14 tinyint
,	@num15 tinyint
,	@num16 tinyint
,	@num17 tinyint
,	@num18 tinyint
,	@num19 tinyint
,	@num20 tinyint
,	@num21 tinyint
,	@num22 tinyint
,	@num23 tinyint
,	@num24 tinyint
,	@num25 tinyint
)
AS

SET NOCOUNT ON

IF( EXISTS( SELECT * FROM dbo.userEventBingo_Number WITH( NOLOCK ) WHERE accountIDX = @accountIDX ) )
BEGIN
	RETURN
END
ELSE
BEGIN
	INSERT INTO dbo.userEventBingo_Number(
		accountidx,
		number1, number2, number3, number4, number5, number6, number7, number8, number9, number10,
	    number11, number12, number13, number14, number15, number16, number17, number18, number19, number20,
	    number21, number22, number23, number24, number25, regDate
	)
	VALUES (
		@accountIDX,
		@num1, @num2, @num3, @num4, @num5, @num6, @num7, @num8, @num9, @num10,
		@num11, @num12, @num13, @num14, @num15, @num16, @num17, @num18, @num19, @num20,
		@num21, @num22, @num23, @num24, @num25, GETDATE()
	)
END
GO
/****** Object:  StoredProcedure [dbo].[game_event_bingo_number_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_event_bingo_number_get]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

IF ( EXISTS(SELECT * FROM dbo.userEventBingo_Number WITH( NOLOCK ) WHERE accountIDX = @accountIDX) )
BEGIN
	SELECT number1, number2, number3, number4, number5, number6, number7, number8, number9, number10,
		   number11, number12, number13, number14, number15, number16, number17, number18, number19, number20,
		   number21, number22, number23, number24, number25
	  FROM dbo.userEventBingo_Number WITH( NOLOCK )
	 WHERE accountIDX = @accountIDX
END
ELSE
BEGIN
	-- return 0, 0, 0, ... 0
	SELECT 0 AS number1, 0 AS number2, 0 AS number3, 0 AS number4, 0 AS number5, 0 AS number6, 0 AS number7, 0 AS number8, 0 AS number9, 0 AS number10,
		   0 AS number11, 0 AS number12, 0 AS number13, 0 AS number14, 0 AS number15, 0 AS number16, 0 AS number17, 0 AS number18, 0 AS number19, 0 AS number20,
		   0 AS number21, 0 AS number22, 0 AS number23, 0 AS number24, 0 AS number25
END
GO
/****** Object:  StoredProcedure [dbo].[game_event_bingo_number_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_event_bingo_number_save]
(
	@accountIDX int
,	@num1 tinyint
,	@num2 tinyint
,	@num3 tinyint
,	@num4 tinyint
,	@num5 tinyint
,	@num6 tinyint
,	@num7 tinyint
,	@num8 tinyint
,	@num9 tinyint
,	@num10 tinyint
,	@num11 tinyint
,	@num12 tinyint
,	@num13 tinyint
,	@num14 tinyint
,	@num15 tinyint
,	@num16 tinyint
,	@num17 tinyint
,	@num18 tinyint
,	@num19 tinyint
,	@num20 tinyint
,	@num21 tinyint
,	@num22 tinyint
,	@num23 tinyint
,	@num24 tinyint
,	@num25 tinyint
)
AS

SET NOCOUNT ON

UPDATE dbo.userEventBingo_Number
   SET number1 = @num1,
	   number2 = @num2,
	   number3 = @num3,
	   number4 = @num4,
	   number5 = @num5,
	   number6 = @num6,
	   number7 = @num7,
	   number8 = @num8,
	   number9 = @num9,
	   number10 = @num10,
	   number11 = @num11,
	   number12 = @num12,
	   number13 = @num13,
	   number14 = @num14,
	   number15 = @num15,
	   number16 = @num16,
	   number17 = @num17,
	   number18 = @num18,
	   number19 = @num19,
	   number20 = @num20,
	   number21 = @num21,
	   number22 = @num22,
	   number23 = @num23,
	   number24 = @num24,
	   number25 = @num25
WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_event_bingo_present_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_event_bingo_present_add]
(
	@accountIDX int
,	@item1 tinyint
,	@item2 tinyint
,	@item3 tinyint
,	@item4 tinyint
,	@item5 tinyint
,	@item6 tinyint
,	@item7 tinyint
,	@item8 tinyint
,	@item9 tinyint
,	@item10 tinyint
,	@item11 tinyint
,	@item12 tinyint
,	@item13 tinyint
)
AS

SET NOCOUNT ON

IF( EXISTS( SELECT * FROM dbo.userEventBingo_Present WITH( NOLOCK ) WHERE accountIDX = @accountIDX ) )
BEGIN
	RETURN
END
ELSE
BEGIN
	INSERT INTO dbo.userEventBingo_Present(
		accountidx, item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12, item13, regDate
	)
	VALUES (
		@accountIDX, @item1, @item2, @item3, @item4, @item5, @item6, @item7, @item8, @item9, @item10, @item11, @item12, @item13, GETDATE()
	)
END
GO
/****** Object:  StoredProcedure [dbo].[game_event_bingo_present_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_event_bingo_present_get]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

IF ( EXISTS(SELECT * FROM dbo.userEventBingo_Present WITH( NOLOCK ) WHERE accountIDX = @accountIDX) )
BEGIN
	SELECT item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12, item13
	  FROM dbo.userEventBingo_Present WITH( NOLOCK )
	 WHERE accountIDX = @accountIDX
END
ELSE
BEGIN
	-- return 0, 0, 0, ... 0
	SELECT 0 AS item1, 0 AS item2, 0 AS item3, 0 AS item4, 0 AS item5, 0 AS item6, 0 AS item7, 0 AS item8, 0 AS item9, 0 AS item10, 0 AS item11, 0 AS item12, 0 AS item13
END
GO
/****** Object:  StoredProcedure [dbo].[game_event_bingo_present_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_event_bingo_present_save]
(
	@accountIDX int
,	@item1 tinyint
,	@item2 tinyint
,	@item3 tinyint
,	@item4 tinyint
,	@item5 tinyint
,	@item6 tinyint
,	@item7 tinyint
,	@item8 tinyint
,	@item9 tinyint
,	@item10 tinyint
,	@item11 tinyint
,	@item12 tinyint
,	@item13 tinyint
)
AS

SET NOCOUNT ON

UPDATE dbo.userEventBingo_Present
   SET item1 = @item1,
	   item2 = @item2,
	   item3 = @item3,
	   item4 = @item4,
	   item5 = @item5,
	   item6 = @item6,
	   item7 = @item7,
	   item8 = @item8,
	   item9 = @item9,
	   item10 = @item10,
	   item11 = @item11,
	   item12 = @item12,
	   item13 = @item13
WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_event_chuchun_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_event_chuchun_get_data]
(
	@accountIDX int
)
AS
	SELECT idx, friendIDX FROM event_chuchun WITH(NOLOCK) WHERE accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_event_get_createIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_event_get_createIDX]
(
	@accountIDX int
,	@eventType int
)
AS

SET NOCOUNT ON

SELECT MAX(idx)
  FROM dbo.userEventDB
 WHERE accountIDX=@accountIDX
   AND eventType=@eventType
GO
/****** Object:  StoredProcedure [dbo].[game_event_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_event_get_data]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT idx, eventType, value1, value2
  FROM dbo.userEventDB WITH(NOLOCK)
 WHERE accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_event_openbeta_coin_log]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_event_openbeta_coin_log]
(
	@accountIDX int
,	@coin int
)
AS

SET NOCOUNT ON

INSERT INTO LosaGame_log.DBO.log_event_openbeta_coin (accountIDX, coin, flag, regDate)
VALUES (@accountIDX, @coin, 0, GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[game_event_PirateRoulette_number_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_event_PirateRoulette_number_get]  
(  
 @accountIDX int  
)  
AS  
  
SET NOCOUNT ON  
  
IF ( EXISTS(SELECT * FROM dbo.userEventPirateRoulette_Number WITH( NOLOCK ) WHERE accountIDX = @accountIDX) )  
BEGIN  
 SELECT HP, slot1, slot2, slot3, slot4, slot5  
  , slot6, slot7, slot8, slot9, slot10  
  , slot11, slot12, slot13, slot14, slot15  
  , slot16, slot17, slot18, slot19, slot20  
  , slot21, slot22, slot23, slot24, slot25  
  , slot26, slot27, slot28, slot29, slot30  
  , slot31, slot32, slot33, slot34, slot35  
  , slot36, slot37, slot38, slot39, slot40   
   FROM dbo.userEventPirateRoulette_Number WITH( NOLOCK )  
   
  WHERE accountIDX = @accountIDX  
END  
ELSE  
BEGIN  
 SELECT -1 AS HP  
  , 0 AS slot1, 0 AS slot2, 0 AS slot3, 0 AS slot4, 0 AS slot5  
  , 0 AS slot6, 0 AS slot7, 0 AS slot8, 0 AS slot9, 0 AS slot10  
  , 0 AS slot11, 0 AS slot12, 0 AS slot13, 0 AS slot14, 0 AS slot15  
  , 0 AS slot16, 0 AS slot17, 0 AS slot18, 0 AS slot19, 0 AS slot20  
  , 0 AS slot21, 0 AS slot22, 0 AS slot23, 0 AS slot24, 0 AS slot25  
  , 0 AS slot26, 0 AS slot27, 0 AS slot28, 0 AS slot29, 0 AS slot30  
  , 0 AS slot31, 0 AS slot32, 0 AS slot33, 0 AS slot34, 0 AS slot35  
  , 0 AS slot36, 0 AS slot37, 0 AS slot38, 0 AS slot39, 0 AS slot40  
END
GO
/****** Object:  StoredProcedure [dbo].[game_event_PirateRoulette_present_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_event_PirateRoulette_present_get]  
(  
 @accountIDX int  
)  
AS  
  
SET NOCOUNT ON  
  
IF ( EXISTS(SELECT * FROM dbo.userEventPirateRoulette_Present WITH( NOLOCK ) WHERE accountIDX = @accountIDX) )  
BEGIN  
 SELECT reward1, reward2, reward3, reward4, reward5,  
     reward6, reward7, reward8, reward9, reward10  
--     reward11, reward12, reward13, reward14, reward15  
   FROM dbo.userEventPirateRoulette_Present WITH( NOLOCK )  
  WHERE accountIDX = @accountIDX  
END  
ELSE  
BEGIN  
 SELECT 0 AS reward1, 0 AS reward2, 0 AS reward3, 0 AS reward4, 0 AS reward5,  
     0 AS reward6, 0 AS reward7, 0 AS reward8, 0 AS reward9, 0 AS reward10  
--     0 AS reward11, 0 AS reward12, 0 AS reward13, 0 AS reward14, 0 AS reward15    
END
GO
/****** Object:  StoredProcedure [dbo].[game_event_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_event_save]
(
	@idx int
,	@value1 int
,	@value2 int
)
AS

SET NOCOUNT ON

UPDATE dbo.userEventDB
   SET value1 = @value1,
	   value2 = @value2
 WHERE idx = @idx
GO
/****** Object:  StoredProcedure [dbo].[game_factiontype_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_factiontype_save]
(
	@accountIDX int
,	@factionType int
)
AS

SET NOCOUNT ON

UPDATE dbo.userGameDB
   SET regionType=@factionType
 WHERE accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_fame_give_point]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_fame_give_point]
(
	@playType int
,	@modeType int
,	@sub1Type int
,	@sub2Type int
,	@reportIDX int
,	@reportNick varchar(20)
,	@reportpubIP varchar(15)
,	@reportpriIP varchar(15)
,	@receiveNick varchar(20)
,	@receivepubIP varchar(15)
,	@roomInfo varchar(3000)
,	@chatInfo varchar(2000)
,	@note varchar(200)
)
AS

SET NOCOUNT ON

DECLARE @receiveIDX int
SET @receiveIDX = (
	SELECT accountIDX
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE nickName=@receiveNick
)

INSERT INTO LosaGame_log.DBO.log_mannerpoint (
	playType, modeType, sub1Type, sub2Type, reportIDX, reportNick, reportpubIP, reportpriIP, receiveIDX, receiveNick, receivepubIP, roomInfo, chatInfo, note, regDate
)
VALUES (
	@playType, @modeType, @sub1Type, @sub2Type, @reportIDX, @reportNick, @reportpubIP, @reportpriIP, @receiveIDX, @receiveNick, @receivepubIP, @roomInfo, @chatInfo, @note, GETDATE()
)
GO
/****** Object:  StoredProcedure [dbo].[game_fish_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_fish_add]
(
	@accountIDX int
,	@fish1_type tinyint
,	@fish1_an int
,	@fish2_type tinyint
,	@fish2_an int
,	@fish3_type tinyint
,	@fish3_an int
,	@fish4_type tinyint
,	@fish4_an int
,	@fish5_type tinyint
,	@fish5_an int
,	@fish6_type tinyint
,	@fish6_an int
,	@fish7_type tinyint
,	@fish7_an int
,	@fish8_type tinyint
,	@fish8_an int
,	@fish9_type tinyint
,	@fish9_an int
,	@fish10_type tinyint
,	@fish10_an int
,	@fish11_type tinyint
,	@fish11_an int
,	@fish12_type tinyint
,	@fish12_an int
,	@fish13_type tinyint
,	@fish13_an int
,	@fish14_type tinyint
,	@fish14_an int
,	@fish15_type tinyint
,	@fish15_an int
,	@fish16_type tinyint
,	@fish16_an int
,	@fish17_type tinyint
,	@fish17_an int
,	@fish18_type tinyint
,	@fish18_an int
,	@fish19_type tinyint
,	@fish19_an int
,	@fish20_type tinyint
,	@fish20_an int
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userFishDB (
	accountIDX, 
	fish1_type, fish1_an, fish2_type, fish2_an, fish3_type, fish3_an, fish4_type, fish4_an, fish5_type, fish5_an,
	fish6_type, fish6_an, fish7_type, fish7_an, fish8_type, fish8_an, fish9_type, fish9_an, fish10_type, fish10_an,
	fish11_type, fish11_an, fish12_type, fish12_an, fish13_type, fish13_an, fish14_type, fish14_an, fish15_type, fish15_an,
	fish16_type, fish16_an, fish17_type, fish17_an, fish18_type, fish18_an, fish19_type, fish19_an, fish20_type, fish20_an,
	regDate
)
VALUES (
	@accountIDX, 
	@fish1_type, @fish1_an, @fish2_type, @fish2_an, @fish3_type, @fish3_an, @fish4_type, @fish4_an, @fish5_type, @fish5_an,
	@fish6_type, @fish6_an, @fish7_type, @fish7_an, @fish8_type, @fish8_an, @fish9_type, @fish9_an, @fish10_type, @fish10_an,
	@fish11_type, @fish11_an, @fish12_type, @fish12_an, @fish13_type, @fish13_an, @fish14_type, @fish14_an, @fish15_type, @fish15_an,
	@fish16_type, @fish16_an, @fish17_type, @fish17_an, @fish18_type, @fish18_an, @fish19_type, @fish19_an, @fish20_type, @fish20_an,
	GETDATE()
)
GO
/****** Object:  StoredProcedure [dbo].[game_fish_get_data_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_fish_get_data_list]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT idx,
	   fish1_type, fish1_an, fish2_type, fish2_an, fish3_type, fish3_an, fish4_type, fish4_an, fish5_type, fish5_an,
	   fish6_type, fish6_an, fish7_type, fish7_an, fish8_type, fish8_an, fish9_type, fish9_an, fish10_type, fish10_an,
	   fish11_type, fish11_an, fish12_type, fish12_an, fish13_type, fish13_an, fish14_type, fish14_an, fish15_type, fish15_an,
	   fish16_type, fish16_an, fish17_type, fish17_an, fish18_type, fish18_an, fish19_type, fish19_an, fish20_type, fish20_an 
  FROM dbo.userFishDB WITH(NOLOCK)
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_fish_get_self_index]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_fish_get_self_index]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT TOP 1 idx
  FROM dbo.userFishDB
 WHERE accountIDX = @accountIDX
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_fish_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_fish_save]
(
	@idx int
,	@fish1_type tinyint
,	@fish1_an int
,	@fish2_type tinyint
,	@fish2_an int
,	@fish3_type tinyint
,	@fish3_an int
,	@fish4_type tinyint
,	@fish4_an int
,	@fish5_type tinyint
,	@fish5_an int
,	@fish6_type tinyint
,	@fish6_an int
,	@fish7_type tinyint
,	@fish7_an int
,	@fish8_type tinyint
,	@fish8_an int
,	@fish9_type tinyint
,	@fish9_an int
,	@fish10_type tinyint
,	@fish10_an int
,	@fish11_type tinyint
,	@fish11_an int
,	@fish12_type tinyint
,	@fish12_an int
,	@fish13_type tinyint
,	@fish13_an int
,	@fish14_type tinyint
,	@fish14_an int
,	@fish15_type tinyint
,	@fish15_an int
,	@fish16_type tinyint
,	@fish16_an int
,	@fish17_type tinyint
,	@fish17_an int
,	@fish18_type tinyint
,	@fish18_an int
,	@fish19_type tinyint
,	@fish19_an int
,	@fish20_type tinyint
,	@fish20_an int
)
AS

SET NOCOUNT ON

UPDATE dbo.userFishDB
   SET fish1_type = @fish1_type,
	   fish1_an = @fish1_an,
	   fish2_type = @fish2_type,
	   fish2_an = @fish2_an,
	   fish3_type = @fish3_type,
	   fish3_an = @fish3_an,
	   fish4_type = @fish4_type,
	   fish4_an = @fish4_an,
	   fish5_type = @fish5_type,
	   fish5_an = @fish5_an,
	   fish6_type = @fish6_type,
	   fish6_an = @fish6_an,
	   fish7_type = @fish7_type,
	   fish7_an = @fish7_an,
	   fish8_type = @fish8_type,
	   fish8_an = @fish8_an,
	   fish9_type = @fish9_type,
	   fish9_an = @fish9_an,
	   fish10_type = @fish10_type,
	   fish10_an = @fish10_an,
	   fish11_type = @fish11_type,
	   fish11_an = @fish11_an,
	   fish12_type = @fish12_type,
	   fish12_an = @fish12_an,
	   fish13_type = @fish13_type,
	   fish13_an = @fish13_an,
	   fish14_type = @fish14_type,
	   fish14_an = @fish14_an,
	   fish15_type = @fish15_type,
	   fish15_an = @fish15_an,
	   fish16_type = @fish16_type,
	   fish16_an = @fish16_an,
	   fish17_type = @fish17_type,
	   fish17_an = @fish17_an,
	   fish18_type = @fish18_type,
	   fish18_an = @fish18_an,
	   fish19_type = @fish19_type,
	   fish19_an = @fish19_an,
	   fish20_type = @fish20_type,
	   fish20_an = @fish20_an
 WHERE idx = @idx
GO
/****** Object:  StoredProcedure [dbo].[game_friend_best_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_friend_best_add]
(
	@accountIDX int
,	@friendIDX int
)
AS

SET NOCOUNT ON

DECLARE @cnt int

SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE accountIDX=@friendIDX
)

IF (@cnt > 0)
BEGIN
	INSERT INTO dbo.userFriendBestDB (accountIDX, friendIDX, flag, flagTime, regDate)
	VALUES (@accountIDX, @friendIDX, 1, 0, GETDATE())
END
GO
/****** Object:  StoredProcedure [dbo].[game_friend_best_add_self_index]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_friend_best_add_self_index]
(
	@accountIDX int
,	@friendIDX int
)
AS

SET NOCOUNT ON

SELECT TOP 1 idx
  FROM dbo.userFriendBestDB 
 WHERE accountIDX=@accountIDX
   AND friendIDX=@friendIDX
   AND flag=1
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_friend_best_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_friend_best_delete]
(
	@idx int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userFriendBestDB
 WHERE idx=@idx
GO
/****** Object:  StoredProcedure [dbo].[game_friend_best_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_friend_best_list]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT idx, friendIDX, flag, flagTime
  FROM dbo.userFriendBestDB WITH(NOLOCK)
 WHERE accountIDX=@accountIDX
   AND flag > 0
 ORDER BY idx ASC
GO
/****** Object:  StoredProcedure [dbo].[game_friend_best_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_friend_best_save]
(
	@idx int
,	@flag int
,	@flagTime int
)
AS

SET NOCOUNT ON

UPDATE dbo.userFriendBestDB
   SET flag=@flag,
	   flagTime=@flagTime
 WHERE idx=@idx
GO
/****** Object:  StoredProcedure [dbo].[game_friend_check_member]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_friend_check_member]
(
	@friendNickName varchar (20)
)
AS

SET NOCOUNT ON

SELECT userID, nickName, accountIDX
  FROM dbo.userMemberDB WITH(NOLOCK)
 WHERE nickName = @friendNickName
GO
/****** Object:  StoredProcedure [dbo].[game_friend_clover_info_update]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_friend_clover_info_update]
(
	@index int
,	@sendCount int
,	@sendDate int
,	@receiveCount int
,	@receiveDate int
,	@BeforeReceiveCount int
)
AS

SET NOCOUNT ON

UPDATE dbo.userFriendDB
   SET sendCloverCnt = @sendCount,
	   sendCloverDate = @sendDate,
	   receiveCloverCnt = @receiveCount,
	   receiveCloverDate = @receiveDate,
	   receiveBCloverCnt = @BeforeReceiveCount
 WHERE idx = @index
GO
/****** Object:  StoredProcedure [dbo].[game_friend_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_friend_delete]
(
	@accountIDX int
,	@friendNick varchar(20)
)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

DECLARE @friendIDX int
SET @friendIDX = ISNULL((SELECT accountIDX FROM dbo.userMemberDB WHERE nickName=@friendNick), -1)

BEGIN TRAN

IF (@friendIDX > 0)
BEGIN
	DELETE FROM dbo.userFriendDB WHERE userAccIDX=@accountIDX and friendAccIDX=@friendIDX
	DELETE FROM dbo.userFriendDB WHERE friendAccIDX=@accountIDX and userAccIDX=@friendIDX
END

COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[game_friend_dev_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_friend_dev_add]
(
	@accountIDX int
,	@friendNick varchar(20)
)
AS

SET NOCOUNT ON

DECLARE @cnt int
DECLARE @errcount int
DECLARE @friendIDX int

SET @cnt = 0
SET @errcount = 0
SET @friendIDX = ISNULL((
	SELECT accountIDX
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE nickName=@friendNick
), -1)

IF (@friendIDX < 0)
BEGIN
	SET @errcount = 2
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @cnt = (
	SELECT count(*)
	  FROM dbo.userFriendDB WITH(NOLOCK)
	 WHERE userAccIDX=@accountIDX
	   AND friendAccIDX=@friendIDX
	   AND flag=1
)

IF (@cnt > 0)
BEGIN
	SET @errcount = 4
	SELECT @errcount AS 'returnVal'
	RETURN
END

IF (@errcount > 0)
BEGIN
	SELECT @errcount AS 'returnVal'
END
ELSE
BEGIN
	SELECT 1 AS 'returnVal'

	INSERT INTO userFriendDB (
		userAccIDX, friendAccIDX, sendCloverCnt, sendCloverDate, receiveCloverCnt, receiveCloverDate, receiveBCloverCnt, flag, regDate
	)
	VALUES (
		@friendIDX, @accountIDX, 0, 0, 0, 0, 0, 1, GETDATE()
	)

	INSERT INTO userFriendDB (
		userAccIDX, friendAccIDX, sendCloverCnt, sendCloverDate, receiveCloverCnt, receiveCloverDate, receiveBCloverCnt, flag, regDate
	)
	VALUES (
		@accountIDX, @friendIDX, 0, 0, 0, 0, 0, 1, GETDATE()
	)
END
GO
/****** Object:  StoredProcedure [dbo].[game_friend_join_app]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_friend_join_app]
(
	@accountIDX int
,	@friendIDX int
)
AS

--	SET XACT_ABORT ON
SET NOCOUNT ON

DECLARE @default int
DECLARE @cnt int
DECLARE @errcount int
DECLARE @guildIDX int
DECLARE @myextend int
DECLARE @youextend int

SET @default = 100
SET @cnt = 0
SET @errcount = 0
SET @myextend = 0
SET @youextend = 0

SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE accountIDX=@friendIDX
)

IF (@cnt = 0)
BEGIN
	SET @errcount = 2
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userFriendDB WITH(NOLOCK)
	 WHERE userAccIDX=@accountIDX
	   AND flag=1
)

IF (@cnt >= @default)
BEGIN
	SET @myextend = (
		SELECT ISNULL(SUM(CASE item1_type WHEN 4000002 THEN item1_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item2_type WHEN 4000002 THEN item2_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item3_type WHEN 4000002 THEN item3_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item4_type WHEN 4000002 THEN item4_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item5_type WHEN 4000002 THEN item5_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item6_type WHEN 4000002 THEN item6_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item7_type WHEN 4000002 THEN item7_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item8_type WHEN 4000002 THEN item8_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item9_type WHEN 4000002 THEN item9_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item10_type WHEN 4000002 THEN item10_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item11_type WHEN 4000002 THEN item11_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item12_type WHEN 4000002 THEN item12_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item13_type WHEN 4000002 THEN item13_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item14_type WHEN 4000002 THEN item14_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item15_type WHEN 4000002 THEN item15_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item16_type WHEN 4000002 THEN item16_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item17_type WHEN 4000002 THEN item17_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item18_type WHEN 4000002 THEN item18_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item19_type WHEN 4000002 THEN item19_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item20_type WHEN 4000002 THEN item20_value1 ELSE 0 END), 0)
		  FROM dbo.userItemEtcDB WITH(NOLOCK)
		 WHERE accountIDX=@accountIDX
	)
END

IF (@cnt >= (@myextend + @default))
BEGIN
	SET @errcount = 3
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userFriendDB WITH(NOLOCK)
	 WHERE userAccIDX=@friendIDX
	   AND flag=1
)

IF (@cnt >= @default)
BEGIN
	SET @youextend = (
		SELECT ISNULL(SUM(CASE item1_type WHEN 4000002 THEN item1_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item2_type WHEN 4000002 THEN item2_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item3_type WHEN 4000002 THEN item3_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item4_type WHEN 4000002 THEN item4_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item5_type WHEN 4000002 THEN item5_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item6_type WHEN 4000002 THEN item6_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item7_type WHEN 4000002 THEN item7_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item8_type WHEN 4000002 THEN item8_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item9_type WHEN 4000002 THEN item9_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item10_type WHEN 4000002 THEN item10_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item11_type WHEN 4000002 THEN item11_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item12_type WHEN 4000002 THEN item12_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item13_type WHEN 4000002 THEN item13_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item14_type WHEN 4000002 THEN item14_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item15_type WHEN 4000002 THEN item15_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item16_type WHEN 4000002 THEN item16_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item17_type WHEN 4000002 THEN item17_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item18_type WHEN 4000002 THEN item18_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item19_type WHEN 4000002 THEN item19_value1 ELSE 0 END), 0) +
			   ISNULL(SUM(CASE item20_type WHEN 4000002 THEN item20_value1 ELSE 0 END), 0)
		  FROM dbo.userItemEtcDB WITH(NOLOCK)
		 WHERE accountIDX=@friendIDX
	)
END

IF (@cnt >= (@youextend + @default))
BEGIN
	SET @errcount = 4
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userFriendDB WITH(NOLOCK)
	 WHERE userAccIDX=@accountIDX
	   AND friendAccIDX=@friendIDX
	   AND flag=1
)

IF (@cnt > 0)
BEGIN
	SET @errcount = 5
	SELECT @errcount AS 'returnVal'
	RETURN
END

/*
SET @cnt = 0
SET @guildIDX = ISNULL((SELECT guildIDX FROM userGuildInfoDB WHERE accountIDX=@accountIDX and guildJoinType=1), -1)
if (@guildIDX > 0)
BEGIN
	SET @cnt = (SELECT count(*) FROM userGuildInfoDB WHERE guildIDX=@guildIDX and accountIDX=@friendIDX and guildJoinType=1)
END
if (@cnt > 0)
BEGIN
	SET @errcount = 6
	SELECT @errcount AS 'returnVal'
	RETURN
END
*/

BEGIN TRAN

IF (@errcount = 0)
BEGIN
	SELECT 1 AS 'returnVal'

	DELETE FROM dbo.userFriendDB
	 WHERE userAccIDX=@accountIDX
	   AND friendAccIDX=@friendIDX
	   AND flag=0

	INSERT INTO userFriendDB (
		userAccIDX, friendAccIDX, sendCloverCnt, sendCloverDate, receiveCloverCnt, receiveCloverDate, receiveBCloverCnt, flag, regDate
	)
	VALUES (
		@accountIDX, @friendIDX, 0, 0, 0, 0, 0, 1, GETDATE()
	)
	
	INSERT INTO userFriendDB (
		userAccIDX, friendAccIDX, sendCloverCnt, sendCloverDate, receiveCloverCnt, receiveCloverDate, receiveBCloverCnt, flag, regDate
	)
	VALUES (
		@friendIDX, @accountIDX, 0, 0, 0, 0, 0, 1, GETDATE()
	)
END

COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[game_friend_join_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_friend_join_delete]
(
	@idx int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userFriendDB
 WHERE idx=@idx
   AND flag=0
GO
/****** Object:  StoredProcedure [dbo].[game_friend_join_in]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_friend_join_in]
(
	@accountIDX int
,	@friendNick varchar(20)
)
AS

SET NOCOUNT ON

DECLARE @cnt int
DECLARE @errcount int
DECLARE @friendIDX int
DECLARE @eventType int
DECLARE @maxJoinCnt int

SET @cnt = 0
SET @errcount = 0
SET @maxJoinCnt = 20
SET @friendIDX = ISNULL((
	SELECT accountIDX
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE nickName=@friendNick
), -1)

IF (@friendIDX < 0)
BEGIN
	SET @errcount = 2
	SELECT @errcount AS 'returnVal'
	RETURN
END

/*
SET @eventType = isNull((SELECT eventType FROM userMemberDB WITH(NOLOCK) WHERE nickName=@friendNick), 0)
if (@eventType = 1)
BEGIN
	SET @errcount = 7
	SELECT @errcount AS 'returnVal'
	RETURN
END
*/

SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userFriendDB WITH(NOLOCK)
	 WHERE userAccIDX=@accountIDX
	   AND friendAccIDX=@friendIDX
	   AND flag=0
)

IF (@cnt > 0)
BEGIN
	SET @errcount = 3
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userFriendDB WITH(NOLOCK)
	 WHERE userAccIDX=@accountIDX
	   AND friendAccIDX=@friendIDX
	   AND flag=1
)

IF (@cnt > 0)
BEGIN
	SET @errcount = 4
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userFriendDB WITH(NOLOCK)
	 WHERE userAccIDX=@friendIDX
	   AND friendAccIDX=@accountIDX
	   AND flag=0
)

IF (@cnt > 0)
BEGIN
	SET @errcount = 5
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userFriendDB WITH(NOLOCK)
	 WHERE userAccIDX=@friendIDX
	   AND flag=0
)

IF (@cnt >= @maxJoinCnt)
BEGIN
	SET @errcount = 8
	SELECT @errcount AS 'returnVal'
	RETURN
END

IF (@errcount > 0)
BEGIN
	SELECT @errcount AS 'returnVal'
END
ELSE
BEGIN
	SELECT 1 AS 'returnVal'
	INSERT INTO userFriendDB (
		userAccIDX, friendAccIDX, sendCloverCnt, sendCloverDate, receiveCloverCnt, receiveCloverDate, receiveBCloverCnt, flag, regDate
	)
	VALUES (
		@friendIDX, @accountIDX, 0, 0, 0, 0, 0, 0, GETDATE()
	)
END
GO
/****** Object:  StoredProcedure [dbo].[game_friend_join_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_friend_join_list]
(
	@idx int
,	@accountIDX int
,	@topNo int
)
AS

SET NOCOUNT ON

SELECT TOP (@topNo) a.idx, a.friendAccIDX, b.nickName
  FROM dbo.userFriendDB a WITH(NOLOCK)
  JOIN userMemberDB b WITH(NOLOCK)
	ON a.friendAccIDX = b.accountIDX
 WHERE a.userAccIDX = @accountIDX
	   AND a.idx < @idx
	   AND flag=0
 ORDER BY a.idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_friend_list_asc]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_friend_list_asc]
(
	@idx int
,	@accountIDX int
,	@topNo int
)
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

SELECT TOP (@topNo) a.idx, a.friendAccIDX, b.nickName, a.regDate,
	   a.sendCloverCnt, a.sendCloverDate, a.receiveCloverCnt, a.receiveCloverDate, a.receiveBCloverCnt
  FROM userFriendDB a WITH (INDEX (idx_userAccIDX))
 INNER LOOP JOIN userMemberDB b WITH (INDEX (idx_accountIDX))
	ON a.friendAccIDX = b.accountIDX
 WHERE a.userAccIDX = @accountIDX
   AND a.flag=1
   AND a.idx > @idx
 ORDER BY a.idx ASC
GO
/****** Object:  StoredProcedure [dbo].[game_friend_list_asc_debug]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_friend_list_asc_debug]
(
	@idx		int
,	@accountIDX int
,	@topNo		int
)
AS
DECLARE @strSQL nvarchar(1000)
	DECLARE @ParmDefinition nvarchar(500)

	SET @strSQL = N'SELECT Top (@topNo_in) a.idx, a.friendAccIDX, b.nickName, a.regDate from userFriendDB a WITH (INDEX (idx_userAccIDX)) join userMemberDB b WITH (INDEX (idx_accountIDX)) on a.friendAccIDX = b.accountIDX '
	SET @strSQL = @strSQL + ' WHERE a.userAccIDX = @accountIDX_in  and a.idx > @idx_in and a.flag=1 order by a.idx asc'

	SET @ParmDefinition = N'@topNo_in int, @accountIDX_in int, @idx_in int'

	EXECUTE sp_executesql @strSQL, @ParmDefinition, @idx_in=@idx, @accountIDX_in=@accountIDX, @topNo_in=@topNo
GO
/****** Object:  StoredProcedure [dbo].[game_friend_list_asc_org]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_friend_list_asc_org]
(
	@idx		int
,	@accountIDX int
,	@topNo		int
)
AS
DECLARE @strSQL nvarchar(1000)
	DECLARE @ParmDefinition nvarchar(500)

	SET @strSQL = N'SELECT Top (@topNo_in) a.idx, a.friendAccIDX, b.nickName, a.regDate from userFriendDB a WITH(NOLOCK) join userMemberDB b WITH(NOLOCK) on a.friendAccIDX = b.accountIDX '
	SET @strSQL = @strSQL + ' WHERE a.userAccIDX = @accountIDX_in  and a.idx > @idx_in and a.flag=1 order by a.idx asc'

	SET @ParmDefinition = N'@topNo_in int, @accountIDX_in int, @idx_in int'

	EXECUTE sp_executesql @strSQL, @ParmDefinition, @idx_in=@idx, @accountIDX_in=@accountIDX, @topNo_in=@topNo
GO
/****** Object:  StoredProcedure [dbo].[game_friend_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_friend_save]
(
	@userAccIDX int
,	@friendNickName varchar(20)
)
AS

SET NOCOUNT ON

DECLARE @cnt int
DECLARE @friendAccIDX int

SET @friendAccIDX = (
	SELECT accountIDX
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE nickname=@friendNickName
)

SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userFriendDB WITH(NOLOCK)
	 WHERE userAccIDX=@userAccIDX
	   AND friendAccIDX=@friendAccIDX
)

IF (@cnt = 0 AND @friendAccIDX IS NOT NULL)
BEGIN
	INSERT INTO dbo.userFriendDB (userAccIDX,friendAccIDX,regDate)
	VALUES (@userAccIDX, @friendAccIDX, GETDATE())
END
GO
/****** Object:  StoredProcedure [dbo].[game_game_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_game_get_data]
(
	@userID varchar(12)
)
As

SET NOCOUNT ON

SELECT a.accountIDX, b.userID, b.nickName, a.userState, a.gameMoney
	 , a.conn_count, a.connDate, a.userLevel, a.userEXP--, a.relateLevel
	 , b.eventType, isNull(c.class,0) as 'class', b.joinType, b.regDate, a.regionType
	 , a.rencpoint, a.renspoint, isNull(c.region,0) as 'region', b.cpType, ISNULL(d.cpID, '') AS 'cpID'
	 , ISNULL(d.note, '') AS 'cpUNIQ', b.limitType, b.limitDate, a.userFishingLevel, a.userFishingEXP
	 , a.refillData, a.userExcavationLevel, a.userExcavationEXP, a.userHerocEXP, a.userHerosEXP, ISNULL(sp.SpRank, 0) AS 'spRank'
  FROM userGameDB a WITH( NOLOCK )
  JOIN userMemberDB b WITH( NOLOCK )
	ON a.accountIDX = b.accountIDX
  LEFT JOIN userRankingDB c WITH( NOLOCK )
	ON a.accountIDX = c.accountIDX
  LEFT JOIN userCooperationDB d WITH( NOLOCK )
	ON a.accountIDX=d.accountIDX
  LEFT JOIN userSPRankDB sp WITH( NOLOCK )
	ON a.accountIDX=sp.AccountIDX WHERE b.userID = @userID
GO
/****** Object:  StoredProcedure [dbo].[game_game_heroexp_init]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_game_heroexp_init]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

UPDATE dbo.userGameDB
   SET userHerocEXP = 0,
	   userHerosEXP = 0
 WHERE accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_game_heroexp_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_game_heroexp_save]
(
	@accountIDX int
,	@heroEXP int
)
AS

SET NOCOUNT ON

UPDATE dbo.userGameDB
   SET userHerosEXP = @heroEXP 
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_game_renpoint_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_game_renpoint_save]
(
	@accountIDX int
,	@rencpoint int
,	@renspoint int
)
AS

SET NOCOUNT ON

UPDATE dbo.userGameDB
   SET rencpoint = @rencpoint,
	   renspoint = @renspoint
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_game_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_game_save]
(
	@accountIDX int
,	@userState int
,	@gameMoney bigint
,	@conn_count int
,	@connDate datetime
,	@userLevel int
,	@userEXP int
,	@playTime int
,	@regionType int
,	@userFishingLevel int
,	@userFishingEXP int
,	@refillData int
,	@userExcavationLevel int
,	@userExcavationEXP int
,	@init_time int
)
As

SET NOCOUNT ON

IF @userLevel < 50
BEGIN
	UPDATE dbo.userGameDB
	   SET gameMoney = @gameMoney
	,	userState = @userState
	,	playTime = playTime + Round((@playTime/1000)/60,0)
	,	conn_count = @conn_count
	,	userLevel = @userLevel
	,	userEXP = @userEXP
	,	userFishingLevel = @userFishingLevel
	,	userFishingEXP = @userFishingEXP
	,	regionType = @regionType
	,	connDate = @connDate
	,	refillData = @refillData
	,	userExcavationLevel = @userExcavationLevel
	,	userExcavationEXP = @userExcavationEXP 
	 WHERE accountIDX = @accountIDX

END
ELSE
BEGIN
	--
	IF( EXISTS( SELECT * FROM dbo.userRelativeLevelDB WITH( NOLOCK )
				 WHERE accountIDX = @accountIDX ) )
	BEGIN
		
		UPDATE dbo.userGameDB
		   SET gameMoney = @gameMoney
		,	userState = @userState
		,	playTime = playTime + Round((@playTime/1000)/60,0)
		,	conn_count = @conn_count
		--,	userLevel = @userLevel
		,	userEXP = @userEXP
		,	userFishingLevel = @userFishingLevel
		,	userFishingEXP = @userFishingEXP
		,	regionType = @regionType
		,	connDate = @connDate
		,	refillData = @refillData
		,	userExcavationLevel = @userExcavationLevel
		,	userExcavationEXP = @userExcavationEXP 
		 WHERE accountIDX = @accountIDX

		UPDATE dbo.userRelativeLevelDB
		   SET init_time = @init_time
		 WHERE accountIDX = @accountIDX

	END
	ELSE
	BEGIN
		UPDATE dbo.userGameDB
		   SET gameMoney = @gameMoney
		,	userState = @userState
		,	playTime = playTime + Round((@playTime/1000)/60,0)
		,	conn_count = @conn_count
		,	userLevel = @userLevel
		,	userEXP = @userEXP
		,	userFishingLevel = @userFishingLevel
		,	userFishingEXP = @userFishingEXP
		,	regionType = @regionType
		,	connDate = @connDate
		,	refillData = @refillData
		,	userExcavationLevel = @userExcavationLevel
		,	userExcavationEXP = @userExcavationEXP 
		 WHERE accountIDX = @accountIDX
	END
END
GO
/****** Object:  StoredProcedure [dbo].[game_game_sexp_deduct_init]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_game_sexp_deduct_init]

AS

SET NOCOUNT ON

UPDATE dbo.userGameDB
   SET userHerosEXP = 0
 WHERE userHerosEXP = -1
GO
/****** Object:  StoredProcedure [dbo].[game_get_age]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_get_age]
(
	@accountIDX int
)
AS
GO
/****** Object:  StoredProcedure [dbo].[game_get_age_from_id]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_get_age_from_id]
(
	@userID varchar(12)
)
AS



-- TO DO : CpType 추가 - 다음 셧다운 인증 처리(20150424)
SELECT b.userBirthday, b.userNumber, A.cpType FROM userMemberDB a WITH(NOLOCK) JOIN userNameDB b WITH(NOLOCK)  ON a.accountIDX=b.accountIDX
WHERE a.userID=@userID
GO
/****** Object:  StoredProcedure [dbo].[game_get_limitType]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_get_limitType]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT limitType, limitDate
  FROM dbo.userMemberDB WITH(NOLOCK)
 WHERE accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_get_nickname]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_get_nickname]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT nickName
  FROM dbo.userMemberDB WITH(NOLOCK)
 WHERE accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_get_nickname_from_id]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_get_nickname_from_id]
(
	@userID varchar(20)
)
As
	select top 1 
		nickName AS Nickname
	from WebLogin w  WITH (NOLOCK)
	inner join userMemberDB u WITH (NOLOCK)
	on w.Username = u.userID
	inner join userMoneyDB m WITH (NOLOCK)
	on u.accountIDX = m.accountIDX
	inner join userGameDB g WITH (NOLOCK)
	on g.accountIDX = m.accountIDX
	where u.userID = @userID;
GO
/****** Object:  StoredProcedure [dbo].[game_get_userID]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_get_userID]
(  
 @accountIDX int  
)  
AS  
  
SET NOCOUNT ON  
  
SELECT accountIDX, userid  
  FROM dbo.userMemberDB WITH(NOLOCK)  
 WHERE accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_getidx_from_id]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_getidx_from_id]
(
	@userID varchar(20)
)
As
	select top 1 
		u.accountIDX AS idx
	from WebLogin w  WITH (NOLOCK)
	inner join userMemberDB u WITH (NOLOCK)
	on w.Username = u.userID
	inner join userMoneyDB m WITH (NOLOCK)
	on u.accountIDX = m.accountIDX
	inner join userGameDB g WITH (NOLOCK)
	on g.accountIDX = m.accountIDX
	where u.userID = @userID;
GO
/****** Object:  StoredProcedure [dbo].[game_guild_attend_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_attend_get_list]

	@INIT_DATE		DATETIME,
	@GUILD_IDX		INT

AS

	SET NOCOUNT ON
	SET LOCK_TIMEOUT	10000

	DECLARE @nReturn			INT


	SELECT AccountIDX FROM dbo.userGuildAttendDB WITH (READCOMMITTED) 
	WHERE InitDate=@INIT_DATE and GuildIDX=@GUILD_IDX

	IF (@@ERROR<>0)
	BEGIN
		SELECT -1
		RETURN;
	END

RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_guild_attend_set_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_attend_set_add]

	@GUILD_IDX		INT,
	@ACCOUNT_IDX	INT

AS

	SET NOCOUNT ON
	SET LOCK_TIMEOUT	10000

	DECLARE @nReturn			INT
	DECLARE @REG_DATE			DATETIME
	DECLARE @INIT_DATE			DATETIME
		
	SET @REG_DATE=GETDATE()
	SET @INIT_DATE = 0
	
	-- 날짜 초기화
	EXEC @nReturn=dbo.usp_RegDate_get_init @REG_DATE, 5, @INIT_DATE OUTPUT
	IF (@nReturn<>0)
	BEGIN
		RETURN;
	END

	-- 이미 출석체크한 사용자는 같은날 다시 체크 할 수 없다.
	IF EXISTS (SELECT *  FROM dbo.userGuildAttendDB WITH (READCOMMITTED) WHERE InitDate=@INIT_DATE and AccountIDX=@ACCOUNT_IDX)
	BEGIN
		SELECT -1
		RETURN;
	END
	
	BEGIN TRAN
		-- 출석 체크
		INSERT dbo.userGuildAttendDB WITH (XLOCK, ROWLOCK) VALUES (@INIT_DATE, @ACCOUNT_IDX, @GUILD_IDX, @REG_DATE);
		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN
			SELECT -2
			RETURN;
		END

	COMMIT TRAN

	SELECT 0
	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_guild_battle_record_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_battle_record_save]
(
	@guildIDX int
,	@battleType int
,	@win int
,	@lose int
,	@killed int
,	@death int
)
AS

SET NOCOUNT ON

UPDATE dbo.userRecordGuildDB
   SET type1_win = @win, 
	   type1_lose = @lose, 
	   type1_kill = @killed, 
	   type1_death = @death 
 WHERE guildIDX = @guildIDX
GO
/****** Object:  StoredProcedure [dbo].[game_guild_change_guildname]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_change_guildname]
(
	@guildIDX int
,	@guildName varchar(20)
)
AS

SET NOCOUNT ON

DECLARE @cnt int, @errcount int

SET @cnt = 0
SET @errcount = 0

SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userGuildDB WITH(NOLOCK)
	 WHERE guildName=@guildName
)
IF (@cnt > 0)
BEGIN
	SET @errcount = 2
	SELECT @errcount AS 'returnVal'
	RETURN
END

IF (@errcount = 0)
BEGIN
	SELECT 1 AS 'returnVal'

	UPDATE dbo.userGuildDB
	   SET guildName=@guildName
	 WHERE idx=@guildIDX
END
GO
/****** Object:  StoredProcedure [dbo].[game_guild_change_master]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_change_master]
(
	@masterIDX int
,	@changeIDX int
,	@guildIDX int
)
AS

SET NOCOUNT ON

SET XACT_ABORT ON
BEGIN TRAN

UPDATE dbo.userGuildInfoDB
   SET guildPosition='Leader',
	   msg=4
 WHERE guildIDX=@guildIDX
   AND accountIDX=@changeIDX

UPDATE dbo.userGuildInfoDB
   SET guildPosition='Officer'
 WHERE guildIDX=@guildIDX
   AND accountIDX=@masterIDX

COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[game_guild_change_max_capacity]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_change_max_capacity]
(
	@guildIDX int
,	@n int
)
AS

SET NOCOUNT ON

DECLARE @membercount int, @maxcount int, @guildLevel int
SET @membercount = (
	SELECT COUNT(*)
	  FROM dbo.userGuildInfoDB WITH(NOLOCK)
	 WHERE guildIDX=@guildIDX
	   AND guildJoinType=1
)
SET @guildLevel = (
	SELECT guildLevel
	  FROM dbo.userGuildDB WITH(NOLOCK)
	 WHERE idx=@guildIDX
)

IF (@membercount > @n)
BEGIN
	SET @n = @membercount
END

SET @maxcount = @guildLevel * 8

IF (@maxcount = 0)
	SET @maxcount = 8
ELSE IF (@maxcount > 32)
	SET @maxcount = 32

IF (@maxcount < @n)
BEGIN
	SET @n = @maxcount
END

SELECT @n AS 'returnVal'
UPDATE dbo.userGuildDB
   SET membercount=@membercount,
	   maxcount=@n
 WHERE idx=@guildIDX
GO
/****** Object:  StoredProcedure [dbo].[game_guild_create_guild]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_create_guild]
(
	@accountIDX int
,	@guildName varchar(20)
,	@aboutguild varchar(110)
,	@guildmark int
,	@maxcount int
)
AS

SET NOCOUNT ON
SET XACT_ABORT ON

DECLARE @cnt int, @errcount int, @guildIDX int, @masterIDX int

SET @cnt = 0
SET @errcount = 0

SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userGuildDB
	 WHERE guildName=@guildName
)
IF (@cnt > 0)
BEGIN
	SET @errcount = 2
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userGuildInfoDB
	 WHERE accountIDX=@accountIDX
	   AND guildJoinType > 0
)
IF (@cnt > 0)
BEGIN
	SET @errcount = 3
	SELECT @errcount AS 'returnVal'
	RETURN
END

BEGIN TRAN

IF (@errcount = 0)
BEGIN
	SELECT 1 AS 'returnVal'

	DELETE FROM dbo.userGuildInfoDB
	 WHERE accountIDX = @accountIDX

	INSERT INTO dbo.userGuildDB (
		guildName, aboutguild, guildmark, ranking, point, todaypoint, guildLevel, maxcount, membercount, regDate
	)
	VALUES (
		@guildName, @aboutguild, @guildmark, 0, 0, 0, 0, @maxcount, 1, GETDATE()
	)

	SET @guildIDX = (
		SELECT idx
		  FROM dbo.userGuildDB
		 WHERE guildName=@guildName
	)

	INSERT INTO dbo.userGuildInfoDB (accountIDX, guildIDX, guildPosition, guildJoinType, regDate)
	VALUES (@accountIDX, @guildIDX, 'Leader', 1, GETDATE())

	INSERT INTO dbo.userRecordGuildDB (guildIDX, type1_win, type1_lose, type1_kill, type1_death, regDate)
	VALUES (@guildIDX, 0, 0, 0, 0, GETDATE())

END

COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[game_guild_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_delete]
(
	@guildIDX int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userGuildDB
 WHERE idx=@guildIDX

DELETE FROM dbo.userGuildInfoDB
 WHERE guildIDX=@guildIDX
GO
/****** Object:  StoredProcedure [dbo].[game_guild_fail_add_peso]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_fail_add_peso]
(
	@accountIDX int
,	@peso int
)
AS

SET NOCOUNT ON

UPDATE dbo.userGameDB
   SET gameMoney = gameMoney + @peso
 WHERE accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_guild_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_get_list]
(
	@topn int
,	@idx int
)
AS

SET NOCOUNT ON

SELECT TOP (@topn) a.idx, a.guildName, a.aboutguild, a.guildmark, a.point, a.maxcount, a.regDate,
       a.membercount, a.todaypoint, a.guildLevel,
	   b.type1_win, b.type1_lose, b.type1_kill, b.type1_death
  FROM dbo.userGuildDB a WITH(NOLOCK)
 INNER JOIN dbo.userRecordGuildDB b WITH(NOLOCK)
    ON a.idx = b.guildIDX
 WHERE a.idx < @idx
 ORDER BY a.idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_guild_intro_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_intro_save]
(
	@guildIDX int
,	@content varchar(110)
)
AS

SET NOCOUNT ON

UPDATE dbo.userGuildDB
   SET aboutguild=@content
 WHERE idx=@guildIDX
GO
/****** Object:  StoredProcedure [dbo].[game_guild_join_app]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_join_app]
(
	@accountIDX int
,	@guildIDX int
)
AS

SET NOCOUNT ON
SET XACT_ABORT ON

DECLARE @cnt int, @errcount int, @maxcount int

SET @cnt = 0
SET @errcount = 0

SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userGuildInfoDB WITH(NOLOCK)
	 WHERE guildIDX=@guildIDX
	   AND accountIDX=@accountIDX
	   AND guildJoinType=0
)
IF (@cnt = 0)
BEGIN
	SET @errcount = 2
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @maxcount = ISNULL((SELECT maxcount FROM dbo.userGuildDB WITH(NOLOCK) WHERE idx=@guildIDX), 0)
SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userGuildInfoDB WITH(NOLOCK)
	 WHERE guildIDX=@guildIDX
	   AND guildJoinType = 1
)

IF (@maxcount <= @cnt)
BEGIN
	SET @errcount = 3
	SELECT @errcount AS 'returnVal'
	RETURN
END

IF (@errcount = 0)
BEGIN
	SELECT 1 AS 'returnVal'

	UPDATE dbo.userGuildInfoDB
	   SET guildJoinType=1,
		   msg=1
	 WHERE guildIDX=@guildIDX
	   AND accountIDX=@accountIDX

	UPDATE dbo.userGuildDB
	   SET membercount = membercount + 1
	 WHERE idx=@guildIDX

	DELETE FROM dbo.userGuildInfoDB
	 WHERE guildIDX <> @guildIDX
	   AND accountIDX=@accountIDX
	   AND guildJoinType = 0
END
GO
/****** Object:  StoredProcedure [dbo].[game_guild_join_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_join_delete]
(
	@idx int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userGuildInfoDB
 WHERE idx=@idx
GO
/****** Object:  StoredProcedure [dbo].[game_guild_join_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_join_get_list]
(
	@guildIDX int
)
AS

SET NOCOUNT ON

SELECT a.idx, a.accountIDX, b.userLevel, c.nickName 
  FROM dbo.userGuildInfoDB a WITH(NOLOCK)
 INNER JOIN dbo.userGameDB b WITH(NOLOCK)
    ON a.accountIDX = b.accountIDX
 INNER JOIN dbo.userMemberDB c WITH(NOLOCK)
    ON a.accountIDX = c.accountIDX 
 WHERE guildIDX = @guildIDX
   AND guildJoinType=0
 ORDER BY a.idx ASC
GO
/****** Object:  StoredProcedure [dbo].[game_guild_join_in]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_join_in]
(
	@accountIDX int
,	@guildIDX int
)
AS

SET NOCOUNT ON

DECLARE @cnt int, @errcount int, @maxcount int

SET @cnt = 0
SET @errcount = 0

SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userGuildInfoDB WITH(NOLOCK)
	 WHERE accountIDX=@accountIDX
	   AND guildJoinType > 0
)
IF (@cnt > 0)
BEGIN
	SET @errcount = 2
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userGuildInfoDB WITH(NOLOCK)
	 WHERE (guildIDX=@guildIDX
	   AND accountIDX=@accountIDX
	   AND guildJoinType = 0)
)
IF (@cnt > 0)
BEGIN
	SET @errcount = 2
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userGuildInfoDB WITH(NOLOCK)
	 WHERE guildIDX=@guildIDX
	   AND guildJoinType = 0
)

IF (@cnt >= 16)
BEGIN
	SET @errcount = 3
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @maxcount = ISNULL((SELECT maxcount FROM dbo.userGuildDB WITH(NOLOCK) WHERE idx=@guildIDX), 0)
SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userGuildInfoDB WITH(NOLOCK)
	 WHERE guildIDX=@guildIDX
	   AND guildJoinType = 1
)

IF (@maxcount <= @cnt)
BEGIN
	SET @errcount = 4
	SELECT @errcount AS 'returnVal'
	RETURN
END

IF (@errcount = 0)
BEGIN
	SELECT 1 AS 'returnVal'
	INSERT INTO dbo.userGuildInfoDB (accountIDX, guildIDX, guildPosition, guildJoinType, regDate)
	VALUES (@accountIDX, @guildIDX, 'Member', 0, GETDATE())
END
GO
/****** Object:  StoredProcedure [dbo].[game_guild_join_init]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_join_init]
(
	@guildIDX int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userGuildInfoDB
 WHERE guildIDX=@guildIDX
   AND guildJoinType=0
GO
/****** Object:  StoredProcedure [dbo].[game_guild_join_my_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_join_my_list]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT TOP 100 b.idx
  FROM dbo.userGuildInfoDB a WITH(NOLOCK)
 INNER JOIN userGuildDB b WITH(NOLOCK)
    ON a.guildIDX = b.idx
 WHERE accountIDX=@accountIDX
 ORDER BY a.idx ASC
GO
/****** Object:  StoredProcedure [dbo].[game_guild_join_self_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_join_self_delete]
(
	@accountIDX int
,	@guildIDX int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userGuildInfoDB
 WHERE guildIDX=@guildIDX
   AND accountIDX=@accountIDX
   AND guildJoinType=0
GO
/****** Object:  StoredProcedure [dbo].[game_guild_join_self_init]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_join_self_init]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userGuildInfoDB
 WHERE accountIDX=@accountIDX
   AND guildJoinType=0
GO
/****** Object:  StoredProcedure [dbo].[game_guild_login_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_login_get_data]  
(  
 @ACCOUNT_IDX int  
)  
AS  
  
 SET NOCOUNT ON  
  
 DECLARE @GUILD_IDX INT = 0;  
 DECLARE @GUILD_HQ TINYINT = 0;  
  
 -- 길드 본부 활성화 여부 확인  
 SET @GUILD_IDX = (SELECT guildIDX FROM dbo.userGuildInfoDB WHERE AccountIDX=@ACCOUNT_IDX and guildJoinType=1)  
 IF (@GUILD_IDX<>0) or (@GUILD_IDX IS NOT NULL)  
 BEGIN  
  IF EXISTS (SELECT * FROM dbo.userGuildHQDB WHERE GuildIDX=@GUILD_IDX)  
  BEGIN  
   SET @GUILD_HQ=1  
  END  
 END  
  
 -- 사용자 길드 관련 데이터 세팅  
 SELECT B.idx, B.guildName, B.guildmark, A.guildPosition, A.msg, A.AttendDate, A.GuildRankDate, A.regDate, @GUILD_HQ  
 FROM dbo.userGuildInfoDB as A WITH(READUNCOMMITTED) INNER JOIN dbo.userGuildDB AS B WITH(READUNCOMMITTED)  
 ON A.guildIDX = B.idx   
 WHERE A.accountIDX = @ACCOUNT_IDX  
 AND A.guildJoinType in (-1, 1)
GO
/****** Object:  StoredProcedure [dbo].[game_guild_mark_log_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_mark_log_add]
(
	@guildIDX int
,	@accountIDX int
,	@havepeso bigint
,	@markprice int
,	@nowmark int
,	@changemark int
)
AS

SET NOCOUNT ON

DECLARE @cnt tinyint
SET @cnt = (
	SELECT COUNT(*)
	  FROM LosaGame_log.DBO.log_guild_mark WITH(NOLOCK)
	 WHERE guildIDX=@guildIDX and flag=0
)

IF (@cnt = 0)
BEGIN
	INSERT INTO LosaGame_log.DBO.log_guild_mark (
		guildIDX, accountIDX, havepeso, markprice, nowmark, changemark, flag, regDate
	)
	VALUES (
		@guildIDX, @accountIDX, @havepeso, @markprice, @nowmark, @changemark, 0, GETDATE()
	)
END
GO
/****** Object:  StoredProcedure [dbo].[game_guild_mark_log_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_mark_log_delete]
(
	@idx int
)
AS

SET NOCOUNT ON

UPDATE LosaGame_log.DBO.log_guild_mark
   SET flag=2
 WHERE idx=@idx
GO
/****** Object:  StoredProcedure [dbo].[game_guild_mark_log_get_self_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_mark_log_get_self_idx]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT MAX(idx)
  FROM LosaGame_log.DBO.log_guild_mark
 WHERE accountIDX=@accountIDX
   AND flag=0
GO
/****** Object:  StoredProcedure [dbo].[game_guild_mark_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_mark_save]
(
	@guildIDX int
,	@mark int
)
AS

SET NOCOUNT ON

UPDATE dbo.userGuildDB
   SET guildmark=@mark
 WHERE idx=@guildIDX
GO
/****** Object:  StoredProcedure [dbo].[game_guild_member_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_member_get_list]
(
	@guildIDX int
)
AS

SET NOCOUNT ON

SELECT a.idx, a.accountIDX, b.userLevel, c.nickName, a.guildPosition, b.renspoint 
  FROM dbo.userGuildInfoDB a WITH(NOLOCK)
 INNER JOIN dbo.userGameDB b WITH(NOLOCK)
    ON a.accountIDX = b.accountIDX
 INNER JOIN dbo.userMemberDB c WITH(NOLOCK)
    ON a.accountIDX = c.accountIDX 
 WHERE guildIDX = @guildIDX
   AND guildJoinType=1
 ORDER BY a.idx ASC
GO
/****** Object:  StoredProcedure [dbo].[game_guild_member_get_list2]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_member_get_list2]
(
	@guildIDX int
)
AS

SET NOCOUNT ON

SELECT a.idx, a.accountIDX, b.userLevel, c.nickName, a.guildPosition, b.renspoint 
  FROM dbo.userGuildInfoDB a WITH(NOLOCK)
 INNER JOIN dbo.userGameDB b WITH(NOLOCK)
    ON a.accountIDX = b.accountIDX
 INNER JOIN dbo.userMemberDB c WITH(NOLOCK)
    ON a.accountIDX = c.accountIDX 
 WHERE guildIDX = @guildIDX
   AND guildJoinType=1
 ORDER BY a.idx ASC
GO
/****** Object:  StoredProcedure [dbo].[game_guild_member_get_list3]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_member_get_list3]
(
	@guildIDX int
)
AS

SET NOCOUNT ON

SELECT accountIDX
  FROM dbo.userGuildInfoDB WITH(NOLOCK)
 WHERE guildIDX = @guildIDX
   AND guildJoinType=1
 ORDER BY idx ASC
GO
/****** Object:  StoredProcedure [dbo].[game_guild_member_get_masters]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_member_get_masters]
(
	@guildIDX int
)
AS

SET NOCOUNT ON

SELECT accountIDX
  FROM dbo.userGuildInfoDB WITH(NOLOCK)
 WHERE guildIDX=@guildIDX
   AND guildPosition in ('Leader', 'Officer')
GO
/****** Object:  StoredProcedure [dbo].[game_guild_member_out]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_member_out]
(
	@idx int
,	@guildIDX int
)
AS

SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN TRAN

UPDATE dbo.userGuildInfoDB
   SET guildJoinType=-1,
	   msg=2
 WHERE idx=@idx

UPDATE dbo.userGuildDB
   SET membercount = membercount-1
 WHERE idx=@guildIDX

COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[game_guild_member_out_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_member_out_delete]
(
	@accountIDX int
,	@guildIDX int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userGuildInfoDB
 WHERE guildIDX=@guildIDX
   AND accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_guild_member_self_out]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_member_self_out]
(
	@accountIDX int
,	@guildIDX int
)
AS

SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN TRAN

DELETE FROM dbo.userGuildInfoDB
 WHERE guildIDX=@guildIDX
   AND accountIDX=@accountIDX

UPDATE dbo.userGuildDB
   SET membercount = membercount-1
 WHERE idx=@guildIDX

COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[game_guild_msg_init]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_msg_init]
(
	@accountIDX int
,	@guildIDX int
)
AS

SET NOCOUNT ON

UPDATE dbo.userGuildInfoDB
   SET msg=0
 WHERE guildIDX=@guildIDX
   AND accountIDX=@accountIDX
   AND guildJoinType=1
GO
/****** Object:  StoredProcedure [dbo].[game_guild_position_msg_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_position_msg_save]
(
	@accountIDX int
,	@guildIDX int
,	@msg int
)
AS

SET NOCOUNT ON

UPDATE dbo.userGuildInfoDB
   SET msg=@msg
 WHERE guildIDX=@guildIDX
   AND accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_guild_position_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_position_save]
(
	@accountIDX int
,	@guildIDX int
,	@position varchar(20)
)
AS

SET NOCOUNT ON

DECLARE @msg tinyint
SET @msg = 0

IF (@position = 'Officer')
	SET @msg = 3

IF (@position = 'Member')
	SET @msg = 5

UPDATE dbo.userGuildInfoDB
   SET guildPosition=@position,
	   msg=@msg
 WHERE guildIDX=@guildIDX
   AND accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_guild_ranking_point_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_ranking_point_save]
(
	@guildIDX int
,	@ranking int
,	@point int
,	@todaypoint int
,	@guildLevel int
,	@maxcount int
)
AS

SET NOCOUNT ON

UPDATE dbo.userGuildDB
   SET ranking=@ranking,
	   point=@point,
	   todaypoint=@todaypoint,
	   guildLevel=@guildLevel,
	   maxcount=@maxcount 
 WHERE idx=@guildIDX
GO
/****** Object:  StoredProcedure [dbo].[game_guild_reward_set_attend]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_reward_set_attend]  
  
 @ACCOUNT_IDX  INT  
  
AS  
  
 SET NOCOUNT ON  
 SET LOCK_TIMEOUT 10000  
  
 DECLARE @nReturn   INT  
  
 BEGIN TRAN  
     
  UPDATE dbo.userGuildInfoDB WITH (XLOCK, ROWLOCK) SET AttendDate=GETDATE()  
  WHERE AccountIDX=@ACCOUNT_IDX  
  
  IF (@@ROWCOUNT=0) or (@@ERROR<>0)  
  BEGIN  
   ROLLBACK TRAN  
   RETURN  
  END  
  
 COMMIT TRAN  
  
 RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_guild_reward_set_guildRank]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_reward_set_guildRank]

	@ACCOUNT_IDX		INT

AS

	SET NOCOUNT ON
	SET LOCK_TIMEOUT	10000

	DECLARE @nReturn			INT

	BEGIN TRAN
			
		UPDATE dbo.userGuildInfoDB WITH (XLOCK, ROWLOCK) SET GuildRankDate=GETDATE()
		WHERE AccountIDX=@ACCOUNT_IDX

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN
			RETURN
		END

	COMMIT TRAN

	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_guild_use_item]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_use_item]
(
	@no varchar(4)
,	@tblIDX varchar(12)
)
AS

SET NOCOUNT ON

DECLARE @sql varchar(200)
SET @sql = 'UPDATE dbo.userItemETCDB SET item' + @no + '_type=0, item' + @no + '_value1=0, item' + @no + '_value2=0 WHERE idx=' + @tblIDX
EXECUTE (@sql)
GO
/****** Object:  StoredProcedure [dbo].[game_guild_user_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_user_get_data]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT idx, guildName, guildmark
  FROM dbo.userGuildDB WITH(NOLOCK)
 WHERE idx=(
	SELECT guildIDX
	  FROM dbo.userGuildInfoDB WITH(NOLOCK)
	 WHERE @accountIDX=accountIDX
	   AND guildJoinType=1
)
GO
/****** Object:  StoredProcedure [dbo].[game_guild_user_nick_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guild_user_nick_get_data]
(
	@nickname varchar(20)
)
AS

SET NOCOUNT ON

SELECT guildIDX
  FROM dbo.userGuildInfoDB WITH(NOLOCK)
 WHERE accountIDX=(
	SELECT accountIDX
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE nickName=@nickname
	)
   AND guildJoinType=1
GO
/****** Object:  StoredProcedure [dbo].[game_guildHQ_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guildHQ_get_data]  
  
 @GUILD_IDX  INT,  
 @ITEM_STATUS TINYINT,   -- 0: 미설치, 1:설치됨, 2:삭제  
 @PAGE   INT,  
 @PAGE_SIZE  INT  
  
AS   
  
 SET NOCOUNT ON  
 SET LOCK_TIMEOUT 15000  
  
 IF (@ITEM_STATUS=0)  
 BEGIN  
    
  -- 길드 공용 인벤 아이템 SELECT  
  SELECT ItemCode, COUNT(*) FROM dbo.userGuildHQDB WITH (READCOMMITTED)  
  WHERE GuildIDX=@GUILD_IDX and ItemStatus=@ITEM_STATUS  
  GROUP BY ItemCode  
  
 END  
 ELSE IF (@ITEM_STATUS=1)  
 BEGIN  
    
  -- 설치된 아이템 SELECT  
  SELECT ItemSerial, ItemCode, ItemXZ, ItemY, ItemRotate, ItemDecoScore FROM (  
   SELECT ROW_NUMBER() OVER (ORDER BY ItemSerial DESC) as ItemList, ItemSerial, ItemCode, ItemXZ, ItemY, ItemRotate, ItemDecoScore  
   FROM dbo.userGuildHQDB WITH (READCOMMITTED) WHERE GuildIDX=@GUILD_IDX and ItemStatus=@ITEM_STATUS  
  ) as GUILDHQ_LIST  
  WHERE ItemList BETWEEN (((@PAGE - 1) * @PAGE_SIZE) + 1) AND @PAGE * @PAGE_SIZE  
  
 END   
  
  
 RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_guildHQ_set_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guildHQ_set_add]  
  
 @GUILD_IDX  INT,  
 @ITEM_CODE  INT  
  
AS   
  
 SET NOCOUNT ON  
 SET LOCK_TIMEOUT 15000  
  
 DECLARE @nReturn INT = 0;  
  
 BEGIN TRAN  
  -- 길드 본부 꾸미기 아이템 추가  
  INSERT dbo.userGuildHQDB WITH (XLOCK, ROWLOCK) (GuildIDX, ItemCode) VALUES (@GUILD_IDX, @ITEM_CODE)  
  IF (@@ROWCOUNT=0) or (@@ERROR<>0)  
  BEGIN  
   ROLLBACK TRAN  
   RETURN;  
  END  
    
  --  변경된 데이터에 대한 Version관리  
  EXEC @nReturn = dbo.game_guildHQ_ver_set_status @GUILD_IDX  
  IF @nReturn<>0  
  BEGIN  
   ROLLBACK TRAN  
   RETURN;  
  END    
  
 COMMIT TRAN  
  
 RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_guildHQ_set_default_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guildHQ_set_default_add]  
   
 @GUILD_IDX  INT,   
 @ITEM_CODE  INT,  
 @ITEM_XZ  INT,  
 @ITEM_Y   INT,  
 @ITEM_ROTATE TINYINT   
  
AS   
  
 SET NOCOUNT ON  
 SET LOCK_TIMEOUT 15000  
  
 DECLARE @nReturn INT = 0;  
   
 BEGIN TRAN  
  -- 길드 본부 꾸미기 아이템 추가  
  INSERT dbo.userGuildHQDB WITH (XLOCK, ROWLOCK) (GuildIDX, ItemCode, ItemXZ, ItemY, ItemRotate, ItemStatus) VALUES (@GUILD_IDX, @ITEM_CODE, @ITEM_XZ, @ITEM_Y, @ITEM_ROTATE, 1)  
  IF (@@ROWCOUNT=0) or (@@ERROR<>0)  
  BEGIN  
   ROLLBACK TRAN  
   RETURN;  
  END  
    
  --  변경된 데이터에 대한 Version관리  
  EXEC @nReturn = dbo.game_guildHQ_ver_set_status @GUILD_IDX  
  IF @nReturn<>0  
  BEGIN  
   ROLLBACK TRAN  
   RETURN;  
  END    
  
 COMMIT TRAN  
  
 RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_guildHQ_set_fit]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guildHQ_set_fit]  
   
 @GUILD_IDX  INT,  
 @ACCOUNT_IDX INT,  
 @ITEM_SERIAL BIGINT,   
 @ITEM_CODE  INT,  
 @ITEM_XZ  INT,  
 @ITEM_Y   INT,  
 @ITEM_ROTATE TINYINT,  
 @ITEM_STATUS TINYINT  -- 1:설치, 2: 변경  
  
AS   
  
 SET NOCOUNT ON  
 SET LOCK_TIMEOUT 15000  
  
 DECLARE @nReturn INT = 0;  
   
   
 -- 최초 설치시 즉, 인벤(ItemStus=0)에서 userGuildHQDB로 넘어와서 설치 될때 서버가 ItemSerial 정보를 모르기 때문에 제일 먼저 인벤에  
 -- 들어온 아이템 부터 설치 하도록 ItemSerial을 서버에 전달  
 IF (@ITEM_SERIAL=0 and @ITEM_STATUS=1)  
 BEGIN   
  SET @ITEM_SERIAL= (SELECT MIN(ItemSerial) FROM dbo.userGuildHQDB WHERE GuildIDX=@GUILD_IDX and ItemCode=@ITEM_CODE and ItemStatus=0)  
  SELECT @ITEM_SERIAL  
 END  
   
 BEGIN TRAN  
    
  -- @ITEM_STATUS 는 0: 미설치, 1:설치됨, 2:삭제 만 사용되지만, 현재 설치된 아이템의 위치 변경을 위해   
  -- 현재 프로시저에서 2번 코드를 받지만 실제는 1로 강제 초기화 하여 설치로 상태 정보를 유지한다.  
  SET @ITEM_STATUS=1  
  
  UPDATE dbo.userGuildHQDB WITH (XLOCK, ROWLOCK) SET ItemXZ=@ITEM_XZ, ItemY=@ITEM_Y, ItemRotate=@ITEM_ROTATE, ItemStatus=@ITEM_STATUS   
  WHERE ItemSerial=@ITEM_SERIAL  
  
  IF (@@ROWCOUNT=0) or (@@ERROR<>0)  
  BEGIN  
   SELECT -1;  
   ROLLBACK TRAN  
   RETURN;  
  END  
    
  --  변경된 데이터에 대한 Version관리  
  EXEC @nReturn = dbo.game_guildHQ_ver_set_status @GUILD_IDX  
  IF @nReturn<>0  
  BEGIN  
   SELECT @nReturn  
   ROLLBACK TRAN  
   RETURN;  
  END     
  
 COMMIT TRAN  
  
 -- 설치로그  
 -- EXEC LINKED_CONNECTION_BAK.LosaLogDataC.dbo.log_guildHQ_fit_set_insert @GUILD_IDX, @ACCOUNT_IDX, @ITEM_SERIAL, @ITEM_CODE, 1  
  
 RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_guildHQ_set_status]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guildHQ_set_status]  
   
 @GUILD_IDX  INT,  
 @ACCOUNT_IDX INT,  
 @ITEM_SERIAL BIGINT,  
 @ITEM_CODE  INT,   
 @ITEM_STATUS TINYINT  -- 0:인벤(해제), 2: 삭제  
  
AS   
  
 SET NOCOUNT ON  
 SET LOCK_TIMEOUT 15000  
  
 DECLARE @nReturn INT = 0;  
   
 BEGIN TRAN    
    
  UPDATE dbo.userGuildHQDB WITH (XLOCK, ROWLOCK) SET ItemXZ=0, ItemY=0, ItemRotate=0, ItemStatus=@ITEM_STATUS   
  WHERE ItemSerial=@ITEM_SERIAL  
  
  IF (@@ROWCOUNT=0) or (@@ERROR<>0)  
  BEGIN  
   ROLLBACK TRAN  
   RETURN;  
  END  
    
  --  변경된 데이터에 대한 Version관리  
  EXEC @nReturn = dbo.game_guildHQ_ver_set_status @GUILD_IDX  
  IF @nReturn<>0  
  BEGIN  
   ROLLBACK TRAN  
   RETURN;  
  END     
  
 COMMIT TRAN  
  
  
 -- 설치로그  
 -- EXEC LINKED_CONNECTION_BAK.LosaLogDataC.dbo.log_guildHQ_fit_set_insert @GUILD_IDX, @ACCOUNT_IDX, @ITEM_SERIAL, @ITEM_CODE, 0  
  
 RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_guildHQ_ver_get_info]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guildHQ_ver_get_info]  
  
 @GUILD_IDX  INT  
  
AS  
  
 SET NOCOUNT ON  
 SET LOCK_TIMEOUT 10000  
   
 SELECT VerStatus FROM dbo.userGuildHQVerDB WITH (READCOMMITTED) WHERE GuildIDX=@GUILD_IDX  
  
 RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_guildHQ_ver_set_status]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_guildHQ_ver_set_status]  
  
 @GUILD_IDX  INT  
  
AS  
  
 SET NOCOUNT ON  
 SET LOCK_TIMEOUT 10000  
  
 DECLARE @UPDATE_DATE DATETIME = GETDATE()  
  
 BEGIN TRAN  
  
  -- 누적 테이블에 Insert or Update    
  ;MERGE dbo.userGuildHQVerDB as TARGET  
  USING (SELECT @GUILD_IDX) AS SOURCE (GuildIDX)  
  ON (TARGET.GuildIDX=SOURCE.GuildIDX)  
  WHEN MATCHED THEN  
   UPDATE SET TARGET.VerStatus+=1, TARGET.UptDate=@UPDATE_DATE  
  WHEN NOT MATCHED THEN  
   INSERT (GuildIDX, VerStatus) VALUES (SOURCE.GuildIDX, 1);  
  
  IF (@@ROWCOUNT=0) or (@@ERROR<>0)  
  BEGIN  
   ROLLBACK TRAN  
   RETURN;  
  END   
  
 COMMIT TRAN    
  
 RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_hero_price_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_hero_price_get_data]

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT HeroCode, HeroPrice
  FROM dbo.define_hero_price WITH (NOLOCK)
 ORDER BY HeroCode
GO
/****** Object:  StoredProcedure [dbo].[game_hq_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_hq_add]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userHqDB (
	accountIDX,
	class1_type, class1_posx, class1_posy, class2_type, class2_posx, class2_posy, 
	class3_type, class3_posx, class3_posy, class4_type, class4_posx, class4_posy, 
	class5_type, class5_posx, class5_posy, class6_type, class6_posx, class6_posy,
	class7_type, class7_posx, class7_posy, class8_type, class8_posx, class8_posy, 
	class9_type, class9_posx, class9_posy, class10_type, class10_posx, class10_posy, 
	lockType, regDate
)
VALUES (
	@accountIDX,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, GETDATE()
)
GO
/****** Object:  StoredProcedure [dbo].[game_hq_get_count]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_hq_get_count]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT COUNT(*)
  FROM dbo.userHqDB WITH(NOLOCK)
 WHERE accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_hq_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_hq_get_data]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT class1_type, class1_posx, class1_posy, class2_type, class2_posx, class2_posy, 
	   class3_type, class3_posx, class3_posy, class4_type, class4_posx, class4_posy, 
	   class5_type, class5_posx, class5_posy, class6_type, class6_posx, class6_posy,
	   class7_type, class7_posx, class7_posy, class8_type, class8_posx, class8_posy, 
	   class9_type, class9_posx, class9_posy, class10_type, class10_posx, class10_posy, 
	   lockType
  FROM dbo.userHqDB WITH(NOLOCK)
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_hq_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_hq_save]
(
	@accountIDX int
,	@class1_type int
,	@class1_posx int
,	@class1_posy int
,	@class2_type int
,	@class2_posx int
,	@class2_posy int
,	@class3_type int
,	@class3_posx int
,	@class3_posy int
,	@class4_type int
,	@class4_posx int
,	@class4_posy int
,	@class5_type int
,	@class5_posx int
,	@class5_posy int
,	@class6_type int
,	@class6_posx int
,	@class6_posy int
,	@class7_type int
,	@class7_posx int
,	@class7_posy int
,	@class8_type int
,	@class8_posx int
,	@class8_posy int
,	@class9_type int
,	@class9_posx int
,	@class9_posy int
,	@class10_type int
,	@class10_posx int
,	@class10_posy int
,	@lockType smallint
)
AS

SET NOCOUNT ON

UPDATE dbo.userHqDB
   SET class1_type = @class1_type,
	   class1_posx = @class1_posx,
	   class1_posy = @class1_posy,
	   class2_type = @class2_type,
	   class2_posx = @class2_posx,
	   class2_posy = @class2_posy,
	   class3_type = @class3_type,
	   class3_posx = @class3_posx,
	   class3_posy = @class3_posy,
	   class4_type = @class4_type,
	   class4_posx = @class4_posx,
	   class4_posy = @class4_posy,
	   class5_type = @class5_type,
	   class5_posx = @class5_posx,
	   class5_posy = @class5_posy,
	   class6_type = @class6_type,
	   class6_posx = @class6_posx,
	   class6_posy = @class6_posy,
	   class7_type = @class7_type,
	   class7_posx = @class7_posx,
	   class7_posy = @class7_posy,
	   class8_type = @class8_type,
	   class8_posx = @class8_posx,
	   class8_posy = @class8_posy,
	   class9_type = @class9_type,
	   class9_posx = @class9_posx,
	   class9_posy = @class9_posy,
	   class10_type = @class10_type,
	   class10_posx = @class10_posx,
	   class10_posy = @class10_posy,
	   lockType = @lockType
 WHERE accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_item_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_add]
(
	@accountIDX int
,	@item1_type int
,	@item1_code int
,	@item2_type int
,	@item2_code int
,	@item3_type int
,	@item3_code int
,	@item4_type int
,	@item4_code int
,	@item5_type int
,	@item5_code int
,	@item6_type int
,	@item6_code int
,	@item7_type int
,	@item7_code int
,	@item8_type int
,	@item8_code int
,	@item9_type int
,	@item9_code int
,	@item10_type int
,	@item10_code int
,	@item11_type int
,	@item11_code int
,	@item12_type int
,	@item12_code int
,	@item13_type int
,	@item13_code int
,	@item14_type int
,	@item14_code int
,	@item15_type int
,	@item15_code int
,	@item16_type int
,	@item16_code int
,	@item17_type int
,	@item17_code int
,	@item18_type int
,	@item18_code int
,	@item19_type int
,	@item19_code int
,	@item20_type int
,	@item20_code int
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userItemDB (
	accountIDX,
	item1_type, item1_code, item2_type, item2_code, item3_type, item3_code, item4_type, item4_code, item5_type, item5_code,
	item6_type, item6_code, item7_type, item7_code, item8_type, item8_code, item9_type, item9_code, item10_type, item10_code,
	item11_type, item11_code, item12_type, item12_code, item13_type, item13_code, item14_type, item14_code, item15_type, item15_code,
	item16_type, item16_code, item17_type, item17_code, item18_type, item18_code, item19_type, item19_code, item20_type, item20_code
)
VALUES (
	@accountIDX,
	@item1_type, @item1_code, @item2_type, @item2_code, @item3_type, @item3_code, @item4_type, @item4_code, @item5_type, @item5_code,
	@item6_type, @item6_code, @item7_type, @item7_code, @item8_type, @item8_code, @item9_type, @item9_code, @item10_type, @item10_code,
	@item11_type, @item11_code, @item12_type, @item12_code, @item13_type, @item13_code, @item14_type, @item14_code, @item15_type, @item15_code,
	@item16_type, @item16_code, @item17_type, @item17_code, @item18_type, @item18_code, @item19_type, @item19_code, @item20_type, @item20_code
)
GO
/****** Object:  StoredProcedure [dbo].[game_item_etc_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_etc_add]
(
	@accountIDX int
,	@item1_type int
,	@item1_value1 int
,	@item1_value2 int
,	@item2_type int
,	@item2_value1 int
,	@item2_value2 int
,	@item3_type int
,	@item3_value1 int
,	@item3_value2 int
,	@item4_type int
,	@item4_value1 int
,	@item4_value2 int
,	@item5_type int
,	@item5_value1 int
,	@item5_value2 int
,	@item6_type int
,	@item6_value1 int
,	@item6_value2 int
,	@item7_type int
,	@item7_value1 int
,	@item7_value2 int
,	@item8_type int
,	@item8_value1 int
,	@item8_value2 int
,	@item9_type int
,	@item9_value1 int
,	@item9_value2 int
,	@item10_type int
,	@item10_value1 int
,	@item10_value2 int
,	@item11_type int
,	@item11_value1 int
,	@item11_value2 int
,	@item12_type int
,	@item12_value1 int
,	@item12_value2 int
,	@item13_type int
,	@item13_value1 int
,	@item13_value2 int
,	@item14_type int
,	@item14_value1 int
,	@item14_value2 int
,	@item15_type int
,	@item15_value1 int
,	@item15_value2 int
,	@item16_type int
,	@item16_value1 int
,	@item16_value2 int
,	@item17_type int
,	@item17_value1 int
,	@item17_value2 int
,	@item18_type int
,	@item18_value1 int
,	@item18_value2 int
,	@item19_type int
,	@item19_value1 int
,	@item19_value2 int
,	@item20_type int
,	@item20_value1 int
,	@item20_value2 int
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userItemEtcDB (
	accountIDX,
	item1_type, item1_value1, item1_value2, item2_type, item2_value1, item2_value2, item3_type, item3_value1, item3_value2, 
	item4_type, item4_value1, item4_value2, item5_type, item5_value1, item5_value2, item6_type, item6_value1, item6_value2, 
	item7_type, item7_value1, item7_value2, item8_type, item8_value1, item8_value2, item9_type, item9_value1, item9_value2, 
	item10_type, item10_value1, item10_value2, item11_type, item11_value1, item11_value2, item12_type, item12_value1, item12_value2, 
	item13_type, item13_value1, item13_value2, item14_type, item14_value1, item14_value2, item15_type, item15_value1, item15_value2, 
	item16_type, item16_value1, item16_value2, item17_type, item17_value1, item17_value2, item18_type, item18_value1, item18_value2,
	item19_type, item19_value1, item19_value2, item20_type, item20_value1, item20_value2
)
VALUES (
	@accountIDX,
	@item1_type, @item1_value1, @item1_value2, @item2_type, @item2_value1, @item2_value2, @item3_type, @item3_value1, @item3_value2, 
	@item4_type, @item4_value1, @item4_value2, @item5_type, @item5_value1, @item5_value2, @item6_type, @item6_value1, @item6_value2, 
	@item7_type, @item7_value1, @item7_value2, @item8_type, @item8_value1, @item8_value2, @item9_type, @item9_value1, @item9_value2, 
	@item10_type, @item10_value1, @item10_value2, @item11_type, @item11_value1, @item11_value2, @item12_type, @item12_value1, @item12_value2, 
	@item13_type, @item13_value1, @item13_value2, @item14_type, @item14_value1, @item14_value2, @item15_type, @item15_value1, @item15_value2, 
	@item16_type, @item16_value1, @item16_value2, @item17_type, @item17_value1, @item17_value2, @item18_type, @item18_value1, @item18_value2,
	@item19_type, @item19_value1, @item19_value2, @item20_type, @item20_value1, @item20_value2
)
GO
/****** Object:  StoredProcedure [dbo].[game_item_etc_get_data_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_etc_get_data_list]
(
	@accountIDX int
)
As

SET NOCOUNT ON

SELECT idx,
	   item1_type, item1_value1, item1_value2, item2_type, item2_value1, item2_value2, item3_type, item3_value1, item3_value2, 
	   item4_type, item4_value1, item4_value2, item5_type, item5_value1, item5_value2, item6_type, item6_value1, item6_value2, 
	   item7_type, item7_value1, item7_value2, item8_type, item8_value1, item8_value2, item9_type, item9_value1, item9_value2, 
	   item10_type, item10_value1, item10_value2, item11_type, item11_value1, item11_value2, item12_type, item12_value1, item12_value2, 
	   item13_type, item13_value1, item13_value2, item14_type, item14_value1, item14_value2, item15_type, item15_value1, item15_value2, 
	   item16_type, item16_value1, item16_value2, item17_type, item17_value1, item17_value2, item18_type, item18_value1, item18_value2,
	   item19_type, item19_value1, item19_value2, item20_type, item20_value1, item20_value2 
  FROM dbo.userItemEtcDB WITH(NOLOCK)
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_item_etc_get_self_index]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_etc_get_self_index]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT TOP 1 idx
  FROM dbo.userItemEtcDB
 WHERE accountIDX = @accountIDX
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_item_etc_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_etc_save]
(
	@idx int
,	@item1_type int
,	@item1_value1 int
,	@item1_value2 int
,	@item2_type int
,	@item2_value1 int
,	@item2_value2 int
,	@item3_type int
,	@item3_value1 int
,	@item3_value2 int
,	@item4_type int
,	@item4_value1 int
,	@item4_value2 int
,	@item5_type int
,	@item5_value1 int
,	@item5_value2 int
,	@item6_type int
,	@item6_value1 int
,	@item6_value2 int
,	@item7_type int
,	@item7_value1 int
,	@item7_value2 int
,	@item8_type int
,	@item8_value1 int
,	@item8_value2 int
,	@item9_type int
,	@item9_value1 int
,	@item9_value2 int
,	@item10_type int
,	@item10_value1 int
,	@item10_value2 int
,	@item11_type int
,	@item11_value1 int
,	@item11_value2 int
,	@item12_type int
,	@item12_value1 int
,	@item12_value2 int
,	@item13_type int
,	@item13_value1 int
,	@item13_value2 int
,	@item14_type int
,	@item14_value1 int
,	@item14_value2 int
,	@item15_type int
,	@item15_value1 int
,	@item15_value2 int
,	@item16_type int
,	@item16_value1 int
,	@item16_value2 int
,	@item17_type int
,	@item17_value1 int
,	@item17_value2 int
,	@item18_type int
,	@item18_value1 int
,	@item18_value2 int
,	@item19_type int
,	@item19_value1 int
,	@item19_value2 int
,	@item20_type int
,	@item20_value1 int
,	@item20_value2 int
)
AS

SET NOCOUNT ON

UPDATE dbo.userItemEtcDB
   SET item1_type = @item1_type,
	   item1_value1 = @item1_value1,
	   item1_value2 = @item1_value2,
	   item2_type = @item2_type,
	   item2_value1 = @item2_value1,
	   item2_value2 = @item2_value2,
	   item3_type = @item3_type,
	   item3_value1 = @item3_value1,
	   item3_value2 = @item3_value2,
	   item4_type = @item4_type,
	   item4_value1 = @item4_value1,
	   item4_value2 = @item4_value2,
	   item5_type = @item5_type,
	   item5_value1 = @item5_value1,
	   item5_value2 = @item5_value2,
	   item6_type = @item6_type,
	   item6_value1 = @item6_value1,
	   item6_value2 = @item6_value2,
	   item7_type = @item7_type,
	   item7_value1 = @item7_value1,
	   item7_value2 = @item7_value2,
	   item8_type = @item8_type,
	   item8_value1 = @item8_value1,
	   item8_value2 = @item8_value2,
	   item9_type = @item9_type,
	   item9_value1 = @item9_value1,
	   item9_value2 = @item9_value2,
	   item10_type = @item10_type,
	   item10_value1 = @item10_value1,
	   item10_value2 = @item10_value2,
	   item11_type = @item11_type,
	   item11_value1 = @item11_value1,
	   item11_value2 = @item11_value2,
	   item12_type = @item12_type,
	   item12_value1 = @item12_value1,
	   item12_value2 = @item12_value2,
	   item13_type = @item13_type,
	   item13_value1 = @item13_value1,
	   item13_value2 = @item13_value2,
	   item14_type = @item14_type,
	   item14_value1 = @item14_value1,
	   item14_value2 = @item14_value2,
	   item15_type = @item15_type,
	   item15_value1 = @item15_value1,
	   item15_value2 = @item15_value2,
	   item16_type = @item16_type,
	   item16_value1 = @item16_value1,
	   item16_value2 = @item16_value2,
	   item17_type = @item17_type,
	   item17_value1 = @item17_value1,
	   item17_value2 = @item17_value2,
	   item18_type = @item18_type,
	   item18_value1 = @item18_value1,
	   item18_value2 = @item18_value2,
	   item19_type = @item19_type,
	   item19_value1 = @item19_value1,
	   item19_value2 = @item19_value2,
	   item20_type = @item20_type,
	   item20_value1 = @item20_value1,
	   item20_value2 = @item20_value2 
 WHERE idx = @idx
GO
/****** Object:  StoredProcedure [dbo].[game_item_extra_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_extra_add]
(
	@accountIDX int
,	@item1_type int
,	@item1_reinforce int
,	@item1_slotindex int
,	@item1_tradeType int
,	@item1_limitType int
,	@item1_mcustom int
,	@item1_fcustom int
,	@item1_failexp smallint
,	@item1_limitDate datetime
,	@item2_type int
,	@item2_reinforce int
,	@item2_slotindex int
,	@item2_tradeType int
,	@item2_limitType int
,	@item2_mcustom int
,	@item2_fcustom int
,	@item2_failexp smallint
,	@item2_limitDate datetime
,	@item3_type int
,	@item3_reinforce int
,	@item3_slotindex int
,	@item3_tradeType int
,	@item3_limitType int
,	@item3_mcustom int
,	@item3_fcustom int
,	@item3_failexp smallint
,	@item3_limitDate datetime
,	@item4_type int
,	@item4_reinforce int
,	@item4_slotindex int
,	@item4_tradeType int
,	@item4_limitType int
,	@item4_mcustom int
,	@item4_fcustom int
,	@item4_failexp smallint
,	@item4_limitDate datetime
,	@item5_type int
,	@item5_reinforce int
,	@item5_slotindex int
,	@item5_tradeType int
,	@item5_limitType int
,	@item5_mcustom int
,	@item5_fcustom int
,	@item5_failexp smallint
,	@item5_limitDate datetime
,	@item6_type int
,	@item6_reinforce int
,	@item6_slotindex int
,	@item6_tradeType int
,	@item6_limitType int
,	@item6_mcustom int
,	@item6_fcustom int
,	@item6_failexp smallint
,	@item6_limitDate datetime
,	@item7_type int
,	@item7_reinforce int
,	@item7_slotindex int
,	@item7_tradeType int
,	@item7_limitType int
,	@item7_mcustom int
,	@item7_fcustom int
,	@item7_failexp smallint
,	@item7_limitDate datetime
,	@item8_type int
,	@item8_reinforce int
,	@item8_slotindex int
,	@item8_tradeType int
,	@item8_limitType int
,	@item8_mcustom int
,	@item8_fcustom int
,	@item8_failexp smallint
,	@item8_limitDate datetime
,	@item9_type int
,	@item9_reinforce int
,	@item9_slotindex int
,	@item9_tradeType int
,	@item9_limitType int
,	@item9_mcustom int
,	@item9_fcustom int
,	@item9_failexp smallint
,	@item9_limitDate datetime
,	@item10_type int
,	@item10_reinforce int
,	@item10_slotindex int
,	@item10_tradeType int
,	@item10_limitType int
,	@item10_mcustom int
,	@item10_fcustom int
,	@item10_failexp smallint
,	@item10_limitDate datetime
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userItemExtraDB (
	accountIDX,
	item1_type, item1_reinforce, item1_slotindex, item1_tradetype, item1_mcustom, item1_fcustom, item1_limitType, item1_failexp, item1_limitDate, 
	item2_type, item2_reinforce, item2_slotindex, item2_tradetype, item2_mcustom, item2_fcustom, item2_limitType, item2_failexp, item2_limitDate, 
	item3_type, item3_reinforce, item3_slotindex, item3_tradetype, item3_mcustom, item3_fcustom, item3_limitType, item3_failexp, item3_limitDate, 
	item4_type, item4_reinforce, item4_slotindex, item4_tradetype, item4_mcustom, item4_fcustom, item4_limitType, item4_failexp, item4_limitDate, 
	item5_type, item5_reinforce, item5_slotindex, item5_tradetype, item5_mcustom, item5_fcustom, item5_limitType, item5_failexp, item5_limitDate, 
	item6_type, item6_reinforce, item6_slotindex, item6_tradetype, item6_mcustom, item6_fcustom, item6_limitType, item6_failexp, item6_limitDate, 
	item7_type, item7_reinforce, item7_slotindex, item7_tradetype, item7_mcustom, item7_fcustom, item7_limitType, item7_failexp, item7_limitDate, 
	item8_type, item8_reinforce, item8_slotindex, item8_tradetype, item8_mcustom, item8_fcustom, item8_limitType, item8_failexp, item8_limitDate, 
	item9_type, item9_reinforce, item9_slotindex, item9_tradetype, item9_mcustom, item9_fcustom, item9_limitType, item9_failexp, item9_limitDate, 
	item10_type, item10_reinforce, item10_slotindex, item10_tradetype, item10_mcustom, item10_fcustom, item10_limitType, item10_failexp, item10_limitDate,
	regDate
)
VALUES (
	@accountIDX,
	@item1_type, @item1_reinforce, @item1_slotindex, @item1_tradetype, @item1_mcustom, @item1_fcustom, @item1_limitType, @item1_failexp, @item1_limitDate, 
	@item2_type, @item2_reinforce, @item2_slotindex, @item2_tradetype, @item2_mcustom, @item2_fcustom, @item2_limitType, @item2_failexp, @item2_limitDate, 
	@item3_type, @item3_reinforce, @item3_slotindex, @item3_tradetype, @item3_mcustom, @item3_fcustom, @item3_limitType, @item3_failexp, @item3_limitDate, 
	@item4_type, @item4_reinforce, @item4_slotindex, @item4_tradetype, @item4_mcustom, @item4_fcustom, @item4_limitType, @item4_failexp, @item4_limitDate, 
	@item5_type, @item5_reinforce, @item5_slotindex, @item5_tradetype, @item5_mcustom, @item5_fcustom, @item5_limitType, @item5_failexp, @item5_limitDate, 
	@item6_type, @item6_reinforce, @item6_slotindex, @item6_tradetype, @item6_mcustom, @item6_fcustom, @item6_limitType, @item6_failexp, @item6_limitDate, 
	@item7_type, @item7_reinforce, @item7_slotindex, @item7_tradetype, @item7_mcustom, @item7_fcustom, @item7_limitType, @item7_failexp, @item7_limitDate, 
	@item8_type, @item8_reinforce, @item8_slotindex, @item8_tradetype, @item8_mcustom, @item8_fcustom, @item8_limitType, @item8_failexp, @item8_limitDate, 
	@item9_type, @item9_reinforce, @item9_slotindex, @item9_tradetype, @item9_mcustom, @item9_fcustom, @item9_limitType, @item9_failexp, @item9_limitDate, 
	@item10_type, @item10_reinforce, @item10_slotindex, @item10_tradetype, @item10_mcustom, @item10_fcustom, @item10_limitType, @item10_failexp, @item10_limitDate,
	GETDATE()
)
GO
/****** Object:  StoredProcedure [dbo].[game_item_extra_get_customidx]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_extra_get_customidx]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

BEGIN TRAN

SELECT MAX(idx)
  FROM dbo.define_gear_customidx

INSERT INTO dbo.define_gear_customidx (accountIDX)
VALUES (@accountIDX)

COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[game_item_extra_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_extra_get_list]    
(    
 @idx INT    
, @accountIDX INT    
, @getCount int    
)    
AS    
    
SET NOCOUNT ON    
    
SELECT TOP (@getCount) idx,    
    item1_type, item1_reinforce, item1_slotindex, item1_tradetype, item1_limitType, item1_mcustom, item1_fcustom, item1_failexp, item1_limitDate,    
    item2_type, item2_reinforce, item2_slotindex, item2_tradetype, item2_limitType, item2_mcustom, item2_fcustom, item2_failexp, item2_limitDate,    
    item3_type, item3_reinforce, item3_slotindex, item3_tradetype, item3_limitType, item3_mcustom, item3_fcustom, item3_failexp, item3_limitDate,    
    item4_type, item4_reinforce, item4_slotindex, item4_tradetype, item4_limitType, item4_mcustom, item4_fcustom, item4_failexp, item4_limitDate,    
    item5_type, item5_reinforce, item5_slotindex, item5_tradetype, item5_limitType, item5_mcustom, item5_fcustom, item5_failexp, item5_limitDate,    
    item6_type, item6_reinforce, item6_slotindex, item6_tradetype, item6_limitType, item6_mcustom, item6_fcustom, item6_failexp, item6_limitDate,    
    item7_type, item7_reinforce, item7_slotindex, item7_tradetype, item7_limitType, item7_mcustom, item7_fcustom, item7_failexp, item7_limitDate,    
    item8_type, item8_reinforce, item8_slotindex, item8_tradetype, item8_limitType, item8_mcustom, item8_fcustom, item8_failexp, item8_limitDate,    
    item9_type, item9_reinforce, item9_slotindex, item9_tradetype, item9_limitType, item9_mcustom, item9_fcustom, item9_failexp, item9_limitDate,    
    item10_type, item10_reinforce, item10_slotindex, item10_tradetype, item10_limitType, item10_mcustom, item10_fcustom, item10_failexp, item10_limitDate    
  FROM dbo.userItemExtraDB WITH (NOLOCK)    
 WHERE accountIDX = @accountIDX    
   AND idx > @idx    
 ORDER BY idx ASC
GO
/****** Object:  StoredProcedure [dbo].[game_item_extra_get_self_index]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_extra_get_self_index]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT TOP 1 idx
  FROM dbo.userItemExtraDB
 WHERE accountIDX = @accountIDX
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_item_extra_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_extra_save]
(
	@idx int
,	@item1_type int
,	@item1_reinforce int
,	@item1_slotindex int
,	@item1_tradeType int
,	@item1_limitType int
,	@item1_mcustom int
,	@item1_fcustom int
,	@item1_failexp smallint
,	@item1_limitDate datetime
,	@item2_type int
,	@item2_reinforce int
,	@item2_slotindex int
,	@item2_tradeType int
,	@item2_limitType int
,	@item2_mcustom int
,	@item2_fcustom int
,	@item2_failexp smallint
,	@item2_limitDate datetime
,	@item3_type int
,	@item3_reinforce int
,	@item3_slotindex int
,	@item3_tradeType int
,	@item3_limitType int
,	@item3_mcustom int
,	@item3_fcustom int
,	@item3_failexp smallint
,	@item3_limitDate datetime
,	@item4_type int
,	@item4_reinforce int
,	@item4_slotindex int
,	@item4_tradeType int
,	@item4_limitType int
,	@item4_mcustom int
,	@item4_fcustom int
,	@item4_failexp smallint
,	@item4_limitDate datetime
,	@item5_type int
,	@item5_reinforce int
,	@item5_slotindex int
,	@item5_tradeType int
,	@item5_limitType int
,	@item5_mcustom int
,	@item5_fcustom int
,	@item5_failexp smallint
,	@item5_limitDate datetime
,	@item6_type int
,	@item6_reinforce int
,	@item6_slotindex int
,	@item6_tradeType int
,	@item6_limitType int
,	@item6_mcustom int
,	@item6_fcustom int
,	@item6_failexp smallint
,	@item6_limitDate datetime
,	@item7_type int
,	@item7_reinforce int
,	@item7_slotindex int
,	@item7_tradeType int
,	@item7_limitType int
,	@item7_mcustom int
,	@item7_fcustom int
,	@item7_failexp smallint
,	@item7_limitDate datetime
,	@item8_type int
,	@item8_reinforce int
,	@item8_slotindex int
,	@item8_tradeType int
,	@item8_limitType int
,	@item8_mcustom int
,	@item8_fcustom int
,	@item8_failexp smallint
,	@item8_limitDate datetime
,	@item9_type int
,	@item9_reinforce int
,	@item9_slotindex int
,	@item9_tradeType int
,	@item9_limitType int
,	@item9_mcustom int
,	@item9_fcustom int
,	@item9_failexp smallint
,	@item9_limitDate datetime
,	@item10_type int
,	@item10_reinforce int
,	@item10_slotindex int
,	@item10_tradeType int
,	@item10_limitType int
,	@item10_mcustom int
,	@item10_fcustom int
,	@item10_failexp smallint
,	@item10_limitDate datetime
)
AS

SET NOCOUNT ON

UPDATE dbo.userItemExtraDB
   SET item1_type = @item1_type,
	   item1_reinforce = @item1_reinforce,
	   item1_slotindex = @item1_slotindex,
	   item1_tradetype = @item1_tradeType,
	   item1_mcustom = @item1_mcustom,
	   item1_fcustom = @item1_fcustom,
	   item1_failexp = @item1_failexp,
	   item1_limitType = @item1_limitType,
	   item1_limitDate = @item1_limitDate,
	   item2_type = @item2_type,
	   item2_reinforce = @item2_reinforce,
	   item2_slotindex = @item2_slotindex,
	   item2_tradetype = @item2_tradeType,
	   item2_mcustom = @item2_mcustom,
	   item2_fcustom = @item2_fcustom,
	   item2_failexp = @item2_failexp,
	   item2_limitType = @item2_limitType,
	   item2_limitDate = @item2_limitDate,
	   item3_type = @item3_type,
	   item3_reinforce = @item3_reinforce,
	   item3_slotindex = @item3_slotindex,
	   item3_tradetype = @item3_tradeType,
	   item3_mcustom = @item3_mcustom,
	   item3_fcustom = @item3_fcustom,
	   item3_failexp = @item3_failexp,
	   item3_limitType = @item3_limitType,
	   item3_limitDate = @item3_limitDate,
	   item4_type = @item4_type,
	   item4_reinforce = @item4_reinforce,
	   item4_slotindex = @item4_slotindex,
	   item4_tradetype = @item4_tradeType,
	   item4_mcustom = @item4_mcustom,
	   item4_fcustom = @item4_fcustom,
	   item4_failexp = @item4_failexp,
	   item4_limitType = @item4_limitType,
	   item4_limitDate = @item4_limitDate,
	   item5_type = @item5_type,
	   item5_reinforce = @item5_reinforce,
	   item5_slotindex = @item5_slotindex,
	   item5_tradetype = @item5_tradeType,
	   item5_mcustom = @item5_mcustom,
	   item5_fcustom = @item5_fcustom,
	   item5_failexp = @item5_failexp,
	   item5_limitType = @item5_limitType,
	   item5_limitDate = @item5_limitDate,
	   item6_type = @item6_type,
	   item6_reinforce = @item6_reinforce,
	   item6_slotindex = @item6_slotindex,
	   item6_tradetype = @item6_tradeType,
	   item6_mcustom = @item6_mcustom,
	   item6_fcustom = @item6_fcustom,
	   item6_failexp = @item6_failexp,
	   item6_limitType = @item6_limitType,
	   item6_limitDate = @item6_limitDate,
	   item7_type = @item7_type,
	   item7_reinforce = @item7_reinforce,
	   item7_slotindex = @item7_slotindex,
	   item7_tradetype = @item7_tradeType,
	   item7_mcustom = @item7_mcustom,
	   item7_fcustom = @item7_fcustom,
	   item7_failexp = @item7_failexp,
	   item7_limitType = @item7_limitType,
	   item7_limitDate = @item7_limitDate,
	   item8_type = @item8_type,
	   item8_reinforce = @item8_reinforce,
	   item8_slotindex = @item8_slotindex,
	   item8_tradetype = @item8_tradeType,
	   item8_mcustom = @item8_mcustom,
	   item8_fcustom = @item8_fcustom,
	   item8_failexp = @item8_failexp,
	   item8_limitType = @item8_limitType,
	   item8_limitDate = @item8_limitDate,
	   item9_type = @item9_type,
	   item9_reinforce = @item9_reinforce,
	   item9_slotindex = @item9_slotindex,
	   item9_tradetype = @item9_tradeType,
	   item9_mcustom = @item9_mcustom,
	   item9_fcustom = @item9_fcustom,
	   item9_failexp = @item9_failexp,
	   item9_limitType = @item9_limitType,
	   item9_limitDate = @item9_limitDate,
	   item10_type = @item10_type,
	   item10_reinforce = @item10_reinforce,
	   item10_slotindex = @item10_slotindex,
	   item10_tradetype = @item10_tradeType,
	   item10_mcustom = @item10_mcustom,
	   item10_fcustom = @item10_fcustom,
	   item10_failexp = @item10_failexp,
	   item10_limitType = @item10_limitType,
	   item10_limitDate = @item10_limitDate
 WHERE idx = @idx
GO
/****** Object:  StoredProcedure [dbo].[game_item_get_data_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_get_data_list]
(
	@idx			INT,
	@accountIDX		INT,
	@getCount		INT
)
AS

SET NOCOUNT ON;

SELECT TOP (@getCount) idx,
       item1_type, item1_code, item2_type, item2_code, item3_type, item3_code, item4_type, item4_code, item5_type, item5_code,
       item6_type, item6_code, item7_type, item7_code, item8_type, item8_code, item9_type, item9_code, item10_type, item10_code,
       item11_type, item11_code, item12_type, item12_code, item13_type, item13_code, item14_type, item14_code, item15_type, item15_code, 
       item16_type, item16_code, item17_type, item17_code, item18_type, item18_code, item19_type, item19_code, item20_type, item20_code 
  FROM dbo.userItemDB WITH (NOLOCK)
 WHERE accountIDX = @accountIDX
   AND idx > @idx
 ORDER BY idx ASC
GO
/****** Object:  StoredProcedure [dbo].[game_item_get_self_index]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_get_self_index]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT TOP 1 idx
  FROM dbo.userItemDB
 WHERE accountIDX = @accountIDX
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_item_medal_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_medal_add]
(
	@accountIDX int
,	@item1_type int
,	@item1_class int
,	@item1_limitType int
,	@item1_limitDate datetime
,	@item2_type int
,	@item2_class int
,	@item2_limitType int
,	@item2_limitDate datetime
,	@item3_type int
,	@item3_class int
,	@item3_limitType int
,	@item3_limitDate datetime
,	@item4_type int
,	@item4_class int
,	@item4_limitType int
,	@item4_limitDate datetime
,	@item5_type int
,	@item5_class int
,	@item5_limitType int
,	@item5_limitDate datetime
,	@item6_type int
,	@item6_class int
,	@item6_limitType int
,	@item6_limitDate datetime
,	@item7_type int
,	@item7_class int
,	@item7_limitType int
,	@item7_limitDate datetime
,	@item8_type int
,	@item8_class int
,	@item8_limitType int
,	@item8_limitDate datetime
,	@item9_type int
,	@item9_class int
,	@item9_limitType int
,	@item9_limitDate datetime
,	@item10_type int
,	@item10_class int
,	@item10_limitType int
,	@item10_limitDate datetime
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userItemMedalDB (
	accountIDX,
	item1_type, item1_class, item1_limitType, item1_limitDate, item2_type, item2_class, item2_limitType, item2_limitDate,
	item3_type, item3_class, item3_limitType, item3_limitDate, item4_type, item4_class, item4_limitType, item4_limitDate,
	item5_type, item5_class, item5_limitType, item5_limitDate, item6_type, item6_class, item6_limitType, item6_limitDate,
	item7_type, item7_class, item7_limitType, item7_limitDate, item8_type, item8_class, item8_limitType, item8_limitDate,
	item9_type, item9_class, item9_limitType, item9_limitDate, item10_type, item10_class, item10_limitType, item10_limitDate,
	regDate
)
VALUES (
	@accountIDX,
	@item1_type, @item1_class, @item1_limitType, @item1_limitDate, @item2_type, @item2_class, @item2_limitType, @item2_limitDate,
	@item3_type, @item3_class, @item3_limitType, @item3_limitDate, @item4_type, @item4_class, @item4_limitType, @item4_limitDate,
	@item5_type, @item5_class, @item5_limitType, @item5_limitDate, @item6_type, @item6_class, @item6_limitType, @item6_limitDate,
	@item7_type, @item7_class, @item7_limitType, @item7_limitDate, @item8_type, @item8_class, @item8_limitType, @item8_limitDate,
	@item9_type, @item9_class, @item9_limitType, @item9_limitDate, @item10_type, @item10_class, @item10_limitType, @item10_limitDate,
	GETDATE()
)
GO
/****** Object:  StoredProcedure [dbo].[game_item_medal_extend_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_medal_extend_add]
(
	@accountIDX int
,	@medal1_class int
,	@medal1_slot tinyint
,	@medal1_period int
,	@medal2_class int
,	@medal2_slot tinyint
,	@medal2_period int
,	@medal3_class int
,	@medal3_slot tinyint
,	@medal3_period int
,	@medal4_class int
,	@medal4_slot tinyint
,	@medal4_period int
,	@medal5_class int
,	@medal5_slot tinyint
,	@medal5_period int
,	@medal6_class int
,	@medal6_slot tinyint
,	@medal6_period int
,	@medal7_class int
,	@medal7_slot tinyint
,	@medal7_period int
,	@medal8_class int
,	@medal8_slot tinyint
,	@medal8_period int
,	@medal9_class int
,	@medal9_slot tinyint
,	@medal9_period int
,	@medal10_class int
,	@medal10_slot tinyint
,	@medal10_period int
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userItemMedalExtendDB (
	accountIDX,
	medal1_class, medal1_slot, medal1_period, medal2_class, medal2_slot, medal2_period,
	medal3_class, medal3_slot, medal3_period, medal4_class, medal4_slot, medal4_period,
	medal5_class, medal5_slot, medal5_period, medal6_class, medal6_slot, medal6_period,
	medal7_class, medal7_slot, medal7_period, medal8_class, medal8_slot, medal8_period,
	medal9_class, medal9_slot, medal9_period, medal10_class, medal10_slot, medal10_period, regDate
)
VALUES (
	@accountIDX,
	@medal1_class, @medal1_slot, @medal1_period, @medal2_class, @medal2_slot, @medal2_period,
	@medal3_class, @medal3_slot, @medal3_period, @medal4_class, @medal4_slot, @medal4_period,
	@medal5_class, @medal5_slot, @medal5_period, @medal6_class, @medal6_slot, @medal6_period,
	@medal7_class, @medal7_slot, @medal7_period, @medal8_class, @medal8_slot, @medal8_period,
	@medal9_class, @medal9_slot, @medal9_period, @medal10_class, @medal10_slot, @medal10_period,
	GETDATE()
)
GO
/****** Object:  StoredProcedure [dbo].[game_item_medal_extend_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_medal_extend_get_list]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT idx,
	   medal1_class, medal1_slot, medal1_period, medal2_class, medal2_slot, medal2_period,
	   medal3_class, medal3_slot, medal3_period, medal4_class, medal4_slot, medal4_period,
	   medal5_class, medal5_slot, medal5_period, medal6_class, medal6_slot, medal6_period,
	   medal7_class, medal7_slot, medal7_period, medal8_class, medal8_slot, medal8_period,
	   medal9_class, medal9_slot, medal9_period, medal10_class, medal10_slot, medal10_period
  FROM dbo.userItemMedalExtendDB WITH(NOLOCK)
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_item_medal_extend_get_self_index]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_medal_extend_get_self_index]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT TOP 1 idx
  FROM dbo.userItemMedalExtendDB
 WHERE accountIDX = @accountIDX
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_item_medal_extend_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_medal_extend_save]
(
	@idx int
,	@medal1_class int
,	@medal1_slot tinyint
,	@medal1_period int
,	@medal2_class int
,	@medal2_slot tinyint
,	@medal2_period int
,	@medal3_class int
,	@medal3_slot tinyint
,	@medal3_period int
,	@medal4_class int
,	@medal4_slot tinyint
,	@medal4_period int
,	@medal5_class int
,	@medal5_slot tinyint
,	@medal5_period int
,	@medal6_class int
,	@medal6_slot tinyint
,	@medal6_period int
,	@medal7_class int
,	@medal7_slot tinyint
,	@medal7_period int
,	@medal8_class int
,	@medal8_slot tinyint
,	@medal8_period int
,	@medal9_class int
,	@medal9_slot tinyint
,	@medal9_period int
,	@medal10_class int
,	@medal10_slot tinyint
,	@medal10_period int
)
AS

SET NOCOUNT ON

UPDATE dbo.userItemMedalExtendDB
   SET medal1_class = @medal1_class,
	   medal1_slot = @medal1_slot,
	   medal1_period = @medal1_period,
	   medal2_class = @medal2_class,
	   medal2_slot = @medal2_slot,
	   medal2_period = @medal2_period,
	   medal3_class = @medal3_class,
	   medal3_slot = @medal3_slot,
	   medal3_period = @medal3_period,
	   medal4_class = @medal4_class,
	   medal4_slot = @medal4_slot,
	   medal4_period = @medal4_period,
	   medal5_class = @medal5_class,
	   medal5_slot = @medal5_slot,
	   medal5_period = @medal5_period,
	   medal6_class = @medal6_class,
	   medal6_slot = @medal6_slot,
	   medal6_period = @medal6_period,
	   medal7_class = @medal7_class,
	   medal7_slot = @medal7_slot,
	   medal7_period = @medal7_period,
	   medal8_class = @medal8_class,
	   medal8_slot = @medal8_slot,
	   medal8_period = @medal8_period,
	   medal9_class = @medal9_class,
	   medal9_slot = @medal9_slot,
	   medal9_period = @medal9_period,
	   medal10_class = @medal10_class,
	   medal10_slot = @medal10_slot,
	   medal10_period = @medal10_period
 WHERE idx = @idx
GO
/****** Object:  StoredProcedure [dbo].[game_item_medal_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_medal_get_list]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT idx,
	   item1_type, item1_class, item1_limitType, item1_limitDate,
	   item2_type, item2_class, item2_limitType, item2_limitDate,
	   item3_type, item3_class, item3_limitType, item3_limitDate,
	   item4_type, item4_class, item4_limitType, item4_limitDate,
	   item5_type, item5_class, item5_limitType, item5_limitDate,
	   item6_type, item6_class, item6_limitType, item6_limitDate,
	   item7_type, item7_class, item7_limitType, item7_limitDate,
	   item8_type, item8_class, item8_limitType, item8_limitDate,
	   item9_type, item9_class, item9_limitType, item9_limitDate,
	   item10_type, item10_class, item10_limitType, item10_limitDate
  FROM dbo.userItemMedalDB WITH(NOLOCK)
 WHERE accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_item_medal_get_self_index]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_medal_get_self_index]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT TOP 1 idx
  FROM dbo.userItemMedalDB
 WHERE accountIDX = @accountIDX
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_item_medal_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_medal_save]
(
	@idx int
,	@item1_type int
,	@item1_class int
,	@item1_limitType int
,	@item1_limitDate datetime
,	@item2_type int
,	@item2_class int
,	@item2_limitType int
,	@item2_limitDate datetime
,	@item3_type int
,	@item3_class int
,	@item3_limitType int
,	@item3_limitDate datetime
,	@item4_type int
,	@item4_class int
,	@item4_limitType int
,	@item4_limitDate datetime
,	@item5_type int
,	@item5_class int
,	@item5_limitType int
,	@item5_limitDate datetime
,	@item6_type int
,	@item6_class int
,	@item6_limitType int
,	@item6_limitDate datetime
,	@item7_type int
,	@item7_class int
,	@item7_limitType int
,	@item7_limitDate datetime
,	@item8_type int
,	@item8_class int
,	@item8_limitType int
,	@item8_limitDate datetime
,	@item9_type int
,	@item9_class int
,	@item9_limitType int
,	@item9_limitDate datetime
,	@item10_type int
,	@item10_class int
,	@item10_limitType int
,	@item10_limitDate datetime
)
AS

SET NOCOUNT ON

UPDATE dbo.userItemMedalDB
   SET item1_type = @item1_type,
	   item1_class = @item1_class,
	   item1_limitType = @item1_limitType,
	   item1_limitDate = @item1_limitDate,
	   item2_type = @item2_type,
	   item2_class = @item2_class,
	   item2_limitType = @item2_limitType,
	   item2_limitDate = @item2_limitDate,
	   item3_type = @item3_type,
	   item3_class = @item3_class,
	   item3_limitType = @item3_limitType,
	   item3_limitDate = @item3_limitDate,
	   item4_type = @item4_type,
	   item4_class = @item4_class,
	   item4_limitType = @item4_limitType,
	   item4_limitDate = @item4_limitDate,
	   item5_type = @item5_type,
	   item5_class = @item5_class,
	   item5_limitType = @item5_limitType,
	   item5_limitDate = @item5_limitDate,
	   item6_type = @item6_type,
	   item6_class = @item6_class,
	   item6_limitType = @item6_limitType,
	   item6_limitDate = @item6_limitDate,
	   item7_type = @item7_type,
	   item7_class = @item7_class,
	   item7_limitType = @item7_limitType,
	   item7_limitDate = @item7_limitDate,
	   item8_type = @item8_type,
	   item8_class = @item8_class,
	   item8_limitType = @item8_limitType,
	   item8_limitDate = @item8_limitDate,
	   item9_type = @item9_type,
	   item9_class = @item9_class,
	   item9_limitType = @item9_limitType,
	   item9_limitDate = @item9_limitDate,
	   item10_type = @item10_type,
	   item10_class = @item10_class,
	   item10_limitType = @item10_limitType,
	   item10_limitDate = @item10_limitDate
 WHERE idx=@idx
GO
/****** Object:  StoredProcedure [dbo].[game_item_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_item_save]
(
	@idx int
,	@item1_type int
,	@item1_code int
,	@item2_type int
,	@item2_code int
,	@item3_type int
,	@item3_code int
,	@item4_type int
,	@item4_code int
,	@item5_type int
,	@item5_code int
,	@item6_type int
,	@item6_code int
,	@item7_type int
,	@item7_code int
,	@item8_type int
,	@item8_code int
,	@item9_type int
,	@item9_code int
,	@item10_type int
,	@item10_code int
,	@item11_type int
,	@item11_code int
,	@item12_type int
,	@item12_code int
,	@item13_type int
,	@item13_code int
,	@item14_type int
,	@item14_code int
,	@item15_type int
,	@item15_code int
,	@item16_type int
,	@item16_code int
,	@item17_type int
,	@item17_code int
,	@item18_type int
,	@item18_code int
,	@item19_type int
,	@item19_code int
,	@item20_type int
,	@item20_code int
)
AS

SET NOCOUNT ON

UPDATE dbo.userItemDB
   SET item1_type = @item1_type,
	   item1_code = @item1_code,
	   item2_type = @item2_type,
	   item2_code = @item2_code,
	   item3_type = @item3_type,
	   item3_code = @item3_code,
	   item4_type = @item4_type,
	   item4_code = @item4_code,
	   item5_type = @item5_type,
	   item5_code = @item5_code,
	   item6_type = @item6_type,
	   item6_code = @item6_code,
	   item7_type = @item7_type,
	   item7_code = @item7_code,
	   item8_type = @item8_type,
	   item8_code = @item8_code,
	   item9_type = @item9_type,
	   item9_code = @item9_code,
	   item10_type = @item10_type,
	   item10_code = @item10_code,
	   item11_type = @item11_type,
	   item11_code = @item11_code,
	   item12_type = @item12_type,
	   item12_code = @item12_code,
	   item13_type = @item13_type,
	   item13_code = @item13_code,
	   item14_type = @item14_type,
	   item14_code = @item14_code,
	   item15_type = @item15_type,
	   item15_code = @item15_code,
	   item16_type = @item16_type,
	   item16_code = @item16_code,
	   item17_type = @item17_type,
	   item17_code = @item17_code,
	   item18_type = @item18_type,
	   item18_code = @item18_code,
	   item19_type = @item19_type,
	   item19_code = @item19_code,
	   item20_type = @item20_type,
	   item20_code = @item20_code
 WHERE idx = @idx
GO
/****** Object:  StoredProcedure [dbo].[game_league_auth_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_auth_add]
(
	@leagueIDX int
,	@accountIDX int
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userLeagueAuthDB (leagueIDX, accountIDX, regDate)
VALUES (@leagueIDX, @accountIDX, GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[game_league_auth_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_auth_list]
(
	@topN int
,	@idx int
,	@leagueIDX int
)
AS

SET NOCOUNT ON

SELECT TOP (@topN) a.accountIDX, b.nickName, c.userLevel
  FROM dbo.userLeagueAuthDB a WITH(NOLOCK)
  JOIN userMemberDB b WITH(NOLOCK)
    ON a.accountIDX = b.accountIDX
  JOIN userGameDB c WITH(NOLOCK)
    ON a.accountIDX = c.accountIDX
 WHERE idx > @idx
   AND leagueIDX=@leagueIDX
 ORDER BY idx ASC
GO
/****** Object:  StoredProcedure [dbo].[game_league_backup]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_backup]
(
	@leagueIDX int
)
AS

SET NOCOUNT ON

DECLARE @startDate int
SET @startDate = ISNULL((
	SELECT startDate 
	  FROM dbo.userLeagueListDB WITH(NOLOCK)
	 WHERE idx=@leagueIDX
	), 0)


-- league backup
INSERT INTO LosaGame_log.dbo.log_league_list (
	leagueIDX, accountIDX, startDate, endDate, leagueType, leagueState, regDate, insertDate
)
SELECT idx, accountIDX, startDate, endDate, leagueType, leagueState, regDate, GETDATE()
  FROM dbo.userLeagueListDB WITH(NOLOCK)
 WHERE idx=@leagueIDX


-- team backup
INSERT INTO LosaGame_log.dbo.log_league_team (
	teamIDX, leagueIDX, startDate, teamName, leaderIDX, leagueStartPosition, leaguePosition, maxcount, cheerPoint,
	currentRound, factionPoint, factionType, regDate, insertDate
)
SELECT idx, leagueIDX, @startDate, teamName, leaderIDX, leagueStartPosition, leaguePosition, maxcount, cheerPoint,
	   currentRound, factionPoint, factionType, regDate, GETDATE()
  FROM dbo.userLeagueTeamDB WITH(NOLOCK)
 WHERE leagueIDX=@leagueIDX


-- team member backup
INSERT INTO LosaGame_log.dbo.log_league_team_member (
	teamMemberIDX, startDate, accountIDX, leagueIDX, teamIDX, joinType, regDate, insertDate
)
SELECT idx, @startDate, accountIDX, leagueIDX, teamIDX, joinType, regDate, GETDATE()
  FROM dbo.userLeagueTeamMemberDB WITH(NOLOCK)
 WHERE leagueIDX=@leagueIDX


-- cheer backup
INSERT INTO LosaGame_log.dbo.log_league_cheer (
	cheerIDX, startDate, accountIDX, leagueIDX, teamIDX, regDate, insertDate
)
SELECT idx, @startDate, accountIDX, leagueIDX, teamIDX, regDate, GETDATE()
  FROM dbo.userLeagueCheerDB WITH(NOLOCK)
 WHERE leagueIDX=@leagueIDX
GO
/****** Object:  StoredProcedure [dbo].[game_league_backup_user]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_backup_user]
(
	@leagueIDX int
)
AS

SET NOCOUNT ON


DECLARE @startDate int
DECLARE @infoIDX int

SET @startDate = ISNULL((
	SELECT startDate 
	  FROM dbo.userLeagueListDB WITH(NOLOCK)
	 WHERE idx=@leagueIDX
	), 0)

SET @infoIDX = ISNULL((
	SELECT idx
	  FROM dbo.userLeagueInfoDB WITH(NOLOCK)
	 WHERE leagueIDX=@leagueIDX
	), 0)

INSERT INTO LosaGame_log.dbo.log_league_list_user (
	leagueIDX, accountIDX, startDate, endDate, leagueType, leagueState, regDate, insertDate
)
SELECT idx, accountIDX, startDate, endDate, leagueType, leagueState, regDate, GETDATE()
  FROM dbo.userLeagueListDB WITH(NOLOCK)
 WHERE idx=@leagueIDX


INSERT INTO LosaGame_log.dbo.log_league_team_user (
	teamIDX, leagueIDX, startDate, teamName, leaderIDX, leagueStartPosition, leaguePosition, maxcount, cheerPoint,
	currentRound, factionPoint, factionType, regDate, insertDate
)
SELECT idx, leagueIDX, @startDate, teamName, leaderIDX, leagueStartPosition, leaguePosition, maxcount, cheerPoint,
	   currentRound, factionPoint, factionType, regDate, GETDATE()
  FROM dbo.userLeagueTeamDB WITH(NOLOCK)
 WHERE leagueIDX=@leagueIDX


INSERT INTO LosaGame_log.dbo.log_league_team_member_user (
	teamMemberIDX, startDate, accountIDX, leagueIDX, teamIDX, joinType, regDate, insertDate
)
SELECT idx, @startDate, accountIDX, leagueIDX, teamIDX, joinType, regDate, GETDATE()
  FROM dbo.userLeagueTeamMemberDB WITH(NOLOCK)
 WHERE leagueIDX=@leagueIDX


INSERT INTO LosaGame_log.dbo.log_league_info_user (
	infoIDX, leagueIDX, leagueName, maxRound, bannerA, bannerB, modeType, maxcount, autoType, announce, recruitDate, waitDate, regDate, insertDate
)
SELECT idx, leagueIDX, leagueName, maxRound, bannerA, bannerB, modeType, maxcount, autoType, announce, recruitDate, waitDate, regDate, GETDATE()
  FROM dbo.userLeagueInfoDB WITH(NOLOCK)
 WHERE leagueIDX=@leagueIDX


INSERT INTO LosaGame_log.dbo.log_league_round_user (
	roundIDX, infoIDX,
	roundType1_playDate, roundType1_presentCode1, roundType1_presentCode2, roundType1_presentCode3, roundType1_presentCode4,
	roundType2_playDate, roundType2_presentCode1, roundType2_presentCode2, roundType2_presentCode3, roundType2_presentCode4,
	roundType3_playDate, roundType3_presentCode1, roundType3_presentCode2, roundType3_presentCode3, roundType3_presentCode4,
	roundType4_playDate, roundType4_presentCode1, roundType4_presentCode2, roundType4_presentCode3, roundType4_presentCode4,
	roundType5_playDate, roundType5_presentCode1, roundType5_presentCode2, roundType5_presentCode3, roundType5_presentCode4,
	roundType6_playDate, roundType6_presentCode1, roundType6_presentCode2, roundType6_presentCode3, roundType6_presentCode4,
	roundType7_playDate, roundType7_presentCode1, roundType7_presentCode2, roundType7_presentCode3, roundType7_presentCode4,
	roundType8_playDate, roundType8_presentCode1, roundType8_presentCode2, roundType8_presentCode3, roundType8_presentCode4,
	roundType9_playDate, roundType9_presentCode1, roundType9_presentCode2, roundType9_presentCode3, roundType9_presentCode4,
	roundType10_playDate, roundType10_presentCode1, roundType10_presentCode2, roundType10_presentCode3, roundType10_presentCode4,
	roundType11_playDate, roundType11_presentCode1, roundType11_presentCode2, roundType11_presentCode3, roundType11_presentCode4,
	regDate, insertDate
)
SELECT idx, infoIDX,
	   roundType1_playDate, roundType1_presentCode1, roundType1_presentCode2, roundType1_presentCode3, roundType1_presentCode4,
	   roundType2_playDate, roundType2_presentCode1, roundType2_presentCode2, roundType2_presentCode3, roundType2_presentCode4,
	   roundType3_playDate, roundType3_presentCode1, roundType3_presentCode2, roundType3_presentCode3, roundType3_presentCode4,
	   roundType4_playDate, roundType4_presentCode1, roundType4_presentCode2, roundType4_presentCode3, roundType4_presentCode4,
	   roundType5_playDate, roundType5_presentCode1, roundType5_presentCode2, roundType5_presentCode3, roundType5_presentCode4,
	   roundType6_playDate, roundType6_presentCode1, roundType6_presentCode2, roundType6_presentCode3, roundType6_presentCode4,
	   roundType7_playDate, roundType7_presentCode1, roundType7_presentCode2, roundType7_presentCode3, roundType7_presentCode4,
	   roundType8_playDate, roundType8_presentCode1, roundType8_presentCode2, roundType8_presentCode3, roundType8_presentCode4,
	   roundType9_playDate, roundType9_presentCode1, roundType9_presentCode2, roundType9_presentCode3, roundType9_presentCode4,
	   roundType10_playDate, roundType10_presentCode1, roundType10_presentCode2, roundType10_presentCode3, roundType10_presentCode4,
	   roundType11_playDate, roundType11_presentCode1, roundType11_presentCode2, roundType11_presentCode3, roundType11_presentCode4,
	   regDate, GETDATE()
  FROM dbo.userLeagueRoundDB WITH(NOLOCK)
 WHERE infoIDX=@infoIDX
GO
/****** Object:  StoredProcedure [dbo].[game_league_cheer_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_cheer_add]
(
	@accountIDX int
,	@leagueIDX int
,	@teamIDX int
)
AS

SET NOCOUNT ON

DECLARE @cnt INT
DECLARE @errcount INT

SET @cnt = 0
SET @errcount = 0

SET @cnt = (
	SELECT COUNT(*)
	FROM dbo.userLeagueCheerDB WITH(NOLOCK)
	WHERE accountIDX=@accountIDX
	  AND leagueIDX=@leagueIDX
)

IF (@cnt > 0)
BEGIN
	SET @errcount = 2
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userLeagueTeamDB WITH(NOLOCK)
	 WHERE idx=@teamIDX
	   AND leagueIDX=@leagueIDX
)

IF (@cnt = 0)
BEGIN
	SET @errcount = 3
	SELECT @errcount AS 'returnVal'
	RETURN
END

IF (@errcount = 0)
BEGIN
	INSERT INTO dbo.userLeagueCheerDB (accountIDX, leagueIDX, teamIDX, regDate)
	VALUES (@accountIDX, @leagueIDX, @teamIDX, GETDATE())

	UPDATE dbo.userLeagueTeamDB
	   SET cheerPoint = cheerPoint + 1
	 WHERE idx=@teamIDX

	SET @errcount = 1
	SELECT @errcount AS 'returnVal'
END
GO
/****** Object:  StoredProcedure [dbo].[game_league_cheer_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_cheer_list]
(
	@accountIDX int
,	@topN int
,	@idx int
)
AS

SET NOCOUNT ON

SELECT TOP (@topN) leagueIDX, teamIDX, idx
  FROM dbo.userLeagueCheerDB WITH(NOLOCK)
 WHERE idx < @idx
   AND accountIDX=@accountIDX
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_league_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_delete]
(
	@leagueIDX int
)
AS

SET NOCOUNT ON

DECLARE @infoIDX int
SET @infoIDX = ISNULL((SELECT idx FROM dbo.userLeagueInfoDB WITH(NOLOCK) WHERE leagueIDX=@leagueIDX), 0)

DELETE FROM dbo.userLeagueTeamMemberDB WHERE leagueIDX=@leagueIDX
DELETE FROM dbo.userLeagueTeamDB WHERE leagueIDX=@leagueIDX
DELETE FROM dbo.userLeagueInfoDB WHERE leagueIDX=@leagueIDX
DELETE FROM dbo.userLeagueAuthDB WHERE leagueIDX=@leagueIDX
DELETE FROM dbo.userLeagueRoundDB WHERE infoIDX=@infoIDX
DELETE FROM dbo.userLeagueListDB WHERE idx=@leagueIDX
GO
/****** Object:  StoredProcedure [dbo].[game_league_get_info]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_get_info]
(
	@leagueIDX int
)
AS

SET NOCOUNT ON

SELECT idx, leagueName, maxRound, bannerA, bannerB, modeType, maxcount, autoType, announce, recruitDate, waitDate
  FROM dbo.userLeagueInfoDB WITH(NOLOCK)
 WHERE leagueIDX=@leagueIDX
GO
/****** Object:  StoredProcedure [dbo].[game_league_get_reward]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_get_reward]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT idx, startDate, currentRound, userFactionType, winnerFactionType, rewardPeso, factionRank, factionPoint
  FROM dbo.userLeagueRewardDB WITH(NOLOCK)
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_league_get_reward_cheer]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_get_reward_cheer]
(
	@accountIDX INT
,	@flag TINYINT
)
AS

SET NOCOUNT ON


SELECT idx, rewardPeso
  FROM dbo.userLeagueRewardCheerDB WITH(NOLOCK)
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_league_history_get_winner_team_info]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_history_get_winner_team_info]

AS

SET NOCOUNT ON

SELECT TOP 1 teamName, factionType
  FROM dbo.userLeagueWinnerHistoryDB WITH(NOLOCK)
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_league_history_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_history_list]
(
	@topN int
,	@idx int
)
AS

SET NOCOUNT ON

SELECT TOP (@topN) idx, leagueTitle, startDate, teamName, factionType, factionName
  FROM dbo.userLeagueWinnerHistoryDB WITH(NOLOCK)
 WHERE idx > @idx
 ORDER BY idx ASC
GO
/****** Object:  StoredProcedure [dbo].[game_league_info_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_info_save]
(
	@idx int
,	@announce nvarchar(512)
,	@recruitDate int
,	@waitDate int
)
AS

SET NOCOUNT ON

UPDATE dbo.userLeagueInfoDB
   SET announce = @announce
,	   recruitDate = @recruitDate
,	   waitDate = @waitDate
 WHERE idx=@idx
GO
/****** Object:  StoredProcedure [dbo].[game_league_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_list]
(
	@topN int
,	@idx int
)
AS

SET NOCOUNT ON

SELECT TOP (@topN) idx, accountIDX, startDate, endDate, leagueType, leagueState
  FROM dbo.userLeagueListDB WITH(NOLOCK)
 WHERE idx < @idx
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_league_list_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_list_add]
(
	@accountIDX int
,	@startDate int
,	@endDate int
,	@leagueType tinyint
,	@leagueState tinyint
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userLeagueListDB (
	accountIDX, startDate, endDate, leagueType, leagueState, regDate
)
VALUES (
	@accountIDX, @startDate, @endDate, @leagueType, @leagueState, GETDATE()
)
GO
/****** Object:  StoredProcedure [dbo].[game_league_list_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_list_save]
(
	@idx int
,	@startDate int
,	@endDate int
,	@leagueType tinyint
,	@leagueState tinyint
)
AS

SET NOCOUNT ON

UPDATE dbo.userLeagueListDB
   SET startDate = @startDate,
	   endDate = @endDate,
	   leagueType = @leagueType,
	   leagueState = @leagueState
 WHERE idx = @idx
GO
/****** Object:  StoredProcedure [dbo].[game_league_my_team_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_my_team_list]
(
	@topN int
,	@idx int
,	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT TOP (@topN) idx, leagueIDX, teamName, leaderIDX, leaguePosition,
	   cheerPoint, currentRound, factionPoint, factionType
  FROM dbo.userLeagueTeamDB WITH(NOLOCK)
 WHERE idx < @idx
   AND idx IN (
	SELECT teamIDX
	  FROM dbo.userLeagueTeamMemberDB WITH(NOLOCK)
	 WHERE accountIDX=@accountIDX
	   AND joinType=1
  )
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_league_my_team_member_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_my_team_member_list]
(
	@accountIDX int
,	@topN int
,	@idx int
)
AS

SET NOCOUNT ON

SELECT TOP (@topN) [idx], accountIDX, teamIDX
  FROM dbo.userLeagueTeamMemberDB WITH(NOLOCK)
 WHERE idx < @idx
   AND teamIDX in (
	SELECT teamIDX
	  FROM dbo.userLeagueTeamMemberDB WITH(NOLOCK)
	 WHERE accountIDX=@accountIDX
       AND joinType=1
  )
   AND joinType=1
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_league_reward_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_reward_add]
(
	@startDate int
,	@leagueIDX int
,	@leagueSize smallint
,	@teamConst smallint
,	@userConst smallint
)
AS

SET NOCOUNT ON

DECLARE @winnerFactionType INT
DECLARE @factionType TINYINT
DECLARE @winnerTeamIDX INT
DECLARE @winnerTeamCheerCount INT
DECLARE @cheerTotalCount decimal( 10, 2 )
DECLARE @rewardTeamCheer INT
DECLARE @rewardUserCheer float
DECLARE @DeveloperKIDX INT

SET @winnerFactionType = 0
SET @factionType = 0
SET @winnerTeamIDX = 0


IF (EXISTS(SELECT * FROM dbo.userLeagueWinnerHistoryDB WITH(NOLOCK) WHERE startDate=@startDate))
BEGIN
	SELECT TOP 1 @winnerFactionType = factionType,
				 @winnerTeamIDX = teamIDX
	  FROM dbo.userLeagueWinnerHistoryDB WITH(NOLOCK)
	 WHERE startDate=@startDate
	 ORDER BY idx DESC
END



DELETE FROM dbo.userLeagueRewardDB
WHERE regDate < LEFT(CONVERT(varchar(20), GETDATE(), 120), 10)

DELETE FROM dbo.userLeagueRewardCheerDB
WHERE regDate < LEFT(CONVERT(varchar(20), GETDATE(), 120), 10)




INSERT INTO dbo.userLeagueRewardDB (
	accountIDX, startDate, currentRound, userFactionType, winnerFactionType, rewardPeso, factionRank, factionPoint, regDate
)
SELECT a.accountIDX, @startDate, c.currentRound, b.regionType, @winnerFactionType, 
	CASE WHEN @winnerFactionType = b.regionType THEN CAST(b.renspoint * 5 AS INT)
		 WHEN @winnerFactionType <> b.regionType THEN CAST(b.renspoint AS INT)
	ELSE CAST(b.renspoint AS INT) END AS rewardPeso,
	   0, b.renspoint, GETDATE()
  FROM dbo.userLeagueTeamMemberDB a WITH(NOLOCK)
  JOIN dbo.userGameDB b WITH(NOLOCK)
    ON a.accountIDX = b.accountIDX
  JOIN dbo.userLeagueTeamDB c WITH(NOLOCK)
	ON a.teamIDX=c.idx
 WHERE a.leagueIDX=@leagueIDX
   AND a.joinType=1



INSERT INTO dbo.userLeagueRewardDB (
	accountIDX, startDate, currentRound, userFactionType, winnerFactionType, rewardPeso, factionRank, factionPoint, regDate
)
SELECT accountIDX, @startDate, 0, regionType, @winnerFactionType, 
	CASE WHEN @winnerFactionType = regionType THEN CAST(renspoint * 5 AS INT)
		 WHEN @winnerFactionType <> regionType THEN CAST(renspoint AS INT)
	ELSE CAST(renspoint AS INT) END AS rewardPeso,
	   0, renspoint, GETDATE()
  FROM dbo.userGameDB WITH(NOLOCK)
 WHERE renspoint > 0
   AND accountIDX NOT IN (
	   SELECT accountIDX
		 FROM dbo.userLeagueRewardDB WITH(NOLOCK)
	   )



UPDATE B
   SET currentRound = A.currentRound
  FROM (
	SELECT a.accountIDX, b.currentRound, @startDate AS startDate
	  FROM dbo.userLeagueTeamMemberDB a WITH(NOLOCK)
	  JOIN dbo.userLeagueTeamDB b WITH(NOLOCK)
		ON a.teamIDX=b.idx
	 WHERE a.leagueIDX=@leagueIDX
	   AND b.leagueIDX=@leagueIDX
) A
  JOIN dbo.userLeagueRewardDB B WITH(NOLOCK)
    ON A.accountIDX = B.accountIDX



UPDATE B
   SET factionRank = A.region
  FROM (
	SELECT accountIDX, region
	  FROM dbo.userRankingDB WITH(NOLOCK)
) A
  JOIN dbo.userLeagueRewardDB B WITH(NOLOCK)
    ON A.accountIDX = B.accountIDX



UPDATE dbo.userLeagueRewardDB
   SET factionRank = 100000000
 WHERE factionRank = 0



IF (@winnerTeamIDX > 0)
BEGIN

	SET @winnerTeamCheerCount = (
		SELECT cheerPoint
		  FROM dbo.userLeagueTeamDB WITH(NOLOCK)
		 WHERE leagueIDX=@leagueIDX
		   AND idx=@winnerTeamIDX
	)
/*
	SET @rewardTeamCheer = @winnerTeamCheerCount * @teamConst

	IF (@rewardTeamCheer > 100000)
	BEGIN
		SET @rewardTeamCheer = 100000
	END

	SET @DeveloperKIDX = (
		SELECT accountIDX
		  FROM dbo.userMemberDB WITH(NOLOCK)
		 WHERE userID = 'DeveloperK'
	)

	IF (@DeveloperKIDX NOT IS NULL)
	BEGIN
		INSERT INTO dbo.userPresentDB (
			sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate
		)
		SELECT @DeveloperKIDX, accountIDX, 4, @rewardTeamCheer, 0, 0, 0, 3, 1, GETDATE()+14, GETDATE())
	END
*/




	SET @cheerTotalCount = convert( numeric( 19,1 ), (
		SELECT COUNT(*)
		  FROM dbo.userLeagueCheerDB WITH(NOLOCK)
		 WHERE leagueIDX=@leagueIDX
	) )

	SET @rewardUserCheer = ((@cheerTotalCount / @leagueSize) / @winnerTeamCheerCount * @userConst)


	IF (@rewardUserCheer < 1000)
	BEGIN
		SET @rewardUserCheer = 1000
	END


	IF (@rewardUserCheer > 100000)
	BEGIN
		SET @rewardUserCheer = 100000
	END

	INSERT INTO dbo.userLeagueRewardCheerDB (
		accountIDX, rewardPeso, startDate, flag, regDate
	)
	SELECT accountIDX, @rewardUserCheer, @startDate, 1, GETDATE()
	  FROM dbo.userLeagueCheerDB WITH(NOLOCK)
	 WHERE leagueIDX=@leagueIDX
	   AND teamIDX=@winnerTeamIDX

END
GO
/****** Object:  StoredProcedure [dbo].[game_league_reward_cheer_del]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_reward_cheer_del]
(
	@idx int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userLeagueRewardCheerDB
 WHERE idx = @idx
GO
/****** Object:  StoredProcedure [dbo].[game_league_reward_del]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_reward_del]
(
	@idx int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userLeagueRewardDB
 WHERE idx=@idx
GO
/****** Object:  StoredProcedure [dbo].[game_league_round_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_round_data]
(
	@infoIDX int
)
AS

SET NOCOUNT ON

SELECT idx,
	   roundType1_playDate, roundType1_presentCode1, roundType1_presentCode2, roundType1_presentCode3, roundType1_presentCode4,
	   roundType2_playDate, roundType2_presentCode1, roundType2_presentCode2, roundType2_presentCode3, roundType2_presentCode4,
	   roundType3_playDate, roundType3_presentCode1, roundType3_presentCode2, roundType3_presentCode3, roundType3_presentCode4,
	   roundType4_playDate, roundType4_presentCode1, roundType4_presentCode2, roundType4_presentCode3, roundType4_presentCode4,
	   roundType5_playDate, roundType5_presentCode1, roundType5_presentCode2, roundType5_presentCode3, roundType5_presentCode4,
	   roundType6_playDate, roundType6_presentCode1, roundType6_presentCode2, roundType6_presentCode3, roundType6_presentCode4,
	   roundType7_playDate, roundType7_presentCode1, roundType7_presentCode2, roundType7_presentCode3, roundType7_presentCode4,
	   roundType8_playDate, roundType8_presentCode1, roundType8_presentCode2, roundType8_presentCode3, roundType8_presentCode4,
	   roundType9_playDate, roundType9_presentCode1, roundType9_presentCode2, roundType9_presentCode3, roundType9_presentCode4,
	   roundType10_playDate, roundType10_presentCode1, roundType10_presentCode2, roundType10_presentCode3, roundType10_presentCode4,
	   roundType11_playDate, roundType11_presentCode1, roundType11_presentCode2, roundType11_presentCode3, roundType11_presentCode4
  FROM dbo.userLeagueRoundDB WITH(NOLOCK)
 WHERE infoIDX=@infoIDX
GO
/****** Object:  StoredProcedure [dbo].[game_league_round_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_round_save]
(
	@idx int
,	@roundType1_playDate int
,	@roundType1_presentCode1 int
,	@roundType1_presentCode2 int
,	@roundType1_presentCode3 int
,	@roundType1_presentCode4 int
,	@roundType2_playDate int
,	@roundType2_presentCode1 int
,	@roundType2_presentCode2 int
,	@roundType2_presentCode3 int
,	@roundType2_presentCode4 int
,	@roundType3_playDate int
,	@roundType3_presentCode1 int
,	@roundType3_presentCode2 int
,	@roundType3_presentCode3 int
,	@roundType3_presentCode4 int
,	@roundType4_playDate int
,	@roundType4_presentCode1 int
,	@roundType4_presentCode2 int
,	@roundType4_presentCode3 int
,	@roundType4_presentCode4 int
,	@roundType5_playDate int
,	@roundType5_presentCode1 int
,	@roundType5_presentCode2 int
,	@roundType5_presentCode3 int
,	@roundType5_presentCode4 int
,	@roundType6_playDate int
,	@roundType6_presentCode1 int
,	@roundType6_presentCode2 int
,	@roundType6_presentCode3 int
,	@roundType6_presentCode4 int
,	@roundType7_playDate int
,	@roundType7_presentCode1 int
,	@roundType7_presentCode2 int
,	@roundType7_presentCode3 int
,	@roundType7_presentCode4 int
,	@roundType8_playDate int
,	@roundType8_presentCode1 int
,	@roundType8_presentCode2 int
,	@roundType8_presentCode3 int
,	@roundType8_presentCode4 int
,	@roundType9_playDate int
,	@roundType9_presentCode1 int
,	@roundType9_presentCode2 int
,	@roundType9_presentCode3 int
,	@roundType9_presentCode4 int
,	@roundType10_playDate int
,	@roundType10_presentCode1 int
,	@roundType10_presentCode2 int
,	@roundType10_presentCode3 int
,	@roundType10_presentCode4 int
,	@roundType11_playDate int
,	@roundType11_presentCode1 int
,	@roundType11_presentCode2 int
,	@roundType11_presentCode3 int
,	@roundType11_presentCode4 int
)
AS

SET NOCOUNT ON

UPDATE dbo.userLeagueRoundDB
   SET roundType1_playDate = @roundType1_playDate,
	   roundType1_presentCode1 = @roundType1_presentCode1,
	   roundType1_presentCode2 = @roundType1_presentCode2,
	   roundType1_presentCode3 = @roundType1_presentCode3,
	   roundType1_presentCode4 = @roundType1_presentCode4,
	   roundType2_playDate = @roundType2_playDate,
	   roundType2_presentCode1 = @roundType2_presentCode1,
	   roundType2_presentCode2 = @roundType2_presentCode2,
	   roundType2_presentCode3 = @roundType2_presentCode3,
	   roundType2_presentCode4 = @roundType2_presentCode4,
	   roundType3_playDate = @roundType3_playDate,
	   roundType3_presentCode1 = @roundType3_presentCode1,
	   roundType3_presentCode2 = @roundType3_presentCode2,
	   roundType3_presentCode3 = @roundType3_presentCode3,
	   roundType3_presentCode4 = @roundType3_presentCode4,
	   roundType4_playDate = @roundType4_playDate,
	   roundType4_presentCode1 = @roundType4_presentCode1,
	   roundType4_presentCode2 = @roundType4_presentCode2,
	   roundType4_presentCode3 = @roundType4_presentCode3,
	   roundType4_presentCode4 = @roundType4_presentCode4,
	   roundType5_playDate = @roundType5_playDate,
	   roundType5_presentCode1 = @roundType5_presentCode1,
	   roundType5_presentCode2 = @roundType5_presentCode2,
	   roundType5_presentCode3 = @roundType5_presentCode3,
	   roundType5_presentCode4 = @roundType5_presentCode4,
	   roundType6_playDate = @roundType6_playDate,
	   roundType6_presentCode1 = @roundType6_presentCode1,
	   roundType6_presentCode2 = @roundType6_presentCode2,
	   roundType6_presentCode3 = @roundType6_presentCode3,
	   roundType6_presentCode4 = @roundType6_presentCode4,
	   roundType7_playDate = @roundType7_playDate,
	   roundType7_presentCode1 = @roundType7_presentCode1,
	   roundType7_presentCode2 = @roundType7_presentCode2,
	   roundType7_presentCode3 = @roundType7_presentCode3,
	   roundType7_presentCode4 = @roundType7_presentCode4,
	   roundType8_playDate = @roundType8_playDate,
	   roundType8_presentCode1 = @roundType8_presentCode1,
	   roundType8_presentCode2 = @roundType8_presentCode2,
	   roundType8_presentCode3 = @roundType8_presentCode3,
	   roundType8_presentCode4 = @roundType8_presentCode4,
	   roundType9_playDate = @roundType9_playDate,
	   roundType9_presentCode1 = @roundType9_presentCode1,
	   roundType9_presentCode2 = @roundType9_presentCode2,
	   roundType9_presentCode3 = @roundType9_presentCode3,
	   roundType9_presentCode4 = @roundType9_presentCode4,
	   roundType10_playDate = @roundType10_playDate,
	   roundType10_presentCode1 = @roundType10_presentCode1,
	   roundType10_presentCode2 = @roundType10_presentCode2,
	   roundType10_presentCode3 = @roundType10_presentCode3,
	   roundType10_presentCode4 = @roundType10_presentCode4,
	   roundType11_playDate = @roundType11_playDate,
	   roundType11_presentCode1 = @roundType11_presentCode1,
	   roundType11_presentCode2 = @roundType11_presentCode2,
	   roundType11_presentCode3 = @roundType11_presentCode3,
	   roundType11_presentCode4 = @roundType11_presentCode4
 WHERE idx=@idx
GO
/****** Object:  StoredProcedure [dbo].[game_league_self_index]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_self_index]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT TOP 1 idx
  FROM dbo.userLeagueListDB WITH(NOLOCK)
 WHERE accountIDX = @accountIDX
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_league_team_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_team_add]
(
	@leagueIDX int
,	@teamName nvarchar(20)
,	@leaderIDX int
,	@maxcount tinyint
,	@factionPoint int
,	@factionType tinyint
)
AS

SET NOCOUNT ON

DECLARE @errcount int
DECLARE @teamIDX int
SET @errcount = 0
SET @teamIDX = 0

IF EXISTS(SELECT * FROM dbo.userLeagueTeamDB WITH(NOLOCK) WHERE leagueIDX=@leagueIDX AND teamName=@teamName)
BEGIN
	SET @errcount = 2
	SELECT @errcount AS 'returnVal'
	RETURN
END

IF EXISTS(SELECT * FROM dbo.userLeagueTeamDB WITH(NOLOCK) WHERE leagueIDX=@leagueIDX AND leaderIDX=@leaderIDX)
BEGIN
	SET @errcount = 3
	SELECT @errcount AS 'returnVal'
	RETURN
END

IF EXISTS(SELECT * FROM dbo.userLeagueTeamMemberDB WITH(NOLOCK) WHERE leagueIDX=@leagueIDX AND accountIDX=@leaderIDX AND joinType=1)
BEGIN
	SET @errcount = 4
	SELECT @errcount AS 'returnVal'
	RETURN
END

IF (@errcount = 0)
BEGIN

	SET @errcount = 1
	SELECT @errcount AS 'returnVal'

	INSERT INTO dbo.userLeagueTeamDB (
		leagueIDX, teamName, leaderIDX, leaguePosition, maxcount, cheerPoint, currentRound, factionPoint, factionType, leagueStartPosition, regDate
	)
	VALUES (
		@leagueIDX, @teamName, @leaderIDX, 0, @maxcount, 0, 0, @factionPoint, @factionType, 0, GETDATE()
	)

	SET @teamIDX = SCOPE_IDENTITY()

	INSERT INTO dbo.userLeagueTeamMemberDB (accountIDX, leagueIDX, teamIDX, joinType, regDate)
	VALUES (@leaderIDX, @leagueIDX, @teamIDX, 1, GETDATE())

END
GO
/****** Object:  StoredProcedure [dbo].[game_league_team_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_team_delete]
(
	@teamIDX int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userLeagueTeamMemberDB
 WHERE teamIDX=@teamIDX

DELETE FROM dbo.userLeagueTeamDB
 WHERE idx=@teamIDX
GO
/****** Object:  StoredProcedure [dbo].[game_league_team_delete_all]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_team_delete_all]
(
	@leagueIDX int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userLeagueTeamMemberDB
 WHERE leagueIDX=@leagueIDX

DELETE FROM dbo.userLeagueTeamDB
 WHERE leagueIDX=@leagueIDX

DELETE FROM dbo.userLeagueCheerDB
 WHERE leagueIDX=@leagueIDX
GO
/****** Object:  StoredProcedure [dbo].[game_league_team_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_team_get_data]
(
	@idx int
)
AS

SET NOCOUNT ON

SELECT leagueIDX, teamName, leaderIDX, leaguePosition,
	   maxcount, cheerPoint, currentRound, factionPoint, factionType
  FROM dbo.userLeagueTeamDB WITH(NOLOCK)
 WHERE idx=@idx
GO
/****** Object:  StoredProcedure [dbo].[game_league_team_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_team_list]
(
	@topN int
,	@idx int
)
AS

SET NOCOUNT ON

SELECT TOP (@topN) idx, leagueIDX, teamName, leaderIDX, leaguePosition,
	   maxcount, cheerPoint, currentRound, factionPoint, factionType, leagueStartPosition
  FROM dbo.userLeagueTeamDB WITH(NOLOCK)
 WHERE idx < @idx
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_league_team_member_app_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_team_member_app_add]
(
	@accountIDX int
,	@leagueIDX int
,	@teamIDX int
)
AS

SET NOCOUNT ON

DECLARE @chkcnt int
DECLARE @errcount int
DECLARE @maxque tinyint

SET @chkcnt = 0
SET @errcount = 0
SET @maxque = 8

SET @chkcnt = (
	SELECT joinType
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE accountIDX=@accountIDX
)
IF (@chkcnt <= 1)
BEGIN
	SET @errcount = 2
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @chkcnt = (
	SELECT COUNT(*)
	  FROM dbo.userLeagueTeamDB WITH(NOLOCK)
	 WHERE idx=@teamIDX
)
IF (@chkcnt = 0)
BEGIN
	SET @errcount = 6
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @chkcnt = (
	SELECT COUNT(*)
	  FROM dbo.userLeagueTeamMemberDB WITH(NOLOCK)
	 WHERE accountIDX=@accountIDX
	   AND leagueIDX=@leagueIDX
	   AND joinType=1
)
IF (@chkcnt > 0)
BEGIN
	SET @errcount = 3
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @chkcnt = (
	SELECT COUNT(*)
	  FROM dbo.userLeagueTeamMemberDB WITH(NOLOCK)
	 WHERE accountIDX=@accountIDX
	   AND teamIDX=@teamIDX
	   AND joinType=0
)
IF (@chkcnt > 0)
BEGIN
	SET @errcount = 4
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @chkcnt = (
	SELECT COUNT(*)
	  FROM dbo.userLeagueTeamMemberDB WITH(NOLOCK)
	 WHERE teamIDX=@teamIDX
	   AND joinType=0
)
IF (@maxque <= @chkcnt)
BEGIN
	SET @errcount = 5
	SELECT @errcount AS 'returnVal'
	RETURN
END

IF (@errcount = 0)
BEGIN
	SET @errcount = 1
	SELECT @errcount AS 'returnVal'

	INSERT INTO dbo.userLeagueTeamMemberDB (accountIDX, leagueIDX, teamIDX, joinType, regDate)
	VALUES (@accountIDX, @leagueIDX, @teamIDX, 0, GETDATE())
END
GO
/****** Object:  StoredProcedure [dbo].[game_league_team_member_app_del]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_team_member_app_del]
(
	@idx int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userLeagueTeamMemberDB
 WHERE idx=@idx
GO
/****** Object:  StoredProcedure [dbo].[game_league_team_member_app_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_team_member_app_list]
(
	@teamIDX int
)
AS

SET NOCOUNT ON

SELECT a.idx, a.accountIDX, b.nickName, c.userLevel, c.regionType, 
	   CASE WHEN d.guildJoinType=1 THEN d.guildIDX
	   ELSE 0
	   END AS guildIDX
  FROM dbo.userLeagueTeamMemberDB a WITH(NOLOCK)
  JOIN dbo.userMemberDB b WITH(NOLOCK)
    ON a.accountIDX = b.accountIDX
  JOIN dbo.userGameDB c WITH(NOLOCK)
    ON a.accountIDX = c.accountIDX
  LEFT JOIN dbo.userGuildInfoDB d WITH(NOLOCK)
    ON a.accountIDX = d.accountIDX
 WHERE a.teamIDX=@teamIDX
   AND a.joinType=0
 ORDER BY a.idx ASC
GO
/****** Object:  StoredProcedure [dbo].[game_league_team_member_app_list_del]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_team_member_app_list_del]
(
	@accountIDX int
,	@leagueIDX int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userLeagueTeamMemberDB
 WHERE accountIDX=@accountIDX
   AND leagueIDX=@leagueIDX
   AND joinType=0
GO
/****** Object:  StoredProcedure [dbo].[game_league_team_member_app_reg]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_team_member_app_reg]
(
	@accountIDX int
,	@leagueIDX int
,	@teamIDX int
,	@factionType tinyint
)
AS

SET NOCOUNT ON

DECLARE @chkcnt int
DECLARE @errcount int
DECLARE @maxmember tinyint
DECLARE @dbFactionType tinyint

SET @chkcnt = 0
SET @errcount = 0
SET @maxmember = 0
SET @dbFactionType = 0

SET @chkcnt = (
	SELECT COUNT(*)
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE accountIDX=@accountIDX
)
IF (@chkcnt = 0)
BEGIN
	SET @errcount = 2
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @chkcnt = (
	SELECT joinType
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE accountIDX=@accountIDX
)
IF (@chkcnt <= 1)
BEGIN
	SET @errcount = 3
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @chkcnt = (
	SELECT COUNT(*)
	  FROM dbo.userLeagueTeamMemberDB WITH(NOLOCK)
	 WHERE accountIDX=@accountIDX
	   AND leagueIDX=@leagueIDX
	   AND joinType=1
)
IF (@chkcnt > 0)
BEGIN
	SET @errcount = 4
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @maxmember = (
	SELECT maxcount
	  FROM dbo.userLeagueTeamDB WITH(NOLOCK)
	 WHERE idx=@teamIDX
)
SET @chkcnt = (
	SELECT COUNT(*)
	  FROM dbo.userLeagueTeamMemberDB WITH(NOLOCK)
	 WHERE teamIDX=@teamIDX
	   AND joinType=1
)

IF (@maxmember <= @chkcnt)
BEGIN
	SET @errcount = 5
	SELECT @errcount AS 'returnVal'
	RETURN
END

IF (@factionType > 0)
BEGIN
	SET @dbFactionType = (
		SELECT regionType
		  FROM dbo.userGameDB WITH(NOLOCK)
		 WHERE accountIDX=@accountIDX
	)
	IF (@factionType <> @dbFactionType)
	BEGIN
		SET @errcount = 6
		SELECT @errcount AS 'returnVal'
		RETURN
	END
END

IF (@errcount = 0)
BEGIN
	SET @errcount = 1
	SELECT @errcount AS 'returnVal'

	UPDATE dbo.userLeagueTeamMemberDB
	   SET joinType=1
	 WHERE teamIDX=@teamIDX
	   AND accountIDX=@accountIDX
END
GO
/****** Object:  StoredProcedure [dbo].[game_league_team_member_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_team_member_delete]
(
	@idx int
,	@accountIDX int
)
AS

SET NOCOUNT ON

DECLARE @renspoint int
DECLARE @chkcnt int
DECLARE @errcount int

SET @chkcnt = 0
SET @errcount = 0

SET @chkcnt = (
	SELECT COUNT(*)
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE accountIDX=@accountIDX
)
IF (@chkcnt = 0)
BEGIN
	SET @errcount = -2
	SELECT @errcount AS 'returnVal'
	RETURN
END

SET @renspoint = (
	SELECT renspoint
	  FROM dbo.userGameDB WITH(NOLOCK)
	 WHERE accountIDX=@accountIDX
)

SELECT @renspoint AS factionPoint

DELETE FROM dbo.userLeagueTeamMemberDB
 WHERE idx=@idx
   AND accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_league_team_member_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_team_member_list]
(
	@teamIDX int
)
AS

SET NOCOUNT ON

SELECT a.idx, a.accountIDX, b.nickName, c.userLevel, c.renspoint,
	   CASE WHEN d.guildJoinType=1 THEN d.guildIDX
	   ELSE 0
	   END AS guildIDX
  FROM dbo.userLeagueTeamMemberDB a WITH(NOLOCK)
  JOIN dbo.userMemberDB b WITH(NOLOCK)
    ON a.accountIDX = b.accountIDX
  JOIN dbo.userGameDB c WITH(NOLOCK)
    ON a.accountIDX = c.accountIDX
  LEFT JOIN dbo.userGuildInfoDB d WITH(NOLOCK)
    ON a.accountIDX = d.accountIDX
 WHERE a.teamIDX=@teamIDX
   AND a.joinType=1
 ORDER BY a.idx ASC
GO
/****** Object:  StoredProcedure [dbo].[game_league_team_point_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_team_point_save]
(
	@idx int
,	@factionPoint int
,	@currentRound tinyint
,	@leaguePosition smallint
,	@leagueStartPosition smallint
)
AS

SET NOCOUNT ON

UPDATE dbo.userLeagueTeamDB
   SET leaguePosition = @leaguePosition,
	   currentRound = @currentRound,
	   factionPoint = @factionPoint,
	   leagueStartPosition = @leagueStartPosition
 WHERE idx=@idx
GO
/****** Object:  StoredProcedure [dbo].[game_league_team_position_update]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_team_position_update]
(
	@teamIndex int
,	@position int
)
AS

SET NOCOUNT ON

UPDATE dbo.userLeagueTeamDB 
   SET leaguePosition = @position
 WHERE idx = @teamIndex
GO
/****** Object:  StoredProcedure [dbo].[game_league_team_round_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_team_round_save]
(
	@teamIDX int
,	@currentRound tinyint
)
AS

SET NOCOUNT ON

UPDATE dbo.userLeagueTeamDB
   SET currentRound = @currentRound
 WHERE idx=@teamIDX
GO
/****** Object:  StoredProcedure [dbo].[game_league_team_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_team_save]
(
	@idx int
,	@leaderIDX int
,	@leaguePosition smallint
,	@currentRound tinyint
,	@factionPoint int
)
AS

SET NOCOUNT ON

UPDATE dbo.userLeagueTeamDB
   SET leaderIDX = @leaderIDX,
	   leaguePosition = @leaguePosition,
	   currentRound = @currentRound,
	   factionPoint = @factionPoint
 WHERE idx=@idx
GO
/****** Object:  StoredProcedure [dbo].[game_league_team_self_index]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_team_self_index]
(
	@leagueIDX int
,	@leaderIDX int
)
AS

SET NOCOUNT ON

SELECT TOP 1 idx
  FROM dbo.userLeagueTeamDB WITH(NOLOCK)
 WHERE leagueIDX = @leagueIDX
   AND leaderIDX = @leaderIDX
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_league_user_list_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_user_list_add]
(
	@accountIDX int
,	@startDate int
,	@endDate int
,	@leagueType tinyint
,	@leagueState tinyint
,	@leagueName nvarchar(20)
,	@maxRound smallint
,	@bannerA int
,	@bannerB int
,	@modeType int
,	@maxcount tinyint
,	@autoType tinyint
,	@recruitDate int
,	@waitDate int
,	@roundType1_playDate int
,	@roundType2_playDate int
,	@roundType3_playDate int
,	@roundType4_playDate int
,	@roundType5_playDate int
,	@roundType6_playDate int
,	@roundType7_playDate int
,	@roundType8_playDate int
,	@roundType9_playDate int
,	@roundType10_playDate int
,	@roundType11_playDate int
)
AS

SET NOCOUNT ON

BEGIN TRAN

DECLARE @leagueIDX int
DECLARE @infoIDX int
DECLARE @roundIDX int

INSERT INTO dbo.userLeagueListDB (
	accountIDX, startDate, endDate, leagueType, leagueState, regDate
)
VALUES (
	@accountIDX, @startDate, @endDate, @leagueType, @leagueState, GETDATE()
)

IF (@@ROWCOUNT = 0 or @@ERROR <> 0)
BEGIN
	ROLLBACK TRAN
	SET @leagueIDX = 0
	SELECT @leagueIDX AS 'idx'
END
ELSE
BEGIN
	SET @leagueIDX = SCOPE_IDENTITY()
END


INSERT INTO dbo.userLeagueInfoDB (
	leagueIDX, leagueName, maxRound, bannerA, bannerB, modeType, maxcount, autoType, announce, recruitDate, waitDate, regDate
)
VALUES (
	@leagueIDX, @leagueName, @maxRound, @bannerA, @bannerB, @modeType, @maxcount, @autoType, '', @recruitDate, @waitDate, GETDATE()
)


IF (@@ROWCOUNT = 0 or @@ERROR <> 0)
BEGIN
	ROLLBACK TRAN
	SET @infoIDX = 0
	SELECT @infoIDX AS 'idx'
END
ELSE
BEGIN
	SET @infoIDX = SCOPE_IDENTITY()
END


INSERT INTO dbo.userLeagueRoundDB (
	infoIDX,
	roundType1_playDate, roundType1_presentCode1, roundType1_presentCode2, roundType1_presentCode3, roundType1_presentCode4,
	roundType2_playDate, roundType2_presentCode1, roundType2_presentCode2, roundType2_presentCode3, roundType2_presentCode4,
	roundType3_playDate, roundType3_presentCode1, roundType3_presentCode2, roundType3_presentCode3, roundType3_presentCode4,
	roundType4_playDate, roundType4_presentCode1, roundType4_presentCode2, roundType4_presentCode3, roundType4_presentCode4,
	roundType5_playDate, roundType5_presentCode1, roundType5_presentCode2, roundType5_presentCode3, roundType5_presentCode4,
	roundType6_playDate, roundType6_presentCode1, roundType6_presentCode2, roundType6_presentCode3, roundType6_presentCode4,
	roundType7_playDate, roundType7_presentCode1, roundType7_presentCode2, roundType7_presentCode3, roundType7_presentCode4,
	roundType8_playDate, roundType8_presentCode1, roundType8_presentCode2, roundType8_presentCode3, roundType8_presentCode4,
	roundType9_playDate, roundType9_presentCode1, roundType9_presentCode2, roundType9_presentCode3, roundType9_presentCode4,
	roundType10_playDate, roundType10_presentCode1, roundType10_presentCode2, roundType10_presentCode3, roundType10_presentCode4,
	roundType11_playDate, roundType11_presentCode1, roundType11_presentCode2, roundType11_presentCode3, roundType11_presentCode4,
	regDate
)
VALUES (
	@infoIDX,
	@roundType1_playDate, 0, 0, 0, 0,
	@roundType2_playDate, 0, 0, 0, 0,
	@roundType3_playDate, 0, 0, 0, 0,
	@roundType4_playDate, 0, 0, 0, 0,
	@roundType5_playDate, 0, 0, 0, 0,
	@roundType6_playDate, 0, 0, 0, 0,
	@roundType7_playDate, 0, 0, 0, 0,
	@roundType8_playDate, 0, 0, 0, 0,
	@roundType9_playDate, 0, 0, 0, 0,
	@roundType10_playDate, 0, 0, 0, 0,
	@roundType11_playDate, 0, 0, 0, 0,
	GETDATE()
)


IF (@@ROWCOUNT = 0 or @@ERROR <> 0)
BEGIN
	ROLLBACK TRAN
	SET @roundIDX = 0
	SELECT @roundIDX AS 'idx'
END
ELSE
BEGIN
	COMMIT TRAN
	SELECT @leagueIDX AS 'idx'
END
GO
/****** Object:  StoredProcedure [dbo].[game_league_user_reward_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_user_reward_add]
(
	@leagueIDX int
)
AS

SET NOCOUNT ON

DECLARE @rt1A int, @rt1B int, @rt1C int, @rt1D int
DECLARE @rt2A int, @rt2B int, @rt2C int, @rt2D int
DECLARE @rt3A int, @rt3B int, @rt3C int, @rt3D int
DECLARE @rt4A int, @rt4B int, @rt4C int, @rt4D int
DECLARE @rt5A int, @rt5B int, @rt5C int, @rt5D int
DECLARE @rt6A int, @rt6B int, @rt6C int, @rt6D int
DECLARE @rt7A int, @rt7B int, @rt7C int, @rt7D int
DECLARE @rt8A int, @rt8B int, @rt8C int, @rt8D int
DECLARE @rt9A int, @rt9B int, @rt9C int, @rt9D int
DECLARE @rt10A int, @rt10B int, @rt10C int, @rt10D int
DECLARE @rt11A int, @rt11B int, @rt11C int, @rt11D int
DECLARE @infoIDX int
DECLARE @maxRound smallint
DECLARE @sendNickName nvarchar(20)
DECLARE @leagueName nvarchar(20)
DECLARE @teamList table (accountIDX int, currentRound tinyint)

INSERT INTO @teamList (accountIDX, currentRound)
SELECT a.accountIDX, b.currentRound
  FROM dbo.userLeagueTeamMemberDB a WITH(NOLOCK)
  JOIN dbo.userLeagueTeamDB b WITH(NOLOCK)
	ON a.teamIDX=b.idx
 WHERE a.leagueIDX=@leagueIDX
   AND b.leagueIDX=@leagueIDX
   AND a.joinType=1

SELECT @infoIDX = idx,
	   @leagueName = leagueName,
	   @maxRound = maxRound
  FROM dbo.userLeagueInfoDB WITH(NOLOCK)
 WHERE leagueIDX=@leagueIDX

SET @sendNickName = ISNULL((
	SELECT b.nickName
	  FROM dbo.userLeagueListDB a WITH(NOLOCK)
	  JOIN dbo.userMemberDB b WITH(NOLOCK)
		ON a.accountIDX=b.accountIDX
	 WHERE a.idx=@leagueIDX
), 'DeveloperK')

SELECT @rt1A = roundType1_presentCode1,
	   @rt1B = roundType1_presentCode2,
	   @rt1C = roundType1_presentCode3,
	   @rt1D = roundType1_presentCode4,
	   @rt2A = roundType2_presentCode1,
	   @rt2B = roundType2_presentCode2,
	   @rt2C = roundType2_presentCode3,
	   @rt2D = roundType2_presentCode4,
	   @rt3A = roundType3_presentCode1,
	   @rt3B = roundType3_presentCode2,
	   @rt3C = roundType3_presentCode3,
	   @rt3D = roundType3_presentCode4,
	   @rt4A = roundType4_presentCode1,
	   @rt4B = roundType4_presentCode2,
	   @rt4C = roundType4_presentCode3,
	   @rt4D = roundType4_presentCode4,
	   @rt5A = roundType5_presentCode1,
	   @rt5B = roundType5_presentCode2,
	   @rt5C = roundType5_presentCode3,
	   @rt5D = roundType5_presentCode4,
	   @rt6A = roundType6_presentCode1,
	   @rt6B = roundType6_presentCode2,
	   @rt6C = roundType6_presentCode3,
	   @rt6D = roundType6_presentCode4,
	   @rt7A = roundType7_presentCode1,
	   @rt7B = roundType7_presentCode2,
	   @rt7C = roundType7_presentCode3,
	   @rt7D = roundType7_presentCode4,
	   @rt8A = roundType8_presentCode1,
	   @rt8B = roundType8_presentCode2,
	   @rt8C = roundType8_presentCode3,
	   @rt8D = roundType8_presentCode4,
	   @rt9A = roundType9_presentCode1,
	   @rt9B = roundType9_presentCode2,
	   @rt9C = roundType9_presentCode3,
	   @rt9D = roundType9_presentCode4,
	   @rt10A = roundType10_presentCode1,
	   @rt10B = roundType10_presentCode2,
	   @rt10C = roundType10_presentCode3,
	   @rt10D = roundType10_presentCode4,
	   @rt11A = roundType11_presentCode1,
	   @rt11B = roundType11_presentCode2,
	   @rt11C = roundType11_presentCode3,
	   @rt11D = roundType11_presentCode4
  FROM dbo.userLeagueRoundDB WITH(NOLOCK)
 WHERE infoIDX=@infoIDX

IF (EXISTS(SELECT * FROM @teamList WHERE currentRound=1))
BEGIN
	INSERT INTO dbo.userLeagueRewardUserDB (
		accountIDX, leagueIDX, sendNickname, leagueName, roundnum, maxRound, presentCode1, presentCode2, presentCode3, presentCode4, regDate
	)
	SELECT accountIDX, @leagueIDX, @sendNickName, @leagueName, currentRound, @maxRound, @rt1A, @rt1B, @rt1C, @rt1D, GETDATE()
	  FROM @teamList
	 WHERE currentRound=1
END

IF (EXISTS(SELECT * FROM @teamList WHERE currentRound=2))
BEGIN
	INSERT INTO dbo.userLeagueRewardUserDB (
		accountIDX, leagueIDX, sendNickname, leagueName, roundnum, maxRound, presentCode1, presentCode2, presentCode3, presentCode4, regDate
	)
	SELECT accountIDX, @leagueIDX, @sendNickName, @leagueName, currentRound, @maxRound, @rt2A, @rt2B, @rt2C, @rt2D, GETDATE()
	  FROM @teamList
	 WHERE currentRound=2
END

IF (EXISTS(SELECT * FROM @teamList WHERE currentRound=3))
BEGIN
	INSERT INTO dbo.userLeagueRewardUserDB (
		accountIDX, leagueIDX, sendNickname, leagueName, roundnum, maxRound, presentCode1, presentCode2, presentCode3, presentCode4, regDate
	)
	SELECT accountIDX, @leagueIDX, @sendNickName, @leagueName, currentRound, @maxRound, @rt3A, @rt3B, @rt3C, @rt3D, GETDATE()
	  FROM @teamList
	 WHERE currentRound=3
END

IF (EXISTS(SELECT * FROM @teamList WHERE currentRound=4))
BEGIN
	INSERT INTO dbo.userLeagueRewardUserDB (
		accountIDX, leagueIDX, sendNickname, leagueName, roundnum, maxRound, presentCode1, presentCode2, presentCode3, presentCode4, regDate
	)
	SELECT accountIDX, @leagueIDX, @sendNickName, @leagueName, currentRound, @maxRound, @rt4A, @rt4B, @rt4C, @rt4D, GETDATE()
	  FROM @teamList
	 WHERE currentRound=4
END

IF (EXISTS(SELECT * FROM @teamList WHERE currentRound=5))
BEGIN
	INSERT INTO dbo.userLeagueRewardUserDB (
		accountIDX, leagueIDX, sendNickname, leagueName, roundnum, maxRound, presentCode1, presentCode2, presentCode3, presentCode4, regDate
	)
	SELECT accountIDX, @leagueIDX, @sendNickName, @leagueName, currentRound, @maxRound, @rt5A, @rt5B, @rt5C, @rt5D, GETDATE()
	  FROM @teamList
	 WHERE currentRound=5
END

IF (EXISTS(SELECT * FROM @teamList WHERE currentRound=6))
BEGIN
	INSERT INTO dbo.userLeagueRewardUserDB (
		accountIDX, leagueIDX, sendNickname, leagueName, roundnum, maxRound, presentCode1, presentCode2, presentCode3, presentCode4, regDate
	)
	SELECT accountIDX, @leagueIDX, @sendNickName, @leagueName, currentRound, @maxRound, @rt6A, @rt6B, @rt6C, @rt6D, GETDATE()
	  FROM @teamList
	 WHERE currentRound=6
END

IF (EXISTS(SELECT * FROM @teamList WHERE currentRound=7))
BEGIN
	INSERT INTO dbo.userLeagueRewardUserDB (
		accountIDX, leagueIDX, sendNickname, leagueName, roundnum, maxRound, presentCode1, presentCode2, presentCode3, presentCode4, regDate
	)
	SELECT accountIDX, @leagueIDX, @sendNickName, @leagueName, currentRound, @maxRound, @rt7A, @rt7B, @rt7C, @rt7D, GETDATE()
	  FROM @teamList
	 WHERE currentRound=7
END

IF (EXISTS(SELECT * FROM @teamList WHERE currentRound=8))
BEGIN
	INSERT INTO dbo.userLeagueRewardUserDB (
		accountIDX, leagueIDX, sendNickname, leagueName, roundnum, maxRound, presentCode1, presentCode2, presentCode3, presentCode4, regDate
	)
	SELECT accountIDX, @leagueIDX, @sendNickName, @leagueName, currentRound, @maxRound, @rt8A, @rt8B, @rt8C, @rt8D, GETDATE()
	  FROM @teamList
	 WHERE currentRound=8
END

IF (EXISTS(SELECT * FROM @teamList WHERE currentRound=9))
BEGIN
	INSERT INTO dbo.userLeagueRewardUserDB (
		accountIDX, leagueIDX, sendNickname, leagueName, roundnum, maxRound, presentCode1, presentCode2, presentCode3, presentCode4, regDate
	)
	SELECT accountIDX, @leagueIDX, @sendNickName, @leagueName, currentRound, @maxRound, @rt9A, @rt9B, @rt9C, @rt9D, GETDATE()
	  FROM @teamList
	 WHERE currentRound=9
END

IF (EXISTS(SELECT * FROM @teamList WHERE currentRound=10))
BEGIN
	INSERT INTO dbo.userLeagueRewardUserDB (
		accountIDX, leagueIDX, sendNickname, leagueName, roundnum, maxRound, presentCode1, presentCode2, presentCode3, presentCode4, regDate
	)
	SELECT accountIDX, @leagueIDX, @sendNickName, @leagueName, currentRound, @maxRound, @rt10A, @rt10B, @rt10C, @rt10D, GETDATE()
	  FROM @teamList
	 WHERE currentRound=10
END

IF (EXISTS(SELECT * FROM @teamList WHERE currentRound=11))
BEGIN
	INSERT INTO dbo.userLeagueRewardUserDB (
		accountIDX, leagueIDX, sendNickname, leagueName, roundnum, maxRound, presentCode1, presentCode2, presentCode3, presentCode4, regDate
	)
	SELECT accountIDX, @leagueIDX, @sendNickName, @leagueName, currentRound, @maxRound, @rt11A, @rt11B, @rt11C, @rt11D, GETDATE()
	  FROM @teamList
	 WHERE currentRound=11
END
GO
/****** Object:  StoredProcedure [dbo].[game_league_user_reward_del]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_user_reward_del]
(
	@idx int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userLeagueRewardUserDB
 WHERE idx=@idx
GO
/****** Object:  StoredProcedure [dbo].[game_league_user_reward_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_user_reward_get_data]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT idx, sendNickname, leagueName, roundnum, maxRound, presentCode1, presentCode2, presentCode3, presentCode4
  FROM dbo.userLeagueRewardUserDB WITH(NOLOCK)
 WHERE accountIDX=@accountIDX
   AND regDate >= DATEADD(d, -14, GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[game_league_winner_history]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_winner_history]
(
	@leagueTitle nvarchar(20)
,	@startDate int
,	@endDate int
,	@teamIDX int
,	@teamName nvarchar(20)
,	@factionName nvarchar(20)
,	@factionType int
)
AS

SET NOCOUNT ON

IF (NOT EXISTS(SELECT * FROM dbo.userLeagueWinnerHistoryDB WHERE startDate=@startDate AND teamIDX > 0))
BEGIN
	INSERT INTO dbo.userLeagueWinnerHistoryDB (
		leagueTitle, startDate, endDate, teamIDX, teamName, factionName, factionType, regDate
	)
	VALUES (
		@leagueTitle, @startDate, @endDate, @teamIDX, @teamName, @factionName, @factionType, GETDATE()
	)

	IF (@teamIDX > 0)
	BEGIN
		EXEC game_league_winner_info_add @startDate, @teamIDX
	END
END
GO
/****** Object:  StoredProcedure [dbo].[game_league_winner_info]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_winner_info]
(
	@historyIDX int
)
AS

SET NOCOUNT ON

SELECT accountIDX, nickName, userLevel,
	   classType, classGender, classFace, classHair, classSkinColor, classHairColor, classUnderwear,
	   classGear1, classGear2, classGear3, classGear4
  FROM dbo.userLeagueWinnerInfoDB WITH(NOLOCK)
 WHERE historyIDX=@historyIDX
GO
/****** Object:  StoredProcedure [dbo].[game_league_winner_info_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_league_winner_info_add]
(
	@startDate int
,	@teamIDX int
)
AS

SET NOCOUNT ON

DECLARE @historyIDX int
DECLARE @classType int
DECLARE @CI_gender int
DECLARE @CI_face int
DECLARE @CI_hair int
DECLARE @CI_skinColor int
DECLARE @CI_hairColor int
DECLARE @CI_underwear int
DECLARE @EI1_type int
DECLARE @EI2_type int
DECLARE @EI3_type int
DECLARE @EI4_type int
DECLARE @classGear1 int
DECLARE @classGear2 int
DECLARE @classGear3 int
DECLARE @classGear4 int
DECLARE @classCnt int
DECLARE @winnerAccountIDX table (accountIDX int)

SET @classGear1 = 0
SET @classGear2 = 0
SET @classGear3 = 0
SET @classGear4 = 0

IF (@teamIDX = 0)
BEGIN
	RETURN
END

SET @historyIDX = (
	SELECT TOP 1 idx
	  FROM dbo.userLeagueWinnerHistoryDB WITH(NOLOCK)
	 WHERE startDate=@startDate
	   AND teamIDX=@teamIDX
	 ORDER BY idx DESC
)

IF (@historyIDX IS NULL)
BEGIN
	RETURN
END

INSERT INTO dbo.userLeagueWinnerInfoDB (
	accountIDX, nickName, userLevel, historyIDX, teamIDX, 
	classType, classGender, classFace, classHair, classSkinColor, classHairColor, classUnderwear, 
	classGear1, classGear2, classGear3, classGear4, regDate
)
SELECT a.accountIDX, b.nickName, c.userLevel, @historyIDX, @teamIDX, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE()
  FROM dbo.userLeagueTeamMemberDB a WITH(NOLOCK)
  JOIN dbo.userMemberDB b WITH(NOLOCK)
    ON a.accountIDX = b.accountIDX
  JOIN dbo.userGameDB c WITH(NOLOCK)
    ON a.accountIDX = c.accountIDX
 WHERE a.teamIDX=@teamIDX

INSERT INTO @winnerAccountIDX (accountIDX)
SELECT accountIDX
  FROM dbo.userLeagueWinnerInfoDB WITH(NOLOCK)
 WHERE teamIDX=@teamIDX


DECLARE selectCharacter CURSOR
FOR
SELECT accountIDX FROM @winnerAccountIDX
FOR READ ONLY	

OPEN selectCharacter

DECLARE @winnerIDX INT
FETCH NEXT FROM selectCharacter INTO @winnerIDX

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @classCnt = (
		SELECT COUNT(*) FROM dbo.userCharacterDB WITH(NOLOCK) WHERE accountIDX=@winnerIDX
	)

	IF (@classCnt > 0)
	BEGIN
		IF (EXISTS(SELECT * FROM dbo.userCharacterDB WITH(NOLOCK) WHERE accountIDX=@winnerIDX AND leaderType=1))
		BEGIN
			SELECT TOP 1
				@classType = ClassType,
				@CI_gender = CI_gender,
				@CI_face = CI_face,
				@CI_hair = CI_hair,
				@CI_skinColor = CI_skinColor,
				@CI_hairColor = CI_hairColor,
				@CI_underwear = CI_underwear,
				@EI1_type = EI1_type,
				@EI2_type = EI2_type,
				@EI3_type = EI3_type,
				@EI4_type = EI4_type
			  FROM dbo.userCharacterDB WITH(NOLOCK)
			 WHERE accountIDX = @winnerIDX
			   AND leaderType=1
		END
		ELSE
		BEGIN
			SELECT TOP 1
				@classType = ClassType,
				@CI_gender = CI_gender,
				@CI_face = CI_face,
				@CI_hair = CI_hair,
				@CI_skinColor = CI_skinColor,
				@CI_hairColor = CI_hairColor,
				@CI_underwear = CI_underwear,
				@EI1_type = EI1_type,
				@EI2_type = EI2_type,
				@EI3_type = EI3_type,
				@EI4_type = EI4_type
			  FROM dbo.userCharacterDB WITH(NOLOCK)
			 WHERE accountIDX = @winnerIDX
			 ORDER BY CI_position ASC
		END

		IF (@EI1_type > 0)
		BEGIN
			SET @classGear1 = ISNULL(dbo.SELECT_GEAR_CODE(@winnerIDX, @EI1_type), 0)
		END

		IF (@EI2_type > 0)
		BEGIN
			SET @classGear2 = ISNULL(dbo.SELECT_GEAR_CODE(@winnerIDX, @EI2_type), 0)
		END

		IF (@EI3_type > 0)
		BEGIN
			SET @classGear3 = ISNULL(dbo.SELECT_GEAR_CODE(@winnerIDX, @EI3_type), 0)
		END

		IF (@EI4_type > 0)
		BEGIN
			SET @classGear4 = ISNULL(dbo.SELECT_GEAR_CODE(@winnerIDX, @EI4_type), 0)
		END

		UPDATE dbo.userLeagueWinnerInfoDB
		   SET classType = @classType,
			   classGender = @CI_gender,
			   classFace = @CI_face,
			   classHair = @CI_hair,
			   classSkinColor = @CI_skinColor,
			   classHairColor = @CI_hairColor,
			   classUnderwear = @CI_underwear,
			   classGear1 = @classGear1,
			   classGear2 = @classGear2,
			   classGear3 = @classGear3,
			   classGear4 = @classGear4
		 WHERE accountIDX=@winnerIDX
		   AND teamIDX=@teamIDX
	END

	FETCH NEXT FROM selectCharacter INTO @winnerIDX
END

CLOSE selectCharacter
DEALLOCATE selectCharacter
GO
/****** Object:  StoredProcedure [dbo].[game_log_class_buytime]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_log_class_buytime]
(
	@classType int
,	@buyTime bigint
)
AS

SET NOCOUNT ON

INSERT INTO LosaGame_log.DBO.log_class_buytime (classType, buyTime, regDate)
VALUES (@classType, @buyTime, GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[game_log_concurrent]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_log_concurrent]
(
	@serverID bigint
,	@serverIP varchar(15)
,	@serverPort int
,	@serverName varchar(32)
,	@concurrent int
,	@cpType smallint
)
As

	INSERT INTO log_game_concurrent (serverID, serverIP, serverPort, serverName, concurrent, cpType, regDate)
	VALUES (@serverID, @serverIP, @serverPort, @serverName, @concurrent, @cpType, getdate())
GO
/****** Object:  StoredProcedure [dbo].[game_log_level_playtime]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_log_level_playtime]
(
	@userLevel int
,	@playTime bigint
)
AS

SET NOCOUNT ON

INSERT INTO LosaGame_log.DBO.log_level_playtime (userLevel, playTime, regDate)
VALUES (@userLevel, @playTime, GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[game_login_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_login_get_data]
(
	@userID varchar(20),
	@cpuId varchar(128),
	@moId varchar(128),
	@ip varchar(15),
	@hash varchar(32)
)
AS
BEGIN

SET NOCOUNT ON
/*
SELECT b.userID, a.encodeKey, a.gameServerID, a.connDate, 0
  FROM dbo.userLoginDB a WITH(NOLOCK)
 INNER JOIN userMemberDB b WITH(NOLOCK)
    ON a.accountIDX = b.accountIDX
 WHERE b.userID=@userID
*/
INSERT INTO WebConnectLog (UserID, IP, Hash, LogDate) VALUES (@userID, @ip, @hash, getdate());

SELECT b.userID, a.encodeKey, a.gameServerID, a.connDate, 
	CASE WHEN w.ban = 0 THEN 
		CASE WHEN len(@hash) <> 32 THEN 
		1 
		ELSE
			CASE WHEN @ip like '%103.78.114.%' THEN 1 ELSE 0 END
		END 
	ELSE 1 END AS BAN
  FROM dbo.userLoginDB a WITH(NOLOCK)
 INNER JOIN userMemberDB b WITH(NOLOCK)
    ON a.accountIDX = b.accountIDX
 LEFT JOIN
 (
	SELECT COUNT(b.Id) As ban FROM WebBlock b
	WHERE Hash = @hash AND GETDATE() < EndDate
	AND (SELECT COUNT(UserId) FROM WebBlockException WHERE UserId = @userID) = 0
 ) w
 ON 1 = 1
 WHERE b.userID=@userID;

 END
GO
/****** Object:  StoredProcedure [dbo].[game_login_init_server]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_login_init_server]
(
	@gameServerID bigint
)
AS

SET NOCOUNT ON

UPDATE dbo.userLoginDB
   SET gameServerID = 0
 WHERE gameServerID = @gameServerID
GO
/****** Object:  StoredProcedure [dbo].[game_login_init_user]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_login_init_user]      
(      
 @userID varchar(20)
, @encodeKey varchar(15)   = null    
)      
AS      
      
SET NOCOUNT ON      
      
UPDATE dbo.userLoginDB      
   SET gameServerID=0      
 WHERE accountIDX = (      
 SELECT accountIDX      
   FROM dbo.userMemberDB      
  WHERE userID=@userID     
 )
GO
/****** Object:  StoredProcedure [dbo].[game_login_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_login_save]  
(  
 @userID varchar(20)  
, @gameServerID bigint  
)  
AS  
  
SET NOCOUNT ON  
  
BEGIN TRAN  
  
SELECT b.userID, a.gameServerID  
  FROM userLoginDB a  
 INNER JOIN userMemberDB b  
    ON a.accountIDX = b.accountIDX  
 WHERE b.userID = @userID  

--알파에선 gameserverID 무조건 0으로 세팅함, 테스트용
  
UPDATE dbo.userLoginDB  
   SET gameServerID = 0,  
    connDate = GETDATE()  
 WHERE accountIDX = (  
 SELECT accountIDX  
   FROM dbo.userMemberDB  
  WHERE userID=@userID  
 )  
  
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[game_login_serverid_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_login_serverid_save]
(
	@accountIDX int
,	@gameServerID bigint
)
AS

SET NOCOUNT ON

UPDATE dbo.userLoginDB
   SET gameServerID = @gameServerID
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_managetool_user_block]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_managetool_user_block]
(
	@nickName NVARCHAR(20)
,	@limitType TINYINT
,	@limitDate DATETIME
,	@reportNick NVARCHAR(20)
,	@reportIP NVARCHAR(15)
,	@reason NVARCHAR(1000)
,	@note NVARCHAR(1000)
)
AS

SET NOCOUNT ON;

DECLARE @accountIDX INT
DECLARE @ddiff INT

SET @ddiff = DATEDIFF(hh, GETDATE(), @limitDate)

SET @accountIDX = (
	SELECT accountIDX
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE nickName=@nickName
)

IF (@accountIDX IS NULL)
BEGIN
	SELECT 0
	RETURN;
END


IF (@ddiff > 0)
BEGIN
	UPDATE dbo.userMemberDB
	   SET limitType=@limitType,
		   limitDate=@limitDate
	 WHERE accountIDX=@accountIDX
END
ELSE
BEGIN
	UPDATE dbo.userMemberDB
	   SET limitDate=GETDATE()-1
	 WHERE accountIDX=@accountIDX  
END


IF (@@ROWCOUNT = 0)
BEGIN
	SELECT 0
	RETURN;
END
ELSE
BEGIN
	SELECT 1
END


-- ???????
INSERT INTO LosaGame_log.dbo.log_user_block (
	accountIDX, limitType, limitDate, reason, userIP, regDate
)
VALUES (
	@accountIDX, @limitType, @limitDate, @reason, @reportIP, GETDATE()
)
GO
/****** Object:  StoredProcedure [dbo].[game_mannerpoint_log_get_receiveIDX_from_tableIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_mannerpoint_log_get_receiveIDX_from_tableIDX]
(
	@idx varchar(200)
)
AS

SET NOCOUNT ON

DECLARE @strSQL varchar(1000)

SET @strSQL = 'SELECT receiveIDX FROM LosaGame_log.DBO.log_mannerpoint WITH(NOLOCK) WHERE idx in (' + @idx + ')'
EXECUTE (@strSQL)
GO
/****** Object:  StoredProcedure [dbo].[game_medal_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_medal_add]
(
	@accountIDX int
,	@medalIDX int
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userMedalDB_receive (accountIDX, medalIDX, flag, regDate)
VALUES (@accountIDX, @medalIDX, 0, GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[game_medal_get_level]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_medal_get_level]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT medalLevel, expert
  FROM dbo.userRankingDB_medal WITH(NOLOCK)
 WHERE accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_medal_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_medal_get_list]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT idx, medal1_type, medal2_type, medal3_type, medal4_type, medal5_type, medal6_type, medal7_type, medal8_type, medal9_type, medal10_type
  FROM dbo.userMedalDB WITH(NOLOCK)
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_medal_get_top1]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_medal_get_top1]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT TOP 1 medal1_type, medal2_type, medal3_type, medal4_type, medal5_type, medal6_type, medal7_type, medal8_type, medal9_type, medal10_type 
  FROM dbo.userMedalDB WITH(NOLOCK)
 WHERE accountIDX=@accountIDX
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_member_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_member_add]  
(  
 @userID varchar(20)  
, @nickName varchar(20)  
)  
AS  
  
SET NOCOUNT ON  
SET XACT_ABORT ON  
  
BEGIN TRAN  
  
 DECLARE @accountIDX int  
  
 INSERT INTO dbo.userMemberDB (userID, nickName, userPWD, EMail, mailling, userType, joinType, limitType, limitDate, regDate)  
 VALUES (@userID, @nickName, '', '', 0, 100, 10, 0, '1999-01-01', GETDATE())  
  
 --SCOPE_IDENTITY()  
 SET @accountIDX = (  
  SELECT accountIDX  
    FROM dbo.userMemberDB WITH(NOLOCK)  
   WHERE userID=@userID  
 )  
  
 INSERT INTO dbo.userGameDB (  
  accountIDX, userState, gameMoney, playTime, conn_count, userLevel, userEXP, rencpoint, renspoint, relateLevel, regionType, refillData, connDate, regDate  
 )  
 VALUES (  
  @accountIDX, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2000-01-01', GETDATE()  
 )  
  
 INSERT INTO userRecordBattleDB (  
  accountIDX, type1_win, type1_lose, type1_kill, type1_death, type2_win, type2_lose, type2_kill, type2_death, regDate  
 )  
 VALUES (  
  @accountIDX, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE()  
 )  
  
 INSERT INTO dbo.userLoginDB (accountIDX, encodeKey, gameServerID, connDate)  
 VALUES (@accountIDX, '111111111111111', 0, GETDATE())  
  
 INSERT INTO dbo.userMoneyDB (accountIDX, realCash, bonusCash, regDate )    
 VALUES (@accountIDX, 0, 0, GETDATE())   
  
 IF (@@ERROR = 0)  
  COMMIT TRAN  
 ELSE  
  ROLLBACK TRAN
GO
/****** Object:  StoredProcedure [dbo].[game_member_add_dev]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_member_add_dev]
(
	@userID varchar(20)
,	@nickName varchar(20)
)
AS

SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN TRAN

	DECLARE @accountIDX int

	INSERT INTO dbo.userMemberDB (userID, nickName, userPWD, EMail, mailling, userType, joinType, limitType, limitDate, regDate)
	VALUES (@userID, @nickName, '', '', 0, 100, 10, 0, '1999-01-01', GETDATE())

	--SCOPE_IDENTITY()
	SET @accountIDX = (
		SELECT accountIDX
		  FROM dbo.userMemberDB WITH(NOLOCK)
		 WHERE userID=@userID
	)

	INSERT INTO dbo.userMoneyDB (accountIDX, realCash, bonusCash )
	VALUES (@accountIDX, 0, 0)

	IF (@@ERROR = 0)
		COMMIT TRAN
	ELSE
		ROLLBACK TRAN


	-- OBT EVENT -------------------------------------------------------------------------
	DECLARE @USER_LEVEL INT
	DECLARE @EVENT_TYPE TINYINT

	SET @USER_LEVEL = 0
	SET @EVENT_TYPE = 0

	SET @USER_LEVEL = ISNULL((
		SELECT UG.userLevel
		  FROM LosaGame.dbo.userMemberDB UM WITH (NOLOCK)
		  JOIN LosaGame.dbo.userGameDB UG WITH (NOLOCK)
		    ON UM.accountIDX=UG.accountIDX
		 WHERE UM.userID = @userID
	), 0)

	IF (@USER_LEVEL >= 16)
	BEGIN
		IF (NOT EXISTS(SELECT * FROM dbo.TBL_obt_event_log WITH (NOLOCK) WHERE accountIDX=@accountIDX AND eventType=@EVENT_TYPE))
		BEGIN

			BEGIN TRAN

			UPDATE dbo.userMoneyDB
			   SET bonusCash = bonusCash + 21000
			 WHERE accountIDX = @accountIDX

			INSERT INTO dbo.TBL_obt_event_log (accountIDX, eventType, regDate)
			VALUES (@accountIDX, @EVENT_TYPE, GETDATE())

			IF (@@ROWCOUNT=0) or (@@ERROR<>0)
			BEGIN
				ROLLBACK TRAN
				RETURN;
			END

			COMMIT TRAN;

		END
	END
	-- OBT EVENT -------------------------------------------------------------------------
GO
/****** Object:  StoredProcedure [dbo].[game_member_change_userNickname]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_member_change_userNickname]
(
	@accountIDX int
,	@nickname varchar(20)
,	@chageNickname varchar(20)
,	@itemType int
,	@itemCode int
,	@itemRowIDX varchar(12)
,	@itemColIDX varchar(12)
,	@userIP varchar(15)
)
AS

SET NOCOUNT ON

DECLARE @cnt1 int, @cnt2 int, @cnt3 int
DECLARE @sql varchar(500), @note varchar(100)

SET @cnt1 = (
	SELECT COUNT(*)
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE userID=@chageNickname
)
SET @cnt2 = (
	SELECT COUNT(*)
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE nickName=@chageNickname
)
SET @cnt3 = @cnt1 + @cnt2

If (@cnt3 = 0)
BEGIN
	SET @note = @nickname + ' -> ' + @chageNickname

	BEGIN TRAN

	UPDATE dbo.userMemberDB
	   SET nickName=@chageNickname
	 WHERE accountIDX=@accountIDX

	SET @sql = 'UPDATE dbo.userItemEtcDB SET item' + @itemColIDX + '_type=0, item' + @itemColIDX + '_value1=0, item' + @itemColIDX + '_value2=0 WHERE idx=' + @itemRowIDX
	EXECUTE (@sql)

	COMMIT TRAN

	INSERT INTO LosaLogData.DBO.Log_use_item (
		accountIDX, nickname, itemType, itemCode, rowIDX, colIDX, userIP, note, regDate
	)
	VALUES (
		@accountIDX, @nickname, @itemType, @itemCode, @itemRowIDX, @itemColIDX, @userIP, @note, GETDATE()
	)
END
GO
/****** Object:  StoredProcedure [dbo].[game_member_count]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_member_count]
(
	@userID varchar(20)
)
AS

SET NOCOUNT ON

DECLARE @cnt int
SET @cnt = 0
SET @cnt = @cnt + (
	SELECT COUNT(*)
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE userID=@userID
)
SET @cnt = @cnt + (
	SELECT COUNT(*)
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE nickName=@userID
)

SELECT @cnt 'count'
GO
/****** Object:  StoredProcedure [dbo].[game_member_get_count]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_member_get_count]
(
	@nickname varchar(20)
)
AS

SET NOCOUNT ON

SELECT COUNT(*)
  FROM dbo.userMemberDB WITH(NOLOCK)
 WHERE nickname=@nickname
GO
/****** Object:  StoredProcedure [dbo].[game_member_get_userNickname_count]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_member_get_userNickname_count]
(
	@userID varchar(20)
)
AS

SET NOCOUNT ON

DECLARE @cnt1 int, @cnt2 int
SET @cnt1 = (
	SELECT COUNT(*)
	  FROM dbo.userMemberDB
	 WHERE userID=@userID
)
SET @cnt2 = (
	SELECT COUNT(*)
	  FROM dbo.userMemberDB
	 WHERE nickName=@userID
)

SELECT @cnt1 + @cnt2 AS 'recordCnt'
GO
/****** Object:  StoredProcedure [dbo].[game_member_namecheck_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_member_namecheck_get_data]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT joinType
  FROM dbo.userMemberDB WITH(NOLOCK)
 WHERE accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_member_total_count]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_member_total_count]

AS

SET NOCOUNT ON

SELECT COUNT(*)
  FROM dbo.userMemberDB WITH(NOLOCK)
GO
/****** Object:  StoredProcedure [dbo].[game_mission_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_mission_get_data]

	@ACCOUNT_IDX		INT

AS
SET NOCOUNT ON
	SET LOCK_TIMEOUT 10000
		
	SELECT MissionType, MissionCode, MissionValue, MissionStatus FROM dbo.userMissionDB WITH (READUNCOMMITTED)
	WHERE AccountIDX=@ACCOUNT_IDX and MissionStatus<4

	IF (@@ERROR<>0)
	BEGIN	
		SELECT -1
		RETURN;
	END	

	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_mission_set_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_mission_set_data]  
  
 @ACCOUNT_IDX  INT,  
 @MISSION_TYPE  TINYINT,  
 @MISSION_CODE  INT,  
 @MISSION_VALUE  INT,  
 @MISSION_STATUS  TINYINT  
  
AS  
  
 SET NOCOUNT ON  
 SET LOCK_TIMEOUT 10000  
  
 DECLARE @nReturn   INT   
 SET @nReturn=0   -- True  
  
 BEGIN TRAN  
  
  -- MERGE dbo.userMissionDB as TARGET  
  -- USING (SELECT @ACCOUNT_IDX, @MISSION_TYPE, @MISSION_CODE, @MISSION_VALUE, @MISSION_STATUS) AS SOURCE (AccountIDX, MissionType, MissionCode, MissionValue, MissionStatus)  
  -- ON (TARGET.AccountIDX=SOURCE.AccountIDX and TARGET.MissionType=SOURCE.MissionType and TARGET.MissionCode=SOURCE.MissionCode)  
  -- WHEN MATCHED THEN  
  --  UPDATE SET MissionValue=SOURCE.MissionValue, MissionStatus=SOURCE.MissionStatus  
  -- WHEN NOT MATCHED THEN  
  --  INSERT (AccountIDX, MissionType, MissionCode, MissionValue, MissionStatus) VALUES (@ACCOUNT_IDX, SOURCE.MissionType, SOURCE.MissionCode, SOURCE.MissionValue, SOURCE.MissionStatus);  
  
  UPDATE dbo.userMissionDB WITH (XLOCK, ROWLOCK) SET MissionValue=@MISSION_VALUE, MissionStatus=@MISSION_STATUS  
  WHERE AccountIDX=@ACCOUNT_IDX and MissionType=@MISSION_TYPE and MissionCode=@MISSION_CODE  
  
  IF (@@ROWCOUNT=0)  
  BEGIN   
  
   INSERT dbo.userMissionDB WITH (XLOCK, ROWLOCK) (AccountIDX, MissionType, MissionCode, MissionValue, MissionStatus)  
   VALUES (@ACCOUNT_IDX, @MISSION_TYPE, @MISSION_CODE, @MISSION_VALUE, @MISSION_STATUS)  
   IF (@@ROWCOUNT=0) or (@@ERROR<>0)  
   BEGIN  
    ROLLBACK TRAN      
    SELECT -1  
    RETURN;  
   END  
  END  
  
 COMMIT TRAN  
  
 SELECT @nReturn  
 RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_mission_set_init]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_mission_set_init]

	@ACCOUNT_IDX		INT,
	@MISSION_TYPE		TINYINT

AS
SET NOCOUNT ON
	SET LOCK_TIMEOUT 10000

	DECLARE @nReturn			INT	
	SET @nReturn=0			-- True

	BEGIN TRAN

		UPDATE dbo.userMissionDB WITH (XLOCK, ROWLOCK) SET MissionStatus=4 
		WHERE AccountIDX=@ACCOUNT_IDX and MissionType=@MISSION_TYPE

		IF (@@ERROR<>0)			
		BEGIN	
			ROLLBACK TRAN
			SELECT -1
			RETURN;
		END

	COMMIT TRAN

	SELECT @nReturn
	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_money_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_money_get]  
(
	@ACCOUNTIDX INT  
)

AS  

SET NOCOUNT ON;  
   
SELECT realCash, bonusCash FROM dbo.userMoneyDB WHERE accountIDX = @ACCOUNTIDX
GO
/****** Object:  StoredProcedure [dbo].[game_money_set_bonusCash]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_money_set_bonusCash]  
(
	@ACCOUNTIDX INT,  
	@USER_MONEY INT  
)
AS  

SET NOCOUNT ON;  

UPDATE dbo.userMoneyDB SET bonusCash = @USER_MONEY WHERE accountIDX = @ACCOUNTIDX
GO
/****** Object:  StoredProcedure [dbo].[game_money_set_bonusCash_Garena]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_money_set_bonusCash_Garena]
	@ACCOUNTIDX INT,  
	@USER_MONEY INT  
AS

	SET NOCOUNT ON;
	
	DECLARE @MONEY INT  
	SET @MONEY = 0  
   
	UPDATE dbo.userMoneyDB SET bonusCash = bonusCash + @USER_MONEY WHERE accountIDX = @ACCOUNTIDX
GO
/****** Object:  StoredProcedure [dbo].[game_money_set_realCash]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_money_set_realCash]  
  
 @ACCOUNTIDX INT,  
 @USER_MONEY INT  
  
AS  
 SET NOCOUNT ON;  
   
 DECLARE @MONEY INT  
 /*add HexDec*/
 SET @MONEY = 100000000  
   
 UPDATE dbo.userMoneyDB SET realCash = @USER_MONEY WHERE accountIDX = @ACCOUNTIDX
GO
/****** Object:  StoredProcedure [dbo].[game_money_set_realCash_Garena]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_money_set_realCash_Garena]
	@ACCOUNTIDX INT,  
	@USER_MONEY INT  
AS

	SET NOCOUNT ON;
	
	DECLARE @MONEY INT  
	SET @MONEY = 0  
   
	UPDATE dbo.userMoneyDB SET realCash = realCash + @USER_MONEY WHERE accountIDX = @ACCOUNTIDX
GO
/****** Object:  StoredProcedure [dbo].[game_personalHQ_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_personalHQ_get_data]  
  
 @ACCOUNT_IDX  INT,  
 @ITEM_STATUS  TINYINT,   -- 0: 미설치, 1:설치됨, 2:삭제  
 @PAGE    INT,  
 @PAGE_SIZE   INT  
  
AS   
  
 SET NOCOUNT ON  
 SET LOCK_TIMEOUT 15000  
  
 IF (@ITEM_STATUS=0)  
 BEGIN  
    
  -- 길드 공용 인벤 아이템 SELECT  
  SELECT ItemCode, COUNT(*) FROM dbo.userPersonalHQDB WITH (READCOMMITTED)  
  WHERE AccountIDX=@ACCOUNT_IDX and ItemStatus=@ITEM_STATUS  
  GROUP BY ItemCode  
  
 END  
 ELSE IF (@ITEM_STATUS=1)  
 BEGIN  
    
  -- 설치된 아이템 SELECT  
  SELECT ItemSerial, ItemCode, ItemXZ, ItemY, ItemRotate, ItemDecoScore FROM (  
   SELECT ROW_NUMBER() OVER (ORDER BY ItemSerial DESC) as ItemList, ItemSerial, ItemCode, ItemXZ, ItemY, ItemRotate, ItemDecoScore  
   FROM dbo.userPersonalHQDB WITH (READCOMMITTED) WHERE AccountIDX=@ACCOUNT_IDX and ItemStatus=@ITEM_STATUS  
  ) as USER_PERSONAL_HQ_LIST  
  WHERE ItemList BETWEEN (((@PAGE - 1) * @PAGE_SIZE) + 1) AND @PAGE * @PAGE_SIZE  
  
 END   
  
  
 RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_personalHQ_get_user_info]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_personalHQ_get_user_info]  
  
 @ACCOUNT_IDX  INT  
  
AS   
  
 SET NOCOUNT ON  
 SET LOCK_TIMEOUT 15000  
  
 IF EXISTS (SELECT * FROM dbo.userPersonalHQDB WITH (READUNCOMMITTED) WHERE AccountIDX=@ACCOUNT_IDX)  
 BEGIN  
  SELECT 1;  
  RETURN  
 END  
   
 SELECT 0;  
 RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_personalHQ_set_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_personalHQ_set_add]  
  
 @ACCOUNT_IDX INT,  
 @ITEM_CODE  INT  
  
AS   
  
 SET NOCOUNT ON  
 SET LOCK_TIMEOUT 15000  
  
 DECLARE @nReturn INT = 0;  
  
 BEGIN TRAN  
  -- 길드 본부 꾸미기 아이템 추가  
  INSERT dbo.userPersonalHQDB WITH (XLOCK, ROWLOCK) (AccountIDX, ItemCode) VALUES (@ACCOUNT_IDX, @ITEM_CODE)  
  IF (@@ROWCOUNT=0) or (@@ERROR<>0)  
  BEGIN  
   ROLLBACK TRAN  
   RETURN;  
  END  
  
 COMMIT TRAN  
  
 RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_personalHQ_set_default_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_personalHQ_set_default_add]  
   
 @ACCCOUNT_IDX INT,   
 @ITEM_CODE  INT,  
 @ITEM_XZ  INT,  
 @ITEM_Y   INT,  
 @ITEM_ROTATE TINYINT   
  
AS   
  
 SET NOCOUNT ON  
 SET LOCK_TIMEOUT 15000  
  
 DECLARE @nReturn INT = 0;  
   
 BEGIN TRAN  
  -- 길드 본부 꾸미기 아이템 추가  
  INSERT dbo.userPersonalHQDB WITH (XLOCK, ROWLOCK) (AccountIDX, ItemCode, ItemXZ, ItemY, ItemRotate, ItemStatus) VALUES (@ACCCOUNT_IDX, @ITEM_CODE, @ITEM_XZ, @ITEM_Y, @ITEM_ROTATE, 1)  
  IF (@@ROWCOUNT=0) or (@@ERROR<>0)  
  BEGIN  
   ROLLBACK TRAN  
   RETURN;  
  END  
 COMMIT TRAN  
  
 RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_personalHQ_set_fit]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_personalHQ_set_fit]   
   
 @ACCOUNT_IDX INT,  
 @ITEM_SERIAL BIGINT,   
 @ITEM_CODE  INT,  
 @ITEM_XZ  INT,  
 @ITEM_Y   INT,  
 @ITEM_ROTATE TINYINT,  
 @ITEM_STATUS TINYINT  -- 1:설치, 2: 변경  
  
AS   
  
 SET NOCOUNT ON  
 SET LOCK_TIMEOUT 15000  
  
 DECLARE @nReturn INT = 0;  
   
   
 -- 최초 설치시 즉, 인벤(ItemStus=0)에서 userGuildHQDB로 넘어와서 설치 될때 서버가 ItemSerial 정보를 모르기 때문에 제일 먼저 인벤에  
 -- 들어온 아이템 부터 설치 하도록 ItemSerial을 서버에 전달  
 IF (@ITEM_SERIAL=0 and @ITEM_STATUS=1)  
 BEGIN   
  SET @ITEM_SERIAL= (SELECT MIN(ItemSerial) FROM dbo.userPersonalHQDB WHERE AccountIDX=@ACCOUNT_IDX and ItemCode=@ITEM_CODE and ItemStatus=0)  
  SELECT @ITEM_SERIAL  
 END  
   
 BEGIN TRAN  
    
  -- @ITEM_STATUS 는 0: 미설치, 1:설치됨, 2:삭제 만 사용되지만, 현재 설치된 아이템의 위치 변경을 위해   
  -- 현재 프로시저에서 2번 코드를 받지만 실제는 1로 강제 초기화 하여 설치로 상태 정보를 유지한다.  
  SET @ITEM_STATUS=1  
  
  UPDATE dbo.userPersonalHQDB WITH (XLOCK, ROWLOCK) SET ItemXZ=@ITEM_XZ, ItemY=@ITEM_Y, ItemRotate=@ITEM_ROTATE, ItemStatus=@ITEM_STATUS   
  WHERE ItemSerial=@ITEM_SERIAL  
  
  IF (@@ROWCOUNT=0) or (@@ERROR<>0)  
  BEGIN  
   SELECT -1;  
   ROLLBACK TRAN  
   RETURN;  
  END  
  
 COMMIT TRAN  
  
 -- 설치로그  
 -- EXEC LINKED_CONNECTION_BAK.LosaLogDataC.dbo.log_guildHQ_fit_set_insert @GUILD_IDX, @ACCOUNT_IDX, @ITEM_SERIAL, @ITEM_CODE, 1  
  
 RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_personalHQ_set_status]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_personalHQ_set_status]  
    
 @ACCOUNT_IDX INT,  
 @ITEM_SERIAL BIGINT,  
 @ITEM_CODE  INT,   
 @ITEM_STATUS TINYINT  -- 0:인벤(해제), 2: 삭제  
  
AS   
  
 SET NOCOUNT ON  
 SET LOCK_TIMEOUT 15000  
  
 DECLARE @nReturn INT = 0;  
   
 BEGIN TRAN    
    
  UPDATE dbo.userPersonalHQDB WITH (XLOCK, ROWLOCK) SET ItemXZ=0, ItemY=0, ItemRotate=0, ItemStatus=@ITEM_STATUS   
  WHERE ItemSerial=@ITEM_SERIAL  
  
  IF (@@ROWCOUNT=0) or (@@ERROR<>0)  
  BEGIN  
   ROLLBACK TRAN  
   RETURN;  
  END  
  
 COMMIT TRAN  
  
  
 -- 설치로그  
 -- EXEC LINKED_CONNECTION_BAK.LosaLogDataC.dbo.log_guildHQ_fit_set_insert @GUILD_IDX, @ACCOUNT_IDX, @ITEM_SERIAL, @ITEM_CODE, 0  
  
 RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_pet_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_pet_add]

	@ACCOUNT_IDX	INT,
	@PET_CODE		INT,
	@PET_RANK		TINYINT,
	@PET_LEVEL		INT

AS	

	SET NOCOUNT ON
	SET LOCK_TIMEOUT 10000

	DECLARE @PET_IDX	INT	

	BEGIN TRAN
		
		INSERT dbo.userPetDB WITH (ROWLOCK, XLOCK) (accountIDX, petCode, petRank, petLevel) VALUES (@ACCOUNT_IDX, @PET_CODE, @PET_RANK, @PET_LEVEL)
		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN			
			ROLLBACK TRAN			
		END

		SET @PET_IDX = @@IDENTITY
	
	COMMIT TRAN
	
	SELECT @PET_IDX as PET_IDX, @PET_CODE as PET_CODE, @PET_RANK as PET_RANK, @PET_LEVEL as PET_LEVEL;
GO
/****** Object:  StoredProcedure [dbo].[game_pet_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_pet_delete]

	@ACCOUNT_IDX	INT,
	@PET_IDX		INT

AS

	SET NOCOUNT ON
	SET LOCK_TIMEOUT 10000

	BEGIN TRAN

		-- 펫 데이터 삭제 처리
		UPDATE dbo.userPetDB WITH (ROWLOCK, XLOCK) SET petStatus=0 WHERE accountIDX=@ACCOUNT_IDX and petIDX=@PET_IDX
		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN
		END

	COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[game_pet_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_pet_get_list]

	@ACCOUNT_IDX	INT

AS

	SET NOCOUNT ON
	SET LOCK_TIMEOUT 10000

	BEGIN
		SELECT petIDX, petCode, petRank, petLevel, petExp, petEquip FROM dbo.userPetDB WITH (READUNCOMMITTED)
		WHERE accountIDX=@ACCOUNT_IDX and petStatus=1
	END
GO
/****** Object:  StoredProcedure [dbo].[game_pet_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_pet_save]

	@ACCOUNT_IDX	INT,
	@PET_IDX		INT,
	@PET_RANK		TINYINT,
	@PET_LEVEL		INT,
	@PET_EXP		INT,
	@PET_EQUIP		TINYINT
	
AS

	SET NOCOUNT ON
	SET LOCK_TIMEOUT 10000

	BEGIN TRAN

		UPDATE dbo.userPetDB WITH(ROWLOCK, XLOCK) 
		SET petRank=@PET_RANK, petLevel=@PET_LEVEL, petExp=@PET_EXP, petEquip=@PET_EQUIP
		WHERE accountIDX=@ACCOUNT_IDX and petIDX=@PET_IDX

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN
		END

	COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[game_piece_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_piece_add]
(
	@accountIDX int
,	@piece1_type int
,	@piece1_cnt int
,	@piece2_type int
,	@piece2_cnt int
,	@piece3_type int
,	@piece3_cnt int
,	@piece4_type int
,	@piece4_cnt int
,	@piece5_type int
,	@piece5_cnt int
,	@piece6_type int
,	@piece6_cnt int
,	@piece7_type int
,	@piece7_cnt int
,	@piece8_type int
,	@piece8_cnt int
,	@piece9_type int
,	@piece9_cnt int
,	@piece10_type int
,	@piece10_cnt int
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userPieceDB (
	accountIDX,
	piece1_type, piece1_value1, piece1_value2, piece1_cnt, piece2_type, piece2_value1, piece2_value2, piece2_cnt,
	piece3_type, piece3_value1, piece3_value2, piece3_cnt, piece4_type, piece4_value1, piece4_value2, piece4_cnt,
	piece5_type, piece5_value1, piece5_value2, piece5_cnt, piece6_type, piece6_value1, piece6_value2, piece6_cnt,
	piece7_type, piece7_value1, piece7_value2, piece7_cnt, piece8_type, piece8_value1, piece8_value2, piece8_cnt,
	piece9_type, piece9_value1, piece9_value2, piece9_cnt, piece10_type, piece10_value1, piece10_value2, piece10_cnt,
	regDate
)
VALUES (
	@accountIDX,
	@piece1_type, 0, 0, @piece1_cnt, @piece2_type, 0, 0, @piece2_cnt,
	@piece3_type, 0, 0, @piece3_cnt, @piece4_type, 0, 0, @piece4_cnt,
	@piece5_type, 0, 0, @piece5_cnt, @piece6_type, 0, 0, @piece6_cnt,
	@piece7_type, 0, 0, @piece7_cnt, @piece8_type, 0, 0, @piece8_cnt,
	@piece9_type, 0, 0, @piece9_cnt, @piece10_type, 0, 0, @piece10_cnt,
	GETDATE()
)
GO
/****** Object:  StoredProcedure [dbo].[game_piece_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_piece_get_list]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT idx,
	   piece1_type, piece1_cnt, piece2_type, piece2_cnt, piece3_type, piece3_cnt, piece4_type, piece4_cnt, piece5_type, piece5_cnt,
	   piece6_type, piece6_cnt, piece7_type, piece7_cnt, piece8_type, piece8_cnt, piece9_type, piece9_cnt, piece10_type, piece10_cnt
  FROM dbo.userPieceDB WITH(NOLOCK)
 WHERE accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_piece_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_piece_save]
(
	@idx int
,	@piece1_type int
,	@piece1_cnt int
,	@piece2_type int
,	@piece2_cnt int
,	@piece3_type int
,	@piece3_cnt int
,	@piece4_type int
,	@piece4_cnt int
,	@piece5_type int
,	@piece5_cnt int
,	@piece6_type int
,	@piece6_cnt int
,	@piece7_type int
,	@piece7_cnt int
,	@piece8_type int
,	@piece8_cnt int
,	@piece9_type int
,	@piece9_cnt int
,	@piece10_type int
,	@piece10_cnt int
)
AS

SET NOCOUNT ON

UPDATE dbo.userPieceDB
   SET piece1_type = @piece1_type,
	   piece1_cnt = @piece1_cnt,
	   piece2_type = @piece2_type,
	   piece2_cnt = @piece2_cnt,
	   piece3_type = @piece3_type,
	   piece3_cnt = @piece3_cnt,
	   piece4_type = @piece4_type,
	   piece4_cnt = @piece4_cnt,
	   piece5_type = @piece5_type,
	   piece5_cnt = @piece5_cnt,
	   piece6_type = @piece6_type,
	   piece6_cnt = @piece6_cnt,
	   piece7_type = @piece7_type,
	   piece7_cnt = @piece7_cnt,
	   piece8_type = @piece8_type,
	   piece8_cnt = @piece8_cnt,
	   piece9_type = @piece9_type,
	   piece9_cnt = @piece9_cnt,
	   piece10_type = @piece10_type,
	   piece10_cnt = @piece10_cnt
 WHERE idx=@idx
GO
/****** Object:  StoredProcedure [dbo].[game_piece_self_index]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_piece_self_index]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT TOP 1 idx
  FROM dbo.userPieceDB
 WHERE accountIDX=@accountIDX
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_popStore_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_popStore_get_data]

	@ACCOUNT_IDX		INT

AS

	SET NOCOUNT ON
	SET LOCK_TIMEOUT 10000

	
	SELECT PopupSlot FROM dbo.userPopStoreDB WITH (READUNCOMMITTED) 
	WHERE AccountIDX=@ACCOUNT_IDX


	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_popStore_set_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_popStore_set_add]

	@ACCOUNT_IDX		INT,
	@POPUP_SLOT			INT

AS

	SET NOCOUNT ON
	SET LOCK_TIMEOUT 10000

	BEGIN TRAN

		-- 팝업 스토어 구매 내역 Insert
		INSERT dbo.userPopStoreDB WITH (XLOCK, ROWLOCK) (AccountIDX, PopupSlot) 
		VALUES (@ACCOUNT_IDX, @POPUP_SLOT)

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN
			SELECT -1;
			RETURN;
		END 

	COMMIT TRAN		

	SELECT 0;
	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_present_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_present_add]
(
	@sendNick varchar(20)
,	@receiveNick varchar(20)
,	@persentType smallint
,	@value1 int
,	@value2 int
,	@value3 int
,	@value4 int
,	@msgType smallint
,	@limitDate datetime
,	@flag smallint
)
AS

SET NOCOUNT ON

DECLARE @sendIDX int, @receiveIDX int
SET @sendIDX = (
	SELECT accountIDX
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE nickName=@sendNick
)

IF (@sendIDX IS NULL)
BEGIN
	SET @sendIDX = (
		SELECT accountIDX
		  FROM dbo.userMemberDB WITH(NOLOCK)
		 WHERE nickName='DeveloperK'
	)
END

SET @receiveIDX = (
	SELECT accountIDX
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE nickName=@receiveNick
)

INSERT INTO dbo.userPresentDB (
	sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate
)
VALUES (
	@sendIDX, @receiveIDX, @persentType, @value1, @value2, @value3, @value4, @msgType, @flag, @limitDate, GETDATE()
)
GO
/****** Object:  StoredProcedure [dbo].[game_present_add_0617]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_present_add_0617]      
(      
     
 @receiveIDX int 
 ,@presentType int     
 ,@value1 int
 ,@value2 int
     
)      
AS      
      
SET NOCOUNT ON     
    
DECLARE @sendIDX int    
DECLARE @persentType smallint      
DECLARE @value3 int    
DECLARE @value4 int    
DECLARE @msgType smallint    
DECLARE @limitDate datetime    
DECLARE @flag smallint    
    
Set @sendIDX = (select accountIDX from dbo.userMemberDB with(nolock) where userID = 'DeveloperK')
set @value3 = 0    
set @value4 = 0    
set @msgType = 3    
set @limitDate = dateadd(D, 28, GETDATE())    
set @flag = 1    
     
INSERT INTO dbo.userPresentDB (      
 sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate      
)      
VALUES (      
 @sendIDX, @receiveIDX, @presentType, @value1, @value2, @value3, @value4, @msgType, @flag, @limitDate, GETDATE()      
)
GO
/****** Object:  StoredProcedure [dbo].[game_present_add_idx]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_present_add_idx]  
(  
 @sendIDX int  
, @receiveIDX int  
, @persentType smallint  
, @value1 int  
, @value2 int  
, @value3 int  
, @value4 int  
, @msgType smallint  
, @limitDate datetime  
, @flag smallint  
, @TranIDX BIGINT   
)  
AS  
 -- 웹상점에서 넘어온 선물은 TranIDX가 존재하고 게임 상점은 0  
 INSERT INTO userPresentDB (sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate)  
 VALUES (@sendIDX, @receiveIDX, @persentType, @value1, @value2, @value3, @value4, @msgType, @flag, @limitDate, getdate())
GO
/****** Object:  StoredProcedure [dbo].[game_present_add_test]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_present_add_test]    
(      
  @userID varchar(20)    
, @presentType smallint      
, @value1 int      
, @value2 int      
    
)      
AS      
      
SET NOCOUNT ON      
      
DECLARE @receiveIDX INT  
DECLARE @sendIDX INT  
  
   SET @receiveIDX = 0
   SET @sendIDX = (      
 SELECT accountIDX      
   FROM dbo.userMemberDB WITH(NOLOCK)      
  WHERE nickName='DeveloperK'      
)      
  

 --SET @receiveIDX = ISNULL((      
 --   SELECT accountIDX      
 --     FROM dbo.userMemberDB WITH(NOLOCK)      
 --    WHERE userID=@userID  
 --    ) ,0)     
       
       
 --BEGIN
 -- IF @receiveIDX = 0 
 -- RETURN -1
 --END 
 SET @receiveIDX = (      
    SELECT accountIDX      
      FROM dbo.userMemberDB WITH(NOLOCK)      
     WHERE userID=@userID  
     ) 
 
INSERT INTO dbo.userPresentDB (      
 sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate      
)      
VALUES (      
 @sendIDX, @receiveIDX, @presentType, @value1, @value2, 0, 0, 3, 1, GetDate()+28, GetDate()     
)
GO
/****** Object:  StoredProcedure [dbo].[game_present_add_tool]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_present_add_tool]
(
	@sendNick varchar(20)
,	@receiveNick varchar(20)
,	@persentType smallint
,	@value1 int
,	@value2 int
,	@value3 int
,	@value4 int
,	@msgType smallint
,	@limitDate datetime
,	@flag smallint
)
AS

SET NOCOUNT ON

DECLARE @sendIDX int, @receiveIDX int

SET @sendIDX = (
	SELECT accountIDX
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE nickName=@sendNick
)

SET @receiveIDX = (
	SELECT accountIDX
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE nickName=@receiveNick
)

SELECT @sendIDX = ISNULL(@sendIDX, 1105) 

INSERT INTO userPresentDB (sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate)
VALUES (@sendIDX, @receiveIDX, @persentType, @value1, @value2, @value3, @value4, @msgType, @flag, @limitDate, GETDATE())
	
SELECT @receiveIDX AS recvIndex
GO
/****** Object:  StoredProcedure [dbo].[game_present_count]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_present_count]
(
	@nickName varchar(20)
)
AS

SET NOCOUNT ON

DECLARE @accountIDX int
DECLARE @userID varchar(20)
DECLARE @cnt int

SET @accountIDX = (
	SELECT accountIDX
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE nickName=@nickName
)
SET @userID = (
	SELECT userID
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE nickName=@nickName
)
SET @cnt = (
	SELECT COUNT(*)
	  FROM dbo.userPresentDB WITH(NOLOCK)
	 WHERE receiveIDX=@accountIDX
	   AND flag NOT IN (2)
)

IF (@accountIDX IS NULL)
BEGIN
	SELECT accountIDX, accountIDX AS 'cnt', userID
	  FROM dbo.userMemberDB WITH(NOLOCK)
	 WHERE nickName=@nickName
END
ELSE
BEGIN
	SELECT @accountIDX AS 'accountIDX', @cnt AS 'cnt', @userID AS 'userID'
END
GO
/****** Object:  StoredProcedure [dbo].[game_present_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_present_delete]
(
	@idx int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userPresentDB
 WHERE idx=@idx
GO
/****** Object:  StoredProcedure [dbo].[game_present_delete_all]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_present_delete_all]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userPresentDB
 WHERE receiveIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_present_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_present_get_list]
(
	@idx int
,	@receiveIDX int
,	@topN int
)
AS

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

SELECT TOP (@topN) a.idx, a.sendIDX, ISNULL(b.nickName, 'former member'), a.presentType,
	   a.value1, a.value2, a.value3, a.value4, a.msgType, a.flag, a.limitDate
  FROM dbo.userPresentDB a WITH (INDEX (idx_receiveIDX))
  LEFT JOIN dbo.userMemberDB b WITH (INDEX (idx_accountIDX))
    ON a.sendIDX = b.accountIDX
 WHERE a.receiveIDX = @receiveIDX
   AND a.idx > @idx
 ORDER BY a.idx ASC
GO
/****** Object:  StoredProcedure [dbo].[game_present_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_present_save]
(
	@tblIDX int
,	@flag smallint
)
AS

SET NOCOUNT ON

UPDATE dbo.userPresentDB
   SET flag=@flag
 WHERE idx=@tblIDX
GO
/****** Object:  StoredProcedure [dbo].[game_present_set_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_present_set_add]

	@FROM_USER			VARCHAR(20),
	@TO_USER			VARCHAR(20),
	@USER_ID_TYPE		TINYINT,  -- 1:PublicID, 2:PrivateID
	@PRESENT_TYPE		SMALLINT,
	@VALUE_1			INT,
	@VALUE_2			INT,
	@VALUE_3			INT,
	@VALUE_4			INT,
	@MSG_TYPE			SMALLINT,
	@LIMIT_DATE			DATETIME,
	@ALAM_FLAG			SMALLINT

AS 

	SET NOCOUNT ON
	SET LOCK_TIMEOUT 15000

	DECLARE @nReturn			INT
	DECLARE @FROM_ACCOUNT_IDX	INT
	DECLARE @TO_ACCOUNT_IDX		INT
	DECLARE @GET_DATE			DATETIME

	SET @GET_DATE = GETDATE()
	SET @FROM_ACCOUNT_IDX=0
	SET @TO_ACCOUNT_IDX=0

	-- 보내는 사람 AccountIDX
	EXEC @nReturn = dbo.usp_Member_get_user_accountIDX @FROM_USER, @USER_ID_TYPE, @FROM_ACCOUNT_IDX OUTPUT
	IF (@nReturn<>0) or (@FROM_ACCOUNT_IDX IS NULL)
	BEGIN
		SELECT -1;
		RETURN;
	END

	-- 받는 사람 AccountIDX
	EXEC @nReturn = dbo.usp_Member_get_user_accountIDX @TO_USER, @USER_ID_TYPE, @TO_ACCOUNT_IDX OUTPUT
	IF (@nReturn<>0) or (@TO_ACCOUNT_IDX IS NULL)
	BEGIN
		SELECT -2;
		RETURN;
	END

	BEGIN TRAN

		INSERT dbo.userPresentDB WITH (XLOCK, ROWLOCK) (sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate)
		VALUES (@FROM_ACCOUNT_IDX, @TO_ACCOUNT_IDX, @PRESENT_TYPE, @VALUE_1, @VALUE_2, @VALUE_3, @VALUE_4, @MSG_TYPE, @ALAM_FLAG, @LIMIT_DATE, @GET_DATE)

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN;
			SELECT -3;
			RETURN;
		END 

	COMMIT TRAN

	SELECT @TO_ACCOUNT_IDX AS recvIndex;
	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_price_class_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_price_class_get_data]

AS

SET NOCOUNT ON

SELECT TOP 1 class1_price, class2_price, class3_price, class4_price, class5_price, class6_price, class7_price, class8_price, class9_price, class10_price, 
	   class11_price, class12_price, class13_price, class14_price, class15_price, class16_price, class17_price, class18_price, class19_price, class20_price, 
	   class21_price, class22_price, class23_price, class24_price, class25_price, class26_price, class27_price, class28_price, class29_price, class30_price, 
	   class31_price, class32_price, class33_price, class34_price, class35_price, class36_price, class37_price, class38_price, class39_price, class40_price, 
	   class41_price, class42_price, class43_price, class44_price, class45_price, class46_price, class47_price, class48_price, class49_price, class50_price,
	   class51_price, class52_price, class53_price, class54_price, class55_price, class56_price, class57_price, class58_price, class59_price, class60_price,
	   class61_price, class62_price, class63_price, class64_price, class65_price, class66_price, class67_price, class68_price, class69_price, class70_price,
	   class71_price, class72_price, class73_price, class74_price, class75_price, class76_price, class77_price, class78_price, class79_price, class80_price,
	   class81_price, class82_price, class83_price, class84_price, class85_price, class86_price, class87_price, class88_price, class89_price, class90_price,
	   class91_price, class92_price, class93_price, class94_price, class95_price, class96_price, class97_price, class98_price, class99_price, class100_price,
	   class101_price, class102_price, class103_price, class104_price, class105_price, class106_price, class107_price, class108_price, class109_price, class110_price,
	   class111_price, class112_price, class113_price, class114_price, class115_price, class116_price, class117_price, class118_price, class119_price, class120_price,
	   class121_price, class122_price, class123_price, class124_price, class125_price, class126_price, class127_price, class128_price, class129_price, class130_price,
	   class131_price, class132_price, class133_price, class134_price, class135_price, class136_price, class137_price, class138_price, class139_price, class140_price,
	   class141_price, class142_price, class143_price, class144_price, class145_price, class146_price, class147_price, class148_price, class149_price, class150_price
  FROM dbo.define_class_price
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_price_class_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_price_class_save]
(
	@class_number varchar(4)
,	@cnt varchar(4)
)
AS

SET NOCOUNT ON

DECLARE @strSQL varchar(500)
SET @strSQL = 'UPDATE dbo.define_class_price SET '
SET @strSQL = @strSQL + 'class' + @class_number + '_buy_cnt = class' + @class_number + '_buy_cnt + ' + @cnt + ' '
SET @strSQL = @strSQL + 'WHERE idx = (SELECT Max(idx) FROM define_class_price)'
EXEC (@strSQL)
GO
/****** Object:  StoredProcedure [dbo].[game_quest_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_quest_add]
(
	@accountIDX int
,	@quest1_type int
,	@quest1_value1 int
,	@quest1_value2 int
,	@quest1_time int
,	@quest2_type int
,	@quest2_value1 int
,	@quest2_value2 int
,	@quest2_time int
,	@quest3_type int
,	@quest3_value1 int
,	@quest3_value2 int
,	@quest3_time int
,	@quest4_type int
,	@quest4_value1 int
,	@quest4_value2 int
,	@quest4_time int
,	@quest5_type int
,	@quest5_value1 int
,	@quest5_value2 int
,	@quest5_time int
,	@quest6_type int
,	@quest6_value1 int
,	@quest6_value2 int
,	@quest6_time int
,	@quest7_type int
,	@quest7_value1 int
,	@quest7_value2 int
,	@quest7_time int
,	@quest8_type int
,	@quest8_value1 int
,	@quest8_value2 int
,	@quest8_time int
,	@quest9_type int
,	@quest9_value1 int
,	@quest9_value2 int
,	@quest9_time int
,	@quest10_type int
,	@quest10_value1 int
,	@quest10_value2 int
,	@quest10_time int
,	@quest11_type int
,	@quest11_value1 int
,	@quest11_value2 int
,	@quest11_time int
,	@quest12_type int
,	@quest12_value1 int
,	@quest12_value2 int
,	@quest12_time int
,	@quest13_type int
,	@quest13_value1 int
,	@quest13_value2 int
,	@quest13_time int
,	@quest14_type int
,	@quest14_value1 int
,	@quest14_value2 int
,	@quest14_time int
,	@quest15_type int
,	@quest15_value1 int
,	@quest15_value2 int
,	@quest15_time int
,	@quest16_type int
,	@quest16_value1 int
,	@quest16_value2 int
,	@quest16_time int
,	@quest17_type int
,	@quest17_value1 int
,	@quest17_value2 int
,	@quest17_time int
,	@quest18_type int
,	@quest18_value1 int
,	@quest18_value2 int
,	@quest18_time int
,	@quest19_type int
,	@quest19_value1 int
,	@quest19_value2 int
,	@quest19_time int
,	@quest20_type int
,	@quest20_value1 int
,	@quest20_value2 int
,	@quest20_time int
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userQuestDB (
	accountIDX, 
	quest1_type, quest1_value1, quest1_value2, quest1_time, quest2_type, quest2_value1, quest2_value2, quest2_time, quest3_type, quest3_value1, quest3_value2, quest3_time, 
	quest4_type, quest4_value1, quest4_value2, quest4_time, quest5_type, quest5_value1, quest5_value2, quest5_time, quest6_type, quest6_value1, quest6_value2, quest6_time, 
	quest7_type, quest7_value1, quest7_value2, quest7_time, quest8_type, quest8_value1, quest8_value2, quest8_time, quest9_type, quest9_value1, quest9_value2, quest9_time, 
	quest10_type, quest10_value1, quest10_value2, quest10_time, quest11_type, quest11_value1, quest11_value2, quest11_time, quest12_type, quest12_value1, quest12_value2, quest12_time, 
	quest13_type, quest13_value1, quest13_value2, quest13_time, quest14_type, quest14_value1, quest14_value2, quest14_time, quest15_type, quest15_value1, quest15_value2, quest15_time, 
	quest16_type, quest16_value1, quest16_value2, quest16_time, quest17_type, quest17_value1, quest17_value2, quest17_time, quest18_type, quest18_value1, quest18_value2, quest18_time,
	quest19_type, quest19_value1, quest19_value2, quest19_time, quest20_type, quest20_value1, quest20_value2, quest20_time) 
VALUES (
	@accountIDX,
	@quest1_type, @quest1_value1, @quest1_value2, @quest1_time, @quest2_type, @quest2_value1, @quest2_value2, @quest2_time, @quest3_type, @quest3_value1, @quest3_value2, @quest3_time, 
	@quest4_type, @quest4_value1, @quest4_value2, @quest4_time, @quest5_type, @quest5_value1, @quest5_value2, @quest5_time, @quest6_type, @quest6_value1, @quest6_value2, @quest6_time, 
	@quest7_type, @quest7_value1, @quest7_value2, @quest7_time, @quest8_type, @quest8_value1, @quest8_value2, @quest8_time, @quest9_type, @quest9_value1, @quest9_value2, @quest9_time, 
	@quest10_type, @quest10_value1, @quest10_value2, @quest10_time, @quest11_type, @quest11_value1, @quest11_value2, @quest11_time, @quest12_type, @quest12_value1, @quest12_value2, @quest12_time, 
	@quest13_type, @quest13_value1, @quest13_value2, @quest13_time, @quest14_type, @quest14_value1, @quest14_value2, @quest14_time, @quest15_type, @quest15_value1, @quest15_value2, @quest15_time, 
	@quest16_type, @quest16_value1, @quest16_value2, @quest16_time, @quest17_type, @quest17_value1, @quest17_value2, @quest17_time, @quest18_type, @quest18_value1, @quest18_value2, @quest18_time,
	@quest19_type, @quest19_value1, @quest19_value2, @quest19_time, @quest20_type, @quest20_value1, @quest20_value2, @quest20_time
)
GO
/****** Object:  StoredProcedure [dbo].[game_quest_board_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_quest_board_add]
(
	@accountIDX int
,	@nickname varchar(20)
,	@gameLevel int
,	@questIDX int
,	@userIP varchar(16)
)
AS
GO
/****** Object:  StoredProcedure [dbo].[game_quest_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_quest_delete]
(
	@idx int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userQuestDB
 WHERE idx = @idx
GO
/****** Object:  StoredProcedure [dbo].[game_quest_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_quest_get_list]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT idx,
	   quest1_type, quest1_value1, quest1_value2, quest1_time, quest2_type, quest2_value1, quest2_value2, quest2_time, quest3_type, quest3_value1, quest3_value2, quest3_time, 
	   quest4_type, quest4_value1, quest4_value2, quest4_time, quest5_type, quest5_value1, quest5_value2, quest5_time, quest6_type, quest6_value1, quest6_value2, quest6_time, 
	   quest7_type, quest7_value1, quest7_value2, quest7_time, quest8_type, quest8_value1, quest8_value2, quest8_time, quest9_type, quest9_value1, quest9_value2, quest9_time, 
	   quest10_type, quest10_value1, quest10_value2, quest10_time, quest11_type, quest11_value1, quest11_value2, quest11_time, quest12_type, quest12_value1, quest12_value2, quest12_time, 
	   quest13_type, quest13_value1, quest13_value2, quest13_time, quest14_type, quest14_value1, quest14_value2, quest14_time, quest15_type, quest15_value1, quest15_value2, quest15_time, 
	   quest16_type, quest16_value1, quest16_value2, quest16_time, quest17_type, quest17_value1, quest17_value2, quest17_time, quest18_type, quest18_value1, quest18_value2, quest18_time,
	   quest19_type, quest19_value1, quest19_value2, quest19_time, quest20_type, quest20_value1, quest20_value2, quest20_time 
  FROM dbo.userQuestDB WITH(NOLOCK)
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_quest_get_self_index]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_quest_get_self_index]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT MAX(idx)
  FROM dbo.userQuestDB
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_quest_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_quest_save]
(
	@idx int
,	@quest1_type int
,	@quest1_value1 int
,	@quest1_value2 int
,	@quest1_time int
,	@quest2_type int
,	@quest2_value1 int
,	@quest2_value2 int
,	@quest2_time int
,	@quest3_type int
,	@quest3_value1 int
,	@quest3_value2 int
,	@quest3_time int
,	@quest4_type int
,	@quest4_value1 int
,	@quest4_value2 int
,	@quest4_time int
,	@quest5_type int
,	@quest5_value1 int
,	@quest5_value2 int
,	@quest5_time int
,	@quest6_type int
,	@quest6_value1 int
,	@quest6_value2 int
,	@quest6_time int
,	@quest7_type int
,	@quest7_value1 int
,	@quest7_value2 int
,	@quest7_time int
,	@quest8_type int
,	@quest8_value1 int
,	@quest8_value2 int
,	@quest8_time int
,	@quest9_type int
,	@quest9_value1 int
,	@quest9_value2 int
,	@quest9_time int
,	@quest10_type int
,	@quest10_value1 int
,	@quest10_value2 int
,	@quest10_time int
,	@quest11_type int
,	@quest11_value1 int
,	@quest11_value2 int
,	@quest11_time int
,	@quest12_type int
,	@quest12_value1 int
,	@quest12_value2 int
,	@quest12_time int
,	@quest13_type int
,	@quest13_value1 int
,	@quest13_value2 int
,	@quest13_time int
,	@quest14_type int
,	@quest14_value1 int
,	@quest14_value2 int
,	@quest14_time int
,	@quest15_type int
,	@quest15_value1 int
,	@quest15_value2 int
,	@quest15_time int
,	@quest16_type int
,	@quest16_value1 int
,	@quest16_value2 int
,	@quest16_time int
,	@quest17_type int
,	@quest17_value1 int
,	@quest17_value2 int
,	@quest17_time int
,	@quest18_type int
,	@quest18_value1 int
,	@quest18_value2 int
,	@quest18_time int
,	@quest19_type int
,	@quest19_value1 int
,	@quest19_value2 int
,	@quest19_time int
,	@quest20_type int
,	@quest20_value1 int
,	@quest20_value2 int
,	@quest20_time int
)
AS

SET NOCOUNT ON

UPDATE dbo.userQuestDB
   SET quest1_type = @quest1_type,
	   quest1_value1 = @quest1_value1,
	   quest1_value2 = @quest1_value2,
	   quest1_time = @quest1_time,
	   quest2_type = @quest2_type,
	   quest2_value1 = @quest2_value1,
	   quest2_value2 = @quest2_value2,
	   quest2_time = @quest2_time,
	   quest3_type = @quest3_type,
	   quest3_value1 = @quest3_value1,
	   quest3_value2 = @quest3_value2,
	   quest3_time = @quest3_time,
	   quest4_type = @quest4_type,
	   quest4_value1 = @quest4_value1,
	   quest4_value2 = @quest4_value2,
	   quest4_time = @quest4_time,
	   quest5_type = @quest5_type,
	   quest5_value1 = @quest5_value1,
	   quest5_value2 = @quest5_value2,
	   quest5_time = @quest5_time,
	   quest6_type = @quest6_type,
	   quest6_value1 = @quest6_value1,
	   quest6_value2 = @quest6_value2,
	   quest6_time = @quest6_time,
	   quest7_type = @quest7_type,
	   quest7_value1 = @quest7_value1,
	   quest7_value2 = @quest7_value2,
	   quest7_time = @quest7_time,
	   quest8_type = @quest8_type,
	   quest8_value1 = @quest8_value1,
	   quest8_value2 = @quest8_value2,
	   quest8_time = @quest8_time,
	   quest9_type = @quest9_type,
	   quest9_value1 = @quest9_value1,
	   quest9_value2 = @quest9_value2,
	   quest9_time = @quest9_time,
	   quest10_type = @quest10_type,
	   quest10_value1 = @quest10_value1,
	   quest10_value2 = @quest10_value2,
	   quest10_time = @quest10_time,
	   quest11_type = @quest11_type,
	   quest11_value1 = @quest11_value1,
	   quest11_value2 = @quest11_value2,
	   quest11_time = @quest11_time,
	   quest12_type = @quest12_type,
	   quest12_value1 = @quest12_value1,
	   quest12_value2 = @quest12_value2,
	   quest12_time = @quest12_time,
	   quest13_type = @quest13_type,
	   quest13_value1 = @quest13_value1,
	   quest13_value2 = @quest13_value2,
	   quest13_time = @quest13_time,
	   quest14_type = @quest14_type,
	   quest14_value1 = @quest14_value1,
	   quest14_value2 = @quest14_value2,
	   quest14_time = @quest14_time,
	   quest15_type = @quest15_type,
	   quest15_value1 = @quest15_value1,
	   quest15_value2 = @quest15_value2,
	   quest15_time = @quest15_time,
	   quest16_type = @quest16_type,
	   quest16_value1 = @quest16_value1,
	   quest16_value2 = @quest16_value2,
	   quest16_time = @quest16_time,
	   quest17_type = @quest17_type,
	   quest17_value1 = @quest17_value1,
	   quest17_value2 = @quest17_value2,
	   quest17_time = @quest17_time,
	   quest18_type = @quest18_type,
	   quest18_value1 = @quest18_value1,
	   quest18_value2 = @quest18_value2,
	   quest18_time = @quest18_time,
	   quest19_type = @quest19_type,
	   quest19_value1 = @quest19_value1,
	   quest19_value2 = @quest19_value2,
	   quest19_time = @quest19_time,
	   quest20_type = @quest20_type,
	   quest20_value1 = @quest20_value1,
	   quest20_value2 = @quest20_value2,
	   quest20_time = @quest20_time 
 WHERE idx = @idx
GO
/****** Object:  StoredProcedure [dbo].[game_questcomplete_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_questcomplete_add]
(
	@accountIDX int
,	@quest1_type int
,	@quest1_time int
,	@quest2_type int
,	@quest2_time int
,	@quest3_type int
,	@quest3_time int
,	@quest4_type int
,	@quest4_time int
,	@quest5_type int
,	@quest5_time int
,	@quest6_type int
,	@quest6_time int
,	@quest7_type int
,	@quest7_time int
,	@quest8_type int
,	@quest8_time int
,	@quest9_type int
,	@quest9_time int
,	@quest10_type int
,	@quest10_time int
,	@quest11_type int
,	@quest11_time int
,	@quest12_type int
,	@quest12_time int
,	@quest13_type int
,	@quest13_time int
,	@quest14_type int
,	@quest14_time int
,	@quest15_type int
,	@quest15_time int
,	@quest16_type int
,	@quest16_time int
,	@quest17_type int
,	@quest17_time int
,	@quest18_type int
,	@quest18_time int
,	@quest19_type int
,	@quest19_time int
,	@quest20_type int
,	@quest20_time int
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userQuestCompleteDB (
	accountIDX,
	quest1_type, quest1_time, quest2_type, quest2_time, quest3_type, quest3_time, quest4_type, quest4_time, quest5_type, quest5_time, 
	quest6_type, quest6_time, quest7_type, quest7_time, quest8_type, quest8_time, quest9_type, quest9_time, quest10_type, quest10_time, 
	quest11_type, quest11_time, quest12_type, quest12_time, quest13_type, quest13_time, quest14_type, quest14_time, quest15_type, quest15_time, 
	quest16_type, quest16_time, quest17_type, quest17_time, quest18_type, quest18_time, quest19_type, quest19_time, quest20_type, quest20_time) 
VALUES (@accountIDX,
	@quest1_type, @quest1_time, @quest2_type, @quest2_time, @quest3_type, @quest3_time, @quest4_type, @quest4_time, @quest5_type, @quest5_time, 
	@quest6_type, @quest6_time, @quest7_type, @quest7_time, @quest8_type, @quest8_time, @quest9_type, @quest9_time, @quest10_type, @quest10_time, 
	@quest11_type, @quest11_time, @quest12_type, @quest12_time, @quest13_type, @quest13_time, @quest14_type, @quest14_time, @quest15_type, @quest15_time, 
	@quest16_type, @quest16_time, @quest17_type, @quest17_time, @quest18_type, @quest18_time, @quest19_type, @quest19_time, @quest20_type, @quest20_time
)
GO
/****** Object:  StoredProcedure [dbo].[game_questcomplete_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_questcomplete_get_list]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT idx,
	   quest1_type, quest1_time, quest2_type, quest2_time, quest3_type, quest3_time, quest4_type, quest4_time, quest5_type, quest5_time, 
	   quest6_type, quest6_time, quest7_type, quest7_time, quest8_type, quest8_time, quest9_type, quest9_time, quest10_type, quest10_time, 
	   quest11_type, quest11_time, quest12_type, quest12_time, quest13_type, quest13_time, quest14_type, quest14_time, quest15_type, quest15_time, 
	   quest16_type, quest16_time, quest17_type, quest17_time, quest18_type, quest18_time, quest19_type, quest19_time, quest20_type, quest20_time 
  FROM dbo.userQuestCompleteDB WITH(NOLOCK)
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_questcomplete_get_self_index]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_questcomplete_get_self_index]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT MAX(idx)
  FROM dbo.userQuestCompleteDB
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_questcomplete_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_questcomplete_save]
(
	@idx int
,	@quest1_type int
,	@quest1_time int
,	@quest2_type int
,	@quest2_time int
,	@quest3_type int
,	@quest3_time int
,	@quest4_type int
,	@quest4_time int
,	@quest5_type int
,	@quest5_time int
,	@quest6_type int
,	@quest6_time int
,	@quest7_type int
,	@quest7_time int
,	@quest8_type int
,	@quest8_time int
,	@quest9_type int
,	@quest9_time int
,	@quest10_type int
,	@quest10_time int
,	@quest11_type int
,	@quest11_time int
,	@quest12_type int
,	@quest12_time int
,	@quest13_type int
,	@quest13_time int
,	@quest14_type int
,	@quest14_time int
,	@quest15_type int
,	@quest15_time int
,	@quest16_type int
,	@quest16_time int
,	@quest17_type int
,	@quest17_time int
,	@quest18_type int
,	@quest18_time int
,	@quest19_type int
,	@quest19_time int
,	@quest20_type int
,	@quest20_time int
)
AS

SET NOCOUNT ON

UPDATE dbo.userQuestCompleteDB
   SET quest1_type = @quest1_type,
	   quest1_time = @quest1_time,
	   quest2_type = @quest2_type,
	   quest2_time = @quest2_time,
	   quest3_type = @quest3_type,
	   quest3_time = @quest3_time,
	   quest4_type = @quest4_type,
	   quest4_time = @quest4_time,
	   quest5_type = @quest5_type,
	   quest5_time = @quest5_time,
	   quest6_type = @quest6_type,
	   quest6_time = @quest6_time,
	   quest7_type = @quest7_type,
	   quest7_time = @quest7_time,
	   quest8_type = @quest8_type,
	   quest8_time = @quest8_time,
	   quest9_type = @quest9_type,
	   quest9_time = @quest9_time,
	   quest10_type = @quest10_type,
	   quest10_time = @quest10_time,
	   quest11_type = @quest11_type,
	   quest11_time = @quest11_time,
	   quest12_type = @quest12_type,
	   quest12_time = @quest12_time,
	   quest13_type = @quest13_type,
	   quest13_time = @quest13_time,
	   quest14_type = @quest14_type,
	   quest14_time = @quest14_time,
	   quest15_type = @quest15_type,
	   quest15_time = @quest15_time,
	   quest16_type = @quest16_type,
	   quest16_time = @quest16_time,
	   quest17_type = @quest17_type,
	   quest17_time = @quest17_time,
	   quest18_type = @quest18_type,
	   quest18_time = @quest18_time,
	   quest19_type = @quest19_type,
	   quest19_time = @quest19_time,
	   quest20_type = @quest20_type,
	   quest20_time = @quest20_time 
 WHERE idx = @idx
GO
/****** Object:  StoredProcedure [dbo].[game_ranking_hero_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_ranking_hero_get_data]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT title, daily, season1, season2, season3, season4, season5, season6
  FROM dbo.userRankingDB_hero WITH(NOLOCK)
 WHERE accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_ranking_hero_topN]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_ranking_hero_topN]
(
	@rank1 int
,	@rank2 int
)
AS

SET NOCOUNT ON

SELECT a.accountIDX, b.userLevel, c.nickName, a.title, d.type3_win, d.type3_lose, b.regionType, b.userHerocEXP + b.userHerosEXP AS 'userHeroEXP'
  FROM dbo.userRankingDB_hero a WITH(NOLOCK)
  LEFT JOIN dbo.userGameDB b WITH(NOLOCK)
    ON a.accountIDX = b.accountIDX
  LEFT JOIN dbo.userMemberDB c WITH(NOLOCK)
    ON a.accountIDX = c.accountIDX
  LEFT JOIN dbo.userRecordBattleDB d WITH(NOLOCK)
    ON a.accountIDX = d.accountIDX
 WHERE a.daily >= @rank1
   AND a.daily <= @rank2
 ORDER BY a.daily ASC
GO
/****** Object:  StoredProcedure [dbo].[game_record_battle_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_record_battle_get_data]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT type1_win, type1_lose, type1_kill, type1_death, 
	   type2_win, type2_lose, type2_kill, type2_death, 
	   type3_win, type3_lose, type3_kill, type3_death, 
	   type4_win, type4_lose, type4_kill, type4_death 
  FROM dbo.userRecordBattleDB WITH(NOLOCK)
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[game_record_battle_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_record_battle_save]
(
	@accountIDX int
,	@type1_win int
,	@type1_lose int
,	@type1_kill int
,	@type1_death int
,	@type2_win int
,	@type2_lose int
,	@type2_kill int
,	@type2_death int
,	@type3_win int
,	@type3_lose int
,	@type3_kill int
,	@type3_death int
,	@type4_win int
,	@type4_lose int
,	@type4_kill int
,	@type4_death int
)
AS

SET NOCOUNT ON

IF (NOT EXISTS(SELECT * FROM dbo.userRecordBattleDB WITH(NOLOCK) WHERE accountIDX=@accountIDX))
BEGIN
	INSERT INTO dbo.userRecordBattleDB (
		accountIDX,
		type1_win, type1_lose, type1_kill, type1_death, type2_win, type2_lose, type2_kill, type2_death,
		type3_win, type3_lose, type3_kill, type3_death, type4_win, type4_lose, type4_kill, type4_death,
		regDate
	)
	VALUES (
		@accountIDX,
		@type1_win, @type1_lose, @type1_kill, @type1_death, @type2_win, @type2_lose, @type2_kill, @type2_death,
		@type3_win, @type3_lose, @type3_kill, @type3_death, @type4_win, @type4_lose, @type4_kill, @type4_death,
		GETDATE()
	)
END
ELSE
BEGIN
	UPDATE dbo.userRecordBattleDB
	   SET type1_win = @type1_win,
		   type1_lose = @type1_lose,
		   type1_kill = @type1_kill,
		   type1_death = @type1_death,
		   type2_win = @type2_win,
		   type2_lose = @type2_lose,
		   type2_kill = @type2_kill,
		   type2_death = @type2_death,
		   type3_win = @type3_win,
		   type3_lose = @type3_lose,
		   type3_kill = @type3_kill,
		   type3_death = @type3_death,
		   type4_win = @type4_win,
		   type4_lose = @type4_lose,
		   type4_kill = @type4_kill,
		   type4_death = @type4_death
	 WHERE accountIDX = @accountIDX

END
GO
/****** Object:  StoredProcedure [dbo].[game_region_backup_compen]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_region_backup_compen]

AS

SET NOCOUNT ON

DECLARE @tblName varchar(100), @sql varchar(300), @limitRenpoint int
DECLARE @i tinyint, @rtn bit, @tcount tinyint

SET @i = 65
SET @rtn = 0
SET @limitRenpoint = DBO.DEFINE_REGION_LIMIT_RENSPOINT()

WHILE (@rtn = 0)
BEGIN
	SET @tblName = 'LosaGame_' + RTrim(substring(convert(varchar(10), GETDATE(), 112),3,10)) + '_userRegionDB_compen_se_' + char(@i)
	SET @tcount = (
		SELECT COUNT(*)
		  FROM [Backup].DBO.sysobjects
		 WHERE [uid]=1
		   AND xtype='U'
		   AND [name]=@tblName
	)

	If (@tcount = 0)
		SET @rtn = 1
	ELSE
		SET @i = @i + 1
END

SET @sql = 'SELECT accountIDX, rt1point, rt1point_bonus, rt1count, rt2point, rt2point_bonus, rt2count, regionType, renspoint, regDate INTO [Backup].DBO.' + @tblName + ' FROM userRegionDB_compen WHERE regDate > ''' + Left(convert(varchar(20), GETDATE(), 112), 10) + ''''
EXECUTE (@sql)
GO
/****** Object:  StoredProcedure [dbo].[game_region_backup_point]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_region_backup_point]

AS

SET NOCOUNT ON

DECLARE @tblNameA varchar(100), @tblNameB varchar(100), @sql varchar(300), @limitRenpoint int
DECLARE @i tinyint, @rtn bit, @tcount tinyint

SET @i = 65
SET @rtn = 0
SET @limitRenpoint = DBO.DEFINE_REGION_LIMIT_RENSPOINT()

WHILE (@rtn = 0)
BEGIN
	SET @tblNameA = 'LosaGame_' + RTrim(substring(convert(varchar(10), GETDATE(), 112),3,10)) + '_userGameDB_se_' + char(@i)
	SET @tblNameB = 'LosaGame_' + RTrim(substring(convert(varchar(10), GETDATE(), 112),3,10)) + '_userGuildDB_se_' + char(@i)
	SET @tcount = (SELECT COUNT(*) FROM [Backup].DBO.sysobjects WHERE [uid]=1 and xtype='U' and [name]=@tblNameA)
	SET @tcount = @tcount + (SELECT COUNT(*) FROM [Backup].DBO.sysobjects WHERE [uid]=1 and xtype='U' and [name]=@tblNameB)

	If (@tcount = 0)
		SET @rtn = 1
	ELSE
		SET @i = @i + 1
END

SET @sql = 'SELECT accountIDX, gameMoney, userLevel, userEXP, userHerocEXP, userHerosEXP, rencpoint, renspoint, regionType INTO [Backup].DBO.' + @tblNameA + ' FROM userGameDB WHERE renspoint > ' + Convert(varchar(6), @limitRenpoint) + ' or userHerocEXP > 0 or userHerosEXP > 0'
EXECUTE (@sql)

SET @sql = 'SELECT idx, guildName, guildmark, ranking, point, todaypoint, guildLevel INTO [Backup].DBO.' + @tblNameB + ' FROM dbo.userGuildDB'
EXECUTE (@sql)
GO
/****** Object:  StoredProcedure [dbo].[game_region_compen_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_region_compen_delete]
(
	@idx int
,	@accountIDX int
,	@nickName varchar(20)
,	@peso int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userRegionDB_compen
 WHERE idx=@idx

INSERT INTO LosaLogData_v140826.DBO.log_data_peso (accountIDX, nickName, peso, logType, regDate)
VALUES (@accountIDX, @nickName, @peso, 9, GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[game_region_get_compen]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_region_get_compen]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT TOP 1 idx, rt1point, rt1point_bonus, rt1count, rt2point, rt2point_bonus, rt2count, regionType, renspoint, regionRanking
  FROM dbo.userRegionDB_compen WITH(NOLOCK)
 WHERE accountIDX=@accountIDX
 ORDER BY idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_region_get_point]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_region_get_point]

AS

SET NOCOUNT ON

SELECT rt1point, rt1point_today, rt1point_bonus, rt2point, rt2point_today, rt2point_bonus
  FROM dbo.userRegionDB WITH(NOLOCK)
GO
/****** Object:  StoredProcedure [dbo].[game_region_init_renspoint]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_region_init_renspoint]

AS

SET NOCOUNT ON

UPDATE dbo.userGameDB
   SET renspoint=0
 WHERE renspoint > 0
GO
/****** Object:  StoredProcedure [dbo].[game_region_player_count]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_region_player_count]
(
	@regionType int
)
AS

SET NOCOUNT ON

DECLARE @limitRenpoint int
SET @limitRenpoint = DBO.DEFINE_REGION_LIMIT_RENSPOINT()

SELECT COUNT(*)
  FROM dbo.userGameDB WITH(NOLOCK)
 WHERE regionType=@regionType
   AND renspoint > @limitRenpoint
GO
/****** Object:  StoredProcedure [dbo].[game_region_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_region_save]
(
	@rt1point int
,	@rt1point_today int
,	@rt1point_bonus int
,	@rt2point int
,	@rt2point_today int
,	@rt2point_bonus int
)
AS

SET NOCOUNT ON

UPDATE dbo.userRegionDB
   SET rt1point = @rt1point,
	   rt1point_today = @rt1point_today,
	   rt1point_bonus = @rt1point_bonus,
	   rt2point = @rt2point,
	   rt2point_today = @rt2point_today,
	   rt2point_bonus = @rt2point_bonus
GO
/****** Object:  StoredProcedure [dbo].[game_region_season_end]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_region_season_end]

AS
/*
	BEGIN TRAN

	DECLARE @limitRenpoint int, @limitPrepoint int, @season int, @totalpoint int
	DECLARE @rt1point int, @rt1point_bonus int, @rt1count int, @rt2point int, @rt2point_bonus int, @rt2count int

	SET @limitRenpoint = DBO.DEFINE_REGION_LIMIT_RENSPOINT()
	SET @limitPrepoint = DBO.DEFINE_REGION_LIMIT_SE_RENSPOINT()
	SET @season = ISNULL((SELECT max(season) FROM userRegionDB_history), 0) + 1
	SET @totalpoint = (SELECT rt1point + rt2point AS 'rp' FROM userRegionDB)
	SET @rt1point = (SELECT rt1point FROM userRegionDB)
	SET @rt2point = (SELECT rt2point FROM userRegionDB)
	SET @rt1point_bonus = (SELECT rt1point_bonus FROM userRegionDB)
	SET @rt2point_bonus = (SELECT rt2point_bonus FROM userRegionDB)
	SET @rt1count = (SELECT COUNT(*) FROM userGameDB WHERE regionType=1 and renspoint > @limitRenpoint)
	SET @rt2count = (SELECT COUNT(*) FROM userGameDB WHERE regionType=2 and renspoint > @limitRenpoint)

	If (@totalpoint > 0)
	BEGIN
		INSERT INTO userRegionDB_compen (accountIDX, rt1point, rt1point_bonus, rt1count, rt2point, rt2point_bonus, rt2count, regionType, renspoint, regionRanking, regDate)
		SELECT a.accountIDX, @rt1point,  @rt1point_bonus, @rt1count, @rt2point, @rt2point_bonus, @rt2count, a.regionType, a.renspoint, ISNULL(b.region, 0), GETDATE() FROM userGameDB a LEFT JOIN userRankingDB b ON a.accountIDX=b.accountIDX WHERE a.regionType > 0 and renspoint > @limitPrepoint
	END

	DELETE FROM userRegionDB_compen WHERE regDate < Left(GETDATE(), 10)

	INSERT INTO dbo.userRegionDB_history (point, point_bonus, membercount, regionType, season, regDate) VALUES (@rt1point, @rt1point_bonus, @rt1count, 1, @season, GETDATE())
	INSERT INTO dbo.userRegionDB_history (point, point_bonus, membercount, regionType, season, regDate) VALUES (@rt2point, @rt2point_bonus, @rt2count, 2, @season, GETDATE())

	COMMIT TRAN
*/
GO
/****** Object:  StoredProcedure [dbo].[game_region_season_end_data_init]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_region_season_end_data_init]

AS

SET NOCOUNT ON


UPDATE dbo.userGameDB
   SET renspoint = 0
 WHERE renspoint > 0

UPDATE dbo.userGameDB
   SET regionType=0
 WHERE regionType > 0

UPDATE dbo.userRecordBattleDB
   SET type4_win=0
 WHERE type4_win > 0

UPDATE dbo.userRecordBattleDB
   SET type4_lose=0
 WHERE type4_lose > 0

UPDATE dbo.userRecordBattleDB
   SET type4_kill=0
 WHERE type4_kill > 0

UPDATE dbo.userRecordBattleDB
   SET type4_death=0
 WHERE type4_death > 0

UPDATE dbo.userGameDB
   SET userHerocEXP = CONVERT(int, userHerocEXP * 0.9) + userHerosEXP,
	   userHerosEXP = -1
 WHERE userHerosEXP > 0
GO
/****** Object:  StoredProcedure [dbo].[game_region_season_end_server_close]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_region_season_end_server_close]

AS
/*
	BEGIN TRAN

	DECLARE @limitRenpoint int, @limitPrepoint int, @season int, @totalpoint int
	DECLARE @rt1point int, @rt1point_bonus int, @rt1count int, @rt2point int, @rt2point_bonus int, @rt2count int

	SET @limitRenpoint = DBO.DEFINE_REGION_LIMIT_RENSPOINT()
	SET @limitPrepoint = DBO.DEFINE_REGION_LIMIT_SE_RENSPOINT()
	SET @season = ISNULL((SELECT max(season) FROM userRegionDB_history), 0) + 1
	SET @totalpoint = (SELECT rt1point + rt2point AS 'rp' FROM userRegionDB)
	SET @rt1point = (SELECT rt1point FROM userRegionDB)
	SET @rt2point = (SELECT rt2point FROM userRegionDB)
	SET @rt1point_bonus = (SELECT rt1point_bonus FROM userRegionDB)
	SET @rt2point_bonus = (SELECT rt2point_bonus FROM userRegionDB)
	SET @rt1count = (SELECT COUNT(*) FROM userGameDB WHERE regionType=1 and renspoint > @limitRenpoint)
	SET @rt2count = (SELECT COUNT(*) FROM userGameDB WHERE regionType=2 and renspoint > @limitRenpoint)

	If (@totalpoint > 0)
	BEGIN
		INSERT INTO userRegionDB_compen (accountIDX, rt1point, rt1point_bonus, rt1count, rt2point, rt2point_bonus, rt2count, regionType, renspoint, regionRanking, regDate)
		SELECT a.accountIDX, @rt1point,  @rt1point_bonus, @rt1count, @rt2point, @rt2point_bonus, @rt2count, a.regionType, a.renspoint, ISNULL(b.region, 0), GETDATE() FROM userGameDB a LEFT JOIN userRankingDB b ON a.accountIDX=b.accountIDX WHERE a.regionType > 0 and renspoint > @limitPrepoint
	END

	DELETE FROM dbo.userRegionDB_compen WHERE regDate < Left(GETDATE(), 10)

	INSERT INTO dbo.userRegionDB_history (point, point_bonus, membercount, regionType, season, regDate) VALUES (@rt1point, @rt1point_bonus, @rt1count, 1, @season, GETDATE())
	INSERT INTO dbo.userRegionDB_history (point, point_bonus, membercount, regionType, season, regDate) VALUES (@rt2point, @rt2point_bonus, @rt2count, 2, @season, GETDATE())

	EXEC game_region_init_renspoint

	COMMIT TRAN
*/
GO
/****** Object:  StoredProcedure [dbo].[game_relative_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_relative_add]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

IF( EXISTS( SELECT * FROM dbo.userRelativeLevelDB WITH( NOLOCK ) WHERE accountIDX = @accountIDX ) )
BEGIN
	RETURN
END
ELSE
BEGIN
	INSERT INTO dbo.userRelativeLevelDB ( accountIDX, weekend_BackupLevel, weekend_BackupExp, init_time, reward_State, regDate )
	VALUES( @accountIDX, 50, 0, 0, 0, GETDATE() )
END
GO
/****** Object:  StoredProcedure [dbo].[game_relative_ranking_week]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_relative_ranking_week]
(
	@init_time	int
,	@rate int
)
AS

SET NOCOUNT ON

DECLARE @temp_table TABLE
(
	ranking INT
,	accountIDX INT
,	tempLevel INT
)


DECLARE @tblName varchar(256), @sql varchar(256)

SET @tblName = '[Backup].dbo.LosaGame_' + convert( varchar(16), @init_time ) + '_userGameDB'
SET @sql = 'SELECT * INTO ' + @tblName + ' FROM dbo.userGameDB WITH( NOLOCK )'

EXECUTE( @sql )


DELETE FROM dbo.userRelativeLevelDB
 WHERE accountIDX  NOT IN
(
	SELECT accountIDX
	  FROM dbo.userGameDB WITH( NOLOCK )
	 WHERE userLevel >= 50
)


UPDATE dbo.userRelativeLevelDB
   SET weekend_BackupLevel = UG.userLevel,
	   reward_State = 0
  FROM dbo.userRelativeLevelDB URL WITH( NOLOCK )
  JOIN dbo.userGameDB UG WITH( NOLOCK )
	ON UG.accountIDX = URL.accountIDX
 WHERE UG.userLevel >= 50



INSERT INTO @temp_table( ranking, accountIDX, tempLevel )
(
	SELECT ROW_NUMBER() OVER ( ORDER BY userExp DESC ), accountIDX, 0
	  FROM dbo.userGameDB WITH( NOLOCK )
	 WHERE userLevel >= 50
)




DECLARE @userCount INT
SET @userCount = 0;

SELECT @userCount = COUNT(*) FROM @temp_table


DECLARE @5star INT, @4star INT, @3star INT, @2star INT
DECLARE @LoopCount INT, @LoopLevel INT


IF( @userCount <= 5 )
BEGIN
	SET @2star = 30;
	SET @LoopCount = 2;
	SET @LoopLevel = 51;	-- 2 star
END
ELSE IF( @userCount > 5 and @userCount <= 50 )
BEGIN
	SET @3star = 5
	SET @2star = 25;
	SET @LoopCount = 3;
	SET @LoopLevel = 52;	-- 3 start	
END
ELSE IF( @userCount > 50 and @userCount <= 80 )
BEGIN
	SET @4star = 2
	SET @3star = 3
	SET @2star = 25;
	SET @LoopCount = 4;
	SET @LoopLevel = 53;	-- 4 start
END
ELSE IF( @userCount > 80 )
BEGIN
	-- 81.
	SET @5star = 1
	SET @4star = 2
	SET @3star = 3
	SET @2star = 24;
	SET @LoopCount = 5;
	SET @LoopLevel = 54;	-- 5 start
END


WHILE( @LoopCount > 0 )
BEGIN

	IF( @LoopCount = 1 )
		BEGIN
			UPDATE @temp_table
			   SET tempLevel = @LoopLevel
			 WHERE tempLevel = 0
		END
	ELSE
		BEGIN
			DECLARE @percent INT;
			SET @percent = 
				CASE
					WHEN ( @LoopCount = 2 ) THEN @2star
					WHEN ( @LoopCount = 3 ) THEN @3star
					WHEN ( @LoopCount = 4 ) THEN @4star
					WHEN ( @LoopCount = 5 ) THEN @5star
				END

			DECLARE @userCNT INT;
			SET @userCNT = 0;

			SET @userCNT = FLOOR( @userCount * 1. * @percent / 100 );

			IF( @userCNT > 0 )
				BEGIN
					UPDATE @temp_table
					   SET tempLevel = @LoopLevel
					 WHERE accountIDX IN
					(
						SELECT TOP( @userCNT ) accountIDX
						  FROM @temp_table
						 WHERE tempLevel = 0
						 ORDER BY ranking
					)
				END
		END

	SET @LoopLevel = @LoopLevel - 1;
	SET @LoopCount = @LoopCount - 1;

END

UPDATE b
   SET userLevel = a.tempLevel
  FROM
(
	SELECT * FROM @temp_table
) a
  JOIN userGameDB b WITH( NOLOCK )
	ON a.accountIDX = b.accountIDX
 WHERE b.userlevel >= 50




UPDATE dbo.userRelativeLevelDB
   SET reward_State = 1
 WHERE accountIDX in
(
	SELECT URL.accountIDX
	  FROM dbo.userRelativeLevelDB URL WITH( NOLOCK )
	  JOIN dbo.userGameDB UG WITH( NOLOCK )
		ON URL.accountIDX = UG.accountIDX
	 WHERE UG.userLevel >= 50
       AND UG.userExp > URL.weekend_BackupExp
)


/*
UPDATE dbo.userRelativeLevelDB
   SET reward_State = 0
 WHERE accountIDX in
(
	SELECT URL.accountIDX
	  FROM dbo.userRelativeLevelDB URL WITH( NOLOCK )
	  JOIN dbo.userGameDB UG WITH( NOLOCK )
		ON URL.accountIDX = UG.accountIDX
	 WHERE UG.userLevel >= 50
       AND UG.userExp = URL.weekend_BackupExp
)
*/


UPDATE dbo.userGameDB
   SET userExp = userExp - FLOOR( ( userExp * 1. * @rate ) / 100 )
 WHERE userLevel >= 50
   AND accountIDX in
(
	SELECT accountIDX
	  FROM dbo.userRelativeLevelDB WITH( NOLOCK )
	 WHERE init_time <> @init_time
)


UPDATE dbo.userRelativeLevelDB
   SET init_time = @init_time
 WHERE accountIDX in
(
	SELECT accountIDX
	  FROM dbo.userRelativeLevelDB WITH( NOLOCK )
	 WHERE init_time <> @init_time
) 



UPDATE dbo.userRelativeLevelDB
   SET weekend_BackupExp = UG.userExp
  FROM dbo.userRelativeLevelDB URL WITH( NOLOCK )
  JOIN dbo.userGameDB UG WITH( NOLOCK )
	ON UG.accountIDX = URL.accountIDX
 WHERE UG.userLevel >= 50
GO
/****** Object:  StoredProcedure [dbo].[game_relative_reward_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_relative_reward_get_data]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

IF ( EXISTS( SELECT * FROM dbo.userRelativeLevelDB WITH( NOLOCK ) WHERE accountIDX = @accountIDX ) )
BEGIN
	SELECT weekend_BackupExp, init_time, reward_State
      FROM dbo.userRelativeLevelDB WITH( NOLOCK )
	 WHERE accountIDX = @accountIDX
END
ELSE
BEGIN
	-- return 0, 0, 0, ... 0
	SELECT 0 AS weekend_BackupExp, 0 AS init_time, 0 AS reward_State
END
GO
/****** Object:  StoredProcedure [dbo].[game_relative_reward_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_relative_reward_save]
(
	@accountIDX int
,	@reward tinyint
)
AS

SET NOCOUNT ON

IF( EXISTS( SELECT * FROM dbo.userRelativeLevelDB WITH( NOLOCK ) WHERE accountIDX = @accountIDX ) )
BEGIN
	UPDATE dbo.userRelativeLevelDB
	   SET reward_State = @reward
	 WHERE accountIDX = @accountIDX
END
ELSE
BEGIN
	RETURN
END
GO
/****** Object:  StoredProcedure [dbo].[game_reset_bingonumber]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_reset_bingonumber]  

AS  
  
SET NOCOUNT ON  
  
DELETE FROM dbo.userEventBingo_Number  
DELETE FROM dbo.userEventBingo_Present
GO
/****** Object:  StoredProcedure [dbo].[game_sbox_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_sbox_add]
  
 @accountIDX  INT,  
 @presentType SMALLINT,  
 @value1   INT,  
 @value2   INT,  
 @amount   INT,  
 @bonusAmount INT,  
 @flag   SMALLINT,  
 @billingID  VARCHAR(64),  
 @limitDate  DATETIME  
  
AS  
  
SET NOCOUNT ON;  
  
INSERT INTO dbo.userSBoxDB (  
 accountIDX, presentType, value1, value2, amount,  flag, billingID, limitDate, regDate  
)  
VALUES (  
 @accountIDX, @presentType, @value1, @value2, @amount,  @flag, @billingID, @limitDate, GETDATE()  
)
GO
/****** Object:  StoredProcedure [dbo].[game_sbox_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_sbox_delete]
(
	@idx INT
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userSBoxDB
 WHERE idx = @idx
GO
/****** Object:  StoredProcedure [dbo].[game_sbox_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_sbox_get_list]
(  
 @idx INT  
, @accountIDX INT  
, @topN INT  
)  
AS  
  
SET NOCOUNT ON  
  
SELECT TOP (@topN) idx, presentType, value1, value2, amount, 0, flag, billingID, limitDate  
  FROM dbo.userSBoxDB WITH(NOLOCK)  
 WHERE accountIDX=@accountIDX  
   AND idx > @idx
GO
/****** Object:  StoredProcedure [dbo].[game_sbox_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_sbox_save]
(  
 @idx   INT,  
 @presentType SMALLINT,  
 @value1   INT,  
 @value2   INT,  
 @amount   INT,  
 @bonusAmount INT,  
 @flag   SMALLINT,  
 @billingID  VARCHAR(64),  
 @limitDate  DATETIME  
)  
AS  
  
SET NOCOUNT ON;  
  
UPDATE dbo.userSBoxDB  
   SET presentType = @presentType,  
       value1 = @value1,  
       value2 = @value2,  
       amount = @amount,  
       flag = @flag,  
       billingID = @billingID,  
       limitDate = @limitDate  
 WHERE idx = @idx;
GO
/****** Object:  StoredProcedure [dbo].[game_server_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_server_add]
(
	@serverID bigint
,	@serverIP varchar(15)
,	@serverPort int
,	@serverName varchar(50)
,	@clientPort int
)
AS

SET NOCOUNT ON

IF (NOT EXISTS(SELECT * FROM dbo.define_game_server WITH(NOLOCK) WHERE serverIP=@serverIP AND serverPort=@serverPort))
BEGIN
	INSERT INTO dbo.define_game_server (serverID, serverIP, serverPort, serverName, clientPort, connNumber, [status], regDate)
	VALUES (@serverID, @serverIP, @serverPort, @serverName, @clientPort, 0, 0, GETDATE())
END
GO
/****** Object:  StoredProcedure [dbo].[game_server_connection_count_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_server_connection_count_save]
(
	@serverID bigint
,	@count int
)
AS

SET NOCOUNT ON

UPDATE dbo.define_game_server
   SET connNumber = @count
 WHERE serverID = @serverID
GO
/****** Object:  StoredProcedure [dbo].[game_server_connection_on]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_server_connection_on]
(
	@serverID bigint
)
AS

SET NOCOUNT ON

UPDATE dbo.define_game_server
   SET [status] = 1
 WHERE serverID = @serverID
GO
/****** Object:  StoredProcedure [dbo].[game_server_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_server_delete]
(
	@serverID bigint
)
AS

SET NOCOUNT ON

DELETE FROM dbo.define_game_server
 WHERE serverID = @serverID
GO
/****** Object:  StoredProcedure [dbo].[game_server_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_server_get_list]

AS

SET NOCOUNT ON

SELECT idx, serverIP, serverPort
  FROM dbo.define_game_server WITH(NOLOCK)
 ORDER BY regDate ASC
GO
/****** Object:  StoredProcedure [dbo].[game_server_get_self_index]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_server_get_self_index]
(
	@serverID bigint
)
AS

SET NOCOUNT ON

SELECT idx
  FROM dbo.define_game_server
 WHERE serverID=@serverID
GO
/****** Object:  StoredProcedure [dbo].[game_spentGold_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_spentGold_get_data]

	@ACCOUNT_IDX		INT

AS

	SET NOCOUNT ON
	SET LOCK_TIMEOUT 10000

	DECLARE @nReturn			INT
	DECLARE @SPENT_GOLD_SUM		INT
	DECLARE @SPENT_GOLD			INT
	DECLARE @PLAY_TIME			INT
	
	DECLARE @START_DATE		DATETIME
	DECLARE @OVER_DATE		DATETIME
	
	SET @OVER_DATE = CAST(CONVERT(CHAR(10), GETDATE(), 121) as DATETIME);
	SET @START_DATE = DATEADD(dd, -30, @OVER_DATE)

	SET @nReturn=0;
	SET @SPENT_GOLD_SUM=0;
	SET @SPENT_GOLD=0;
	SET @PLAY_TIME=0;

	IF EXISTS (SELECT * FROM dbo.userMemberDB WHERE AccountIDX=@ACCOUNT_IDX)
	BEGIN

		-- 누적 소비 골드
		SET @SPENT_GOLD_SUM = (SELECT UserSpentGold FROM dbo.userSpentGoldDB WITH (READCOMMITTED)
		WHERE AccountIDX=@ACCOUNT_IDX);
	
		-- 해당 기간의 소비 골드 합
		SET @SPENT_GOLD=(SELECT SpentGold FROM (
				SELECT AccountIDX, SUM(UserSpentGold) as SpentGold FROM dbo.userSpentGoldLogDB WITH (READCOMMITTED)
				WHERE RegDate>=@START_DATE and RegDate<@OVER_DATE+1 and AccountIDX=@ACCOUNT_IDX
				GROUP BY AccountIDX
			) as userSpentGoldLogDB
		)

		-- 사용자 플레이 타임
		SET @PLAY_TIME = (SELECT PlayTime FROM dbo.userGameDB WITH (READUNCOMMITTED) WHERE AccountIDX=@ACCOUNT_IDX);


		SELECT @nReturn as nReturn, ISNULL(@SPENT_GOLD_SUM,0) as SPENT_GOLD_SUM, ISNULL(@SPENT_GOLD,0) as SPENT_GOLD, @PLAY_TIME as PlayTime
	END
	ELSE
	BEGIN
		SELECT -1, 0 as SPENT_GOLD_SUM, 0 as SPENT_GOLD, 0 as PlayTime
	END
	
	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_spentGold_set_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_spentGold_set_add]

	@ACCOUNT_IDX		INT,
	@SPENT_GOLD			INT

AS

	SET NOCOUNT ON
	SET LOCK_TIMEOUT 10000

	DECLARE @GET_DATE		DATETIME
	SET @GET_DATE=GETDATE();

	BEGIN TRAN

		-- 골드 소비 내역 테이블에 Insert
		INSERT dbo.userSpentGoldLogDB WITH (XLOCK, ROWLOCK) (RegDate, AccountIDX, UserSpentGold) 
		VALUES (@GET_DATE, @ACCOUNT_IDX, @SPENT_GOLD)

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN
			RETURN;
		END 

		-- 누적 테이블에 Insert or Update		
		;MERGE dbo.userSpentGoldDB as TARGET
		USING (SELECT @ACCOUNT_IDX, @SPENT_GOLD) AS SOURCE (AccountIDX, UserSpentGold)
		ON (TARGET.AccountIDX=SOURCE.AccountIDX)
		WHEN MATCHED THEN
			UPDATE SET TARGET.UserSpentGold=TARGET.UserSpentGold+SOURCE.UserSpentGold
		WHEN NOT MATCHED THEN
			INSERT (AccountIDX, UserSpentGold) VALUES (SOURCE.AccountIDX, SOURCE.UserSpentGold);

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN
			RETURN;
		END 

	COMMIT TRAN		

	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_title_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_title_get_data]  
  
 @ACCOUNT_IDX  INT   
  
AS  
  
 SET NOCOUNT ON  
 SET LOCK_TIMEOUT 10000  
  
 BEGIN  
  
  SELECT TitleCode, TitleValue, TitleLevel, TitlePremium, TitleEquip, TitleStatus FROM dbo.userTitleDB WITH (READUNCOMMITTED)  
  WHERE AccountIDX=@ACCOUNT_IDX  
    
  IF (@@ERROR<>0)  
  BEGIN     
   RETURN;  
  END   
  
 END  
   
 RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_title_set_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_title_set_add]  
  
 @ACCOUNT_IDX  INT,  
 @TITLE_CODE   INT,  
 @TITLE_VALUE  BIGINT,  
 @TITLE_LEVEL  INT,  
 @TITLE_PREMIUM  TINYINT,  
 @TITLE_EQUIP  TINYINT,  
 @TITLE_STATUS  TINYINT  
  
AS  
  
 SET NOCOUNT ON  
 SET LOCK_TIMEOUT 10000  
  
 DECLARE @GET_DATE  DATETIME  
 SET @GET_DATE=GETDATE();  
  
 BEGIN TRAN  
  
  -- Insert or Update    
  ;MERGE dbo.userTitleDB as TARGET  
  USING (SELECT @ACCOUNT_IDX, @TITLE_CODE) AS SOURCE (AccountIDX, TitleCode)  
  ON (TARGET.AccountIDX=SOURCE.AccountIDX and TARGET.TitleCode=SOURCE.TitleCode)  
  WHEN MATCHED THEN  
   UPDATE SET TARGET.TitleValue=@TITLE_VALUE, TARGET.TitleLevel=@TITLE_LEVEL, TARGET.TitlePremium=@TITLE_PREMIUM, TARGET.TitleEquip=@TITLE_EQUIP, TARGET.TitleStatus=@TITLE_STATUS, TARGET.UpdDate=@GET_DATE  
  WHEN NOT MATCHED THEN  
   INSERT (AccountIDX, TitleCode, TitleValue, TitleLevel, TitlePremium, TitleEquip, TitleStatus) VALUES (SOURCE.AccountIDX, SOURCE.TitleCode, @TITLE_VALUE, @TITLE_LEVEL, @TITLE_PREMIUM, @TITLE_EQUIP, @TITLE_STATUS);  
  
  IF (@@ROWCOUNT=0) or (@@ERROR<>0)  
  BEGIN  
   ROLLBACK TRAN  
   RETURN;  
  END   
  
 COMMIT TRAN    
  
 RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_title_set_status]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_title_set_status]  
  
 @ACCOUNT_IDX  INT  
  
AS  
  
 SET NOCOUNT ON  
 SET LOCK_TIMEOUT 10000  
  
 BEGIN TRAN  
  
  UPDATE dbo.userTitleDB WITH (XLOCK, ROWLOCK) SET TitleStatus=1  
  WHERE AccountIDX=@ACCOUNT_IDX and TitleStatus=2  
    
  IF (@@ROWCOUNT=0) or (@@ERROR<>0)  
  BEGIN  
   ROLLBACK TRAN  
   RETURN;  
  END   
  
 COMMIT TRAN  
   
 RETURN;
GO
/****** Object:  StoredProcedure [dbo].[game_trade_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_trade_add]
(
	@accountIDX int
,	@itemType int
,	@value1 int
,	@value2 int
,	@price bigint
,	@mcustom int
,	@fcustom int
,	@userIP varchar(16)
,	@periodDate int
)
AS

SET NOCOUNT ON

INSERT INTO dbo.userTradeDB (accountIDX, itemType, value1, value2, price, mcustom, fcustom, userIP, periodDate, regDate)
VALUES (@accountIDX, @itemType, @value1, @value2, @price, @mcustom, @fcustom, @userIP, @periodDate, GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[game_trade_delete]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_trade_delete]
(
	@idx int
)
AS

SET NOCOUNT ON

DELETE FROM dbo.userTradeDB
 WHERE idx = @idx
GO
/****** Object:  StoredProcedure [dbo].[game_trade_get_list]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_trade_get_list]
(
	@topn int
,	@idx int
)
AS

SET NOCOUNT ON

SELECT TOP (@topn) a.idx, a.accountIDX, b.nickName, a.itemType, a.value1, a.value2, a.price, a.mcustom, a.fcustom, a.periodDate, a.regDate
  FROM dbo.userTradeDB a WITH(NOLOCK)
  JOIN dbo.userMemberDB b WITH(NOLOCK)
    ON a.accountIDX = b.accountIDX
 WHERE a.idx < @idx
 ORDER BY a.idx DESC
GO
/****** Object:  StoredProcedure [dbo].[game_trade_get_self_index]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[game_trade_get_self_index]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT MAX(idx)
  FROM dbo.userTradeDB
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[log_data_clover_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[log_data_clover_add]
(
	@userIDX int
,	@FriendIDX int
,	@Type smallint
,	@Count int
)
AS

SET NOCOUNT ON

INSERT INTO dbo.log_data_clover( accountIDX, friendIDX, eventType, CloverCount, regDate )
VALUES( @userIDX, @FriendIDX, @Type, @Count, GETDATE() )
GO
/****** Object:  StoredProcedure [dbo].[log_data_pcroom_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[log_data_pcroom_add]
(
	@accountIDX int
,	@nickName varchar(20)
,	@playTime int
,	@userIP varchar(15)
,	@pcnum int
,	@logType int
,	@pcrType int
)
AS

INSERT INTO dbo.log_data_pcroom (accountIDX, nickName, playTime, userIP, pcnum, logType, pcrType, regDate)
VALUES (@accountIDX, @nickName, @playTime, @userIP, @pcnum, @logType, @pcrType, getdate())
GO
/****** Object:  StoredProcedure [dbo].[log_data_quest_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[log_data_quest_add]
(
	@accountIDX int
,	@nickName varchar(20)
,	@userLevel int
,	@mainIDX int
,	@subIDX int
,	@logType int
)
As

	INSERT INTO log_data_quest (accountIDX, nickName, userLevel, mainIDX, subIDX, logType, regDate)
	VALUES (@accountIDX, @nickName, @userLevel, @mainIDX, @subIDX, @logType, getdate())
GO
/****** Object:  StoredProcedure [dbo].[log_data_time_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[log_data_time_add]
(
	@accountIDX int
,	@nickName varchar(20)
,	@playTime int
,	@logType int
)
As

	INSERT INTO log_data_time (accountIDX, nickName, playTime, logType, regDate)
	VALUES (@accountIDX, @nickName, @playTime, @logType, getdate())
GO
/****** Object:  StoredProcedure [dbo].[log_gameLog_set_log]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[log_gameLog_set_log]

	@LOG_TYPE			INT,
	@ACCOUNT_IDX		INT,
	@USER_ID			VARCHAR(20),
	@USER_NAME			VARCHAR(20),
	@USER_LEVEL			INT,
	@USER_EXP			INT,
	@CHANNEL_TYPE		INT,
	@TBL_INDEX			INT,
	@OBJECT_CODE		INT,
	@EVENT_TYPE			TINYINT,	
	@PARAM_1			INT,
	@PARAM_2			INT,
	@PARAM_3			INT,
	@PARAM_4			INT,
	@PARAM_5			VARCHAR(50),
	@USER_IP			VARCHAR(15)
	
AS

	SET NOCOUNT ON
	SET LOCK_TIMEOUT 10000

	DECLARE @nReturn			INT	
	DECLARE @REG_DATE			DATETIME

	SET @nReturn=0			-- True
	SET @REG_DATE=GETDATE()	
		
	INSERT dbo.GAME_LOG WITH (XLOCK, ROWLOCK) (RegDate, LogType, AccountIDX, UserID, UserName, UserLevel, UserExp, CpType, TBLIDX, ObjCode, EventType, Param1, Param2, Param3, Param4, Param5, UserIP)
	VALUES (@REG_DATE, @LOG_TYPE, @ACCOUNT_IDX, @USER_ID, @USER_NAME, @USER_LEVEL, @USER_EXP, @CHANNEL_TYPE, @TBL_INDEX, @OBJECT_CODE, @EVENT_TYPE, @PARAM_1, @PARAM_2, @PARAM_3, @PARAM_4, @PARAM_5, @USER_IP)
				
	
	RETURN 0;
GO
/****** Object:  StoredProcedure [dbo].[log_item_class_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[log_item_class_add]
(
	@accountIDX int
,	@nickName varchar(20)
,	@userLevel int
,	@classType int
,	@limitType int
,	@eventType int
,	@amount int
,	@userIP varchar(15)
,	@note varchar(100)
)
AS
	INSERT INTO log_buy_item_class (accountIDX, nickName, userLevel, classType, limitType, eventType, amount, userIP, note, regDate)
	VALUES (@accountIDX, @nickName, @userLevel, @classType, @limitType, @eventType, @amount, @userIP, @note, getdate())
GO
/****** Object:  StoredProcedure [dbo].[log_item_decoration_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[log_item_decoration_add]
(
	@accountIDX int
,	@nickName varchar(20)
,	@classType int
,	@kindred int
,	@itemType int
,	@itemCode int
,	@eventType int
,	@amount int
,	@userIP varchar(15)
,	@note varchar(100)
)
AS
	INSERT INTO log_buy_item_decoration (accountIDX, nickName, classType, kindred, itemType, itemCode, eventType, amount, userIP, note, regDate)
	VALUES (@accountIDX, @nickName, @classType, @kindred, @itemType, @itemCode, @eventType, @amount, @userIP, @note, getdate())
GO
/****** Object:  StoredProcedure [dbo].[log_item_special_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[log_item_special_add]
(
	@accountIDX int
,	@nickName varchar(20)
,	@itemType int
,	@itemValue int
,	@eventType int
,	@amount int
,	@userIP varchar(15)
,	@note varchar(100)
)
AS

SET NOCOUNT ON

INSERT INTO dbo.log_buy_item_special (accountIDX, nickName, itemType, itemValue, eventType, amount, userIP, note, regDate)
VALUES (@accountIDX, @nickName, @itemType, @itemValue, @eventType, @amount, @userIP, @note, getdate())
GO
/****** Object:  StoredProcedure [dbo].[log_present_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[log_present_add]
(
	@accountIDX int
,	@nickname varchar(20)
,	@receiveIDX int
,	@presentType smallint
,	@value1 int
,	@value2 int
,	@eventType int
,	@userIP varchar(15)
,	@note varchar(100)
)
AS

SET NOCOUNT ON

INSERT INTO dbo.log_present (accountIDX, nickname, receiveIDX, presentType, value1, value2, eventType, userIP, note, regDate)
VALUES (@accountIDX, @nickName, @receiveIDX, @presentType, @value1, @value2, @eventType, @userIP, @note, getdate())
GO
/****** Object:  StoredProcedure [dbo].[manage_member_count]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[manage_member_count]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT COUNT(*)
  FROM dbo.userMemberDB WITH(NOLOCK)
 WHERE accountIDX=@accountIDX
GO
/****** Object:  StoredProcedure [dbo].[manage_present_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[manage_present_add]
(
	@accountIDX varchar(2500)
,	@presentType varchar(4)
,	@value1 varchar(32)
,	@value2 varchar(32)
,	@msgType varchar(8)
)
AS

SET NOCOUNT ON

DECLARE @sql varchar(3000)

SET @sql = ''
SET @sql = @sql + 'INSERT INTO dbo.userPresentDB (sendIDX, receiveIDX, presentType, value1, value2, msgType, flag, limitDate, regDate) '
SET @sql = @sql + 'SELECT 1, accountIDX, ' + @presentType + ', ' + @value1 + ', ' + @value2 + ', ' + @msgType + ', 1, GETDATE() + 28, GETDATE() '
SET @sql = @sql + 'FROM dbo.userMemberDB WITH(NOLOCK) '
SET @sql = @sql + 'WHERE accountIDX IN (' + @accountIDX + ')'
EXECUTE (@sql)

-- Index : DeveloperK
GO
/****** Object:  StoredProcedure [dbo].[manage_present_get_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[manage_present_get_accountIDX]
(
	@userID varchar(2500)
)
AS

SET NOCOUNT ON

DECLARE @SQL varchar(3000)
SET @SQL = 'SELECT accountIDX FROM userMemberDB WHERE userID in (' + @userID + ')'

EXECUTE (@SQL)
GO
/****** Object:  StoredProcedure [dbo].[manage_user_state_upt]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[manage_user_state_upt]
(
	@accountIDX INT
,	@limitType TINYINT
,	@limitDate DATETIME
,	@reason VARCHAR(1000)
,	@userIP VARCHAR(15)
)
AS
 
BEGIN
 
SET NOCOUNT ON

UPDATE dbo.userMemberDB
   SET limitType=@limitType,
       limitDate=@limitDate
 WHERE accountIDX=@accountIDX

INSERT INTO LosaGame_log.dbo.log_user_block (
	accountIDX, limitType, limitDate, reason, userIP, regDate
)
VALUES (
	@accountIDX, @limitType, @limitDate, @reason, @userIP, GETDATE()
)
 
END
GO
/****** Object:  StoredProcedure [dbo].[manage_userinfo_get_character_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[manage_userinfo_get_character_data]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT idx, classType, limitTime, limitType, regDate
  FROM dbo.userCharacterDB WITH(NOLOCK)
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[manage_userinfo_get_guild_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[manage_userinfo_get_guild_data]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT b.guildName, a.guildPosition, a.guildJoinType
  FROM dbo.userGuildInfoDB a WITH(NOLOCK)
  JOIN dbo.userGuildDB b WITH(NOLOCK)
    ON a.guildIDX = b.idx 
 WHERE a.accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[manage_userinfo_get_item_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[manage_userinfo_get_item_data]
(
	@accountIDX int
)
AS

SET NOCOUNT ON

SELECT idx, item1_type, item1_code, item2_type, item2_code, item3_type, item3_code, item4_type, item4_code, item5_type, item5_code, 
	   item6_type, item6_code, item7_type, item7_code, item8_type, item8_code, item9_type, item9_code, item10_type, item10_code, 
	   item11_type, item11_code, item12_type, item12_code, item13_type, item13_code, item14_type, item14_code, item15_type, item15_code, 
	   item16_type, item16_code, item17_type, item17_code, item18_type, item18_code, item19_type, item19_code, item20_type, item20_code 
  FROM dbo.userItemDB WITH(NOLOCK)
 WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[manage_userinfo_get_member_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[manage_userinfo_get_member_data]
(
	@searchType varchar(12)
,	@searchString varchar(20)
)
AS

SET NOCOUNT ON

DECLARE @sql varchar(1000)

SET @sql = ''
SET @sql = @sql + 'SELECT a.accountIDX, a.userID, a.nickName, a.limitType, a.limitDate, a.regDate, b.gameMoney, b.userState, b.playTime, b.userLevel, b.userEXP, b.connDate '
SET @sql = @sql + 'FROM dbo.userMemberDB a JOIN dbo.userGameDB b ON a.accountIDX=b.accountIDX '
SET @sql = @sql + 'WHERE a.' + @searchType + '=''' + @searchString + ''''

EXECUTE (@sql)
GO
/****** Object:  StoredProcedure [dbo].[obt_event_for_cbt]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obt_event_for_cbt]
(
	@GARENA_UID		VARCHAR(20)
)
AS

	SET NOCOUNT ON;
	SET LOCK_TIMEOUT 10000;

	DECLARE @ACCOUNT_IDX			INT
	DECLARE @EVENT_TYPE				TINYINT

	DECLARE @DEFINE_REWARD_TYPE		INT
	DECLARE @DEFINE_REWARD_VALUE1	INT
	DECLARE @DEFINE_REWARD_VALUE2	INT

	SET @DEFINE_REWARD_TYPE = 3
	SET @DEFINE_REWARD_VALUE1 = 1002475
	SET @DEFINE_REWARD_VALUE2 = 1

	DECLARE @nReturn			INT
	SET @nReturn=0				-- True

	SET @EVENT_TYPE = 2

	IF (NOT EXISTS(SELECT * FROM LosaGame.dbo.userMemberDB WITH (NOLOCK) WHERE userID = @GARENA_UID))
	BEGIN
		RETURN 8001;
	END

	-- LIVE Account Data Check
	SET @ACCOUNT_IDX = ISNULL((
		SELECT accountIDX
		  FROM dbo.userMemberDB WITH (NOLOCK)
		 WHERE userID = @GARENA_UID
	), 0)

	IF (@ACCOUNT_IDX=0)
	BEGIN
		RETURN 8002;
	END

	IF (EXISTS(SELECT * FROM dbo.TBL_obt_event_log WITH (NOLOCK) WHERE accountIDX=@ACCOUNT_IDX AND eventType=@EVENT_TYPE))
	BEGIN
		RETURN 8003;
	END



	-- insert reward
	BEGIN TRAN

		INSERT INTO dbo.userPresentDB (
			sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate
		)
		VALUES (
			1, @ACCOUNT_IDX, @DEFINE_REWARD_TYPE, @DEFINE_REWARD_VALUE1, @DEFINE_REWARD_VALUE2, 0, 0, 3, 1, GETDATE()+35, GETDATE()
		)

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN
			RETURN 8004;
		END

		INSERT INTO dbo.TBL_obt_event_log (accountIDX, eventType, regDate)
		VALUES (@ACCOUNT_IDX, @EVENT_TYPE, GETDATE())

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN
			RETURN 8005;
		END

	COMMIT TRAN

	RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[obt_event_for_game_bug]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obt_event_for_game_bug]
(
	@GARENA_UID		VARCHAR(20)
)
AS

	SET NOCOUNT ON;
	SET LOCK_TIMEOUT 10000;

	DECLARE @ACCOUNT_IDX			INT
	DECLARE @EVENT_TYPE				TINYINT
	DECLARE @i						TINYINT

	DECLARE @DEFINE_REWARD_TYPE		INT
	DECLARE @DEFINE_REWARD_VALUE1	INT
	DECLARE @DEFINE_REWARD_VALUE2	INT

	SET @DEFINE_REWARD_TYPE = 6
	SET @DEFINE_REWARD_VALUE1 = 2
	SET @DEFINE_REWARD_VALUE2 = 0

	DECLARE @nReturn			INT
	SET @nReturn=0				-- True

	SET @EVENT_TYPE = 3


	-- LIVE Account Data Check
	SET @ACCOUNT_IDX = ISNULL((
		SELECT accountIDX
		  FROM dbo.userMemberDB WITH (NOLOCK)
		 WHERE userID = @GARENA_UID
	), 0)

	IF (@ACCOUNT_IDX=0)
	BEGIN
		RETURN 8001;
	END

	IF (NOT EXISTS(SELECT * FROM dbo.TBL_obt_event_bug_reporting WITH (NOLOCK) WHERE accountIDX=@ACCOUNT_IDX AND brType=1))
	BEGIN
		RETURN 8002;
	END

	IF (EXISTS(SELECT * FROM dbo.TBL_obt_event_log WITH (NOLOCK) WHERE accountIDX=@ACCOUNT_IDX AND eventType=@EVENT_TYPE))
	BEGIN
		RETURN 8003;
	END



	-- insert reward
	BEGIN TRAN

		SET @i = 0
		WHILE (@i < 5)
		BEGIN
			INSERT INTO dbo.userPresentDB (
				sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate
			)
			VALUES (
				1, @ACCOUNT_IDX, @DEFINE_REWARD_TYPE, @DEFINE_REWARD_VALUE1, @DEFINE_REWARD_VALUE2, 0, 0, 3, 1, GETDATE()+35, GETDATE()
			)

			IF (@@ROWCOUNT=0) or (@@ERROR<>0)
			BEGIN
				ROLLBACK TRAN
				RETURN 8004;
			END

			SET @i = @i + 1
		END

		INSERT INTO dbo.TBL_obt_event_log (accountIDX, eventType, regDate)
		VALUES (@ACCOUNT_IDX, @EVENT_TYPE, GETDATE())

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN
			RETURN 8005;
		END

	COMMIT TRAN

	RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[obt_event_for_ghost]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obt_event_for_ghost]
(
	@GARENA_UID		VARCHAR(20)
)
AS

	SET NOCOUNT ON;
	SET LOCK_TIMEOUT 10000;

	DECLARE @ACCOUNT_IDX			INT
	DECLARE @EVENT_TYPE				TINYINT
	DECLARE @i						TINYINT

	DECLARE @DEFINE_REWARD_TYPE		INT
	DECLARE @DEFINE_REWARD_VALUE1	INT
	DECLARE @DEFINE_REWARD_VALUE2	INT

	SET @DEFINE_REWARD_TYPE = 9
	SET @DEFINE_REWARD_VALUE1 = 2003
	SET @DEFINE_REWARD_VALUE2 = 0

	DECLARE @nReturn			INT
	SET @nReturn=0				-- True

	SET @EVENT_TYPE = 5


	-- LIVE Account Data Check
	SET @ACCOUNT_IDX = ISNULL((
		SELECT accountIDX
		  FROM dbo.userMemberDB WITH (NOLOCK)
		 WHERE userID = @GARENA_UID
	), 0)

	IF (@ACCOUNT_IDX=0)
	BEGIN
		RETURN 8001;
	END

	IF (NOT EXISTS(SELECT * FROM dbo.TBL_obt_event_bug_reporting WITH (NOLOCK) WHERE accountIDX=@ACCOUNT_IDX AND brType=3))
	BEGIN
		RETURN 8002;
	END

	IF (EXISTS(SELECT * FROM dbo.TBL_obt_event_log WITH (NOLOCK) WHERE accountIDX=@ACCOUNT_IDX AND eventType=@EVENT_TYPE))
	BEGIN
		RETURN 8003;
	END



	-- insert reward
	BEGIN TRAN

		INSERT INTO dbo.userPresentDB (
			sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate
		)
		VALUES (
			1, @ACCOUNT_IDX, @DEFINE_REWARD_TYPE, @DEFINE_REWARD_VALUE1, @DEFINE_REWARD_VALUE2, 0, 0, 3, 1, GETDATE()+35, GETDATE()
		)

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN
			RETURN 8004;
		END

		INSERT INTO dbo.TBL_obt_event_log (accountIDX, eventType, regDate)
		VALUES (@ACCOUNT_IDX, @EVENT_TYPE, GETDATE())

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN
			RETURN 8005;
		END

	COMMIT TRAN

	RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[obt_event_for_level]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obt_event_for_level]
(
	@GARENA_UID		VARCHAR(20)
)
AS

	SET NOCOUNT ON;
	SET LOCK_TIMEOUT 10000;

	DECLARE @CBT_ACCOUNT_IDX		INT
	DECLARE @LIVE_ACCOUNT_IDX		INT
	DECLARE @USER_LEVEL				INT
--	DECLARE @GAME_SERVER_ID			BIGINT
	DECLARE @EVENT_TYPE				TINYINT

	DECLARE @DEFINE_REWARD1_TYPE	INT
	DECLARE @DEFINE_REWARD1_VALUE1	INT
	DECLARE @DEFINE_REWARD1_VALUE2	INT
	DECLARE @DEFINE_REWARD2_TYPE	INT
	DECLARE @DEFINE_REWARD2_VALUE1	INT
	DECLARE @DEFINE_REWARD2_VALUE2	INT
	DECLARE @DEFINE_REWARD4_TYPE	INT
	DECLARE @DEFINE_REWARD4_VALUE1	INT
	DECLARE @DEFINE_REWARD4_VALUE2	INT

	SET @DEFINE_REWARD1_TYPE = 9			-- Lv7
	SET @DEFINE_REWARD1_VALUE1 = 2001		-- Lv7
	SET @DEFINE_REWARD1_VALUE2 = 0			-- Lv7
	SET @DEFINE_REWARD2_TYPE = 3			-- Lv12
	SET @DEFINE_REWARD2_VALUE1 = 3000019	-- Lv12
	SET @DEFINE_REWARD2_VALUE2 = 1			-- Lv12
	SET @DEFINE_REWARD4_TYPE = 3			-- Lv20
	SET @DEFINE_REWARD4_VALUE1 = 1000608	-- Lv20
	SET @DEFINE_REWARD4_VALUE2 = 1			-- Lv20

	DECLARE @nReturn			INT
	SET @nReturn=0				-- True

	SET @EVENT_TYPE = 1

	-- CBT Account Data Check
	SET @CBT_ACCOUNT_IDX = ISNULL((
		SELECT accountIDX
		  FROM LosaGame.dbo.userMemberDB WITH (NOLOCK)
		 WHERE userID = @GARENA_UID
	), 0)

	IF (@CBT_ACCOUNT_IDX=0)
	BEGIN
		RETURN 8001;
	END

	-- LIVE Account Data Check
	SET @LIVE_ACCOUNT_IDX = ISNULL((
		SELECT accountIDX
		  FROM dbo.userMemberDB WITH (NOLOCK)
		 WHERE userID = @GARENA_UID
	), 0)

	IF (@LIVE_ACCOUNT_IDX=0)
	BEGIN
		RETURN 8002;
	END


	SELECT @USER_LEVEL = ISNULL(userLevel, 0)
	  FROM LosaGame.dbo.userGameDB WITH (NOLOCK)
	 WHERE accountIDX = @CBT_ACCOUNT_IDX

	IF (@USER_LEVEL < 7)
	BEGIN
		RETURN 8003;
	END

--	IF (@USER_LEVEL >= 16 AND @USER_LEVEL < 20)
--	BEGIN
--		SELECT @GAME_SERVER_ID = ISNULL(gameServerID, 0)
--			FROM dbo.userLoginDB WITH (NOLOCK)
--			WHERE accountIDX = @LIVE_ACCOUNT_IDX
--
--		IF (@GAME_SERVER_ID > 0)
--		BEGIN
--			RETURN 8004;
--		END
--	END

	IF (EXISTS(SELECT * FROM dbo.TBL_obt_event_log WITH (NOLOCK) WHERE accountIDX=@LIVE_ACCOUNT_IDX AND eventType=@EVENT_TYPE))
	BEGIN
		RETURN 8005;
	END



	-- insert reward
	BEGIN TRAN

		IF (@USER_LEVEL >= 7)
		BEGIN
			INSERT INTO dbo.userPresentDB (
				sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate
			)
			VALUES (
				1, @LIVE_ACCOUNT_IDX, @DEFINE_REWARD1_TYPE, @DEFINE_REWARD1_VALUE1, @DEFINE_REWARD1_VALUE2, 0, 0, 3, 1, GETDATE()+35, GETDATE()
			)

			IF (@@ROWCOUNT=0) or (@@ERROR<>0)
			BEGIN
				ROLLBACK TRAN
				RETURN 8006;
			END
		END

		IF (@USER_LEVEL >= 12)
		BEGIN
			INSERT INTO dbo.userPresentDB (
				sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate
			)
			VALUES (
				1, @LIVE_ACCOUNT_IDX, @DEFINE_REWARD2_TYPE, @DEFINE_REWARD2_VALUE1, @DEFINE_REWARD2_VALUE2, 0, 0, 3, 1, GETDATE()+35, GETDATE()
			)

			IF (@@ROWCOUNT=0) or (@@ERROR<>0)
			BEGIN
				ROLLBACK TRAN
				RETURN 8007;
			END
		END

--		IF (@USER_LEVEL >= 16)
--		BEGIN
--
--			UPDATE dbo.userMoneyDB
--			   SET bonusCash = bonusCash + 21000
--			 WHERE accountIDX = @LIVE_ACCOUNT_IDX
--
--			IF (@@ROWCOUNT=0) or (@@ERROR<>0)
--			BEGIN
--				ROLLBACK TRAN
--				RETURN 8008;
--			END
--		END

		IF (@USER_LEVEL >= 20)
		BEGIN
			INSERT INTO dbo.userPresentDB (
				sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate
			)
			VALUES (
				1, @LIVE_ACCOUNT_IDX, @DEFINE_REWARD4_TYPE, @DEFINE_REWARD4_VALUE1, @DEFINE_REWARD4_VALUE2, 0, 0, 3, 1, GETDATE()+35, GETDATE()
			)

			IF (@@ROWCOUNT=0) or (@@ERROR<>0)
			BEGIN
				ROLLBACK TRAN
				RETURN 8009;
			END
		END

		INSERT INTO dbo.TBL_obt_event_log (accountIDX, eventType, regDate)
		VALUES (@LIVE_ACCOUNT_IDX, @EVENT_TYPE, GETDATE())

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN
			RETURN 8010;
		END

	COMMIT TRAN

	RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[obt_event_for_shop_bug]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[obt_event_for_shop_bug]
(
	@GARENA_UID		VARCHAR(20)
)
AS

	SET NOCOUNT ON;
	SET LOCK_TIMEOUT 10000;

	DECLARE @ACCOUNT_IDX			INT
	DECLARE @EVENT_TYPE				TINYINT
	DECLARE @i						TINYINT

	DECLARE @DEFINE_REWARD_TYPE		INT
	DECLARE @DEFINE_REWARD_VALUE1	INT
	DECLARE @DEFINE_REWARD_VALUE2	INT

	SET @DEFINE_REWARD_TYPE = 4
	SET @DEFINE_REWARD_VALUE1 = 100000
	SET @DEFINE_REWARD_VALUE2 = 0

	DECLARE @nReturn			INT
	SET @nReturn=0				-- True

	SET @EVENT_TYPE = 4


	-- LIVE Account Data Check
	SET @ACCOUNT_IDX = ISNULL((
		SELECT accountIDX
		  FROM dbo.userMemberDB WITH (NOLOCK)
		 WHERE userID = @GARENA_UID
	), 0)

	IF (@ACCOUNT_IDX=0)
	BEGIN
		RETURN 8001;
	END

	IF (NOT EXISTS(SELECT * FROM dbo.TBL_obt_event_bug_reporting WITH (NOLOCK) WHERE accountIDX=@ACCOUNT_IDX AND brType=2))
	BEGIN
		RETURN 8002;
	END

	IF (EXISTS(SELECT * FROM dbo.TBL_obt_event_log WITH (NOLOCK) WHERE accountIDX=@ACCOUNT_IDX AND eventType=@EVENT_TYPE))
	BEGIN
		RETURN 8003;
	END



	-- insert reward
	BEGIN TRAN

		INSERT INTO dbo.userPresentDB (
			sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate
		)
		VALUES (
			1, @ACCOUNT_IDX, @DEFINE_REWARD_TYPE, @DEFINE_REWARD_VALUE1, @DEFINE_REWARD_VALUE2, 0, 0, 3, 1, GETDATE()+35, GETDATE()
		)

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN
			RETURN 8004;
		END

		INSERT INTO dbo.TBL_obt_event_log (accountIDX, eventType, regDate)
		VALUES (@ACCOUNT_IDX, @EVENT_TYPE, GETDATE())

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN
			RETURN 8005;
		END

	COMMIT TRAN

	RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_BESTFRIEND_SET_ADD]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_BESTFRIEND_SET_ADD]

	@ACCOUNT_IDX	INT,
	@FRIEND_IDX		INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn	INT
DECLARE @nCnt		INT
DECLARE @nMaxCnt	INT
SET @nReturn = 0
SET @nCnt = 0
SET @nMaxCnt = 5

IF (NOT EXISTS(SELECT * FROM dbo.userMemberDB WITH (NOLOCK) WHERE accountIDX = @FRIEND_IDX))
BEGIN
	RETURN 1001;
END

IF (EXISTS(SELECT * FROM dbo.userFriendBestDB WITH (NOLOCK) WHERE friendIDX = @FRIEND_IDX))
BEGIN
	RETURN 1002;
END

SET @nCnt = (
	SELECT COUNT(*)
	  FROM dbo.userFriendBestDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
)

IF (@nCnt >= @nMaxCnt)
BEGIN
	RETURN 1003;
END

BEGIN TRAN

	INSERT INTO dbo.userFriendBestDB (accountIDX, friendIDX, flag, flagTime, regDate)
	VALUES (@ACCOUNT_IDX, @FRIEND_IDX, 1, 0, GETDATE())

	IF (@@ROWCOUNT=0 OR @@ERROR <> 0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1004;
	END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_BESTFRIEND_SET_DELETE]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_BESTFRIEND_SET_DELETE]

	@TABLE_IDX		INT,
	@ACCOUNT_IDX	INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn INT
SET @nReturn = 0

BEGIN TRAN

	DELETE FROM dbo.userFriendBestDB
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND idx = @TABLE_IDX

	IF (@@ROWCOUNT=0 OR @@ERROR <> 0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1001;
	END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_CHARACTER_SET_DELETE]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_CHARACTER_SET_DELETE]

	@TABLE_IDX			INT,
	@ACCOUNT_IDX		INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn INT
SET @nReturn = 0

BEGIN TRAN

DELETE FROM dbo.userCharacterDB
 WHERE accountIDX = @ACCOUNT_IDX
   AND idx = @TABLE_IDX

IF (@@ROWCOUNT=0 OR @@ERROR <> 0)
BEGIN
	ROLLBACK TRAN
	RETURN 1001;
END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_CLASS_GET_LEVEL]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_CLASS_GET_LEVEL]

	@ACCOUNT_IDX		INT,
	@CLASS_CODE			TINYINT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT idx, accountIDX, classType, classLevel, classEXP, classStat
  FROM (
	SELECT idx, accountIDX, classType, classLevel, classEXP, classStat
	  FROM (
		SELECT *
		  FROM dbo.userClassDB WITH (NOLOCK)
		 WHERE accountIDX = @ACCOUNT_IDX
	  ) AS Hero
	UNPIVOT (classType FOR ctype IN (class1_type, class2_type, class3_type, class4_type, class5_type, class6_type, class7_type, class8_type, class9_type, class10_type)
	) AS UNP1
	UNPIVOT (classLevel FOR clevel IN (class1_level, class2_level, class3_level, class4_level, class5_level, class6_level, class7_level, class8_level, class9_level, class10_level)
	) AS UNP2
	UNPIVOT (classEXP FOR cexp IN (class1_expert, class2_expert, class3_expert, class4_expert, class5_expert, class6_expert, class7_expert, class8_expert, class9_expert, class10_expert)
	) AS UNP3
	UNPIVOT (classStat FOR cstat IN (class1_stat, class2_stat, class3_stat, class4_stat, class5_stat, class6_stat, class7_stat, class8_stat, class9_stat, class10_stat)
	) AS UNP4
	 WHERE SUBSTRING(ctype, 6, 2) = SUBSTRING(clevel, 6, 2)
	   AND SUBSTRING(ctype, 6, 2) = SUBSTRING(cexp, 6, 2)
	   AND SUBSTRING(ctype, 6, 2) = SUBSTRING(cstat, 6, 2)
	   AND classType != 0
  ) AS HeroLevel
 WHERE classType=@CLASS_CODE
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_CLASS_SET_EXP]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_CLASS_SET_EXP]

	@TABLE_IDX			INT,
	@ACCOUNT_IDX		INT,
	@COLUMN_NO			TINYINT,
	@CLASS_LEVEL		INT,
	@CLASS_EXPERT		INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn INT
SET @nReturn = 0

BEGIN TRAN

	IF (@COLUMN_NO = 1)
	BEGIN
		UPDATE dbo.userClassDB
		   SET class1_level = @CLASS_LEVEL,
		       class1_expert = @CLASS_EXPERT
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 2)
	BEGIN
		UPDATE dbo.userClassDB
		   SET class2_level = @CLASS_LEVEL,
		       class2_expert = @CLASS_EXPERT
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 3)
	BEGIN
		UPDATE dbo.userClassDB
		   SET class3_level = @CLASS_LEVEL,
		       class3_expert = @CLASS_EXPERT
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 4)
	BEGIN
		UPDATE dbo.userClassDB
		   SET class4_level = @CLASS_LEVEL,
		       class4_expert = @CLASS_EXPERT
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 5)
	BEGIN
		UPDATE dbo.userClassDB
		   SET class5_level = @CLASS_LEVEL,
		       class5_expert = @CLASS_EXPERT
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 6)
	BEGIN
		UPDATE dbo.userClassDB
		   SET class6_level = @CLASS_LEVEL,
		       class6_expert = @CLASS_EXPERT
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 7)
	BEGIN
		UPDATE dbo.userClassDB
		   SET class7_level = @CLASS_LEVEL,
		       class7_expert = @CLASS_EXPERT
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 8)
	BEGIN
		UPDATE dbo.userClassDB
		   SET class8_level = @CLASS_LEVEL,
		       class8_expert = @CLASS_EXPERT
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 9)
	BEGIN
		UPDATE dbo.userClassDB
		   SET class9_level = @CLASS_LEVEL,
		       class9_expert = @CLASS_EXPERT
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 10)
	BEGIN
		UPDATE dbo.userClassDB
		   SET class10_level = @CLASS_LEVEL,
		       class10_expert = @CLASS_EXPERT
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE
	BEGIN
		ROLLBACK TRAN
		RETURN 1002;
	END

	IF (@@ROWCOUNT=0 OR @@ERROR <> 0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1001;
	END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_FRIEND_SET_DELETE]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_FRIEND_SET_DELETE]

	@ACCOUNT_IDX	INT,
	@FRIEND_IDX		INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn INT
SET @nReturn = 0

BEGIN TRAN

	DELETE FROM dbo.userFriendDB
	 WHERE userAccIDX = @ACCOUNT_IDX
	   AND friendAccIDX = @FRIEND_IDX

	IF (@@ERROR <> 0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1001;
	END

	DELETE FROM dbo.userFriendDB
	 WHERE friendAccIDX = @ACCOUNT_IDX
	   AND userAccIDX = @FRIEND_IDX

	IF (@@ERROR <> 0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1002;
	END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_GEAR_SET_DELETE]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_GEAR_SET_DELETE]

	@TABLE_IDX			INT,
	@ACCOUNT_IDX		INT,
	@COLUMN_NO			TINYINT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn INT
SET @nReturn = 0

BEGIN TRAN

	IF (@COLUMN_NO = 1)
	BEGIN
		UPDATE dbo.userItemExtraDB
		   SET item1_type = 0,
		       item1_reinforce = 0,
			   item1_slotindex = 0,
			   item1_tradetype = 0,
			   item1_mcustom = 0,
			   item1_fcustom = 0,
			   item1_failexp = 0,
			   item1_limitType = 0,
			   item1_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 2)
	BEGIN
		UPDATE dbo.userItemExtraDB
		   SET item2_type = 0,
		       item2_reinforce = 0,
			   item2_slotindex = 0,
			   item2_tradetype = 0,
			   item2_mcustom = 0,
			   item2_fcustom = 0,
			   item2_failexp = 0,
			   item2_limitType = 0,
			   item2_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 3)
	BEGIN
		UPDATE dbo.userItemExtraDB
		   SET item3_type = 0,
		       item3_reinforce = 0,
			   item3_slotindex = 0,
			   item3_tradetype = 0,
			   item3_mcustom = 0,
			   item3_fcustom = 0,
			   item3_failexp = 0,
			   item3_limitType = 0,
			   item3_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 4)
	BEGIN
		UPDATE dbo.userItemExtraDB
		   SET item4_type = 0,
		       item4_reinforce = 0,
			   item4_slotindex = 0,
			   item4_tradetype = 0,
			   item4_mcustom = 0,
			   item4_fcustom = 0,
			   item4_failexp = 0,
			   item4_limitType = 0,
			   item4_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 5)
	BEGIN
		UPDATE dbo.userItemExtraDB
		   SET item5_type = 0,
		       item5_reinforce = 0,
			   item5_slotindex = 0,
			   item5_tradetype = 0,
			   item5_mcustom = 0,
			   item5_fcustom = 0,
			   item5_failexp = 0,
			   item5_limitType = 0,
			   item5_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 6)
	BEGIN
		UPDATE dbo.userItemExtraDB
		   SET item6_type = 0,
		       item6_reinforce = 0,
			   item6_slotindex = 0,
			   item6_tradetype = 0,
			   item6_mcustom = 0,
			   item6_fcustom = 0,
			   item6_failexp = 0,
			   item6_limitType = 0,
			   item6_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 7)
	BEGIN
		UPDATE dbo.userItemExtraDB
		   SET item7_type = 0,
		       item7_reinforce = 0,
			   item7_slotindex = 0,
			   item7_tradetype = 0,
			   item7_mcustom = 0,
			   item7_fcustom = 0,
			   item7_failexp = 0,
			   item7_limitType = 0,
			   item7_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 8)
	BEGIN
		UPDATE dbo.userItemExtraDB
		   SET item8_type = 0,
		       item8_reinforce = 0,
			   item8_slotindex = 0,
			   item8_tradetype = 0,
			   item8_mcustom = 0,
			   item8_fcustom = 0,
			   item8_failexp = 0,
			   item8_limitType = 0,
			   item8_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 9)
	BEGIN
		UPDATE dbo.userItemExtraDB
		   SET item9_type = 0,
		       item9_reinforce = 0,
			   item9_slotindex = 0,
			   item9_tradetype = 0,
			   item9_mcustom = 0,
			   item9_fcustom = 0,
			   item9_failexp = 0,
			   item9_limitType = 0,
			   item9_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 10)
	BEGIN
		UPDATE dbo.userItemExtraDB
		   SET item10_type = 0,
		       item10_reinforce = 0,
			   item10_slotindex = 0,
			   item10_tradetype = 0,
			   item10_mcustom = 0,
			   item10_fcustom = 0,
			   item10_failexp = 0,
			   item10_limitType = 0,
			   item10_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE
	BEGIN
		ROLLBACK TRAN
		RETURN 1002;
	END

	IF (@@ROWCOUNT=0 OR @@ERROR <> 0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1001;
	END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_GIFT_SET_DELETE]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_GIFT_SET_DELETE]

	@TABLE_IDX			INT,
	@ACCOUNT_IDX		INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn INT
SET @nReturn = 0

BEGIN TRAN

	DELETE FROM dbo.userPresentDB
	 WHERE idx = @TABLE_IDX
	   AND receiveIDX = @ACCOUNT_IDX

	IF (@@ROWCOUNT=0 OR @@ERROR <> 0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1001;
	END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_GOLD_GET_LIST]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_GOLD_GET_LIST]

	@START_DATE			DATETIME,
	@END_DATE			DATETIME,
	@ACCOUNT_IDX		INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

IF (@ACCOUNT_IDX = 0)
BEGIN
	SELECT TOP 100 idx, nickname, userLevel, itemType, itemCode, itemValue, amount, userIP, note, regDate
	  FROM dbo.log_buy_item_gold WITH(NOLOCK)
	 WHERE regDate >= @START_DATE
	   AND regDate < DATEADD(d, 1, @END_DATE)
	 ORDER BY regDate DESC
END
ELSE
BEGIN
	SELECT idx, nickname, userLevel, itemType, itemCode, itemValue, amount, userIP, note, regDate
	  FROM dbo.log_buy_item_gold WITH(NOLOCK)
	 WHERE regDate >= @START_DATE
	   AND regDate < DATEADD(d, 1, @END_DATE)
	   AND accountIDX = @ACCOUNT_IDX
	 ORDER BY regDate DESC
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_GUILD_GET_DATA]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_GUILD_GET_DATA]

	@SEARCH_TYPE	TINYINT,			-- 1: 길드명, 2: 아이디, 3: 닉네임
	@SEARCH_ID		NVARCHAR(20)

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

IF (@SEARCH_TYPE = 1)
BEGIN
	SELECT idx, guildName, aboutguild, guildmark, ranking, point, todaypoint, guildLevel, maxcount, membercount, regDate
	  FROM dbo.userGuildDB WITH (NOLOCK)
	 WHERE guildName = @SEARCH_ID
END
ELSE IF (@SEARCH_TYPE = 2)
BEGIN
	SELECT GU.idx, GU.guildName, GU.aboutguild, GU.guildmark, GU.ranking, GU.point, GU.todaypoint, GU.guildLevel, GU.maxcount, GU.membercount, GU.regDate
	  FROM dbo.userGuildInfoDB GI WITH (NOLOCK)
	  JOIN dbo.userGuildDB GU WITH (NOLOCK)
	    ON GI.guildIDX = GU.idx
	  JOIN dbo.userMemberDB ME WITH (NOLOCK)
	    ON GI.accountIDX = ME.accountIDX
	 WHERE ME.userID = @SEARCH_ID
END
ELSE
BEGIN
	SELECT GU.idx, GU.guildName, GU.aboutguild, GU.guildmark, GU.ranking, GU.point, GU.todaypoint, GU.guildLevel, GU.maxcount, GU.membercount, GU.regDate
	  FROM dbo.userGuildInfoDB GI WITH (NOLOCK)
	  JOIN dbo.userGuildDB GU WITH (NOLOCK)
	    ON GI.guildIDX = GU.idx
	  JOIN dbo.userMemberDB ME WITH (NOLOCK)
	    ON GI.accountIDX = ME.accountIDX
	 WHERE ME.nickName = @SEARCH_ID
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_GUILD_GET_MEMBER_LIST]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_GUILD_GET_MEMBER_LIST]

	@GUILD_IDX		INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT ME.accountIDX, ME.userID, ME.nickName, GI.guildPosition, ME.regDate
  FROM dbo.userGuildDB GU WITH (NOLOCK)
  JOIN dbo.userGuildInfoDB GI WITH (NOLOCK)
    ON GU.idx = GI.guildIDX
  JOIN dbo.userMemberDB ME WITH (NOLOCK)
    ON GI.accountIDX = ME.accountIDX
 WHERE GU.idx = @GUILD_IDX
   AND GI.guildJoinType IN (0, 1)
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_GUILD_SET_MARK]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_GUILD_SET_MARK]

	@GUILD_IDX		INT,
	@GUILD_MARK		TINYINT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn INT
SET @nReturn = 0


IF (NOT EXISTS(SELECT * FROM dbo.userGuildDB WITH (NOLOCK) WHERE idx = @GUILD_IDX))
BEGIN
	RETURN 1001;
END

BEGIN TRAN

	UPDATE dbo.userGuildDB WITH (ROWLOCK, XLOCK)
	   SET guildmark = @GUILD_MARK
	 WHERE idx = @GUILD_IDX

	IF (@@ROWCOUNT=0) or (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1002;
	END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_GUILD_SET_NAME]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_GUILD_SET_NAME]

	@GUILD_IDX		INT,
	@GUILD_NAME		VARCHAR(20)

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn INT
SET @nReturn = 0


IF (NOT EXISTS(SELECT * FROM dbo.userGuildDB WITH (NOLOCK) WHERE idx = @GUILD_IDX))
BEGIN
	RETURN 1001;
END

IF (EXISTS(SELECT * FROM dbo.userGuildDB WITH (NOLOCK) WHERE guildName = @GUILD_NAME))
BEGIN
	RETURN 1002;
END

BEGIN TRAN

	UPDATE dbo.userGuildDB WITH (ROWLOCK, XLOCK)
	   SET guildName = @GUILD_NAME
	 WHERE idx = @GUILD_IDX

	IF (@@ROWCOUNT=0) or (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1003;
	END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_ITEM_SET_ADD]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_ITEM_SET_ADD]

	@RECV_USER		VARCHAR(20),
	@ITEM_TYPE		SMALLINT,
	@VALUE1			INT,
	@VALUE2			INT

AS     

	SET NOCOUNT ON;
	SET LOCK_TIMEOUT 10000;

	DECLARE @nReturn			INT
	DECLARE @CHECK_INDEX		INT
	DECLARE @SEND_ACCOUNT_IDX	INT
	DECLARE @RECV_ACCOUNT_IDX	INT
	DECLARE @ID_TYPE			TINYINT
	DECLARE @SEND_USER			NVARCHAR(20)

	SET @nReturn = 0		-- true
	SET @CHECK_INDEX = -1
	SET @SEND_USER = 'DeveloperK'
	SET @ID_TYPE = 1

	EXEC @CHECK_INDEX = dbo.usp_user_get_accountidx @SEND_USER, @ID_TYPE, @SEND_ACCOUNT_IDX OUTPUT
	IF (@CHECK_INDEX <> 0) or (@SEND_ACCOUNT_IDX = 0)
	BEGIN
		RETURN -1;
	END

	EXEC @CHECK_INDEX = dbo.usp_user_get_accountidx @RECV_USER, @ID_TYPE, @RECV_ACCOUNT_IDX OUTPUT
	IF (@CHECK_INDEX <> 0) or (@RECV_ACCOUNT_IDX = 0)
	BEGIN
		RETURN -2;
	END

	BEGIN TRAN

		INSERT INTO dbo.userPresentDB WITH (XLOCK, ROWLOCK) (
			sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate
		)
		VALUES (
			@SEND_ACCOUNT_IDX, @RECV_ACCOUNT_IDX, @ITEM_TYPE, @VALUE1, @VALUE2, 0, 0, 3, 1, GETDATE()+28, GETDATE()
		)

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN;
			RETURN -3;
		END 

	COMMIT TRAN

	RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_LOGIN_GET_DATA]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_LOGIN_GET_DATA]

	@ACCOUNT_IDX		INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT gameServerID
  FROM dbo.userLoginDB WITH (NOLOCK)
 WHERE accountIDX = @ACCOUNT_IDX
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEDAL_SET_DELETE]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEDAL_SET_DELETE]

	@TABLE_IDX			INT,
	@ACCOUNT_IDX		INT,
	@COLUMN_NO			TINYINT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn INT
SET @nReturn = 0

BEGIN TRAN

	IF (@COLUMN_NO = 1)
	BEGIN
		UPDATE dbo.userItemMedalDB
		   SET item1_type = 0,
		       item1_class = 0,
			   item1_limitType = 0,
			   item1_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 2)
	BEGIN
		UPDATE dbo.userItemMedalDB
		   SET item2_type = 0,
		       item2_class = 0,
			   item2_limitType = 0,
			   item2_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 3)
	BEGIN
		UPDATE dbo.userItemMedalDB
		   SET item3_type = 0,
		       item3_class = 0,
			   item3_limitType = 0,
			   item3_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 4)
	BEGIN
		UPDATE dbo.userItemMedalDB
		   SET item4_type = 0,
		       item4_class = 0,
			   item4_limitType = 0,
			   item4_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 5)
	BEGIN
		UPDATE dbo.userItemMedalDB
		   SET item5_type = 0,
		       item5_class = 0,
			   item5_limitType = 0,
			   item5_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 6)
	BEGIN
		UPDATE dbo.userItemMedalDB
		   SET item6_type = 0,
		       item6_class = 0,
			   item6_limitType = 0,
			   item6_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 7)
	BEGIN
		UPDATE dbo.userItemMedalDB
		   SET item7_type = 0,
		       item7_class = 0,
			   item7_limitType = 0,
			   item7_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 8)
	BEGIN
		UPDATE dbo.userItemMedalDB
		   SET item8_type = 0,
		       item8_class = 0,
			   item8_limitType = 0,
			   item8_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 9)
	BEGIN
		UPDATE dbo.userItemMedalDB
		   SET item9_type = 0,
		       item9_class = 0,
			   item9_limitType = 0,
			   item9_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 10)
	BEGIN
		UPDATE dbo.userItemMedalDB
		   SET item10_type = 0,
		       item10_class = 0,
			   item10_limitType = 0,
			   item10_limitDate = '1900-01-01 00:00:00'
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE
	BEGIN
		ROLLBACK TRAN
		RETURN 1002;
	END

	IF (@@ROWCOUNT=0 OR @@ERROR <> 0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1001;
	END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_GET_BEST_FRIEND_LIST]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_GET_BEST_FRIEND_LIST]

	@ACCOUNT_IDX		INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT FR.idx, ME.userID, ME.nickName, GA.userLevel, FR.flagTime, GU.guildName, GI.guildPosition, GI.guildJoinType, FR.friendIDX
  FROM dbo.userFriendBestDB FR WITH (NOLOCK)
  JOIN dbo.userMemberDB ME WITH (NOLOCK)
	ON FR.friendIDX = ME.accountIDX
  JOIN dbo.userGameDB GA WITH (NOLOCK)
	ON FR.friendIDX = GA.accountIDX
  LEFT JOIN dbo.userGuildInfoDB GI WITH (NOLOCK)
    ON FR.friendIDX = GI.accountIDX
  LEFT JOIN dbo.userGuildDB GU WITH (NOLOCK)
    ON GI.guildIDX = GU.idx
 WHERE FR.accountIDX = @ACCOUNT_IDX
   AND FR.flag=1
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_GET_CHARACTERINFO]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_GET_CHARACTERINFO]

	@ACCOUNT_IDX		INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT idx, ClassType, limitTime, limitType, leaderType, awakeType, awakeTime, regDate
  FROM dbo.userCharacterDB WITH (NOLOCK)
 WHERE accountIDX = @ACCOUNT_IDX
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_GET_CLASSINFO]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_GET_CLASSINFO]

	@ACCOUNT_IDX		INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT idx, pos, classType, classLevel, classExpert, classStat
  FROM (
	SELECT idx, 1 AS pos, class1_type AS classType, class1_level AS classLevel, class1_expert AS classExpert, class1_stat AS classStat
	  FROM dbo.userClassDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND class1_type > 0

	UNION ALL

	SELECT idx, 2 AS pos, class2_type AS classType, class2_level AS classLevel, class2_expert AS classExpert, class2_stat AS classStat
	  FROM dbo.userClassDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND class2_type > 0

	UNION ALL

	SELECT idx, 3 AS pos, class3_type AS classType, class3_level AS classLevel, class3_expert AS classExpert, class3_stat AS classStat
	  FROM dbo.userClassDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND class3_type > 0

	UNION ALL

	SELECT idx, 4 AS pos, class4_type AS classType, class4_level AS classLevel, class4_expert AS classExpert, class4_stat AS classStat
	  FROM dbo.userClassDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND class4_type > 0

	UNION ALL

	SELECT idx, 5 AS pos, class5_type AS classType, class5_level AS classLevel, class5_expert AS classExpert, class5_stat AS classStat
	  FROM dbo.userClassDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND class5_type > 0

	UNION ALL

	SELECT idx, 6 AS pos, class6_type AS classType, class6_level AS classLevel, class6_expert AS classExpert, class6_stat AS classStat
	  FROM dbo.userClassDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND class6_type > 0

	UNION ALL

	SELECT idx, 7 AS pos, class7_type AS classType, class7_level AS classLevel, class7_expert AS classExpert, class7_stat AS classStat
	  FROM dbo.userClassDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND class7_type > 0

	UNION ALL

	SELECT idx, 8 AS pos, class8_type AS classType, class8_level AS classLevel, class8_expert AS classExpert, class8_stat AS classStat
	  FROM dbo.userClassDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND class8_type > 0

	UNION ALL

	SELECT idx, 9 AS pos, class9_type AS classType, class9_level AS classLevel, class9_expert AS classExpert, class9_stat AS classStat
	  FROM dbo.userClassDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND class9_type > 0

	UNION ALL

	SELECT idx, 10 AS pos, class10_type AS classType, class10_level AS classLevel, class10_expert AS classExpert, class10_stat AS classStat
	  FROM dbo.userClassDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND class10_type > 0
  ) AS classEXP
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_GET_DECOINFO]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_GET_DECOINFO]

	@ACCOUNTIDX  INT    

AS     

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT idx, accountIDX,
       item1_type, item1_code, item2_type, item2_code, item3_type, item3_code, item4_type, item4_code, item5_type, item5_code,
	   item6_type, item6_code, item7_type, item7_code, item8_type, item8_code, item9_type, item9_code, item10_type, item10_code,
	   item11_type, item11_code, item12_type, item12_code, item13_type, item13_code, item14_type, item14_code, item15_type, item15_code,
	   item16_type, item16_code, item17_type, item17_code, item18_type, item18_code, item19_type, item19_code, item20_type, item20_code
  FROM dbo.userItemDB WITH (NOLOCK)
 WHERE accountIDX = @ACCOUNTIDX
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_GET_FRIEND_LIST]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_GET_FRIEND_LIST]

	@ACCOUNT_IDX		INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT ME.userID, ME.nickName, GA.userLevel, GU.guildName, GI.guildPosition, GI.guildJoinType, FR.regDate, FR.friendAccIDX
  FROM dbo.userFriendDB FR WITH (NOLOCK)
  JOIN dbo.userMemberDB ME WITH (NOLOCK)
	ON FR.friendAccIDX = ME.accountIDX
  JOIN dbo.userGameDB GA WITH (NOLOCK)
	ON FR.friendAccIDX = GA.accountIDX
  LEFT JOIN dbo.userGuildInfoDB GI WITH (NOLOCK)
    ON FR.friendAccIDX = GI.accountIDX
  LEFT JOIN dbo.userGuildDB GU WITH (NOLOCK)
    ON GI.guildIDX = GU.idx
 WHERE FR.userAccIDX = @ACCOUNT_IDX
   AND FR.flag=1
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_GET_GAMEINFO]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_GET_GAMEINFO]

	@ACCOUNT_IDX		INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT userState, userLevel, userEXP, gameMoney,
	   userFishingLevel, userFishingEXP, userExcavationLevel, userExcavationEXP, userHerocEXP, userHerosEXP,
	   rencpoint, renspoint, regionType, connDate
  FROM dbo.userGameDB WITH (NOLOCK)
 WHERE accountIDX = @ACCOUNT_IDX
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_GET_GEARINFO]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_GET_GEARINFO]

	@ACCOUNT_IDX  INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT idx, pos, itemType, itemReinForce, itemSlotindex, itemTradeType, itemMCustom, itemFCustom, itemFailEXP, itemLimitType, itemLimitDate
  FROM (
	SELECT idx, 1 AS pos, item1_type AS itemType, item1_reinforce AS itemReinForce, item1_slotindex AS itemSlotindex, item1_tradetype AS itemTradeType, item1_mcustom AS itemMCustom, item1_fcustom AS itemFCustom, item1_failexp AS itemFailEXP, item1_limitType AS itemLimitType, item1_limitDate AS itemLimitDate
	  FROM dbo.userItemExtraDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item1_type > 0

	UNION ALL

	SELECT idx, 2 AS pos, item2_type AS itemType, item2_reinforce AS itemReinForce, item2_slotindex AS itemSlotindex, item2_tradetype AS itemTradeType, item2_mcustom AS itemMCustom, item2_fcustom AS itemFCustom, item2_failexp AS itemFailEXP, item2_limitType AS itemLimitType, item2_limitDate AS itemLimitDate
	  FROM dbo.userItemExtraDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item2_type > 0

	UNION ALL
	
	SELECT idx, 3 AS pos, item3_type AS itemType, item3_reinforce AS itemReinForce, item3_slotindex AS itemSlotindex, item3_tradetype AS itemTradeType, item3_mcustom AS itemMCustom, item3_fcustom AS itemFCustom, item3_failexp AS itemFailEXP, item3_limitType AS itemLimitType, item3_limitDate AS itemLimitDate
	  FROM dbo.userItemExtraDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item3_type > 0

	UNION ALL
	
	SELECT idx, 4 AS pos, item4_type AS itemType, item4_reinforce AS itemReinForce, item4_slotindex AS itemSlotindex, item4_tradetype AS itemTradeType, item4_mcustom AS itemMCustom, item4_fcustom AS itemFCustom, item4_failexp AS itemFailEXP, item4_limitType AS itemLimitType, item4_limitDate AS itemLimitDate
	  FROM dbo.userItemExtraDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item4_type > 0

	UNION ALL
	
	SELECT idx, 5 AS pos, item5_type AS itemType, item5_reinforce AS itemReinForce, item5_slotindex AS itemSlotindex, item5_tradetype AS itemTradeType, item5_mcustom AS itemMCustom, item5_fcustom AS itemFCustom, item5_failexp AS itemFailEXP, item5_limitType AS itemLimitType, item5_limitDate AS itemLimitDate
	  FROM dbo.userItemExtraDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item5_type > 0

	UNION ALL
	
	SELECT idx, 6 AS pos, item6_type AS itemType, item6_reinforce AS itemReinForce, item6_slotindex AS itemSlotindex, item6_tradetype AS itemTradeType, item6_mcustom AS itemMCustom, item6_fcustom AS itemFCustom, item6_failexp AS itemFailEXP, item6_limitType AS itemLimitType, item6_limitDate AS itemLimitDate
	  FROM dbo.userItemExtraDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item6_type > 0

	UNION ALL
	
	SELECT idx, 7 AS pos, item7_type AS itemType, item7_reinforce AS itemReinForce, item7_slotindex AS itemSlotindex, item7_tradetype AS itemTradeType, item7_mcustom AS itemMCustom, item7_fcustom AS itemFCustom, item7_failexp AS itemFailEXP, item7_limitType AS itemLimitType, item7_limitDate AS itemLimitDate
	  FROM dbo.userItemExtraDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item7_type > 0

	UNION ALL
	
	SELECT idx, 8 AS pos, item8_type AS itemType, item8_reinforce AS itemReinForce, item8_slotindex AS itemSlotindex, item8_tradetype AS itemTradeType, item8_mcustom AS itemMCustom, item8_fcustom AS itemFCustom, item8_failexp AS itemFailEXP, item8_limitType AS itemLimitType, item8_limitDate AS itemLimitDate
	  FROM dbo.userItemExtraDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item8_type > 0

	UNION ALL
	
	SELECT idx, 9 AS pos, item9_type AS itemType, item9_reinforce AS itemReinForce, item9_slotindex AS itemSlotindex, item9_tradetype AS itemTradeType, item9_mcustom AS itemMCustom, item9_fcustom AS itemFCustom, item9_failexp AS itemFailEXP, item9_limitType AS itemLimitType, item9_limitDate AS itemLimitDate
	  FROM dbo.userItemExtraDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item9_type > 0

	UNION ALL
	
	SELECT idx, 10 AS pos, item10_type AS itemType, item10_reinforce AS itemReinForce, item10_slotindex AS itemSlotindex, item10_tradetype AS itemTradeType, item10_mcustom AS itemMCustom, item10_fcustom AS itemFCustom, item10_failexp AS itemFailEXP, item10_limitType AS itemLimitType, item10_limitDate AS itemLimitDate
	  FROM dbo.userItemExtraDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item10_type > 0
  ) AS GearItem
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_GET_GIFTINFO]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_GET_GIFTINFO]

	@ACCOUNT_IDX  INT    

AS     

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT idx, sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate
  FROM dbo.userPresentDB WITH (NOLOCK)
 WHERE receiveIDX = @ACCOUNT_IDX
   AND flag < 2
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_GET_GUILDINFO]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_GET_GUILDINFO]

	@ACCOUNT_IDX		INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT GD.idx, GD.guildName, GD.guildLevel, GD.point, GD.todaypoint, GD.aboutguild, GD.guildmark, GD.maxcount, GD.membercount, GD.regDate,
       GI.guildPosition, GI.guildJoinType
  FROM dbo.userGuildInfoDB GI WITH (NOLOCK)
  JOIN dbo.userGuildDB GD WITH (NOLOCK)
    ON GI.guildIDX = GD.idx
 WHERE GI.accountIDX = @ACCOUNT_IDX
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_GET_MEDALINFO]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_GET_MEDALINFO]

	@ACCOUNT_IDX  INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT idx, pos, itemType, itemClass, itemLimitType, itemLimitDate
  FROM (
	SELECT idx, 1 AS pos, item1_type AS itemType, item1_class AS itemClass, item1_limitType AS itemLimitType, item1_limitDate AS itemLimitDate
	  FROM dbo.userItemMedalDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item1_type > 0

	UNION ALL

	SELECT idx, 2 AS pos, item2_type AS itemType, item2_class AS itemClass, item2_limitType AS itemLimitType, item2_limitDate AS itemLimitDate
	  FROM dbo.userItemMedalDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item2_type > 0

	UNION ALL
	
	SELECT idx, 3 AS pos, item3_type AS itemType, item3_class AS itemClass, item3_limitType AS itemLimitType, item3_limitDate AS itemLimitDate
	  FROM dbo.userItemMedalDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item3_type > 0

	UNION ALL
	
	SELECT idx, 4 AS pos, item4_type AS itemType, item4_class AS itemClass, item4_limitType AS itemLimitType, item4_limitDate AS itemLimitDate
	  FROM dbo.userItemMedalDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item4_type > 0

	UNION ALL
	
	SELECT idx, 5 AS pos, item5_type AS itemType, item5_class AS itemClass, item5_limitType AS itemLimitType, item5_limitDate AS itemLimitDate
	  FROM dbo.userItemMedalDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item5_type > 0

	UNION ALL
	
	SELECT idx, 6 AS pos, item6_type AS itemType, item6_class AS itemClass, item6_limitType AS itemLimitType, item6_limitDate AS itemLimitDate
	  FROM dbo.userItemMedalDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item6_type > 0

	UNION ALL
	
	SELECT idx, 7 AS pos, item7_type AS itemType, item7_class AS itemClass, item7_limitType AS itemLimitType, item7_limitDate AS itemLimitDate
	  FROM dbo.userItemMedalDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item7_type > 0

	UNION ALL
	
	SELECT idx, 8 AS pos, item8_type AS itemType, item8_class AS itemClass, item8_limitType AS itemLimitType, item8_limitDate AS itemLimitDate
	  FROM dbo.userItemMedalDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item8_type > 0

	UNION ALL
	
	SELECT idx, 9 AS pos, item9_type AS itemType, item9_class AS itemClass, item9_limitType AS itemLimitType, item9_limitDate AS itemLimitDate
	  FROM dbo.userItemMedalDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item9_type > 0

	UNION ALL
	
	SELECT idx, 10 AS pos, item10_type AS itemType, item10_class AS itemClass, item10_limitType AS itemLimitType, item10_limitDate AS itemLimitDate
	  FROM dbo.userItemMedalDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item10_type > 0
  ) AS MedalItem
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_GET_PETINFO]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_GET_PETINFO]

	@ACCOUNTIDX  INT    

AS     

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT petIDX, petCode, petRank, petLevel, petExp, petEquip, petStatus, regDate
  FROM dbo.userPetDB WITH (NOLOCK)
 WHERE accountIDX = @ACCOUNTIDX
   AND petStatus = 1
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_GET_PIECEINFO]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_GET_PIECEINFO]

	@ACCOUNT_IDX  INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT idx, pos, pieceType, pieceCnt
  FROM (
	SELECT idx, 1 AS pos, piece1_type AS pieceType, piece1_cnt AS pieceCnt
	  FROM dbo.userPieceDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND piece1_type > 0

	UNION ALL

	SELECT idx, 2 AS pos, piece2_type AS pieceType, piece2_cnt AS pieceCnt
	  FROM dbo.userPieceDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND piece2_type > 0

	UNION ALL
	
	SELECT idx, 3 AS pos, piece3_type AS pieceType, piece3_cnt AS pieceCnt
	  FROM dbo.userPieceDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND piece3_type > 0

	UNION ALL
	
	SELECT idx, 4 AS pos, piece4_type AS pieceType, piece4_cnt AS pieceCnt
	  FROM dbo.userPieceDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND piece4_type > 0

	UNION ALL
	
	SELECT idx, 5 AS pos, piece5_type AS pieceType, piece5_cnt AS pieceCnt
	  FROM dbo.userPieceDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND piece5_type > 0

	UNION ALL
	
	SELECT idx, 6 AS pos, piece6_type AS pieceType, piece6_cnt AS pieceCnt
	  FROM dbo.userPieceDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND piece6_type > 0

	UNION ALL
	
	SELECT idx, 7 AS pos, piece7_type AS pieceType, piece7_cnt AS pieceCnt
	  FROM dbo.userPieceDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND piece7_type > 0

	UNION ALL
	
	SELECT idx, 8 AS pos, piece8_type AS pieceType, piece8_cnt AS pieceCnt
	  FROM dbo.userPieceDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND piece8_type > 0

	UNION ALL
	
	SELECT idx, 9 AS pos, piece9_type AS pieceType, piece9_cnt AS pieceCnt
	  FROM dbo.userPieceDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND piece9_type > 0

	UNION ALL
	
	SELECT idx, 10 AS pos, piece10_type AS pieceType, piece10_cnt AS pieceCnt
	  FROM dbo.userPieceDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND piece10_type > 0
  ) AS PieceItem
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_GET_QUESTINFO]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_GET_QUESTINFO]

	@ACCOUNT_IDX		INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT idx, questType, questTime
  FROM (
	SELECT *
	  FROM dbo.userQuestCompleteDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
  ) AS Quest
UNPIVOT (questType FOR qtype IN (quest1_type, quest2_type, quest3_type, quest4_type, quest5_type, quest6_type, quest7_type, quest8_type, quest9_type, quest10_type, quest11_type, quest12_type, quest13_type, quest14_type, quest15_type, quest16_type, quest17_type, quest18_type, quest19_type, quest20_type)
) AS UNP1
UNPIVOT (questTime FOR qtime IN (quest1_time, quest2_time, quest3_time, quest4_time, quest5_time, quest6_time, quest7_time, quest8_time, quest9_time, quest10_time, quest11_time, quest12_time, quest13_time, quest14_time, quest15_time, quest16_time, quest17_time, quest18_time, quest19_time, quest20_time)
) AS UNP2
 WHERE SUBSTRING(qtype, 6, 2) = SUBSTRING(qtime, 6, 2)
   AND questType != 0
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_GET_QUESTINGINFO]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_GET_QUESTINGINFO]

	@ACCOUNT_IDX		INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT idx, questType, questValue1, questValue2, questTime
  FROM (
	SELECT *
	  FROM dbo.userQuestDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
  ) AS Quest
UNPIVOT (questType FOR qtype IN (quest1_type, quest2_type, quest3_type, quest4_type, quest5_type, quest6_type, quest7_type, quest8_type, quest9_type, quest10_type, quest11_type, quest12_type, quest13_type, quest14_type, quest15_type, quest16_type, quest17_type, quest18_type, quest19_type, quest20_type)
) AS UNP1
UNPIVOT (questValue1 FOR qvalue1 IN (quest1_value1, quest2_value1, quest3_value1, quest4_value1, quest5_value1, quest6_value1, quest7_value1, quest8_value1, quest9_value1, quest10_value1, quest11_value1, quest12_value1, quest13_value1, quest14_value1, quest15_value1, quest16_value1, quest17_value1, quest18_value1, quest19_value1, quest20_value1)
) AS UNP2
UNPIVOT (questValue2 FOR qvalue2 IN (quest1_value2, quest2_value2, quest3_value2, quest4_value2, quest5_value2, quest6_value2, quest7_value2, quest8_value2, quest9_value2, quest10_value2, quest11_value2, quest12_value2, quest13_value2, quest14_value2, quest15_value2, quest16_value2, quest17_value2, quest18_value2, quest19_value2, quest20_value2)
) AS UNP3
UNPIVOT (questTime FOR qtime IN (quest1_time, quest2_time, quest3_time, quest4_time, quest5_time, quest6_time, quest7_time, quest8_time, quest9_time, quest10_time, quest11_time, quest12_time, quest13_time, quest14_time, quest15_time, quest16_time, quest17_time, quest18_time, quest19_time, quest20_time)
) AS UNP4
 WHERE SUBSTRING(qtype, 6, 2) = SUBSTRING(qvalue1, 6, 2)
   AND SUBSTRING(qtype, 6, 2) = SUBSTRING(qvalue2, 6, 2)
   AND SUBSTRING(qtype, 6, 2) = SUBSTRING(qtime, 6, 2)
   AND questType != 0
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_GET_SPECIALINFO]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_GET_SPECIALINFO]

	@ACCOUNT_IDX  INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT idx, pos, itemType, itemValue1, itemValue2
  FROM (
	SELECT idx, 1 AS pos, item1_type AS itemType, item1_value1 AS itemValue1, item1_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item1_type > 0

	UNION ALL

	SELECT idx, 2 AS pos, item2_type AS itemType, item2_value1 AS itemValue1, item2_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item2_type > 0

	UNION ALL

	SELECT idx, 3 AS pos, item3_type AS itemType, item3_value1 AS itemValue1, item3_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item3_type > 0

	UNION ALL

	SELECT idx, 4 AS pos, item4_type AS itemType, item4_value1 AS itemValue1, item4_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item4_type > 0

	UNION ALL
	
	SELECT idx, 5 AS pos, item5_type AS itemType, item5_value1 AS itemValue1, item5_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item5_type > 0

	UNION ALL
	
	SELECT idx, 6 AS pos, item6_type AS itemType, item6_value1 AS itemValue1, item6_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item6_type > 0

	UNION ALL
	
	SELECT idx, 7 AS pos, item7_type AS itemType, item7_value1 AS itemValue1, item7_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item7_type > 0

	UNION ALL
	
	SELECT idx, 8 AS pos, item8_type AS itemType, item8_value1 AS itemValue1, item8_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item8_type > 0

	UNION ALL
	
	SELECT idx, 9 AS pos, item9_type AS itemType, item9_value1 AS itemValue1, item9_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item9_type > 0

	UNION ALL
	
	SELECT idx, 10 AS pos, item10_type AS itemType, item10_value1 AS itemValue1, item10_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item10_type > 0

	UNION ALL
	
	SELECT idx, 11 AS pos, item11_type AS itemType, item11_value1 AS itemValue1, item11_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item11_type > 0

	UNION ALL
	
	SELECT idx, 12 AS pos, item12_type AS itemType, item12_value1 AS itemValue1, item12_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item12_type > 0

	UNION ALL
	
	SELECT idx, 13 AS pos, item13_type AS itemType, item13_value1 AS itemValue1, item13_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item13_type > 0

	UNION ALL
	
	SELECT idx, 14 AS pos, item14_type AS itemType, item14_value1 AS itemValue1, item14_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item14_type > 0

	UNION ALL
	
	SELECT idx, 15 AS pos, item15_type AS itemType, item15_value1 AS itemValue1, item15_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item15_type > 0

	UNION ALL
	
	SELECT idx, 16 AS pos, item16_type AS itemType, item16_value1 AS itemValue1, item16_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item16_type > 0

	UNION ALL
	
	SELECT idx, 17 AS pos, item17_type AS itemType, item17_value1 AS itemValue1, item17_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item17_type > 0

	UNION ALL
	
	SELECT idx, 18 AS pos, item18_type AS itemType, item18_value1 AS itemValue1, item18_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item18_type > 0

	UNION ALL
	
	SELECT idx, 19 AS pos, item19_type AS itemType, item19_value1 AS itemValue1, item19_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item19_type > 0

	UNION ALL
	
	SELECT idx, 20 AS pos, item20_type AS itemType, item20_value1 AS itemValue1, item20_value2 AS itemValue2
	  FROM dbo.userItemEtcDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND item20_type > 0

  ) AS speicalItem
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_GET_UPGRADEINFO]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_GET_UPGRADEINFO]

	@ACCOUNT_IDX  INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;


SELECT idx, pos, classType, classBasic1, classBasic2, classBasic3, classBasic4, classSkill1, classSkill2, classSkill3, classSkill4, classTimeSlot, classLimitDate
  FROM (
	SELECT idx, 1 AS pos, class1_type AS classType, class1_basic01 AS classBasic1, class1_basic02 AS classBasic2, class1_basic03 AS classBasic3, class1_basic04 AS classBasic4, class1_skill1_sd AS classSkill1, class1_skill1_asd AS classSkill2, class1_skill1_ad AS classSkill3, class1_skill1_as AS classSkill4, class1_timeslot AS classTimeSlot, class1_limitdate AS classLimitDate
	  FROM dbo.userAbilityDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND class1_type > 0

	UNION ALL

	SELECT idx, 2 AS pos, class2_type AS classType, class2_basic01 AS classBasic1, class2_basic02 AS classBasic2, class2_basic03 AS classBasic3, class2_basic04 AS classBasic4, class2_skill1_sd AS classSkill1, class2_skill1_asd AS classSkill2, class2_skill1_ad AS classSkill3, class2_skill1_as AS classSkill4, class2_timeslot AS classTimeSlot, class2_limitdate AS classLimitDate
	  FROM dbo.userAbilityDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND class2_type > 0

	UNION ALL
	
	SELECT idx, 3 AS pos, class3_type AS classType, class3_basic01 AS classBasic1, class3_basic02 AS classBasic2, class3_basic03 AS classBasic3, class3_basic04 AS classBasic4, class3_skill1_sd AS classSkill1, class3_skill1_asd AS classSkill2, class3_skill1_ad AS classSkill3, class3_skill1_as AS classSkill4, class3_timeslot AS classTimeSlot, class3_limitdate AS classLimitDate
	  FROM dbo.userAbilityDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND class3_type > 0

	UNION ALL

	SELECT idx, 4 AS pos, class4_type AS classType, class4_basic01 AS classBasic1, class4_basic02 AS classBasic2, class4_basic03 AS classBasic3, class4_basic04 AS classBasic4, class4_skill1_sd AS classSkill1, class4_skill1_asd AS classSkill2, class4_skill1_ad AS classSkill3, class4_skill1_as AS classSkill4, class4_timeslot AS classTimeSlot, class4_limitdate AS classLimitDate
	  FROM dbo.userAbilityDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND class4_type > 0

	UNION ALL

	SELECT idx, 5 AS pos, class5_type AS classType, class5_basic01 AS classBasic1, class5_basic02 AS classBasic2, class5_basic03 AS classBasic3, class5_basic04 AS classBasic4, class5_skill1_sd AS classSkill1, class5_skill1_asd AS classSkill2, class5_skill1_ad AS classSkill3, class5_skill1_as AS classSkill4, class5_timeslot AS classTimeSlot, class5_limitdate AS classLimitDate
	  FROM dbo.userAbilityDB WITH (NOLOCK)
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND class5_type > 0
  ) AS UpgradeHero
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_GET_USERINFO]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_GET_USERINFO]

	@ACCOUNT_IDX		INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT MB.accountIDX, MB.userID, MB.nickName, MB.limitType, MB.limitDate, ISNULL(MN.realCash + MN.bonusCash, 0) AS Cash, MB.regDate, ISNULL(MN.realCash,0) AS realCash ,ISNULL(MN.bonusCash,0) AS bonusCash
  FROM dbo.userMemberDB MB WITH (NOLOCK)
  LEFT JOIN dbo.userMoneyDB MN WITH (NOLOCK)
    ON MB.accountIDX=MN.accountIDX
 WHERE MB.accountIDX = @ACCOUNT_IDX
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_SET_CASH]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_SET_CASH]

	@ACCOUNT_IDX		INT,
	@REAL_CASH			INT,
	@BONUS_CASH			INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn INT
SET @nReturn = 0


IF (NOT EXISTS(SELECT * FROM dbo.userMoneyDB WITH (NOLOCK) WHERE accountIDX = @ACCOUNT_IDX))
BEGIN
	RETURN 1001;
END

BEGIN TRAN

	UPDATE dbo.userMoneyDB WITH (ROWLOCK, XLOCK)
	   SET realCash = realCash + @REAL_CASH,
	       bonusCash = bonusCash + @BONUS_CASH
	 WHERE accountIDX = @ACCOUNT_IDX

	IF (@@ROWCOUNT=0) or (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1002;
	END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_SET_FISHING_LEVEL]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_SET_FISHING_LEVEL]

	@ACCOUNT_IDX		INT,
	@USER_LEVEL			INT,
	@USER_EXP			INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn INT
SET @nReturn = 0


IF (NOT EXISTS(SELECT * FROM dbo.userGameDB WITH (NOLOCK) WHERE accountIDX = @ACCOUNT_IDX))
BEGIN
	RETURN 1001;
END

BEGIN TRAN

	UPDATE dbo.userGameDB WITH (ROWLOCK, XLOCK)
	   SET userFishingLevel = @USER_LEVEL,
	       userFishingEXP = @USER_EXP
	 WHERE accountIDX = @ACCOUNT_IDX

	IF (@@ROWCOUNT=0) or (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1002;
	END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_SET_LEVEL]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_SET_LEVEL]

	@ACCOUNT_IDX		INT,
	@USER_LEVEL			INT,
	@USER_EXP			INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn INT
SET @nReturn = 0


IF (NOT EXISTS(SELECT * FROM dbo.userGameDB WITH (NOLOCK) WHERE accountIDX = @ACCOUNT_IDX))
BEGIN
	RETURN 1001;
END

BEGIN TRAN

	UPDATE dbo.userGameDB WITH (ROWLOCK, XLOCK)
	   SET userLevel = @USER_LEVEL,
	       userEXP = @USER_EXP
	 WHERE accountIDX = @ACCOUNT_IDX

	IF (@@ROWCOUNT=0) or (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1002;
	END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_SET_NICKNAME]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_SET_NICKNAME]

	@ACCOUNT_IDX		INT,
	@NICK_NAME			NVARCHAR(20)

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn INT
SET @nReturn = 0


IF (EXISTS(SELECT * FROM dbo.userMemberDB WITH (NOLOCK) WHERE userID = @NICK_NAME))
BEGIN
	RETURN 1001;
END

IF (EXISTS(SELECT * FROM dbo.userMemberDB WITH (NOLOCK) WHERE nickName = @NICK_NAME))
BEGIN
	RETURN 1002;
END

BEGIN TRAN

	UPDATE dbo.userMemberDB WITH (ROWLOCK, XLOCK)
	   SET nickName = @NICK_NAME
	 WHERE accountIDX = @ACCOUNT_IDX

	IF (@@ROWCOUNT=0) or (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1003;
	END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_SET_PESO]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_SET_PESO]

	@ACCOUNT_IDX		INT,
	@USER_PESO			INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn INT
SET @nReturn = 0


IF (NOT EXISTS(SELECT * FROM dbo.userGameDB WITH (NOLOCK) WHERE accountIDX = @ACCOUNT_IDX))
BEGIN
	RETURN 1001;
END

BEGIN TRAN

	UPDATE dbo.userGameDB WITH (ROWLOCK, XLOCK)
	   SET gameMoney = @USER_PESO
	 WHERE accountIDX = @ACCOUNT_IDX

	IF (@@ROWCOUNT=0) or (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1002;
	END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_SET_RELIC_LEVEL]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_SET_RELIC_LEVEL]

	@ACCOUNT_IDX		INT,
	@USER_LEVEL			INT,
	@USER_EXP			INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn INT
SET @nReturn = 0


IF (NOT EXISTS(SELECT * FROM dbo.userGameDB WITH (NOLOCK) WHERE accountIDX = @ACCOUNT_IDX))
BEGIN
	RETURN 1001;
END

BEGIN TRAN

	UPDATE dbo.userGameDB WITH (ROWLOCK, XLOCK)
	   SET userExcavationLevel = @USER_LEVEL,
	       userExcavationEXP = @USER_EXP
	 WHERE accountIDX = @ACCOUNT_IDX

	IF (@@ROWCOUNT=0) or (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1002;
	END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_MEMBER_SET_RESTRICTION]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_MEMBER_SET_RESTRICTION]

	@ACCOUNT_IDX	INT,
	@LIMIT_TYPE		TINYINT,
	@LIMIT_DATE		DATETIME,
	@NOTE			NVARCHAR(500),
	@USER_IP		VARCHAR(15),
	@TABLE_IDX		INT				OUTPUT

AS

	SET NOCOUNT ON;
	SET LOCK_TIMEOUT 10000;

	DECLARE @nReturn			INT
	DECLARE @nDiff				INT

	SET @nReturn = 0		-- true
	SET @nDiff = DATEDIFF(hh, GETDATE(), @LIMIT_DATE)

	IF (NOT EXISTS(SELECT * FROM dbo.userMemberDB WITH (NOLOCK) WHERE accountIDX = @ACCOUNT_IDX))
	BEGIN
		RETURN 1001;
	END

	BEGIN TRAN

		IF (@nDiff > 0)
		BEGIN
			UPDATE dbo.userMemberDB
			   SET limitType = @LIMIT_TYPE,
				   limitDate = @LIMIT_DATE
			 WHERE accountIDX = @ACCOUNT_IDX
		END
		ELSE
		BEGIN
			UPDATE dbo.userMemberDB
			   SET limitDate = GETDATE() - 1
			 WHERE accountIDX = @ACCOUNT_IDX
		END

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN;
			RETURN 1002;
		END 

		INSERT INTO LosaGame_log.dbo.log_user_block (
			accountIDX, limitType, limitDate, reason, userIP, regDate
		)
		VALUES (
			@ACCOUNT_IDX, @LIMIT_TYPE, @LIMIT_DATE, @NOTE, @USER_IP, GETDATE()
		)

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN;
			RETURN 1002;
		END 

		SET @TABLE_IDX = SCOPE_IDENTITY()

	COMMIT TRAN

	RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_PET_GET_DELETE]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_PET_GET_DELETE]

	@TABLE_IDX			INT,
	@ACCOUNT_IDX		INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn INT
SET @nReturn = 0

BEGIN TRAN

	UPDATE dbo.userPetDB
	   SET petStatus = 0
	 WHERE accountIDX = @ACCOUNT_IDX
	   AND petIDX = @TABLE_IDX

	IF (@@ROWCOUNT=0 OR @@ERROR <> 0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1001;
	END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_PIECE_SET_DELETE]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_PIECE_SET_DELETE]

	@TABLE_IDX			INT,
	@ACCOUNT_IDX		INT,
	@COLUMN_NO			TINYINT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn INT
SET @nReturn = 0

BEGIN TRAN

	IF (@COLUMN_NO = 1)
	BEGIN
		UPDATE dbo.userPieceDB
		   SET piece1_type = 0,
		       piece1_cnt = 0
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 2)
	BEGIN
		UPDATE dbo.userPieceDB
		   SET piece2_type = 0,
		       piece2_cnt = 0
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 3)
	BEGIN
		UPDATE dbo.userPieceDB
		   SET piece3_type = 0,
		       piece3_cnt = 0
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 4)
	BEGIN
		UPDATE dbo.userPieceDB
		   SET piece4_type = 0,
		       piece4_cnt = 0
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 5)
	BEGIN
		UPDATE dbo.userPieceDB
		   SET piece5_type = 0,
		       piece5_cnt = 0
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 6)
	BEGIN
		UPDATE dbo.userPieceDB
		   SET piece6_type = 0,
		       piece6_cnt = 0
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 7)
	BEGIN
		UPDATE dbo.userPieceDB
		   SET piece7_type = 0,
		       piece7_cnt = 0
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 8)
	BEGIN
		UPDATE dbo.userPieceDB
		   SET piece8_type = 0,
		       piece8_cnt = 0
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 9)
	BEGIN
		UPDATE dbo.userPieceDB
		   SET piece9_type = 0,
		       piece9_cnt = 0
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 10)
	BEGIN
		UPDATE dbo.userPieceDB
		   SET piece10_type = 0,
		       piece10_cnt = 0
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE
	BEGIN
		ROLLBACK TRAN
		RETURN 1002;
	END

	IF (@@ROWCOUNT=0 OR @@ERROR <> 0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1001;
	END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_RESTRICTION_GET_LIST]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_RESTRICTION_GET_LIST]

	@ACCOUNT_IDX	INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

SELECT idx, limitType, limitDate, reason, userIP, regDate
  FROM LosaGame_log.dbo.log_user_block WITH (NOLOCK)
 WHERE accountIDX = @ACCOUNT_IDX
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_SPECIAL_ITEM_SET_DATA]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_SPECIAL_ITEM_SET_DATA]

	@TABLE_IDX			INT,
	@ACCOUNT_IDX		INT,
	@COLUMN_NO			TINYINT,
	@ITEM_CODE			INT,
	@ITEM_VALUE1		INT,
	@ITEM_VALUE2		INT

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn INT
SET @nReturn = 0

BEGIN TRAN

	IF (@COLUMN_NO = 1)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item1_type = @ITEM_CODE,
		       item1_value1 = @ITEM_VALUE1,
		       item1_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 2)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item2_type = @ITEM_CODE,
		       item2_value1 = @ITEM_VALUE1,
		       item2_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 3)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item3_type = @ITEM_CODE,
		       item3_value1 = @ITEM_VALUE1,
		       item3_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 4)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item4_type = @ITEM_CODE,
		       item4_value1 = @ITEM_VALUE1,
		       item4_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 5)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item5_type = @ITEM_CODE,
		       item5_value1 = @ITEM_VALUE1,
		       item5_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 6)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item6_type = @ITEM_CODE,
		       item6_value1 = @ITEM_VALUE1,
		       item6_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 7)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item7_type = @ITEM_CODE,
		       item7_value1 = @ITEM_VALUE1,
		       item7_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 8)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item8_type = @ITEM_CODE,
		       item8_value1 = @ITEM_VALUE1,
		       item8_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 9)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item9_type = @ITEM_CODE,
		       item9_value1 = @ITEM_VALUE1,
		       item9_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 10)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item10_type = @ITEM_CODE,
		       item10_value1 = @ITEM_VALUE1,
		       item10_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 11)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item11_type = @ITEM_CODE,
		       item11_value1 = @ITEM_VALUE1,
		       item11_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 12)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item12_type = @ITEM_CODE,
		       item12_value1 = @ITEM_VALUE1,
		       item12_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 13)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item13_type = @ITEM_CODE,
		       item13_value1 = @ITEM_VALUE1,
		       item13_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 14)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item14_type = @ITEM_CODE,
		       item14_value1 = @ITEM_VALUE1,
		       item14_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 15)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item15_type = @ITEM_CODE,
		       item15_value1 = @ITEM_VALUE1,
		       item15_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 16)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item16_type = @ITEM_CODE,
		       item16_value1 = @ITEM_VALUE1,
		       item16_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 17)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item17_type = @ITEM_CODE,
		       item17_value1 = @ITEM_VALUE1,
		       item17_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 18)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item18_type = @ITEM_CODE,
		       item18_value1 = @ITEM_VALUE1,
		       item18_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 19)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item19_type = @ITEM_CODE,
		       item19_value1 = @ITEM_VALUE1,
		       item19_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 20)
	BEGIN
		UPDATE dbo.userItemEtcDB
		   SET item20_type = @ITEM_CODE,
		       item20_value1 = @ITEM_VALUE1,
		       item20_value2 = @ITEM_VALUE2
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE
	BEGIN
		ROLLBACK TRAN
		RETURN 1002;
	END

	IF (@@ROWCOUNT=0 OR @@ERROR <> 0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1001;
	END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_ADM_UPDRADE_SET_STAT]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_ADM_UPDRADE_SET_STAT]

	@TABLE_IDX			INT,
	@ACCOUNT_IDX		INT,
	@COLUMN_NO			TINYINT,
	@CLASS_BASIC1		TINYINT,		-- 공격력
	@CLASS_BASIC2		TINYINT,		-- 방어력
	@CLASS_BASIC3		TINYINT,		-- 이동속도
	@CLASS_BASIC4		TINYINT,		-- 드랍피해감소
	@CLASS_SKILL1		TINYINT,		-- 무기스킬
	@CLASS_SKILL2		TINYINT,		-- 갑옷스킬
	@CLASS_SKILL3		TINYINT,		-- 투구스킬
	@CLASS_SKILL4		TINYINT			-- 망토스킬

AS

SET NOCOUNT ON;
SET LOCK_TIMEOUT 10000;

DECLARE @nReturn INT
SET @nReturn = 0

BEGIN TRAN

	IF (@COLUMN_NO = 1)
	BEGIN
		UPDATE dbo.userAbilityDB
		   SET class1_basic01 = @CLASS_BASIC1,
			   class1_basic02 = @CLASS_BASIC2,
			   class1_basic03 = @CLASS_BASIC3,
			   class1_basic04 = @CLASS_BASIC4,
			   class1_skill1_sd = @CLASS_SKILL1,
			   class1_skill1_asd = @CLASS_SKILL2,
			   class1_skill1_ad = @CLASS_SKILL3,
			   class1_skill1_as = @CLASS_SKILL4
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 2)
	BEGIN
		UPDATE dbo.userAbilityDB
		   SET class2_basic01 = @CLASS_BASIC1,
			   class2_basic02 = @CLASS_BASIC2,
			   class2_basic03 = @CLASS_BASIC3,
			   class2_basic04 = @CLASS_BASIC4,
			   class2_skill1_sd = @CLASS_SKILL1,
			   class2_skill1_asd = @CLASS_SKILL2,
			   class2_skill1_ad = @CLASS_SKILL3,
			   class2_skill1_as = @CLASS_SKILL4
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 3)
	BEGIN
		UPDATE dbo.userAbilityDB
		   SET class3_basic01 = @CLASS_BASIC1,
			   class3_basic02 = @CLASS_BASIC2,
			   class3_basic03 = @CLASS_BASIC3,
			   class3_basic04 = @CLASS_BASIC4,
			   class3_skill1_sd = @CLASS_SKILL1,
			   class3_skill1_asd = @CLASS_SKILL2,
			   class3_skill1_ad = @CLASS_SKILL3,
			   class3_skill1_as = @CLASS_SKILL4
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 4)
	BEGIN
		UPDATE dbo.userAbilityDB
		   SET class4_basic01 = @CLASS_BASIC1,
			   class4_basic02 = @CLASS_BASIC2,
			   class4_basic03 = @CLASS_BASIC3,
			   class4_basic04 = @CLASS_BASIC4,
			   class4_skill1_sd = @CLASS_SKILL1,
			   class4_skill1_asd = @CLASS_SKILL2,
			   class4_skill1_ad = @CLASS_SKILL3,
			   class4_skill1_as = @CLASS_SKILL4
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	END
	ELSE IF (@COLUMN_NO = 5)
		UPDATE dbo.userAbilityDB
		   SET class5_basic01 = @CLASS_BASIC1,
			   class5_basic02 = @CLASS_BASIC2,
			   class5_basic03 = @CLASS_BASIC3,
			   class5_basic04 = @CLASS_BASIC4,
			   class5_skill1_sd = @CLASS_SKILL1,
			   class5_skill1_asd = @CLASS_SKILL2,
			   class5_skill1_ad = @CLASS_SKILL3,
			   class5_skill1_as = @CLASS_SKILL4
		 WHERE accountIDX = @ACCOUNT_IDX
		   AND idx = @TABLE_IDX
	ELSE
	BEGIN
		ROLLBACK TRAN
		RETURN 1002;
	END

	IF (@@ROWCOUNT=0 OR @@ERROR <> 0)
	BEGIN
		ROLLBACK TRAN
		RETURN 1001;
	END

COMMIT TRAN

RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[usp_gar_gift_set_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_gar_gift_set_add]

	@SEND_USER			VARCHAR(20),
	@RECV_USER			VARCHAR(20),
	@ID_TYPE			TINYINT,		-- 1: GarenaUID, 2: nickName
	@PRESENT_TYPE		SMALLINT,
	@VALUE1				INT,
	@VALUE2				INT,
	@MSG_TYPE			SMALLINT,
	@LIMIT_DATE			DATETIME,
	@ALAM_FLAG			SMALLINT

AS     

	SET NOCOUNT ON;
	SET LOCK_TIMEOUT 10000;

	DECLARE @nReturn			INT
	DECLARE @CHECK_INDEX		INT
	DECLARE @SEND_ACCOUNT_IDX	INT
	DECLARE @RECV_ACCOUNT_IDX	INT

	SET @nReturn = 0		-- true
	SET @CHECK_INDEX = -1

	EXEC @CHECK_INDEX = dbo.usp_user_get_accountidx @SEND_USER, @ID_TYPE, @SEND_ACCOUNT_IDX OUTPUT
	IF (@CHECK_INDEX <> 0) or (@SEND_ACCOUNT_IDX = 0)
	BEGIN
		RETURN -1;
	END

	EXEC @CHECK_INDEX = dbo.usp_user_get_accountidx @RECV_USER, @ID_TYPE, @RECV_ACCOUNT_IDX OUTPUT
	IF (@CHECK_INDEX <> 0) or (@RECV_ACCOUNT_IDX = 0)
	BEGIN
		RETURN -2;
	END

	BEGIN TRAN

		INSERT INTO dbo.userPresentDB WITH (XLOCK, ROWLOCK) (
			sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate
		)
		VALUES (
			@SEND_ACCOUNT_IDX, @RECV_ACCOUNT_IDX, @PRESENT_TYPE, @VALUE1, @VALUE2, 0, 0, @MSG_TYPE, @ALAM_FLAG, @LIMIT_DATE, GETDATE()
		)

		IF (@@ROWCOUNT=0) or (@@ERROR<>0)
		BEGIN
			ROLLBACK TRAN;
			RETURN -3;
		END 

	COMMIT TRAN

	RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_GET_FRIEND_LIST]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_GET_FRIEND_LIST]
(
	@garenaUID varchar(20)
)
AS

SET NOCOUNT ON
	
	SELECT C.userID
      FROM dbo.userMemberDB C 
     WHERE accountIDX IN (  
		 SELECT a.friendAccIDX 
	       FROM dbo.userFriendDB A
	       JOIN dbo.userMemberDB B 
		     ON A.userAccIDX = B.accountIDX
	      WHERE b.userID = @garenaUID
	        AND flag = 1
		)
GO
/****** Object:  StoredProcedure [dbo].[USP_LSW_MEMBER_AWARD_ALL]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_LSW_MEMBER_AWARD_ALL]
	@ACCOUNT_IDX	INT
AS
	SET NOCOUNT ON;
	
	-- 회원 수상 순위 및 점수 전체
	SELECT awardType, prevRanking, nowRanking, point
	FROM TBL_RANKING_AWARD WITH(NOLOCK)
	WHERE accountIDX = @ACCOUNT_IDX
	ORDER BY awardType
GO
/****** Object:  StoredProcedure [dbo].[USP_LTS_MEMBER_SHUTDOWNTIME]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_LTS_MEMBER_SHUTDOWNTIME]      
	@userID				varchar(20)				-- userMemberDB.userID  
	, @GmtCodeNo		int = 201125			-- Game Service Code (201125 : 로스트사가)
	, @dtLoginTime		datetime				-- CONNECT TIME  
as       
begin       
    SET NOCOUNT ON       
    --SET DATEFIRST 1  

    DECLARE @WDAY INT       
    DECLARE @WTIME INT       
    DECLARE @COMP_WDAY INT       
    DECLARE @COMP_WTIME INT       
    DECLARE @CONN_ALLOW TINYINT  -- 0:DON'T ALLOW 1: ALLOW      

	-- ASP와 DB와의 WEEKDAY 계산이 틀려 입력 파라미터 값에 -1Day를 해 준다.(리턴시에는 +1Day을 해 준다.)
	Set @dtLoginTime = DATEADD(Day, -1, @dtLoginTime)


    SET @WDAY = DATEPART(WEEKDAY, @dtLoginTime)      
    SET @WTIME = DATEPART(HOUR, @dtLoginTime)      
    SET @CONN_ALLOW = 0      
  
    if (@WTIME = 0)  
		begin  
			-- 0시인 경우 전일 24시로 처리
			set @COMP_WDAY = datepart(dw, dateadd(day, -1, @dtLoginTime))
			set @COMP_WTIME = 24  
			set @dtLoginTime = dateadd(day, -1, @dtLoginTime)          
		end  
    else 
		begin
			set @COMP_WDAY = @WDAY
			set @COMP_WTIME = @WTIME  
		end  
  
	-- check about all service  
	-- 선택적 셧다운 대상자 확인
	IF Exists (Select Top 1 CHILD_ID From TB_LTS_WEEKTIME_PARENT_CHILD_INFO with (noLock)
				Where CHILD_ID = @userID And (Agree_Type = 'Y' OR Agree_Type = 'S')
	)
		Begin
			SET @CONN_ALLOW = 1  

			if (exists (      
				SELECT       
				wday      
				, wtime       
				FROM TB_LTS_WEEKTIME       
				WHERE UserId = @Userid      
				and gmtcodeno =  201100  
				and wday = @COMP_WDAY  
				and wtime = @COMP_WTIME )      
			)      
			set @GmtCodeNo = 201100  
		  
			if (exists (      
				SELECT       
				wday      
				, wtime       
				FROM TB_LTS_WEEKTIME       
				WHERE UserId = @Userid      
				and GmtCodeNo = @GmtCodeNo   
				and wday = @COMP_WDAY  
				and wtime = @COMP_WTIME )      
			)      
				begin      

					DECLARE @ROWCNT TINYINT     
			  
					select @ROWCNT = count(*)      
					FROM TB_LTS_WEEKTIME       
					WHERE UserId = @Userid      
					and GmtCodeNo = @GmtCodeNo     
			  
					IF (@ROWCNT < 168)   -- allow a certain time 
						BEGIN 
							select top 1 CONN_ALLOW = @CONN_ALLOW
							, shutdowntime = dateadd(day, 1, dateadd(
												 hour
												,t1.wtime 
												,dateadd(day, t1.kick_day-@COMP_WDAY, convert(char(10), @dtlogintime,120))
											 ))            
							from (      
								select *      
								, sflag=case when wday = @COMP_WDAY and wtime = @COMP_WTIME  then 1 else 0 end      
								, kick_day = case       
											  when wday = @COMP_WDAY and wtime >= @COMP_WTIME then wday		-- 로그인 보다 같은 날짜이나 뒤시간이면 해당일
											  when wday > @COMP_WDAY then wday							-- 로그인 보다 날짜가 크면 해당일
											  else cast(wday as int)+7								-- 로그인 보다 요일이 앞서거나 같은 요일이나 시간이 적으면 뒤로 보냄
											  end 
								, com_nwday = case       
								when wday = @COMP_WDAY and wtime >= @COMP_WTIME then wday       
								when wday > @COMP_WDAY then wday       
								else wday+7 
								end 
								* 100+wtime      
								from TB_WEEKTIME      
							) t1       
							where com_nwday > (@WDAY*100+@WTIME)       
							and  not exists (      
								select *       
								from TB_LTS_WEEKTIME t2      
								WHERE t2.UserId = @UserId      
								and t2.GmtCodeNo = @GmtCodeNo      
								and t1.wday = t2.wday      
								and t1.wtime = t2.wtime      
							)      
							order by com_nwday      
						END    
					ELSE
						Begin
							-- 셧다운 대상자이고 모든 시간이 체크된 경우
							Select CONN_ALLOW = @CONN_ALLOW, shutdowntime = cast('2030-01-01' as datetime)
						End
				End      
			Else        
				Begin
					-- 셧다운 대상자 이나 접속 가능 시간이 아닌 경우
					Select CONN_ALLOW = @CONN_ALLOW, shutdowntime = cast('1979-01-01' as datetime)
				End
		End
	Else
		Begin
			-- 선택적 셧다운 대장자가 아닌 경우
			Select CONN_ALLOW = 0, shutdowntime = NULL
		End
End
GO
/****** Object:  StoredProcedure [dbo].[usp_Member_get_user_accountIDX]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Member_get_user_accountIDX]
	
	@USER_ID		VARCHAR(20),
	@USER_ID_TYPE	TINYINT,
	@ACCOUNT_IDX	INT			OUTPUT

AS

	SET NOCOUNT ON
	SET LOCK_TIMEOUT 15000

	SET @ACCOUNT_IDX=0

	IF (@USER_ID_TYPE=1)
	BEGIN
		
		 SET @ACCOUNT_IDX=(SELECT AccountIDX FROM dbo.userMemberDB WITH (READUNCOMMITTED) WHERE nickName=@USER_ID)

		IF (@ACCOUNT_IDX=0) or (@ACCOUNT_IDX IS NULL)
		BEGIN
			RETURN -1
		END 
	END
	ELSE 
	BEGIN
		
		SET @ACCOUNT_IDX=(SELECT AccountIDX FROM dbo.userMemberDB WITH (READUNCOMMITTED) WHERE UserID=@USER_ID)

		IF (@ACCOUNT_IDX=0) or (@ACCOUNT_IDX IS NULL)
		BEGIN
			RETURN -1
		END 
	END 

	RETURN ;
GO
/****** Object:  StoredProcedure [dbo].[usp_money_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_money_get]
	
AS

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
GO
/****** Object:  StoredProcedure [dbo].[usp_RegDate_get_init]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_RegDate_get_init]

	@REG_DATE		DATETIME,		-- GETDATE()
	@SET_HOUR		TINYINT,		-- 초기화할 시간 i.e.) 2015-01-20 05:00:00
	@INIT_DATE		DATETIME		OUTPUT
	
AS

	SET NOCOUNT ON
	SET LOCK_TIMEOUT	10000

	DECLARE @nReturn			INT	

	DECLARE @CURRENT_DATE		DATETIME
	DECLARE @PRE_DATETIME		DATETIME
	DECLARE @POST_DATETIME		DATETIME


	SET @CURRENT_DATE = CAST(CONVERT(CHAR(10),@REG_DATE, 121) as DATETIME);
	SET @PRE_DATETIME = DATEADD(hh, @SET_HOUR, @CURRENT_DATE);
	SET @POST_DATETIME = DATEADD(hh, @SET_HOUR+24, @PRE_DATETIME);

	
	IF @REG_DATE>=@PRE_DATETIME and @REG_DATE<@POST_DATETIME
	BEGIN 
		SET @INIT_DATE = @CURRENT_DATE;
	END 
	ELSE
	BEGIN
		SET @INIT_DATE = DATEADD(dd, 1, @CURRENT_DATE);
	END

	RETURN 0;
GO
/****** Object:  StoredProcedure [dbo].[USP_SEND_Migration_Fail_User]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_SEND_Migration_Fail_User]  
(  
 @accountIDX int  
,  @presentType int  
, @value1 int  
, @value2 int  
  
)  
AS  
  
SET NOCOUNT ON  
  
IF (@presentType = 5)  
SET @value2 = @value2 * 10000  
  
IF (@presentType = 1)  
SET @value2 = 0

IF (@presentType = 5)  
SET @value2 = 0

  
INSERT INTO dbo.userPresentDB ( sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate )  
 SELECT 1, @accountIDX, @presentType, @value1 ,@value2, 0, 0, 3, 1,getdate()+28, getdate()
GO
/****** Object:  StoredProcedure [dbo].[usp_user_get_accountidx]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_user_get_accountidx]

	@USER_ID		VARCHAR(20),
	@ID_TYPE		TINYINT,			-- 1: userID, 2: nickName
	@ACCOUNT_IDX	INT			OUTPUT

AS

	SET NOCOUNT ON;
	SET LOCK_TIMEOUT 10000;

	DECLARE @nReturn INT

	SET @ACCOUNT_IDX = 0
	SET @nReturn = 0

	IF (@ID_TYPE=1)
	BEGIN
		
		SELECT @ACCOUNT_IDX = AccountIDX
		  FROM dbo.userMemberDB WITH (NOLOCK)
		 WHERE userID = @USER_ID;

		IF (@ACCOUNT_IDX=0) or (@ACCOUNT_IDX IS NULL)
		BEGIN
			RETURN -1
		END 
	END
	ELSE 
	BEGIN
		
		SELECT @ACCOUNT_IDX = AccountIDX
		  FROM dbo.userMemberDB WITH (NOLOCK)
		 WHERE nickName = @USER_ID;

		IF (@ACCOUNT_IDX=0) or (@ACCOUNT_IDX IS NULL)
		BEGIN
			RETURN -1
		END 
	END 

	RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[usp_user_get_migration_count]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_user_get_migration_count]

AS

SET NOCOUNT ON
SET LOCK_TIMEOUT 10000

SELECT COUNT(*) AS CNT
  FROM dbo.TBL_migration_mapping_log WITH (NOLOCK)
GO
/****** Object:  StoredProcedure [dbo].[usp_user_get_migration_log]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_user_get_migration_log]

	@USER_ID		VARCHAR(128),	-- 검색ID
	@SEARCH_TYPE	TINYINT			-- 1: 가레나UID 검색, 2: 아시아소프트ID 검색

AS

SET NOCOUNT ON
SET LOCK_TIMEOUT 10000

IF (@SEARCH_TYPE = 1)
BEGIN
	SELECT ML.GarenaID, ML.GarenaUID, ML.AsiasoftID, UM.nickName, ML.regDate
	  FROM dbo.TBL_migration_mapping_log ML WITH (NOLOCK)
	  JOIN dbo.userMemberDB UM WITH (NOLOCK)
		ON ML.GarenaUID = UM.userID
	 WHERE ML.GarenaUID = @USER_ID
END
ELSE
BEGIN
	SELECT ML.GarenaID, ML.GarenaUID, ML.AsiasoftID, UM.nickName, ML.regDate
	  FROM dbo.TBL_migration_mapping_log ML WITH (NOLOCK)
	  JOIN dbo.userMemberDB UM WITH (NOLOCK)
		ON ML.GarenaUID = UM.userID
	 WHERE ML.AsiasoftID = @USER_ID
END
GO
/****** Object:  StoredProcedure [dbo].[usp_user_set_migration]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_user_set_migration]

	@USER_ID		VARCHAR(128),
	@GUSER_ID		VARCHAR(20),
	@GUSER_LoginID	NVARCHAR(32),
	@ACCOUNT_IDX	INT					OUTPUT

AS

	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET LOCK_TIMEOUT 10000

	DECLARE @nReturn				INT
	DECLARE @LOST_ACCOUNT_IDX		INT
	DECLARE @CONFIRM_ACCOUNT_IDX	INT
	DECLARE @CHECK_nickName			NVARCHAR(130)
	
	SET @nReturn=0
	SET @ACCOUNT_IDX=0
	SET @LOST_ACCOUNT_IDX=0       
	SET @CONFIRM_ACCOUNT_IDX=0       

	SELECT @LOST_ACCOUNT_IDX=AccountIDX, @CHECK_nickName=nickName FROM LosaGame.dbo.userMemberDB
	WHERE UserID=@USER_ID
	
	IF (@@ROWCOUNT=0)
	BEGIN
		INSERT INTO dbo.TBL_migration_error_log (AsiasoftID, GarenaUID, GarenaID, errorCode, regDate)
		VALUES (@USER_ID, @GUSER_ID, @GUSER_LoginID, -1, GETDATE())

		RETURN -1;
	END 

	IF (@@ERROR<>0)
	BEGIN
		RETURN -2;
	END 

	IF (RIGHT(@CHECK_nickName, 1) = '#')
	BEGIN
		INSERT INTO dbo.TBL_migration_error_log (AsiasoftID, GarenaUID, GarenaID, errorCode, regDate)
		VALUES (@USER_ID, @GUSER_ID, @GUSER_LoginID, -1, GETDATE())

		RETURN -1;
	END

	IF (EXISTS(SELECT * FROM dbo.TBL_migration_mapping_log WHERE GarenaUID=@GUSER_ID))
	BEGIN
		INSERT INTO dbo.TBL_migration_error_log (AsiasoftID, GarenaUID, GarenaID, errorCode, regDate)
		VALUES (@USER_ID, @GUSER_ID, @GUSER_LoginID, -3, GETDATE())

		RETURN -3;
	END

	IF (EXISTS(SELECT * FROM dbo.TBL_migration_mapping_log WHERE AsiasoftID=@USER_ID))
	BEGIN
		INSERT INTO dbo.TBL_migration_error_log (AsiasoftID, GarenaUID, GarenaID, errorCode, regDate)
		VALUES (@USER_ID, @GUSER_ID, @GUSER_LoginID, -4, GETDATE())

		RETURN -4;
	END

/*
	--Garena DB 에 데이터가 존재하는지 확인
	SELECT @CONFIRM_ACCOUNT_IDX=AccountIDX FROM dbo.userMemberDB
	WHERE UserID=@GUSER_ID
	
	IF (@CONFIRM_ACCOUNT_IDX!=0) 
	BEGIN
		RETURN -1;
	END 
*/

	BEGIN TRAN

	-- dbo.userMemberDB
	INSERT dbo.userMemberDB (userID, nickName, userPWD, email, mailling, userType, joinType, eventType, cpType, limitType, limitDate, regDate)
	SELECT @GUSER_ID, nickName, userPWD, email, mailling, userType, joinType, eventType, cpType, limitType, limitDate, regDate
	  FROM LosaGame.dbo.userMemberDB
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ROWCOUNT=0) or (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -5;
	END 

	SET @ACCOUNT_IDX=SCOPE_IDENTITY();

	-- dbo.userLoginDB
	INSERT dbo.userLoginDB ( accountIDX, encodeKey, gameServerID, userIP, connDate )
	SELECT @ACCOUNT_IDX, encodeKey, 0, userIP, connDate
	  FROM LosaGame.dbo.userLoginDB
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ROWCOUNT=0) or (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -6;
	END 
		
	-- dbo.userAbilityDB
	INSERT dbo.userAbilityDB (accountIDX, class1_type, class1_basic01, class1_basic02, class1_basic03, class1_basic04, class1_skill1_sd, class1_skill1_asd, class1_skill1_ad, class1_skill1_as, class1_timeslot, class1_limitdate, class2_type, class2_basic01, class2_basic02, class2_basic03, class2_basic04, class2_skill1_sd, class2_skill1_asd, class2_skill1_ad, class2_skill1_as, class2_timeslot, class2_limitdate, class3_type, class3_basic01, class3_basic02, class3_basic03, class3_basic04, class3_skill1_sd, class3_skill1_asd, class3_skill1_ad, class3_skill1_as, class3_timeslot, class3_limitdate, class4_type, class4_basic01, class4_basic02, class4_basic03, class4_basic04, class4_skill1_sd, class4_skill1_asd, class4_skill1_ad, class4_skill1_as, class4_timeslot, class4_limitdate, class5_type, class5_basic01, class5_basic02, class5_basic03, class5_basic04, class5_skill1_sd, class5_skill1_asd, class5_skill1_ad, class5_skill1_as, class5_timeslot, class5_limitdate, regDate)
	SELECT @ACCOUNT_IDX, class1_type, class1_basic01, class1_basic02, class1_basic03, class1_basic04, class1_skill1_sd, class1_skill1_asd, class1_skill1_ad, class1_skill1_as, class1_timeslot, class1_limitdate, class2_type, class2_basic01, class2_basic02, class2_basic03, class2_basic04, class2_skill1_sd, class2_skill1_asd, class2_skill1_ad, class2_skill1_as, class2_timeslot, class2_limitdate, class3_type, class3_basic01, class3_basic02, class3_basic03, class3_basic04, class3_skill1_sd, class3_skill1_asd, class3_skill1_ad, class3_skill1_as, class3_timeslot, class3_limitdate, class4_type, class4_basic01, class4_basic02, class4_basic03, class4_basic04, class4_skill1_sd, class4_skill1_asd, class4_skill1_ad, class4_skill1_as, class4_timeslot, class4_limitdate, class5_type, class5_basic01, class5_basic02, class5_basic03, class5_basic04, class5_skill1_sd, class5_skill1_asd, class5_skill1_ad, class5_skill1_as, class5_timeslot, class5_limitdate, regDate
	FROM LosaGame.dbo.userAbilityDB
	WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -7;
	END 

	-- dbo.userAwardDB
	INSERT dbo.userAwardDB (accountIDX, award1_type, award1_number, award1_point, award2_type, award2_number, award2_point, award3_type, award3_number, award3_point, award4_type, award4_number, award4_point, award5_type, award5_number, award5_point, award6_type, award6_number, award6_point, award7_type, award7_number, award7_point, award8_type, award8_number, award8_point, award9_type, award9_number, award9_point, award10_type, award10_number, award10_point, regDate)
	SELECT @ACCOUNT_IDX, award1_type, award1_number, award1_point, award2_type, award2_number, award2_point, award3_type, award3_number, award3_point, award4_type, award4_number, award4_point, award5_type, award5_number, award5_point, award6_type, award6_number, award6_point, award7_type, award7_number, award7_point, award8_type, award8_number, award8_point, award9_type, award9_number, award9_point, award10_type, award10_number, award10_point, regDate
	  FROM LosaGame.dbo.userAwardDB
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -8;
	END 

	-- dbo.userCharacterDB
	INSERT dbo.userCharacterDB (accountIDX, ClassType, CI_type, CI_gender, CI_beard, CI_face, CI_hair, CI_skinColor, CI_hairColor, CI_trinket, CI_position, CI_underwear, EI1_type, EI2_type, EI3_type, EI4_type, limitTime, limitType, leaderType, rentalType, rentalTime, awakeType, awakeTime, regDate)
	SELECT @ACCOUNT_IDX, ClassType, CI_type, CI_gender, CI_beard, CI_face, CI_hair, CI_skinColor, CI_hairColor, CI_trinket, CI_position, CI_underwear, EI1_type, EI2_type, EI3_type, EI4_type, limitTime, limitType, leaderType, rentalType, rentalTime, 0, 0, regDate
	  FROM LosaGame.dbo.userCharacterDB
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -9;
	END 

	-- dbo.userClassDB
	INSERT dbo.userClassDB (accountIDX, class1_type, class1_level, class1_expert, class1_stat, class2_type, class2_level, class2_expert, class2_stat, class3_type, class3_level, class3_expert, class3_stat, class4_type, class4_level, class4_expert, class4_stat, class5_type, class5_level, class5_expert, class5_stat, class6_type, class6_level, class6_expert, class6_stat, class7_type, class7_level, class7_expert, class7_stat, class8_type, class8_level, class8_expert, class8_stat, class9_type, class9_level, class9_expert, class9_stat, class10_type, class10_level, class10_expert, class10_stat)
	SELECT @ACCOUNT_IDX, class1_type, class1_level, class1_expert, 0, class2_type, class2_level, class2_expert, 0, class3_type, class3_level, class3_expert, 0, class4_type, class4_level, class4_expert, 0, class5_type, class5_level, class5_expert, 0, class6_type, class6_level, class6_expert, 0, class7_type, class7_level, class7_expert, 0, class8_type, class8_level, class8_expert, 0, class9_type, class9_level, class9_expert, 0, class10_type, class10_level, class10_expert, 0
	  FROM LosaGame.dbo.userClassDB
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -10;
	END 

	-- dbo.userEventDB
	INSERT dbo.userEventDB (accountIDX, value1, value2, eventType, regDate)
	SELECT @ACCOUNT_IDX, value1, value2, eventType, regDate
	  FROM LosaGame.dbo.userEventDB
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -11;
	END 

	-- dbo.userFishDB
	INSERT dbo.userFishDB (accountIDX, fish1_type, fish1_an, fish2_type, fish2_an, fish3_type, fish3_an, fish4_type, fish4_an, fish5_type, fish5_an, fish6_type, fish6_an, fish7_type, fish7_an, fish8_type, fish8_an, fish9_type, fish9_an, fish10_type, fish10_an, fish11_type, fish11_an, fish12_type, fish12_an, fish13_type, fish13_an, fish14_type, fish14_an, fish15_type, fish15_an, fish16_type, fish16_an, fish17_type, fish17_an, fish18_type, fish18_an, fish19_type, fish19_an, fish20_type, fish20_an, regDate)
	SELECT @ACCOUNT_IDX, fish1_type, fish1_an, fish2_type, fish2_an, fish3_type, fish3_an, fish4_type, fish4_an, fish5_type, fish5_an, fish6_type, fish6_an, fish7_type, fish7_an, fish8_type, fish8_an, fish9_type, fish9_an, fish10_type, fish10_an, fish11_type, fish11_an, fish12_type, fish12_an, fish13_type, fish13_an, fish14_type, fish14_an, fish15_type, fish15_an, fish16_type, fish16_an, fish17_type, fish17_an, fish18_type, fish18_an, fish19_type, fish19_an, fish20_type, fish20_an, regDate
	  FROM LosaGame.dbo.userFishDB
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -12;
	END 

	-- dbo.userGameDB
	INSERT dbo.userGameDB (accountIDX, userState, gameMoney, playTime, conn_count, userLevel, userEXP, userFishingLevel, userFishingEXP, userExcavationLevel, userExcavationEXP, userHerocEXP, userHerosEXP, rencpoint, renspoint, relateLevel, regionType, refillData, connDate, regDate)
	SELECT @ACCOUNT_IDX, userState, gameMoney, playTime, conn_count, userLevel, userEXP, userFishingLevel, userFishingEXP, userExcavationLevel, userExcavationEXP, userHerocEXP, userHerosEXP, rencpoint, renspoint, relateLevel, regionType, refillData, connDate, regDate
	  FROM LosaGame.dbo.userGameDB
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ROWCOUNT=0) or (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -13;
	END 

	-- dbo.userHqDB
	INSERT dbo.userHqDB (accountIDX, class1_type, class1_posx, class1_posy, class2_type, class2_posx, class2_posy, class3_type, class3_posx, class3_posy, class4_type, class4_posx, class4_posy, class5_type, class5_posx, class5_posy, class6_type, class6_posx, class6_posy, class7_type, class7_posx, class7_posy, class8_type, class8_posx, class8_posy, class9_type, class9_posx, class9_posy, class10_type, class10_posx, class10_posy, lockType, regDate)
	SELECT @ACCOUNT_IDX, class1_type, class1_posx, class1_posy, class2_type, class2_posx, class2_posy, class3_type, class3_posx, class3_posy, class4_type, class4_posx, class4_posy, class5_type, class5_posx, class5_posy, class6_type, class6_posx, class6_posy, class7_type, class7_posx, class7_posy, class8_type, class8_posx, class8_posy, class9_type, class9_posx, class9_posy, class10_type, class10_posx, class10_posy, lockType, regDate
	  FROM LosaGame.dbo.userHqDB
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -14;
	END 

	-- dbo.userItemDB
	INSERT dbo.userItemDB (accountIDX, item1_type, item1_code, item2_type, item2_code, item3_type, item3_code, item4_type, item4_code, item5_type, item5_code, item6_type, item6_code, item7_type, item7_code, item8_type, item8_code, item9_type, item9_code, item10_type, item10_code, item11_type, item11_code, item12_type, item12_code, item13_type, item13_code, item14_type, item14_code, item15_type, item15_code, item16_type, item16_code, item17_type, item17_code, item18_type, item18_code, item19_type, item19_code, item20_type, item20_code)
	SELECT @ACCOUNT_IDX, item1_type, item1_code, item2_type, item2_code, item3_type, item3_code, item4_type, item4_code, item5_type, item5_code, item6_type, item6_code, item7_type, item7_code, item8_type, item8_code, item9_type, item9_code, item10_type, item10_code, item11_type, item11_code, item12_type, item12_code, item13_type, item13_code, item14_type, item14_code, item15_type, item15_code, item16_type, item16_code, item17_type, item17_code, item18_type, item18_code, item19_type, item19_code, item20_type, item20_code
	  FROM LosaGame.dbo.userItemDB
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -15;
	END 

	-- dbo.userItemEtcDB
	INSERT dbo.userItemEtcDB (accountIDX, item1_type, item1_value1, item1_value2, item2_type, item2_value1, item2_value2, item3_type, item3_value1, item3_value2, item4_type, item4_value1, item4_value2, item5_type, item5_value1, item5_value2, item6_type, item6_value1, item6_value2, item7_type, item7_value1, item7_value2, item8_type, item8_value1, item8_value2, item9_type, item9_value1, item9_value2, item10_type, item10_value1, item10_value2, item11_type, item11_value1, item11_value2, item12_type, item12_value1, item12_value2, item13_type, item13_value1, item13_value2, item14_type, item14_value1, item14_value2, item15_type, item15_value1, item15_value2, item16_type, item16_value1, item16_value2, item17_type, item17_value1, item17_value2, item18_type, item18_value1, item18_value2, item19_type, item19_value1, item19_value2, item20_type, item20_value1, item20_value2)
	SELECT @ACCOUNT_IDX, item1_type, item1_value1, item1_value2, item2_type, item2_value1, item2_value2, item3_type, item3_value1, item3_value2, item4_type, item4_value1, item4_value2, item5_type, item5_value1, item5_value2, item6_type, item6_value1, item6_value2, item7_type, item7_value1, item7_value2, item8_type, item8_value1, item8_value2, item9_type, item9_value1, item9_value2, item10_type, item10_value1, item10_value2, item11_type, item11_value1, item11_value2, item12_type, item12_value1, item12_value2, item13_type, item13_value1, item13_value2, item14_type, item14_value1, item14_value2, item15_type, item15_value1, item15_value2, item16_type, item16_value1, item16_value2, item17_type, item17_value1, item17_value2, item18_type, item18_value1, item18_value2, item19_type, item19_value1, item19_value2, item20_type, item20_value1, item20_value2
	  FROM LosaGame.dbo.userItemEtcDB
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -16;
	END 

	-- dbo.userItemExtraDB
	INSERT dbo.userItemExtraDB (accountIDX, item1_type, item1_reinforce, item1_slotindex, item1_tradetype, item1_mcustom, item1_fcustom, item1_failexp, item1_limitType, item1_limitDate, item2_type, item2_reinforce, item2_slotindex, item2_tradetype, item2_mcustom, item2_fcustom, item2_failexp, item2_limitType, item2_limitDate, item3_type, item3_reinforce, item3_slotindex, item3_tradetype, item3_mcustom, item3_fcustom, item3_failexp, item3_limitType, item3_limitDate, item4_type, item4_reinforce, item4_slotindex, item4_tradetype, item4_mcustom, item4_fcustom, item4_failexp, item4_limitType, item4_limitDate, item5_type, item5_reinforce, item5_slotindex, item5_tradetype, item5_mcustom, item5_fcustom, item5_failexp, item5_limitType, item5_limitDate, item6_type, item6_reinforce, item6_slotindex, item6_tradetype, item6_mcustom, item6_fcustom, item6_failexp, item6_limitType, item6_limitDate, item7_type, item7_reinforce, item7_slotindex, item7_tradetype, item7_mcustom, item7_fcustom, item7_failexp, item7_limitType, item7_limitDate, item8_type, item8_reinforce, item8_slotindex, item8_tradetype, item8_mcustom, item8_fcustom, item8_failexp, item8_limitType, item8_limitDate, item9_type, item9_reinforce, item9_slotindex, item9_tradetype, item9_mcustom, item9_fcustom, item9_failexp, item9_limitType, item9_limitDate, item10_type, item10_reinforce, item10_slotindex, item10_tradetype, item10_mcustom, item10_fcustom, item10_failexp, item10_limitType, item10_limitDate, regDate)
	SELECT @ACCOUNT_IDX, item1_type, item1_reinforce, item1_slotindex, item1_tradetype, 0, 0, 0, item1_limitType, item1_limitDate, item2_type, item2_reinforce, item2_slotindex, item2_tradetype, 0, 0, 0, item2_limitType, item2_limitDate, item3_type, item3_reinforce, item3_slotindex, item3_tradetype, 0, 0, 0, item3_limitType, item3_limitDate, item4_type, item4_reinforce, item4_slotindex, item4_tradetype, 0, 0, 0, item4_limitType, item4_limitDate, item5_type, item5_reinforce, item5_slotindex, item5_tradetype, 0, 0, 0, item5_limitType, item5_limitDate, item6_type, item6_reinforce, item6_slotindex, item6_tradetype, 0, 0, 0, item6_limitType, item6_limitDate, item7_type, item7_reinforce, item7_slotindex, item7_tradetype, 0, 0, 0, item7_limitType, item7_limitDate, item8_type, item8_reinforce, item8_slotindex, item8_tradetype, 0, 0, 0, item8_limitType, item8_limitDate, item9_type, item9_reinforce, item9_slotindex, item9_tradetype, 0, 0, 0, item9_limitType, item9_limitDate, item10_type, item10_reinforce, item10_slotindex, item10_tradetype, 0, 0, 0, item10_limitType, item10_limitDate, regDate
	  FROM LosaGame.dbo.userItemExtraDB
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -17;
	END 

	-- dbo.userItemMedalDB
	INSERT dbo.userItemMedalDB (accountIDX, item1_type, item1_class, item1_limitType, item1_limitDate, item2_type, item2_class, item2_limitType, item2_limitDate, item3_type, item3_class, item3_limitType, item3_limitDate, item4_type, item4_class, item4_limitType, item4_limitDate, item5_type, item5_class, item5_limitType, item5_limitDate, item6_type, item6_class, item6_limitType, item6_limitDate, item7_type, item7_class, item7_limitType, item7_limitDate, item8_type, item8_class, item8_limitType, item8_limitDate, item9_type, item9_class, item9_limitType, item9_limitDate, item10_type, item10_class, item10_limitType, item10_limitDate, regDate)
	SELECT @ACCOUNT_IDX, item1_type, item1_class, item1_limitType, item1_limitDate, item2_type, item2_class, item2_limitType, item2_limitDate, item3_type, item3_class, item3_limitType, item3_limitDate, item4_type, item4_class, item4_limitType, item4_limitDate, item5_type, item5_class, item5_limitType, item5_limitDate, item6_type, item6_class, item6_limitType, item6_limitDate, item7_type, item7_class, item7_limitType, item7_limitDate, item8_type, item8_class, item8_limitType, item8_limitDate, item9_type, item9_class, item9_limitType, item9_limitDate, item10_type, item10_class, item10_limitType, item10_limitDate, regDate
	  FROM LosaGame.dbo.userItemMedalDB
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -18;
	END 

	-- dbo.userItemMedalExtendDB
	INSERT dbo.userItemMedalExtendDB (accountIDX, medal1_class, medal1_slot, medal1_period, medal2_class, medal2_slot, medal2_period, medal3_class, medal3_slot, medal3_period, medal4_class, medal4_slot, medal4_period, medal5_class, medal5_slot, medal5_period, medal6_class, medal6_slot, medal6_period, medal7_class, medal7_slot, medal7_period, medal8_class, medal8_slot, medal8_period, medal9_class, medal9_slot, medal9_period, medal10_class, medal10_slot, medal10_period, regDate)
	SELECT @ACCOUNT_IDX, medal1_class, medal1_slot, medal1_period, medal2_class, medal2_slot, medal2_period, medal3_class, medal3_slot, medal3_period, medal4_class, medal4_slot, medal4_period, medal5_class, medal5_slot, medal5_period, medal6_class, medal6_slot, medal6_period, medal7_class, medal7_slot, medal7_period, medal8_class, medal8_slot, medal8_period, medal9_class, medal9_slot, medal9_period, medal10_class, medal10_slot, medal10_period, regDate
	  FROM LosaGame.dbo.userItemMedalExtendDB
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -19;
	END 

	-- dbo.userPieceDB
	INSERT dbo.userPieceDB (accountIDX, piece1_type, piece1_value1, piece1_value2, piece1_cnt, piece2_type, piece2_value1, piece2_value2, piece2_cnt, piece3_type, piece3_value1, piece3_value2, piece3_cnt, piece4_type, piece4_value1, piece4_value2, piece4_cnt, piece5_type, piece5_value1, piece5_value2, piece5_cnt, piece6_type, piece6_value1, piece6_value2, piece6_cnt, piece7_type, piece7_value1, piece7_value2, piece7_cnt, piece8_type, piece8_value1, piece8_value2, piece8_cnt, piece9_type, piece9_value1, piece9_value2, piece9_cnt, piece10_type, piece10_value1, piece10_value2, piece10_cnt, regDate)
	SELECT @ACCOUNT_IDX, piece1_type, piece1_value1, piece1_value2, piece1_cnt, piece2_type, piece2_value1, piece2_value2, piece2_cnt, piece3_type, piece3_value1, piece3_value2, piece3_cnt, piece4_type, piece4_value1, piece4_value2, piece4_cnt, piece5_type, piece5_value1, piece5_value2, piece5_cnt, piece6_type, piece6_value1, piece6_value2, piece6_cnt, piece7_type, piece7_value1, piece7_value2, piece7_cnt, piece8_type, piece8_value1, piece8_value2, piece8_cnt, piece9_type, piece9_value1, piece9_value2, piece9_cnt, piece10_type, piece10_value1, piece10_value2, piece10_cnt, regDate
	  FROM LosaGame.dbo.userPieceDB
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -20;
	END 

	-- dbo.userQuestCompleteDB
	INSERT dbo.userQuestCompleteDB (accountIDX, quest1_type, quest1_time, quest2_type, quest2_time, quest3_type, quest3_time, quest4_type, quest4_time, quest5_type, quest5_time, quest6_type, quest6_time, quest7_type, quest7_time, quest8_type, quest8_time, quest9_type, quest9_time, quest10_type, quest10_time, quest11_type, quest11_time, quest12_type, quest12_time, quest13_type, quest13_time, quest14_type, quest14_time, quest15_type, quest15_time, quest16_type, quest16_time, quest17_type, quest17_time, quest18_type, quest18_time, quest19_type, quest19_time, quest20_type, quest20_time, regDate)
	SELECT @ACCOUNT_IDX, quest1_type, quest1_time, quest2_type, quest2_time, quest3_type, quest3_time, quest4_type, quest4_time, quest5_type, quest5_time, quest6_type, quest6_time, quest7_type, quest7_time, quest8_type, quest8_time, quest9_type, quest9_time, quest10_type, quest10_time, quest11_type, quest11_time, quest12_type, quest12_time, quest13_type, quest13_time, quest14_type, quest14_time, quest15_type, quest15_time, quest16_type, quest16_time, quest17_type, quest17_time, quest18_type, quest18_time, quest19_type, quest19_time, quest20_type, quest20_time, regDate
	  FROM LosaGame.dbo.userQuestCompleteDB
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -21;
	END 

	-- dbo.userQuestDB
	INSERT dbo.userQuestDB (accountIDX, quest1_type, quest1_value1, quest1_value2, quest1_time, quest2_type, quest2_value1, quest2_value2, quest2_time, quest3_type, quest3_value1, quest3_value2, quest3_time, quest4_type, quest4_value1, quest4_value2, quest4_time, quest5_type, quest5_value1, quest5_value2, quest5_time, quest6_type, quest6_value1, quest6_value2, quest6_time, quest7_type, quest7_value1, quest7_value2, quest7_time, quest8_type, quest8_value1, quest8_value2, quest8_time, quest9_type, quest9_value1, quest9_value2, quest9_time, quest10_type, quest10_value1, quest10_value2, quest10_time, quest11_type, quest11_value1, quest11_value2, quest11_time, quest12_type, quest12_value1, quest12_value2, quest12_time, quest13_type, quest13_value1, quest13_value2, quest13_time, quest14_type, quest14_value1, quest14_value2, quest14_time, quest15_type, quest15_value1, quest15_value2, quest15_time, quest16_type, quest16_value1, quest16_value2, quest16_time, quest17_type, quest17_value1, quest17_value2, quest17_time, quest18_type, quest18_value1, quest18_value2, quest18_time, quest19_type, quest19_value1, quest19_value2, quest19_time, quest20_type, quest20_value1, quest20_value2, quest20_time, regDate)
	SELECT @ACCOUNT_IDX, quest1_type, quest1_value1, quest1_value2, quest1_time, quest2_type, quest2_value1, quest2_value2, quest2_time, quest3_type, quest3_value1, quest3_value2, quest3_time, quest4_type, quest4_value1, quest4_value2, quest4_time, quest5_type, quest5_value1, quest5_value2, quest5_time, quest6_type, quest6_value1, quest6_value2, quest6_time, quest7_type, quest7_value1, quest7_value2, quest7_time, quest8_type, quest8_value1, quest8_value2, quest8_time, quest9_type, quest9_value1, quest9_value2, quest9_time, quest10_type, quest10_value1, quest10_value2, quest10_time, quest11_type, quest11_value1, quest11_value2, quest11_time, quest12_type, quest12_value1, quest12_value2, quest12_time, quest13_type, quest13_value1, quest13_value2, quest13_time, quest14_type, quest14_value1, quest14_value2, quest14_time, quest15_type, quest15_value1, quest15_value2, quest15_time, quest16_type, quest16_value1, quest16_value2, quest16_time, quest17_type, quest17_value1, quest17_value2, quest17_time, quest18_type, quest18_value1, quest18_value2, quest18_time, quest19_type, quest19_value1, quest19_value2, quest19_time, quest20_type, quest20_value1, quest20_value2, quest20_time, regDate
	  FROM LosaGame.dbo.userQuestDB
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -22;
	END 

	-- dbo.userRankingDB_award
	INSERT dbo.userRankingDB_award (accountIDX, awardLevel, expert, award1_prev, award1_now, award1_point, award2_prev, award2_now, award2_point, award3_prev, award3_now, award3_point, award4_prev, award4_now, award4_point, award5_prev, award5_now, award5_point, award6_prev, award6_now, award6_point, award7_prev, award7_now, award7_point, award8_prev, award8_now, award8_point, award9_prev, award9_now, award9_point, award10_prev, award10_now, award10_point, award11_prev, award11_now, award11_point, award12_prev, award12_now, award12_point, award13_prev, award13_now, award13_point, award14_prev, award14_now, award14_point, award15_prev, award15_now, award15_point, award16_prev, award16_now, award16_point, award17_prev, award17_now, award17_point, award18_prev, award18_now, award18_point, award19_prev, award19_now, award19_point, award20_prev, award20_now, award20_point, award21_prev, award21_now, award21_point, award22_prev, award22_now, award22_point, award23_prev, award23_now, award23_point, award24_prev, award24_now, award24_point, award25_prev, award25_now, award25_point, award26_prev, award26_now, award26_point, award27_prev, award27_now, award27_point, regDate)
	SELECT @ACCOUNT_IDX, awardLevel, expert, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, regDate
	  FROM LosaGame.dbo.userRankingDB_award
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -23;
	END 

	-- dbo.userRecordBattleDB
	INSERT dbo.userRecordBattleDB (accountIDX, type1_win, type1_lose, type1_kill, type1_death, type2_win, type2_lose, type2_kill, type2_death, type3_win, type3_lose, type3_kill, type3_death, type4_win, type4_lose, type4_kill, type4_death, regDate)
	SELECT @ACCOUNT_IDX, type1_win, type1_lose, type1_kill, type1_death, type2_win, type2_lose, type2_kill, type2_death, type3_win, type3_lose, type3_kill, type3_death, type4_win, type4_lose, type4_kill, type4_death, regDate
	  FROM LosaGame.dbo.userRecordBattleDB
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ROWCOUNT=0) or (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -24;
	END 

	-- dbo.userRelativeLevelDB
	INSERT dbo.userRelativeLevelDB (accountIDX, weekend_BackupLevel, weekend_BackupExp, init_time, reward_State, regDate)
	SELECT @ACCOUNT_IDX, weekend_BackupLevel, weekend_BackupExp, init_time, reward_State, regDate
	  FROM LosaGame.dbo.userRelativeLevelDB
	 WHERE AccountIDX=@LOST_ACCOUNT_IDX

	IF (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -25;
	END 

	-- dbo.userMoneyDB
	INSERT INTO dbo.userMoneyDB (accountIDX, realCash, bonusCash, regDate)
	VALUES (@ACCOUNT_IDX, 0, 0, GETDATE())

	IF (@@ROWCOUNT=0) or (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -27;
	END

	-- dbo.TBL_migration_mapping_log
	INSERT INTO dbo.TBL_migration_mapping_log (accountIDX, GarenaID, GarenaUID, AsiasoftID, regDate)
	VALUES (@ACCOUNT_IDX, @GUSER_LoginID, @GUSER_ID, @USER_ID, GETDATE())

	IF (@@ROWCOUNT=0) or (@@ERROR<>0)
	BEGIN
		ROLLBACK TRAN
		RETURN -26;
	END 

	COMMIT TRAN
	
	RETURN @nReturn;
GO
/****** Object:  StoredProcedure [dbo].[USP_Web_Member_Add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_Web_Member_Add]
                                                    
	@sUserId	varchar(20),		-- 사용자아이디
	@sPassword  varchar(128),
	@sNickName	varchar(20) = '',		-- 사용자닉네임
	@sEMail		varchar(50) = '',		-- 이메일주소
	@nMailling	int = '',		-- 메일수신동의여부
	@nUserType	int = 100,			-- 가입자등급(100:정회원)
	@nJoinType	int = 10,			-- 회원확인
	@nGender	int = 0,			-- 성별(M:남자, F:여자 )
	@sUserIP	varchar(15) = '0.0.0.0',		-- 사용자IP
	@sUserBirthday	varchar(6) = '010101',	-- 생년월일
	@sEncodeJumin1	varchar(12) = '',	-- 주민번호앞자리(암호화)
	@sEncodeJumin2	varchar(14) = '',	-- 주민번호뒷자리(암호화)
	@sUserEnCode	varchar(15) = '111111111111111',	-- 전체주민번호(암호화)
	@nUserNumber	tinyint	= 1,	-- 주민번호뒷자리처음(남자:1, 여자:2, 2000년생은 3,4)
	@sActiveCode varchar(10)
AS
BEGIN
	SET NOCOUNT ON;
                                           
	-- 변수 선언
	DECLARE @nAccountIDX	int
	DECLARE @freeCash int
	DECLARE @activeCode varchar(10)
	SET @freeCash = 500
	-- 변수 세팅
	SET @nAccountIDX = 0
	
	-- TRAN START 
	BEGIN TRAN

		IF @activeCode <> '*'
		BEGIN
			SELECT @activeCode = Code FROM WebHardware WHERE Code = @sActiveCode AND ActiveDate IS NULL;
			IF @activeCode IS NULL OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (2)
			END

			UPDATE WebHardware SET ActiveDate = GETDATE(), ActiveUser = @sUserId WHERE Code = @activeCode AND ActiveDate IS NULL;
			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-8)
			END
		END

		-- 게임 관련 기본 데이터 저장
		INSERT INTO userMemberDB (userID, nickName, userPWD, EMail, mailling, userType, joinType, eventType, cpType, limitType, limitDate, regDate)
		     VALUES (@sUserId, '_' + @sUserId + '#', '', @sEMail, @nMailling, @nUserType, @nJoinType, 0, 0, 0, '1999-01-01', GETDATE())
			 --'temp'+ Format(getdate(), N'yyMMddHHmmssfff')
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (-1)
		END

		-- 사용자idx
		SET @nAccountIDX = @@IDENTITY

		INSERT INTO WebLogin (Id, Username, Password, Email, RegisterIP)
			VALUES (@nAccountIDX, @sUserId, @sPassword, @sEMail, @sUserIP);

		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (-2)
		END

		INSERT INTO userMoneyDB (accountIDX, realCash, bonusCash, regDate)
		     VALUES (@nAccountIDX, 0, @freeCash, GETDATE())

		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (-3)
		END

		INSERT INTO userGameDB (accountIDX, userState, gameMoney, playTime, conn_count, userLevel, userEXP, rencpoint, renspoint, relateLevel, regionType, refillData, connDate, regDate)
		     VALUES (@nAccountIDX, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '2000-01-01', GETDATE())

		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (-4)
		END

		INSERT INTO userRecordBattleDB (accountIDX, type1_win, type1_lose, type1_kill, type1_death, type2_win, type2_lose, type2_kill, type2_death, type3_win, type3_lose, type3_kill, type3_death, type4_win, type4_lose, type4_kill, type4_death, regDate)
	 	     VALUES (@nAccountIDX, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE())

		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (-5)
		END

		INSERT INTO userLoginDB (accountIDX, encodeKey, gameServerID, connDate) 
		     VALUES (@nAccountIDX, @sUserEnCode, 0, GETDATE())

		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (-6)
		END

		INSERT INTO userNameDB (accountIDX, userName, userBirthday, userJumin1, userJumin2, userEnCode, userNumber, userGender, returnValue, userIP, regDate)
		     VALUES (@nAccountIDX, '', @sUserBirthday, @sEncodeJumin1, @sEncodeJumin2, @sUserEnCode, @nUserNumber, @nGender, 1, @sUserIP, GETDATE())

		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (-7)
		END		

	-- COMMIT TRAN
	COMMIT TRAN 

 
                                       
                                                                                                                                                                                                 



	RETURN (1)
 
END
GO
/****** Object:  StoredProcedure [dbo].[web_add_cash]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_add_cash]
(
	@userID VARCHAR(20),
	@cash int
)
As

begin
  UPDATE m
  SET realcash += @cash
  FROM userMoneyDB m
  INNER JOIN userMemberDB u
  on m.accountIDX = u.accountIDX
  WHERE u.userID = @userID;
end
GO
/****** Object:  StoredProcedure [dbo].[web_class_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_class_get]
(
	@id INT = NULL
)
As
	SELECT
		idx AS HeroId,
		classEngName AS HeroName,
		premiumType AS Premium,
		rareType AS Rare,
		attackType AS Attack,
		powerupType As PowerUp,
		CASE WHEN @id IS NULL THEN '' ELSE description END AS Description
	FROM define_class c WITH (NOLOCK)
	WHERE idx = @id OR @id IS NULL
	AND display = 1;
GO
/****** Object:  StoredProcedure [dbo].[web_count_user_etcitem]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_count_user_etcitem]
(
	@item int
)
As
	SELECT t.accountIdx, m.nickName, Sum(cnt) As Total
	FROM
	(
		select accountIDX, sum(item1_value1) AS cnt from userItemEtcDB where 
		item1_type = @item
		group by accountIDX
		UNION ALL
		select accountIDX, sum(item2_value1) AS cnt from userItemEtcDB where 
		item2_type = @item
		group by accountIDX
		UNION ALL
		select accountIDX, sum(item3_value1) AS cnt from userItemEtcDB where 
		item3_type = @item
		group by accountIDX
		UNION ALL
		select accountIDX, sum(item4_value1) AS cnt from userItemEtcDB where 
		item4_type = @item
		group by accountIDX
		UNION ALL
		select accountIDX, sum(item5_value1) AS cnt from userItemEtcDB where 
		item5_type = @item
		group by accountIDX
		UNION ALL
		select accountIDX, sum(item6_value1) AS cnt from userItemEtcDB where 
		item6_type = @item
		group by accountIDX
		UNION ALL
		select accountIDX, sum(item7_value1) AS cnt from userItemEtcDB where 
		item7_type = @item
		group by accountIDX
		UNION ALL
		select accountIDX, sum(item8_value1) AS cnt from userItemEtcDB where 
		item8_type = @item
		group by accountIDX
		UNION ALL
		select accountIDX, sum(item9_value1) AS cnt from userItemEtcDB where 
		item9_type = @item
		group by accountIDX
		UNION ALL
		select accountIDX, sum(item10_value1) AS cnt from userItemEtcDB where 
		item10_type = @item
		group by accountIDX
		UNION ALL
		select accountIDX, sum(item11_value1) AS cnt from userItemEtcDB where 
		item11_type = @item
		group by accountIDX
		UNION ALL
		select accountIDX, sum(item12_value1) AS cnt from userItemEtcDB where 
		item12_type = @item
		group by accountIDX
		UNION ALL
		select accountIDX, sum(item13_value1) AS cnt from userItemEtcDB where 
		item13_type = @item
		group by accountIDX
		UNION ALL
		select accountIDX, sum(item14_value1) AS cnt from userItemEtcDB where 
		item14_type = @item
		group by accountIDX
		UNION ALL
		select accountIDX, sum(item15_value1) AS cnt from userItemEtcDB where 
		item15_type = @item
		group by accountIDX
		UNION ALL
		select accountIDX, sum(item16_value1) AS cnt from userItemEtcDB where 
		item16_type = @item
		group by accountIDX
		UNION ALL
		select accountIDX, sum(item17_value1) AS cnt from userItemEtcDB where 
		item17_type = @item
		group by accountIDX
		UNION ALL
		select accountIDX, sum(item18_value1) AS cnt from userItemEtcDB where 
		item18_type = @item
		group by accountIDX
		UNION ALL
		select accountIDX, sum(item19_value1) AS cnt from userItemEtcDB where 
		item19_type = @item
		group by accountIDX
		UNION ALL
		select accountIDX, sum(item20_value1) AS cnt from userItemEtcDB where 
		item20_type = @item
		group by accountIDX
	) t
	LEFT JOIN userMemberDB m
	ON t.accountIDX = m.accountIDX
	group by t.accountIDX, m.nickName
	order by accountIDX
GO
/****** Object:  StoredProcedure [dbo].[web_coupon_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_coupon_add]
(
	@userID VARCHAR(20),
	@code VARCHAR(16)
)
As

begin
	SET NOCOUNT ON 
	DECLARE @groupId int;
	DECLARE @couponId int;
	DECLARE @cash int;
	
	-- TRAN START 
	BEGIN TRAN

	SELECT @groupId = groupId FROM WebCoupon WHERE Code = @code AND Used = 0;
	IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (2)
		END

	SELECT @couponId = Id FROM WebCoupon WHERE groupId = @groupId AND Used = 1 AND UsedUser = @userID;
	IF @couponId IS NOT NULL
	BEGIN
		ROLLBACK TRAN
		RETURN (3)
	END

	UPDATE WebCoupon
		SET Used = 1,
		UsedDate = getdate(),
		UsedUser = @userId
	WHERE Used = 0 AND Code = @code;

	IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (4)
		END
	
	INSERT INTO dbo.userPresentDB (sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate)
	SELECT 1, accountIdx, presentType, value1, value2, 0, 0, 1011, 0, DATEADD(DAY, 14, GETDATE()), GETDATE()
	FROM userMemberDB u
	CROSS APPLY WebCouponItem i
	WHERE i.GroupId = @groupId AND i.ItemType = 0
	AND userID = @userID;

	IF @@ROWCOUNT = 0 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (5)
		END

	SELECT @cash = ISNULL(SUM(Value1), 0) FROM WebCouponItem WHERE GroupId = @groupId AND ItemType = 1;
	IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (6)
		END

	UPDATE c 
		SET realCash+= @cash 
	FROM userMoneyDB c
	INNER JOIN userMemberDB m
	ON c.accountIDX = m.accountIDX
	WHERE userID = @userID;

	IF @@ROWCOUNT = 0 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (7)
		END
	-- COMMIT TRAN
	COMMIT TRAN 

	RETURN (1)
end
GO
/****** Object:  StoredProcedure [dbo].[web_event_present_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_event_present_add]
(
	@pid int,
	@userId varchar(20)
)
As
	BEGIN
		SET NOCOUNT ON
		DECLARE @cnt int;
		DECLARE @accountIdx int;
		DECLARE @rewardType int;
		DECLARE @rewardValue1 int;
		DECLARE @rewardValue2 int;
		DECLARE @start datetime;
		DECLARE @end datetime;
		--SET @start = '2018-12-25';
		--SET @end = '2019-01-07 05:00';

		--Check user exist
		SELECT @accountIdx = Id FROM WebLogin WHERE Username = @userId;
		IF @accountIdx IS NULL
		BEGIN
			RETURN (-1)
		END
		
		--SELECT Event
		SELECT @start = StartDate, @end= EndDate, @rewardType = PresentType, @rewardValue1 = Value1, @rewardValue2 = Value2 FROM WebEvent WHERE Id = @pid;
		IF @start IS NULL OR @end IS NULL OR @rewardType IS NULL OR @rewardValue1 IS NULL OR @rewardValue2 IS NULL
		BEGIN
			RETURN (-6) --ERROR
		END

		--Check Event Peroid
		IF NOT GETDATE() BETWEEN @start AND @end
		BEGIN
			RETURN (-2)
		END

		--Check Event Valid
		If @pid NOT IN (1, 2, 3, 4)
		BEGIN
			RETURN (-3)
		END

		--Check Event reward got or not
		SELECT @cnt = count(*) FROM WebEventLog WHERE PresentId = @pid AND AccountIdx = @accountIdx;
		IF @cnt > 0
		BEGIN
			RETURN (-4)
		END

		--Check User Can Get or not
		IF @pid = 1 --Old Player
			BEGIN
				SELECT @cnt = count(Id) FROM WebLogin WHERE Verify = 1 AND Banned = 0 AND Id = @accountIdx AND RegDate < '2018-12-24';

				IF @cnt IS NULL OR @cnt < 1
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @pid = 2 --New Player
			BEGIN
				SELECT @cnt = count(Id) FROM WebLogin WHERE Verify = 1 AND Banned = 0 AND Id = @accountIdx AND RegDate >= '2018-12-24';

				IF @cnt IS NULL OR @cnt < 1
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @pid = 3 --Donated Player >= 20000BP
			BEGIN
				SELECT @cnt = sum(new) from WebTransaction WHERE Uid = @userId AND Time < '2018-12-24';
				IF @cnt IS NULL OR @cnt < 20000
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @pid = 4 --Login during 1 Jan ~ 3 Jan
			BEGIN
				
				SELECT @cnt = count(UserID) FROM WebConnectLog WHERE LogDate BETWEEN '2019-01-01' AND '2019-01-04' AND UserID = @userId;
				IF @cnt IS NULL OR @cnt < 1
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE		
			RETURN (-6)

		-- TRAN START
		BEGIN TRAN		
		-- Reward
		INSERT INTO dbo.userPresentDB (sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate) VALUES
		(1, @accountIdx, @rewardType, @rewardValue1, @rewardValue2, 0, 0, 1011, 0, DATEADD(DAY, 14, GETDATE()), GETDATE());

		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-6)
			END	

		-- Log
		INSERT INTO WebEventLog (AccountIdx, PresentId, CompleteDate) VALUES (@accountIdx, @pid, GETDATE());
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-7)
			END	

		-- COMMIT TRAN
		COMMIT TRAN 
		RETURN (1)
	END
GO
/****** Object:  StoredProcedure [dbo].[web_get_email_verify]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_get_email_verify]
(
	@userID varchar(20),
	@email varchar(50)
)
As
	SELECT TOP 1
		Verify,
		Banned, 
		w.Email,
		c.SendDate
	FROM WebLogin w
	LEFT JOIN WebLogin_Confirm c
	on w.Username = c.Username and w.Email = c.Email
	WHERE w.Username = @userID COLLATE Latin1_General_BIN AND w.Email = @email;
GO
/****** Object:  StoredProcedure [dbo].[web_get_password_recovery]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_get_password_recovery]
(
	@userID varchar(20),
	@email varchar(50)
)
As
	SELECT TOP 1
		w.Email,
		r.SendDate
	FROM WebLogin w
	LEFT JOIN WebRecovery r
	ON w.Username = r.Username AND w.Email = r.Email
	WHERE w.Username = @userID COLLATE Latin1_General_BIN AND w.Email = @email;
GO
/****** Object:  StoredProcedure [dbo].[web_id_already]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_id_already]

    @USER_ID        VARCHAR(20)
AS
    declare @RET int;
    declare @RET1 int;
    declare @USER_ID_TYPE int;
    declare @ACCOUNT_IDX int;
    SET @RET = 0;
    SET @RET1 = 1;
    SET @ACCOUNT_IDX = 1;
    SET NOCOUNT ON
    SET LOCK_TIMEOUT 15000

    SET @ACCOUNT_IDX=0

    IF (@USER_ID_TYPE=1)
    BEGIN

         SET @ACCOUNT_IDX=(SELECT AccountIDX FROM dbo.userMemberDB WITH (READUNCOMMITTED) WHERE nickName=@USER_ID)

        IF (@ACCOUNT_IDX=0) or (@ACCOUNT_IDX IS NULL)
        BEGIN
            RETURN @RET
        END 
    END
    ELSE 
    BEGIN

        SET @ACCOUNT_IDX=(SELECT AccountIDX FROM dbo.userMemberDB WITH (READUNCOMMITTED) WHERE UserID=@USER_ID)

        IF (@ACCOUNT_IDX=0) or (@ACCOUNT_IDX IS NULL)
        BEGIN
            RETURN @RET
        END 
    END 

    RETURN @RET1;
GO
/****** Object:  StoredProcedure [dbo].[web_login_info]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[web_login_info]
(
	@accountIDX int
)
AS
	SELECT a.userLevel, a.gameMoney, ISNULL(b.realCash, 0) AS 'cash', ISNULL(c.class, 0) AS 'ranking'
	FROM userGameDB a WITH(NOLOCK) LEFT JOIN userMoneyDB b WITH(NOLOCK) ON a.accountIDX = b.accountIDX LEFT JOIN userRankingDB c WITH(NOLOCK) ON a.accountIDX = c.accountIDX
	WHERE a.accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[web_myhome_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_myhome_get]
(
	@homeIDX int
)
As
	WITH ranking (accountIDX, Guild, Name, Level, Exp, Rank, PlayTime, LastLogin, RegDate) as 
		(
			SELECT
				g.accountIDX,
				guild.guildName AS Guild,
				m.nickname AS Name ,
				g.userLevel AS Level,
				g.userEXP AS Exp,	
				RANK() OVER (ORDER BY g.userLevel DESC, g.userEXP DESC) AS Rank,
				g.playTime AS PlayTime,
				g.connDate AS LastLogin,
				m.regDate AS RegDate
			FROM usergamedb g WITH (NOLOCK) 
			INNER JOIN usermemberdb m WITH (NOLOCK) 
			ON g.accountIDX = m.accountIDX
			LEFT JOIN 
			(
				SELECT gd.guildName, gu.accountIDX
				FROM
				[userGuildInfoDB] gu WITH (NOLOCK) 
				INNER JOIN userGuildDB gd WITH (NOLOCK) 
				ON gd.idx = gu.guildIDX
			) guild
			ON guild.accountIDX = m.accountIDX
			WHERE userType = 100 
			and m.nickName not like '%#%'
			and m.nickName not like 'developer%'
		)
		SELECT TOP 1 * FROM ranking
		WHERE accountIDX = @homeIDX
	;
GO
/****** Object:  StoredProcedure [dbo].[web_notice_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_notice_add]
(
	@userID varchar(20),
	@subject varchar(200),
	@type int,
	@content VARCHAR(MAX),
	@plain VARCHAR(MAX)
)
As
	BEGIN
		SET NOCOUNT ON 		
		DECLARE @cnt int;
		SELECT @cnt = count(*) FROM WebNoticeType WHERE Id = @type;
		IF @cnt = 0
		BEGIN
			RETURN (2)
		END

		-- TRAN START 
		BEGIN TRAN

		INSERT INTO WebNotice (NoticeUser, Subject, TypeId, Content, ContentPlain, Status)
		VALUES (@userID, @subject, @type, @content, @plain, 0);
			
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (3)
		END
		
		-- COMMIT TRAN
		COMMIT TRAN 

		RETURN (1)
	END
GO
/****** Object:  StoredProcedure [dbo].[web_notice_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_notice_get]
(
	@id INT = NULL,
	@all bit = 0
)
As
	SELECT
		n.Id,
		TypeId,
		Subject,
		Content,
		ContentPlain,
		NoticeUser,
		NoticeDate,
		Status,
		t.ColorId,
		t.Name,
		LastUpdate
	FROM WebNotice n WITH (NOLOCK)
	INNER JOIN WebNoticeType t WITH (NOLOCK)
	ON n.TypeId = t.Id
	WHERE 
	(@all = 1 OR Status = 0)
	AND (@id IS NULL OR @id = n.Id)
	ORDER BY NoticeDate DESC
GO
/****** Object:  StoredProcedure [dbo].[web_notice_update]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_notice_update]
(
	@userID varchar(20),
	@nid int,
	@subject varchar(200),
	@type int,
	@content VARCHAR(MAX),
	@plain VARCHAR(MAX),
	@status int
)
As
	BEGIN
		SET NOCOUNT ON 		
		DECLARE @cnt int;
		SELECT @cnt = count(*) FROM WebNoticeType WHERE Id = @type;
		IF @cnt = 0
		BEGIN
			RETURN (2)
		END

		SELECT @cnt = count(*) FROM WebNotice WHERE Id = @nid;
		IF @cnt = 0
		BEGIN
			RETURN (3)
		END

		-- TRAN START 
		BEGIN TRAN

		UPDATE WebNotice
		SET
			NoticeUser = @userID,
			Subject = @subject,
			TypeId = @type,
			Content = @content, 
			ContentPlain = @plain,
			Status = @status
		WHERE Id = @nid;
			
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (4)
		END
		
		-- COMMIT TRAN
		COMMIT TRAN 

		RETURN (1)
	END
GO
/****** Object:  StoredProcedure [dbo].[web_noticetype_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_noticetype_get]
As
	SELECT
		Id,
		Name,
		ColorId
	FROM WebNoticeType WITH (NOLOCK)
	ORDER BY Id ASC
GO
/****** Object:  StoredProcedure [dbo].[web_play_enkey_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_play_enkey_get_data]
(
	@accountIDX int
)
As
	SELECT encodeKey, gameServerID, userIP, connDate FROM userLoginDB WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[web_play_enkey_save]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_play_enkey_save]
(
	@accountIDX int
,	@encodeKey char(15)
,	@userIP varchar(15)
)
As
	UPDATE userLoginDB SET
		encodeKey = @encodeKey
,		userIP = @userIP
,		connDate = getdate()
	WHERE accountIDX = @accountIDX
GO
/****** Object:  StoredProcedure [dbo].[web_play_fixkey_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_play_fixkey_get_data]

As
	SELECT encodeKey FROM define_encode_key WHERE idx = (SELECT MAX(idx) FROM define_encode_key)
GO
/****** Object:  StoredProcedure [dbo].[web_play_game_server_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_play_game_server_get_data]

As
	DECLARE @maxcount int
	SET @maxcount = DBO.DEFINE_SERVER_CONNECTION_MAX_COUNT()

	SELECT TOP 1 serverID FROM define_game_server
	WHERE connNumber < @maxcount and [status]=1 ORDER BY NEWID()
GO
/****** Object:  StoredProcedure [dbo].[web_quest_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_quest_get]
(
	@Id int,
	@User varchar(20)
)
As
BEGIN
	SET NOCOUNT ON
	DECLARE @accountIdx int;
	DECLARE @type int;
	DECLARE @start datetime;
	DECLARE @end datetime;

	SELECT @type = QuestType, @start = QuestStartDate, @end = QuestEndDate FROM WebQuest WHERE Id = @Id;
	IF @type IS NULL OR @@ERROR <> 0
		RETURN (8) --QUEST TYPE NOT FOUND
		
	SELECT @accountIdx = Id FROM WebLogin WHERE Username = @User;
	IF @accountIdx IS NULL OR @@ERROR <> 0
		RETURN (8) --USER NOT FOUND
		
	IF @type = 1
		--Login Event
		BEGIN
			SELECT
				time.*,
				QuestTarget
			FROM
			(
				SELECT
					accountIDX,
					ISNULL(SUM(playTime), 0) / 60  AS Progress
				FROM [LosaLogData].[dbo].[log_data_playtime] l
				where accountIDX = @accountIdx
				AND regDate >= @start
				AND regDate < @end
				group by accountIDX
			) time
			CROSS APPLY WebQuest q
			WHERE q.Id = @Id

			IF @@ROWCOUNT = 0
				RETURN (8) --QUEST NOT FOUND
		END
	ELSE IF @type = 2
		--BATTLE MODE Play Time
		BEGIN
			SELECT
				time.*,
				QuestTarget
			FROM
			(
				SELECT
					accountIDX,
					ISNULL(SUM(playTime), 0) / 60 AS Progress
				FROM (
					SELECT
						accountIDX,
						modeType,
						SUM(playTime) + SUM(deathTime) AS 'playTime'
					FROM  [LosaLogData].[dbo].[log_data_play] l
					INNER JOIN WebQuest q
					ON q.PlayType = l.playType AND q.Mode = l.modeType
					WHERE regDate >= @start
					AND regDate < @end
					AND q.Id = @Id
					GROUP BY accountIDX, modetype
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

			) time
			CROSS APPLY WebQuest q
			WHERE q.Id = @Id			

			IF @@ROWCOUNT = 0
				RETURN (8) --QUEST NOT FOUND
		END
	ELSE IF @type = 3
		--BATTLE MODE Kill
		BEGIN
			SELECT
				time.*,
				QuestTarget
			FROM
			(
				SELECT
					accountIDX,
					ISNULL(SUM(kill_count), 0) AS Progress
				FROM (
					SELECT
						accountIDX,
						modeType,
						SUM([kill]) AS 'kill_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l
					INNER JOIN WebQuest q
					ON q.PlayType = l.playType AND q.Mode = l.modeType
					WHERE regDate >= @start
					AND regDate < @end
					AND q.Id = @Id
					GROUP BY accountIDX, modetype
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

			) time
			CROSS APPLY WebQuest q
			WHERE q.Id = @Id			

			IF @@ROWCOUNT = 0
				RETURN (8) --QUEST NOT FOUND
		END
	ELSE IF @type = 4
		BEGIN
			SELECT
				time.*,
				QuestTarget
			FROM
			(
				SELECT
					accountIDX,
					ISNULL(SUM(play_count), 0) AS Progress
				FROM (
					SELECT
						accountIDX,
						modeType,
						count(playTime) AS 'play_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l
					INNER JOIN WebQuest q
					ON q.PlayType = l.playType AND q.Mode = l.modeType
					WHERE playTime > 0
					AND peso > 0
					AND q.Id = @Id	
					AND regDate >= @start
					AND regDate < @end
					GROUP BY accountIDX, modetype
				) a
				WHERE accountIDX = 2
				GROUP BY accountIDX

			) time
			CROSS APPLY WebQuest q
			WHERE q.Id = @Id

			IF @@ROWCOUNT = 0
				RETURN (8) --QUEST NOT FOUND
		END
		
		RETURN (8) --QUEST NOT FOUND
--SELECT power = ISNULL(SUM(CASE WHEN a.modeType = 1 THEN a.playTime ELSE 0 END), 0),
--	   prisoner = ISNULL(SUM(CASE WHEN a.modeType = 2 THEN a.playTime ELSE 0 END), 0),
--	   hidden = ISNULL(SUM(CASE WHEN a.modeType = 3 THEN a.playTime ELSE 0 END), 0),
--	   death = ISNULL(SUM(CASE WHEN a.modeType = 5 THEN a.playTime ELSE 0 END), 0),
--	   teamdeath = ISNULL(SUM(CASE WHEN a.modeType = 6 THEN a.playTime ELSE 0 END), 0),
--	   bossraid = ISNULL(SUM(CASE WHEN a.modeType = 7 THEN a.playTime ELSE 0 END), 0),
--	   skeletonhero = ISNULL(SUM(CASE WHEN a.modeType = 8 THEN a.playTime ELSE 0 END), 0),
--	   soccer = ISNULL(SUM(CASE WHEN a.modeType = 9 THEN a.playTime ELSE 0 END), 0),
--	   kangsi = ISNULL(SUM(CASE WHEN a.modeType = 11 THEN a.playTime ELSE 0 END), 0),
--	   runningman = ISNULL(SUM(CASE WHEN a.modeType = 14 THEN a.playTime ELSE 0 END), 0),
--	   championplay = ISNULL(SUM(CASE WHEN a.modeType = 15 THEN a.playTime ELSE 0 END), 0),
--	   pve = ISNULL(SUM(CASE WHEN a.modeType = 16 THEN a.playTime ELSE 0 END), 0),
--	   pveSnow = ISNULL(SUM(CASE WHEN a.modeType = 17 THEN a.playTime ELSE 0 END), 0),
--	   pveFire = ISNULL(SUM(CASE WHEN a.modeType = 18 THEN a.playTime ELSE 0 END), 0),
--	   pveFactory = ISNULL(SUM(CASE WHEN a.modeType = 21 THEN a.playTime ELSE 0 END), 0),
--       doubleHidden = ISNULL(SUM(CASE WHEN a.modeType = 19 THEN a.playTime ELSE 0 END), 0),
--       ai = ISNULL(SUM(CASE WHEN a.modeType = 22 THEN a.playTime ELSE 0 END), 0),
--	   GETDATE()
--  FROM (
--	SELECT modeType, SUM(playTime) + SUM(deathTime) AS 'playTime'
--	  FROM dbo.log_data_play
--	 WHERE playType = 4
--	 AND accountIDX = 2
--	   --AND regDate >= @startDate
--	   --AND regdate < @endDate
--	 GROUP BY modetype
--) a

END
GO
/****** Object:  StoredProcedure [dbo].[web_quest_reward_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_quest_reward_get]
(
	@Id int,
	@User varchar(20)
)
As
BEGIN
	SET NOCOUNT ON
	DECLARE @status int;
	DECLARE @cash int;

	Exec @status = web_quest_status_get @Id=@Id, @User=@User;

	IF @status = 2
		BEGIN
			-- TRAN START 
			BEGIN TRAN

			INSERT INTO WebQuestUser (QId, UserID) VALUES (@Id, @User);

			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
				BEGIN
					ROLLBACK TRAN
					RETURN (4)
				END
/*
			INSERT INTO dbo.userPresentDB (sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate)
			SELECT 1, accountIdx, presentType, value1, value2, 0, 0, 1011, 0, DATEADD(DAY, 14, GETDATE()), GETDATE()
			FROM userMemberDB u
			CROSS APPLY WebQuestReward i
			WHERE i.QId = @Id AND i.ItemType = 0
			AND userID = @User;

			IF @@ROWCOUNT = 0 OR @@ERROR <> 0
				BEGIN
					ROLLBACK TRAN
					RETURN (5)
				END
*/
			SELECT @cash = ISNULL(SUM(Value1), 0) FROM WebQuestReward WHERE QId = @Id AND ItemType = 1;
			IF @@ERROR <> 0
				BEGIN
					ROLLBACK TRAN
					RETURN (6)
				END

			UPDATE c 
				SET realCash+= @cash 
			FROM userMoneyDB c
			INNER JOIN userMemberDB m
			ON c.accountIDX = m.accountIDX
			WHERE userID = @User;

			IF @@ROWCOUNT = 0 OR @@ERROR <> 0
				BEGIN
					ROLLBACK TRAN
					RETURN (7)
				END

			-- COMMIT TRAN
			COMMIT TRAN 

			RETURN (9)
		END

	RETURN(@status)
END
GO
/****** Object:  StoredProcedure [dbo].[web_quest_status_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_quest_status_get]
(
	@Id int,
	@User varchar(20)
)
As
BEGIN
	SET NOCOUNT ON
	DECLARE @accountIdx int;
	DECLARE @type int;
	DECLARE @start datetime;
	DECLARE @end datetime;
	DECLARE @rewardEnd datetime;
	DECLARE @status int;

	--Status:
	--3 = Rewarded
	--2 = Completed
	--1 = Not Completed

	SELECT @type = QuestType, @start = QuestStartDate, @end = QuestEndDate, @rewardEnd = RewardEndDate FROM WebQuest WHERE Id = @Id;
	IF @type IS NULL OR @start IS NULL OR @end IS NULL OR @rewardEnd IS NULL OR @@ERROR <> 0
		RETURN (8) --QUEST TYPE NOT FOUND
		
	IF @rewardEnd < getdate()
		RETURN (7) --REWARD END

	SELECT @accountIdx = Id FROM WebLogin WHERE Username = @User;
	IF @accountIdx IS NULL OR @@ERROR <> 0
		RETURN (8) --USER NOT FOUND
		
	SELECT @status = CASE WHEN count(*) > 0 THEN 3 ELSE 2 END FROM WebQuestUser WHERE QId = @Id;
	IF @status IS NULL OR @@ERROR <> 0
		RETURN (8) --Status NOT FOUND

	IF @status = 3
		RETURN (3)

	IF @type = 1
		--Login Event
		BEGIN
			SELECT
				@status = CASE WHEN time.Progress >= QuestTarget THEN 2 ELSE 1 END
			FROM
			(
				SELECT
					accountIDX,
					ISNULL(SUM(playTime), 0) / 60  AS Progress
				FROM [LosaLogData].[dbo].[log_data_playtime] l
				where accountIDX = @accountIdx
				AND regDate >= @start
				AND regDate < @end
				group by accountIDX
			) time
			CROSS APPLY WebQuest q
			WHERE q.Id = @Id

			IF @@ROWCOUNT = 0
				RETURN (8) --QUEST NOT FOUND

			RETURN (@status)
		END
	ELSE IF @type = 2
		--BATTLE MODE Play Time
		BEGIN
			SELECT
				@status = CASE WHEN time.Progress >= QuestTarget THEN 2 ELSE 1 END
			FROM
			(
				SELECT
					accountIDX,
					ISNULL(SUM(playTime), 0) / 60 AS Progress
				FROM (
					SELECT
						accountIDX,
						modeType,
						SUM(playTime) + SUM(deathTime) AS 'playTime'
					FROM  [LosaLogData].[dbo].[log_data_play] l
					INNER JOIN WebQuest q
					ON q.PlayType = l.playType AND q.Mode = l.modeType
					WHERE regDate >= @start
					AND regDate < @end
					AND q.Id = @Id
					GROUP BY accountIDX, modetype
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

			) time
			CROSS APPLY WebQuest q
			WHERE q.Id = @Id			

			IF @@ROWCOUNT = 0
				RETURN (8) --QUEST NOT FOUND

			RETURN (@status)
		END
	ELSE IF @type = 3
		--BATTLE MODE Kill
		BEGIN
			SELECT
				@status = CASE WHEN time.Progress >= QuestTarget THEN 2 ELSE 1 END
			FROM
			(
				SELECT
					accountIDX,
					ISNULL(SUM(kill_count), 0) AS Progress
				FROM (
					SELECT
						accountIDX,
						modeType,
						SUM([kill]) AS 'kill_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l
					INNER JOIN WebQuest q
					ON q.PlayType = l.playType AND q.Mode = l.modeType
					WHERE regDate >= @start
					AND regDate < @end
					AND q.Id = @Id
					GROUP BY accountIDX, modetype
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

			) time
			CROSS APPLY WebQuest q
			WHERE q.Id = @Id			

			IF @@ROWCOUNT = 0
				RETURN (8) --QUEST NOT FOUND

			RETURN (@status)
		END
	ELSE IF @type = 4
		BEGIN
			SELECT
				@status = CASE WHEN time.Progress >= QuestTarget THEN 2 ELSE 1 END
			FROM
			(
				SELECT
					accountIDX,
					ISNULL(SUM(play_count), 0) AS Progress
				FROM (
					SELECT
						accountIDX,
						modeType,
						count(playTime) AS 'play_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l
					INNER JOIN WebQuest q
					ON q.PlayType = l.playType AND q.Mode = l.modeType
					WHERE playTime > 0
					AND peso > 0
					AND q.Id = @Id	
					AND regDate >= @start
					AND regDate < @end
					GROUP BY accountIDX, modetype
				) a
				WHERE accountIDX = 2
				GROUP BY accountIDX

			) time
			CROSS APPLY WebQuest q
			WHERE q.Id = @Id

			IF @@ROWCOUNT = 0
				RETURN (8) --QUEST NOT FOUND

			RETURN (@status)
		END

	RETURN (8) --QUEST NOT FOUND
		
--SELECT power = ISNULL(SUM(CASE WHEN a.modeType = 1 THEN a.playTime ELSE 0 END), 0),
--	   prisoner = ISNULL(SUM(CASE WHEN a.modeType = 2 THEN a.playTime ELSE 0 END), 0),
--	   hidden = ISNULL(SUM(CASE WHEN a.modeType = 3 THEN a.playTime ELSE 0 END), 0),
--	   death = ISNULL(SUM(CASE WHEN a.modeType = 5 THEN a.playTime ELSE 0 END), 0),
--	   teamdeath = ISNULL(SUM(CASE WHEN a.modeType = 6 THEN a.playTime ELSE 0 END), 0),
--	   bossraid = ISNULL(SUM(CASE WHEN a.modeType = 7 THEN a.playTime ELSE 0 END), 0),
--	   skeletonhero = ISNULL(SUM(CASE WHEN a.modeType = 8 THEN a.playTime ELSE 0 END), 0),
--	   soccer = ISNULL(SUM(CASE WHEN a.modeType = 9 THEN a.playTime ELSE 0 END), 0),
--	   kangsi = ISNULL(SUM(CASE WHEN a.modeType = 11 THEN a.playTime ELSE 0 END), 0),
--	   runningman = ISNULL(SUM(CASE WHEN a.modeType = 14 THEN a.playTime ELSE 0 END), 0),
--	   championplay = ISNULL(SUM(CASE WHEN a.modeType = 15 THEN a.playTime ELSE 0 END), 0),
--	   pve = ISNULL(SUM(CASE WHEN a.modeType = 16 THEN a.playTime ELSE 0 END), 0),
--	   pveSnow = ISNULL(SUM(CASE WHEN a.modeType = 17 THEN a.playTime ELSE 0 END), 0),
--	   pveFire = ISNULL(SUM(CASE WHEN a.modeType = 18 THEN a.playTime ELSE 0 END), 0),
--	   pveFactory = ISNULL(SUM(CASE WHEN a.modeType = 21 THEN a.playTime ELSE 0 END), 0),
--       doubleHidden = ISNULL(SUM(CASE WHEN a.modeType = 19 THEN a.playTime ELSE 0 END), 0),
--       ai = ISNULL(SUM(CASE WHEN a.modeType = 22 THEN a.playTime ELSE 0 END), 0),
--	   GETDATE()
--  FROM (
--	SELECT modeType, SUM(playTime) + SUM(deathTime) AS 'playTime'
--	  FROM dbo.log_data_play
--	 WHERE playType = 4
--	 AND accountIDX = 2
--	   --AND regDate >= @startDate
--	   --AND regdate < @endDate
--	 GROUP BY modetype
--) a

END
GO
/****** Object:  StoredProcedure [dbo].[web_ranking_class_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_ranking_class_get]
(
	@id INT
)
As
	SELECT TOP 100
		c.accountIdx AS AccountIdx,
		c.nowRanking AS Rank,
	    m.nickname AS Name,
        CASE WHEN c.prevRanking = 0 THEN 0 ELSE c.prevRanking - c.nowRanking END AS Change,
        c.userLevel AS Level,
		g.userLevel AS UserLevel,
        c.expert AS Expert,
		guild.guildName AS Guild
	FROM userRankingDB_class c WITH (NOLOCK)
	INNER JOIN userMemberDB m WITH (NOLOCK)
	ON c.accountIdx = m.accountIdx
	INNER JOIN userGameDB g WITH (NOLOCK)
	ON g.accountIdx = m.accountIdx
	LEFT JOIN 
	(
		SELECT gd.guildName, gu.accountIDX
		FROM
		[userGuildInfoDB] gu WITH (NOLOCK) 
		INNER JOIN userGuildDB gd WITH (NOLOCK) 
		ON gd.idx = gu.guildIDX
	) guild
	ON guild.accountIDX = m.accountIDX
	WHERE classType = @id	
	ORDER BY nowRanking ASC
GO
/****** Object:  StoredProcedure [dbo].[web_ranking_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
type 1 은 탐사
type 2 는 낚시 순서
type 3 는 가장 높은 계급 순서 출력
type 4 는 돈순서*/
CREATE PROCEDURE [dbo].[web_ranking_get_data]
(
	@type varchar(1),
	@userId varchar(20) = NULL
)
As
BEGIN
	SET NOCOUNT ON
	DECLARE @accountIdx int;

	--Check user exist
	SELECT @accountIdx = Id FROM WebLogin WITH (NOLOCK) WHERE Username = @userId;

	IF @type = 1
		/*
		SELECT TOP 10
			guild.guildName AS Guild,
			m.nickname AS Name ,
			g.userExcavationLevel AS Level,
			g.userExcavationEXP AS Exp
		FROM usergamedb g WITH (NOLOCK) 
		INNER JOIN usermemberdb m WITH (NOLOCK) 
		ON g.accountIDX = m.accountIDX
		LEFT JOIN 
		(
			SELECT gd.guildName, gu.accountIDX
			FROM
			[userGuildInfoDB] gu WITH (NOLOCK) 
			INNER JOIN userGuildDB gd WITH (NOLOCK) 
			ON gd.idx = gu.guildIDX
		) guild
		ON guild.accountIDX = m.accountIDX
		WHERE userType = 100 
		and m.nickName not like '%#%'
		and m.nickName not like 'developer%'
		ORDER BY userExcavationLevel DESC, userExcavationEXP DESC
		*/
		WITH ranking (accountIDX, Guild, Name, Level, Exp, Rank) as 
		(
			SELECT
				g.accountIDX,
				guild.guildName AS Guild,
				m.nickname AS Name ,
				g.userExcavationLevel AS Level,
				g.userExcavationEXP AS Exp,	
				RANK() OVER (ORDER BY g.userExcavationLevel DESC, g.userExcavationEXP DESC) AS Rank
			FROM usergamedb g WITH (NOLOCK) 
			INNER JOIN usermemberdb m WITH (NOLOCK) 
			ON g.accountIDX = m.accountIDX
			LEFT JOIN 
			(
				SELECT gd.guildName, gu.accountIDX
				FROM
				[userGuildInfoDB] gu WITH (NOLOCK) 
				INNER JOIN userGuildDB gd WITH (NOLOCK) 
				ON gd.idx = gu.guildIDX
			) guild
			ON guild.accountIDX = m.accountIDX
			WHERE userType = 100 
			and m.nickName not like '%#%'
			and m.nickName not like 'developer%'
		)
		SELECT TOP 10 * FROM ranking
		UNION ALL
		SELECT * FROM ranking
		WHERE accountIdx IS NULL OR accountIDX = @accountIdx
	else if @type  = 2
		/*
		SELECT TOP 10 
			guild.guildName AS Guild,
			m.nickname AS Name ,
			g.userFishingLevel AS Level,
			g.userFishingEXP AS Exp
		FROM usergamedb g WITH (NOLOCK) 
		INNER JOIN usermemberdb m WITH (NOLOCK) 
		ON g.accountIDX = m.accountIDX
		LEFT JOIN 
		(
			SELECT gd.guildName, gu.accountIDX
			FROM
			[userGuildInfoDB] gu WITH (NOLOCK) 
			INNER JOIN userGuildDB gd WITH (NOLOCK) 
			ON gd.idx = gu.guildIDX
		) guild
		ON guild.accountIDX = m.accountIDX
		WHERE userType = 100 
		and m.nickName not like '%#%'
		and m.nickName not like 'developer%'
		ORDER BY userFishingLevel DESC, userFishingEXP DESC
		*/
		WITH ranking (accountIDX, Guild, Name, Level, Exp, Rank) as 
		(
			SELECT
				g.accountIDX,
				guild.guildName AS Guild,
				m.nickname AS Name ,
				g.userFishingLevel AS Level,
				g.userFishingEXP AS Exp,	
				RANK() OVER (ORDER BY g.userFishingLevel DESC, g.userFishingEXP DESC) AS Rank
			FROM usergamedb g WITH (NOLOCK) 
			INNER JOIN usermemberdb m WITH (NOLOCK) 
			ON g.accountIDX = m.accountIDX
			LEFT JOIN 
			(
				SELECT gd.guildName, gu.accountIDX
				FROM
				[userGuildInfoDB] gu WITH (NOLOCK) 
				INNER JOIN userGuildDB gd WITH (NOLOCK) 
				ON gd.idx = gu.guildIDX
			) guild
			ON guild.accountIDX = m.accountIDX
			WHERE userType = 100 
			and m.nickName not like '%#%'
			and m.nickName not like 'developer%'
		)
		SELECT TOP 10 * FROM ranking
		UNION ALL
		SELECT * FROM ranking
		WHERE accountIdx IS NULL OR accountIDX = @accountIdx
	else if @type  = 3
		/*
		SELECT TOP 10
			guild.guildName AS Guild,
			m.nickname AS Name ,
			g.userLevel AS Level,
			g.userEXP AS Exp
		FROM usergamedb g WITH (NOLOCK) 
		INNER JOIN usermemberdb m WITH (NOLOCK) 
		ON g.accountIDX = m.accountIDX
		LEFT JOIN 
		(
			SELECT gd.guildName, gu.accountIDX
			FROM
			[userGuildInfoDB] gu WITH (NOLOCK) 
			INNER JOIN userGuildDB gd WITH (NOLOCK) 
			ON gd.idx = gu.guildIDX
		) guild
		ON guild.accountIDX = m.accountIDX
		WHERE userType = 100  
		and m.nickName not like '%#%'
		and m.nickName not like 'developer%'
		ORDER BY userlevel DESC, userEXP DESC
		*/
		WITH ranking (accountIDX, Guild, Name, Level, Exp, Rank) as 
		(
			SELECT
				g.accountIDX,
				guild.guildName AS Guild,
				m.nickname AS Name ,
				g.userLevel AS Level,
				g.userEXP AS Exp,	
				RANK() OVER (ORDER BY g.userlevel DESC, g.userEXP DESC) AS Rank
			FROM usergamedb g WITH (NOLOCK) 
			INNER JOIN usermemberdb m WITH (NOLOCK) 
			ON g.accountIDX = m.accountIDX
			LEFT JOIN 
			(
				SELECT gd.guildName, gu.accountIDX
				FROM
				[userGuildInfoDB] gu WITH (NOLOCK) 
				INNER JOIN userGuildDB gd WITH (NOLOCK) 
				ON gd.idx = gu.guildIDX
			) guild
			ON guild.accountIDX = m.accountIDX
			WHERE userType = 100 
			and m.nickName not like '%#%'
			and m.nickName not like 'developer%'
		)
		SELECT TOP 10 * FROM ranking
		UNION ALL
		SELECT * FROM ranking
		WHERE accountIdx IS NULL OR accountIDX = @accountIdx
	else if @type = 4
		/*
		SELECT TOP 10
			guild.guildName AS Guild,
			m.nickname AS Name,
			g.gameMoney AS GP
		FROM usergamedb g WITH (NOLOCK) 
		INNER JOIN usermemberdb m WITH (NOLOCK) 
		ON g.accountIDX = m.accountIDX
		LEFT JOIN 
		(
			SELECT gd.guildName, gu.accountIDX
			FROM
			[userGuildInfoDB] gu WITH (NOLOCK) 
			INNER JOIN userGuildDB gd WITH (NOLOCK) 
			ON gd.idx = gu.guildIDX
		) guild
		ON guild.accountIDX = m.accountIDX
		WHERE userType = 100 
		and m.nickName not like '%#%'
		and m.nickName not like 'developer%'
		ORDER BY gameMoney DESC
		*/
		WITH ranking (accountIDX, Guild, Name, GP, Rank) as 
		(
			SELECT
				g.accountIDX,
				guild.guildName AS Guild,
				m.nickname AS Name,
				g.gameMoney AS GP,	
				RANK() OVER (ORDER BY g.gameMoney DESC) AS Rank
			FROM usergamedb g WITH (NOLOCK) 
			INNER JOIN usermemberdb m WITH (NOLOCK) 
			ON g.accountIDX = m.accountIDX
			LEFT JOIN 
			(
				SELECT gd.guildName, gu.accountIDX
				FROM
				[userGuildInfoDB] gu WITH (NOLOCK) 
				INNER JOIN userGuildDB gd WITH (NOLOCK) 
				ON gd.idx = gu.guildIDX
			) guild
			ON guild.accountIDX = m.accountIDX
			WHERE userType = 100 
			and m.nickName not like '%#%'
			and m.nickName not like 'developer%'
		)
		SELECT TOP 10 * FROM ranking
		UNION ALL
		SELECT * FROM ranking
		WHERE accountIdx IS NULL OR accountIDX = @accountIdx
	else if @type = 5
		/*
		SELECT TOP 10
			m.nickname AS Name,
			db.cnt AS Qty
		FROM
		(
			SELECT accountIDX, count(itemCode) as cnt
			FROM
			(
				SELECT DISTINCT accountIDX, itemCode
				FROM userCostumeDB WITH (NOLOCK) 
			) uc
			GROUP BY accountIDX
		) db		
		INNER JOIN usermemberdb m WITH (NOLOCK) 
		ON db.accountIDX = m.accountIDX		
		WHERE userType = 100  
		and m.nickName not like '%#%'
		and m.nickName not like 'developer%'
		ORDER BY cnt DESC
		*/
		WITH ranking (accountIDX, Guild, Name, Qty, Rank) as 
		(
			SELECT
				db.accountIDX,
				guild.guildName AS Guild,
				m.nickname AS Name,
				db.cnt AS Qty,
				RANK() OVER (ORDER BY db.cnt DESC) AS Rank
			FROM
			(
				SELECT accountIDX, count(itemCode) as cnt
				FROM
				(
					SELECT DISTINCT accountIDX, itemCode
					FROM userCostumeDB WITH (NOLOCK) 
				) uc
				GROUP BY accountIDX
			) db		
			INNER JOIN usermemberdb m WITH (NOLOCK) 
			ON db.accountIDX = m.accountIDX
			LEFT JOIN 
			(
				SELECT gd.guildName, gu.accountIDX
				FROM
				[userGuildInfoDB] gu WITH (NOLOCK) 
				INNER JOIN userGuildDB gd WITH (NOLOCK) 
				ON gd.idx = gu.guildIDX
			) guild
			ON guild.accountIDX = m.accountIDX
			WHERE userType = 100  
			and m.nickName not like '%#%'
			and m.nickName not like 'developer%'
		)
		SELECT TOP 10 * FROM ranking
		UNION ALL
		SELECT * FROM ranking
		WHERE accountIdx IS NULL OR accountIDX = @accountIdx
END
GO
/****** Object:  StoredProcedure [dbo].[web_reset_all_event_item]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_reset_all_event_item]
(
	@itemCode int = NULL
)
As

begin
	--1001913 - CLOVER
	--1005165 - Winter Coin [Gold]
	--1005166 - Winter Coin [Silver]
	--1005167 - Winter Coin [Bronze]
	--1000049 - Event Item
	--1002134 - Roulette Coupon
	--1002135 - Bingo Board
	--1002136 - Draw Number
	--1002137 - Suffle Number (Not Use)
	--1002138 - Prize Change
	--1002139 - Guaranteed Number

	IF @itemCode IS NULL
		RETURN (-1)
		
	-- TRAN START 
	BEGIN TRAN

	UPDATE dbo.userItemEtcDB
		SET item1_type		= 0,
			item1_value1	= 0, 
			item1_value2	= 0 
		WHERE item1_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (1)
	END

	UPDATE dbo.userItemEtcDB
		SET item2_type		= 0,
			item2_value1	= 0, 
			item2_value2	= 0 
		WHERE item2_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (2)
	END

	UPDATE dbo.userItemEtcDB
		SET item3_type		= 0,
			item3_value1	= 0, 
			item3_value2	= 0 
		WHERE item3_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (3)
	END

	UPDATE dbo.userItemEtcDB
		SET item4_type		= 0,
			item4_value1	= 0, 
			item4_value2	= 0 
		WHERE item4_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (4)
	END

	UPDATE dbo.userItemEtcDB
		SET item5_type		= 0,
			item5_value1	= 0, 
			item5_value2	= 0 
		WHERE item5_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (5)
	END
	
	UPDATE dbo.userItemEtcDB
		SET item6_type		= 0,
			item6_value1	= 0, 
			item6_value2	= 0 
		WHERE item6_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (6)
	END
	
	UPDATE dbo.userItemEtcDB
		SET item7_type		= 0,
			item7_value1	= 0, 
			item7_value2	= 0 
		WHERE item7_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (7)
	END
	
	UPDATE dbo.userItemEtcDB
		SET item8_type		= 0,
			item8_value1	= 0, 
			item8_value2	= 0 
		WHERE item8_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (8)
	END
	
	UPDATE dbo.userItemEtcDB
		SET item9_type		= 0,
			item9_value1	= 0, 
			item9_value2	= 0 
		WHERE item9_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (9)
	END
	
	UPDATE dbo.userItemEtcDB
		SET item10_type		= 0,
			item10_value1	= 0, 
			item10_value2	= 0 
		WHERE item10_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (10)
	END
	
	UPDATE dbo.userItemEtcDB
		SET item11_type		= 0,
			item11_value1	= 0, 
			item11_value2	= 0 
		WHERE item11_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (11)
	END

	UPDATE dbo.userItemEtcDB
		SET item12_type		= 0,
			item12_value1	= 0, 
			item12_value2	= 0 
		WHERE item12_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (12)
	END
	
	UPDATE dbo.userItemEtcDB
		SET item13_type		= 0,
			item13_value1	= 0, 
			item13_value2	= 0 
		WHERE item13_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (13)
	END
		
	UPDATE dbo.userItemEtcDB
		SET item14_type		= 0,
			item14_value1	= 0, 
			item14_value2	= 0 
		WHERE item14_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (14)
	END
		
	UPDATE dbo.userItemEtcDB
		SET item15_type		= 0,
			item15_value1	= 0, 
			item15_value2	= 0 
		WHERE item15_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (15)
	END
	
	UPDATE dbo.userItemEtcDB
		SET item16_type		= 0,
			item16_value1	= 0, 
			item16_value2	= 0 
		WHERE item16_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (16)
	END
		
	UPDATE dbo.userItemEtcDB
		SET item17_type		= 0,
			item17_value1	= 0, 
			item17_value2	= 0 
		WHERE item17_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (17)
	END
		
	UPDATE dbo.userItemEtcDB
		SET item18_type		= 0,
			item18_value1	= 0, 
			item18_value2	= 0 
		WHERE item18_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (18)
	END
		
	UPDATE dbo.userItemEtcDB
		SET item19_type		= 0,
			item19_value1	= 0, 
			item19_value2	= 0 
		WHERE item19_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (19)
	END

	UPDATE dbo.userItemEtcDB
		SET item20_type		= 0,
			item20_value1	= 0, 
			item20_value2	= 0 
		WHERE item20_type = @itemCode
			
	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRAN
		RETURN (20)
	END

	-- COMMIT TRAN
	COMMIT TRAN 

	RETURN (0)
end
GO
/****** Object:  StoredProcedure [dbo].[web_roulette_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_roulette_get]
(
	@rid int
)
As
	SELECT
		r.Id AS Id,
		r.Name AS RouletteName,
		r.Description AS RouletteDescription,
		i.Name AS CostName,
		r.Cost AS Cost,
		CASE WHEN r.Status = 1 THEN
			CASE WHEN GETDATE() BETWEEN r.StartDate AND r.EndDate THEN 1 ELSE 0 END
		ELSE 0 END AS Status,
		rd.Id AS ItemId,
		rd.Name AS ItemName,
		rd.Image As ItemImage,
		rd.Flag AS Flag
	FROM WebRoulette r WITH (NOLOCK)
	INNER JOIN WebRouletteReward rd WITH (NOLOCK)
	ON rd.Rid = r.Id
	INNER JOIN WebRouletteItem i WITH (NOLOCK)
	ON i.Id = r.CostItem
	WHERE r.Id = @rid
	ORDER BY rd.Id
GO
/****** Object:  StoredProcedure [dbo].[web_roulette_history_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_roulette_history_get]
(
	@rid int
)
As
	SELECT TOP 10
		Flag,
		Nickname,
		RewardName,
		RewardDate
	FROM WebRouletteRewardLog r WITH (NOLOCK)
	WHERE/* r.RouletteId = @rid AND*/ Flag > 0
	ORDER BY r.RewardDate DESC
GO
/****** Object:  StoredProcedure [dbo].[web_roulette_item_buy]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_roulette_item_buy]
(
	@itemid int,
	@userId varchar(20)
)
As
	BEGIN
		SET NOCOUNT ON
		DECLARE @cnt int;
		DECLARE @amount int;
		DECLARE @price int;
		DECLARE @accountIdx int;
		SET @amount = 10;
		SET @price = 299;--599

		--Check user exist
		SELECT @accountIdx = Id FROM WebLogin WHERE Username = @userId;
		IF @accountIdx IS NULL
		BEGIN
			RETURN (-1)
		END

		--Check Item Valid
		If @itemid NOT IN (1)
		BEGIN
			RETURN (-2)
		END

		--Check Enough Money (500 BP)
		SELECT @cnt = realCash FROM userMoneyDB WHERE accountIDX = @accountIdx;
		IF @cnt < @price
		BEGIN
			RETURN (-3)
		END	

		-- TRAN START
		BEGIN TRAN		
		-- Reward
		SELECT @cnt = count(*) FROM WebRouletteUserItem WHERE ItemId = @itemid AND AccountIdx = @accountIdx;
		IF @cnt = 0
			BEGIN
				INSERT INTO WebRouletteUserItem (AccountIdx, ItemId, Amount) VALUES (@accountIdx, @itemid, @amount);
			END
		ELSE
			BEGIN
				UPDATE WebRouletteUserItem SET Amount += @amount WHERE AccountIdx = @accountIdx AND ItemId = @itemid;
			END

		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-4)
			END	

		-- Pay Cash
		UPDATE userMoneyDB SET realCash -= @price WHERE accountIDX = @accountIdx AND realCash >= @price;
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-5)
			END	

		-- Log
		INSERT INTO WebRoulettePayLog (AccountIdx, ItemId, Amount, Paid) VALUES (@accountIdx, @itemId, @amount, @price);
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-6)
			END	
			
		-- event only
		/*
		INSERT INTO dbo.userPresentDB (sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate) VALUES
		(1, @accountIdx, 3, 1000049, 2, 0, 0, 1011, 0, DATEADD(DAY, 14, GETDATE()), GETDATE());
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-6)
			END	
		*/
		-- COMMIT TRAN
		COMMIT TRAN 
		RETURN (@amount)
	END
GO
/****** Object:  StoredProcedure [dbo].[web_roulette_item_reset]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_roulette_item_reset]
As
BEGIN
	DECLARE @item INT;
	SET @item = 1;
	UPDATE WebRouletteUserItem
	SET Amount = 0
	WHERE Amount > 0
	;
END
GO
/****** Object:  StoredProcedure [dbo].[web_roulette_mission_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_roulette_mission_add]
(
	@rid int,
	@mid int,
	@userId varchar(20)
)
As
	BEGIN
		SET NOCOUNT ON
		DECLARE @cnt int;
		DECLARE @accountIdx int;
		DECLARE @rewardId int;
		DECLARE @amount int;
		DECLARE @missionCnt int;
		SET @missionCnt = 0;

		--Check user exist
		SELECT @accountIdx = Id FROM WebLogin WITH (NOLOCK) WHERE Username = @userId;
		IF @accountIdx IS NULL
		BEGIN
			RETURN (-1)
		END

		--Check Roulette Available
		SELECT @cnt = count(*) FROM WebRoulette WHERE GETDATE() BETWEEN StartDate AND EndDate AND Id = @rid AND Status = 1;
		IF @cnt = 0
		BEGIN
			RETURN (-2)
		END

		--Check Mission Valid
		If @mid NOT IN (5, 6, 7, 12, 8, 15)
		BEGIN
			RETURN (-3)
		END

		--Check Mission Complete
		SELECT @cnt = count(*) FROM WebRouletteUserMission WHERE CONVERT(DATE, CompleteDate) = CONVERT(DATE, GETDATE()) AND MissionId = @mid AND AccountIdx = @accountIdx;
		IF @cnt > 0
		BEGIN
			RETURN (-4)
		END

		--Check User Mission
		IF @mid = 1 --LOGIN THE GAME
			BEGIN
				SELECT
					@missionCnt = COUNT(connDate)
				FROM userLoginDB WITH (NOLOCK)
				WHERE accountIdx = @accountIdx 
				AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, connDate), 0) 

				IF @missionCnt IS NULL OR @missionCnt < 1
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 2 --Play Time (60 Minutes)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(playTime), 0) / 60
				FROM (
					SELECT
						accountIDX,
						SUM(playTime) + SUM(deathTime) AS 'playTime'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 0
					AND peso > 0
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX;

				IF @missionCnt IS NULL OR @missionCnt < 60
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 3 --Play Prisoner Mode (6 times)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(play_count), 0)
				FROM (
					SELECT
						accountIDX,
						count(playTime) AS 'play_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 0
					AND peso > 0
					AND l.modeType = 2
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

				IF @missionCnt IS NULL OR @missionCnt < 6
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 4 --Finish Any Monster Dungeon (Master) (5 times)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(play_count), 0)
				FROM (
					SELECT
						accountIDX,
						count(playTime) AS 'play_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 0
					AND peso > 0
					AND l.modeType IN (16, 17, 18, 21)
					AND l.subType1 = 4 --MASTER
					AND l.win = 1
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

				IF @missionCnt IS NULL OR @missionCnt < 5
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 5 --Finish Crusade Mode Floor 41 ~ 60 (1 Time)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(play_count), 0)
				FROM (
					SELECT
						accountIDX,
						count(playTime) AS 'play_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 0
					AND peso > 0
					AND l.modeType = 8
					AND l.subType1 = 3
					AND l.win = 1
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

				IF @missionCnt IS NULL OR @missionCnt < 1
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 6 --Donate 500BP
			BEGIN
				SELECT
					 @missionCnt = ISNULL(SUM(New), 0)
				FROM WebTransaction WITH (NOLOCK)
				WHERE DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, Time), 0)
				AND Uid = @userId

				IF @missionCnt IS NULL OR @missionCnt < 500
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 7 --Stay Online (60 Minutes)
			BEGIN
				SELECT
					@missionCnt = a.play_count
				FROM
				(
					SELECT
						accountIDX,
						ISNULL(SUM(playTime), 0) / 60  AS 'play_count'
					FROM [LosaLogData].[dbo].[log_data_playtime] l WITH (NOLOCK)
					where accountIDX = @accountIdx
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					group by accountIDX
				) a

				IF @missionCnt IS NULL OR @missionCnt < 60
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 8 --Play Time (30 Minutes)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(playTime), 0) / 60
				FROM (
					SELECT
						accountIDX,
						SUM(playTime) + SUM(deathTime) AS 'playTime'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 0
					AND peso > 0
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX;

				IF @missionCnt IS NULL OR @missionCnt < 30
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 9 --Play Prisoner Mode (8 times)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(play_count), 0)
				FROM (
					SELECT
						accountIDX,
						count(playTime) AS 'play_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 0
					AND peso > 0
					AND l.modeType = 2
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

				IF @missionCnt IS NULL OR @missionCnt < 8
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 10 --Finish Fire Temple (Master) (4 times)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(play_count), 0)
				FROM (
					SELECT
						accountIDX,
						count(playTime) AS 'play_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 0
					AND peso > 0
					AND l.modeType = 18 --Fire Temple
					AND l.subType1 = 4 --MASTER
					AND l.win = 1
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

				IF @missionCnt IS NULL OR @missionCnt < 4
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 11 --Finish Secret Factory (Master) (4 times)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(play_count), 0)
				FROM (
					SELECT
						accountIDX,
						count(playTime) AS 'play_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 0
					AND peso > 0
					AND l.modeType = 21 --Secret Factory
					AND l.subType1 = 4 --MASTER
					AND l.win = 1
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

				IF @missionCnt IS NULL OR @missionCnt < 4
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 12 --Finish Deep Forest (Master) (4 times)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(play_count), 0)
				FROM (
					SELECT
						accountIDX,
						count(playTime) AS 'play_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 0
					AND peso > 0
					AND l.modeType = 16 --Deep Forest
					AND l.subType1 = 4 --MASTER
					AND l.win = 1
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

				IF @missionCnt IS NULL OR @missionCnt < 4
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 13 --Finish Snow Town (Master) (4 times)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(play_count), 0)
				FROM (
					SELECT
						accountIDX,
						count(playTime) AS 'play_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 0
					AND peso > 0
					AND l.modeType = 17 --Snow Town
					AND l.subType1 = 4 --MASTER
					AND l.win = 1
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

				IF @missionCnt IS NULL OR @missionCnt < 4
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 14 --Play Time (60 Minutes)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(playTime), 0) / 60
				FROM (
					SELECT
						accountIDX,
						SUM(playTime) + SUM(deathTime) AS 'playTime'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 0
					AND peso > 0
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX;

				IF @missionCnt IS NULL OR @missionCnt < 60
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 15 --Play Prisoner Mode (4 times)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(play_count), 0)
				FROM (
					SELECT
						accountIDX,
						count(playTime) AS 'play_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 0
					AND peso > 0
					AND l.modeType = 2
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

				IF @missionCnt IS NULL OR @missionCnt < 4
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 16 --Play Faction War (3 times)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(play_count), 0)
				FROM (
					SELECT
						accountIDX,
						count(playTime) AS 'play_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 5
					AND peso > 0
					AND l.modeType = 10
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

				IF @missionCnt IS NULL OR @missionCnt < 3
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 17 --Play Ghost Tag Mode (5 times)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(play_count), 0)
				FROM (
					SELECT
						accountIDX,
						count(playTime) AS 'play_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 0
					AND peso > 0
					AND l.modeType = 11
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

				IF @missionCnt IS NULL OR @missionCnt < 5
				BEGIN
					RETURN (-5)
				END	
			END		
		ELSE IF @mid = 18 --Play Football Mode (4 times)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(play_count), 0)
				FROM (
					SELECT
						accountIDX,
						count(playTime) AS 'play_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 0
					AND peso > 0
					AND l.modeType = 9
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

				IF @missionCnt IS NULL OR @missionCnt < 4
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 19 --Finish Snow Town (Master) in 3:30 (1 time)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(play_count), 0)
				FROM (
					SELECT
						accountIDX,
						count(playTime) AS 'play_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 0
					AND peso > 1000
					AND l.modeType = 17 --Snow Town
					AND l.subType1 = 4 --MASTER
					AND l.win = 1
					AND l.playTime > 60
					AND l.playTime<= 210
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

				IF @missionCnt IS NULL OR @missionCnt < 1
				BEGIN
					RETURN (-5)
				END	
			END	
		ELSE IF @mid = 20 --Play Beast Raid Mode (4 times)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(play_count), 0)
				FROM (
					SELECT
						accountIDX,
						count(playTime) AS 'play_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 0
					AND peso > 0
					AND l.modeType = 7
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

				IF @missionCnt IS NULL OR @missionCnt < 4
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 21 --Play Bare Bones Mode (4 times)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(play_count), 0)
				FROM (
					SELECT
						accountIDX,
						count(playTime) AS 'play_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 0
					AND peso > 0
					AND l.modeType = 25
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

				IF @missionCnt IS NULL OR @missionCnt < 4
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 22 --Play Classic Mode Mode (4 times)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(play_count), 0)
				FROM (
					SELECT
						accountIDX,
						count(playTime) AS 'play_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 0
					AND peso > 0
					AND l.modeType = 26
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

				IF @missionCnt IS NULL OR @missionCnt < 4
				BEGIN
					RETURN (-5)
				END	
			END
		ELSE IF @mid = 23 --Play Raid Mode (4 times)
			BEGIN
				SELECT
					@missionCnt = ISNULL(SUM(play_count), 0)
				FROM (
					SELECT
						accountIDX,
						count(playTime) AS 'play_count'
					FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
					WHERE playTime > 0
					AND peso > 0
					AND l.modeType = 27
					AND DATEADD(day, DATEDIFF(day, 0, GETDATE()), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
					GROUP BY accountIDX
				) a
				WHERE accountIDX = @accountIdx
				GROUP BY accountIDX

				IF @missionCnt IS NULL OR @missionCnt < 4
				BEGIN
					RETURN (-5)
				END	
			END
		-- Get Reward
		SELECT @rewardId = RewardItem, @amount = Amount FROM WebRouletteMission WHERE Id = @mid;
		IF @rewardId IS NULL OR  @amount IS NULL
		BEGIN
			RETURN (-6)
		END		

		-- TRAN START
		BEGIN TRAN		
		-- Reward
		SELECT @cnt = count(*) FROM WebRouletteUserItem WHERE ItemId = @rewardId AND AccountIdx = @accountIdx;
		IF @cnt = 0
			BEGIN
				INSERT INTO WebRouletteUserItem (AccountIdx, ItemId, Amount) VALUES (@accountIdx, @rewardId, @amount);
			END
		ELSE
			BEGIN
				UPDATE WebRouletteUserItem SET Amount += @amount WHERE AccountIdx = @accountIdx AND ItemId = @rewardId;
			END

		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-7)
			END	

		-- Log
		INSERT INTO WebRouletteUserMission (AccountIdx, MissionId) VALUES (@accountIdx, @mid);
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-8)
			END	

		-- event only
		/*
		INSERT INTO dbo.userPresentDB (sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate) VALUES
		(1, @accountIdx, 3, 1000049, 1, 0, 0, 1011, 0, DATEADD(DAY, 14, GETDATE()), GETDATE());
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-8)
			END	
		*/
		-- COMMIT TRAN
		COMMIT TRAN 
		RETURN (@amount)
	END
GO
/****** Object:  StoredProcedure [dbo].[web_roulette_mission_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_roulette_mission_get]
(
	@missionList varchar(max)
)
As
	SELECT
		m.Id,
		m.Name,
		m.Description,
		i.Name As RewardName,
		m.Amount As RewardAmount,
		m.Flag As Flag
	FROM WebRouletteMission m WITH (NOLOCK)
	INNER JOIN WebRouletteItem i WITH (NOLOCK)
	ON m.RewardItem = i.Id
	WHERE m.Id IN (SELECT word FROM dbo.udf_Split(@missionList, ','))
	ORDER BY Flag, Id;
GO
/****** Object:  StoredProcedure [dbo].[web_roulette_name_update]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_roulette_name_update]
As
BEGIN
	UPDATE l
	SET l.Nickname = m.nickname
	From WebRouletteRewardLog l
	INNER JOIN userMemberDB m
	ON l.AccountIdx = m.accountIDX
	WHERE l.Nickname != m.nickname;
END
GO
/****** Object:  StoredProcedure [dbo].[web_roulette_rewardlist_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_roulette_rewardlist_get]
(
	@rid int,
	@userId varchar(20) = NULL
)
As
BEGIN
	SET NOCOUNT ON
	DECLARE @lucky int;
	DECLARE @extra int;	
	DECLARE @accountIdx int;
	DECLARE @myluck int;
	SET @extra = 0;
	SET @myluck = 0;

	SELECT @lucky = Lucky FROM WebRouletteSetting WITH (NOLOCK) WHERE Id = 1;
	IF @lucky IS NOT NULL
		BEGIN			
			IF @lucky > 1800
				BEGIN
					SET @extra = 12;
				END
			ELSE IF @lucky > 1100
				BEGIN
					SET @extra = 8;
				END
			ELSE IF @lucky > 500
				BEGIN
					SET @extra = 5;
				END
		END
	
	--Check user exist
	SELECT @accountIdx = Id FROM WebLogin WITH (NOLOCK) WHERE Username = @userId;

	--MyLuck
	SELECT @myluck = Lucky From WebRouletteUserLucky WITH (NOLOCK) WHERE RouletteId = @rid AND AccountIdx = @accountIdx;

	IF @accountIdx IS NOT NULL AND @myluck >= 50
		BEGIN
			SELECT
				Id AS ItemId,
				Rate + CASE WHEN Flag = 2 THEN @extra ELSE 0 END As Rate
			FROM WebRouletteReward WITH (NOLOCK)
			WHERE rId = @rid
			AND Flag > 0;
		END
	ELSE
		BEGIN
			SELECT
				Id AS ItemId,
				Rate + CASE WHEN Flag = 2 THEN @extra ELSE 0 END As Rate
			FROM WebRouletteReward WITH (NOLOCK)
			WHERE rId = @rid;
		END
END
GO
/****** Object:  StoredProcedure [dbo].[web_roulette_setting_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_roulette_setting_get]
(
	@id int
)
As
	SELECT
		RouletteId,
		ItemId
	FROM WebRouletteSetting WITH (NOLOCK)
	WHERE Id = @id
GO
/****** Object:  StoredProcedure [dbo].[web_roulette_sp_mission_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_roulette_sp_mission_add]
(
	@mid int,
	@userId varchar(20)
)
As
	BEGIN
		SET NOCOUNT ON
		DECLARE @cnt int;
		DECLARE @accountIdx int;
		DECLARE @required int;
		DECLARE @rewardType int;
		DECLARE @rewardValue1 int;
		DECLARE @rewardValue2 int;
		DECLARE @start datetime;
		DECLARE @end datetime;

		--Check user exist
		SELECT @accountIdx = Id FROM WebLogin WITH (NOLOCK) WHERE Username = @userId;
		IF @accountIdx IS NULL
		BEGIN
			RETURN (-1)
		END
		
		SELECT @required = Spin, @rewardType = PresentType, @rewardValue1 = Value1, @rewardValue2 = Value2, @start = DateFrom, @end = DateTo
		FROM WebRouletteSPMission WITH (NOLOCK) WHERE Id = @mid AND Enabled = 1 AND GETDATE() BETWEEN DateFrom AND DateTo;
		--Check Mission Valid
		If @required IS NULL OR @required <= 0
		BEGIN
			RETURN (-2)
		END

		--Check Mission Complete
		SELECT @cnt = count(*) FROM WebRouletteSPMissionLog WHERE MissionId = @mid AND AccountIdx = @accountIdx;
		IF @cnt > 0
		BEGIN
			RETURN (-3)
		END

		--Check User Mission
		SELECT @cnt = count(*) FROM WebRouletteRewardLog WHERE RewardDate BETWEEN @start AND @end AND AccountIdx = @accountIdx;
		IF @cnt < @required
		BEGIN
			RETURN (-4)
		END

		-- TRAN START
		BEGIN TRAN		
		-- Reward
		INSERT INTO dbo.userPresentDB (sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate) VALUES
		(1, @accountIdx, @rewardType, @rewardValue1, @rewardValue2, 0, 0, 1011, 0, DATEADD(DAY, 14, GETDATE()), GETDATE());

		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-5)
			END	

		-- Log
		INSERT INTO WebRouletteSPMissionLog (AccountIdx, MissionId) VALUES (@accountIdx, @mid);
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-6)
			END	

		-- COMMIT TRAN
		COMMIT TRAN 
		RETURN (1)
	END
GO
/****** Object:  StoredProcedure [dbo].[web_roulette_sp_mission_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_roulette_sp_mission_get]
(
	@userId varchar(20) = NULL
)
As
	BEGIN
		SET NOCOUNT ON
		DECLARE @cnt int;
		DECLARE @accountIdx int;

		--Check user exist
		SELECT @accountIdx = Id FROM WebLogin WITH (NOLOCK) WHERE Username = @userId;

		SELECT
			Id,
			Name,
			Description,
			CASE WHEN Spin - Spinned > 0 THEN Spin - Spinned ELSE 0 END AS SpinNeed,
			RewardName
		FROM WebRouletteSPMission m WITH (NOLOCK)
		CROSS APPLY
		(
			SELECT count(*) AS Spinned FROM WebRouletteRewardLog WITH (NOLOCK) WHERE AccountIdx = @accountIdx AND RewardDate BETWEEN m.DateFrom AND m.DateTo
		) total
		WHERE Enabled = 1 AND GETDATE() BETWEEN m.DateFrom AND m.DateTo
END
GO
/****** Object:  StoredProcedure [dbo].[web_roulette_use]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_roulette_use]
(
	@rid int,
	@userId varchar(20),
	@rewardId int
)
As
	BEGIN
		SET NOCOUNT ON
		DECLARE @cnt int;
		DECLARE @accountIdx int;
		DECLARE @costitem int;
		DECLARE @amount int;
		DECLARE @cash int;
		DECLARE @bonusCash int;
		DECLARE @flag int;
		DECLARE @myluck int;
		DECLARE @new_id int;
		SET @cash = 0;
		SET @bonusCash = 0;
		SET @flag = 0;

		--Check user exist
		SELECT @accountIdx = Id FROM WebLogin WITH (NOLOCK) WHERE Username = @userId;
		IF @accountIdx IS NULL
		BEGIN
			RETURN (-1)
		END

		--Check Roulette Available
		SELECT @cnt = count(*) FROM WebRoulette WITH (NOLOCK) WHERE GETDATE() BETWEEN StartDate AND EndDate AND Id = @rid AND Status = 1;
		IF @cnt = 0
		BEGIN
			RETURN (-2)
		END

		--Check Ticket
		SELECT
			@cnt = i.Amount,
			@amount = r.Cost,
			@costitem = r.CostItem
		FROM WebRoulette r WITH (NOLOCK)
		INNER JOIN WebRouletteUserItem i WITH (NOLOCK)
		ON r.CostItem = i.ItemId AND i.Amount >= r.Cost
		WHERE r.Id = @rid AND i.AccountIdx = @accountIdx;
		IF @@ROWCOUNT <> 1 OR @cnt = 0 OR @amount = 0
		BEGIN
			RETURN (-3)
		END
		IF @cnt < @amount
		BEGIN
			RETURN (-4)
		END

		--Check Reward Valid
		SELECT @cnt = count(*) FROM WebRouletteReward WITH (NOLOCK) WHERE RId = rid AND Id = @rewardId;
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
		BEGIN
			RETURN (-5)
		END
		-- TRAN START
		BEGIN TRAN

		--Deduce Item
		UPDATE WebRouletteUserItem
		SET Amount -= @amount
		WHERE AccountIdx = @accountIdx AND ItemId = @costitem;
			
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (-6)
		END		

		--Add Reward
		INSERT INTO dbo.userPresentDB (sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate)
		SELECT 1, @accountIdx, presentType, value1, value2, 0, 0, 1011, 0, DATEADD(DAY, 14, GETDATE()), GETDATE()
		FROM WebRouletteReward r WITH (NOLOCK)
		WHERE r.RId = @rid AND r.Id = @rewardId AND r.ItemType = 0;

		IF @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-7)
			END

		--Add Cash
		SELECT @cash = ISNULL(SUM(Value1), 0) FROM WebRouletteReward WITH (NOLOCK) WHERE RId = @rid AND Id = @rewardId AND ItemType = 1;
		IF @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-7)
			END

		--Add Bonus Cash
		SELECT @bonusCash = ISNULL(SUM(Value1), 0) FROM WebRouletteReward WITH (NOLOCK) WHERE RId = @rid AND Id = @rewardId AND ItemType = 2;
		IF @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-7)
			END

		UPDATE c 
		SET
			realCash+= @cash,
			bonusCash += @bonusCash
		FROM userMoneyDB c
		INNER JOIN userMemberDB m
		ON c.accountIDX = m.accountIDX
		WHERE userID = @userID;

		IF @@ROWCOUNT = 0 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-7)
			END

		--Add Lucky / Change Roulette
		UPDATE WebRouletteSetting SET Lucky +=1 WHERE Id = 1;--fixed ID

		--Add My Lucky
		SELECT @myluck = Lucky From WebRouletteUserLucky WHERE RouletteId = @rid AND AccountIdx = @accountIdx;
		IF @myluck IS NULL
			BEGIN
				INSERT INTO WebRouletteUserLucky (AccountIdx, RouletteId, Lucky) VALUES (@accountIdx, @rid, 1);
			END
		ELSE
			BEGIN
				IF @myLuck >= 50
					BEGIN
						UPDATE WebRouletteUserLucky SET Lucky = 1 WHERE RouletteId = @rid AND AccountIdx = @accountIdx;
					END
				ELSE
					BEGIN
						UPDATE WebRouletteUserLucky SET Lucky += 1 WHERE RouletteId = @rid AND AccountIdx = @accountIdx;
					END
			END

		--Add Log
		INSERT INTO WebRouletteRewardLog (AccountIdx, Nickname, RouletteId, RewardName, Flag)
		SELECT @accountIdx, nickname, @rid, r.Name, CASE WHEN @myluck >= 50 THEN 0 ELSE r.Flag END
		FROM userMemberDB m WITH (NOLOCK)
		INNER JOIN WebRouletteReward r WITH (NOLOCK)
		ON r.RId = @rid AND r.Id = @rewardId AND accountIDX = @accountIdx;
		IF @@ROWCOUNT = 0 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-8)
			END

		SELECT @flag = Flag FROM WebRouletteReward r WHERE r.RId = @rid AND r.Id = @rewardId;
		IF @flag = 2 AND @myLuck < 50 --MAX PRIZE
			BEGIN
				--check next roulette
				SELECT @new_id = r.Id FROM WebRouletteSetting s WITH (NOLOCK) LEFT JOIN WebRoulette r WITH (NOLOCK) ON s.NextRoulette = r.Id WHERE s.Id = 1 AND GETDATE() BETWEEN r.StartDate AND r.EndDate;
				IF @new_id IS NULL
					BEGIN
						--random
						SELECT TOP 1 @new_id = Id FROM WebRoulette WITH (NOLOCK) WHERE Id != @rid AND GETDATE() BETWEEN StartDate AND EndDate ORDER BY NEWID()
					END
				--SET @new_id = 9;
				IF @new_id IS NOT NULL
					BEGIN
						UPDATE WebRouletteSetting SET RouletteId = @new_id, Lucky = 0, NextRoulette = NULL, UpdateDate = GETDATE() WHERE Id = 1; -- fixed
						UPDATE WebRoulette SET Status = 0 WHERE Id = @rid;
						UPDATE WebRoulette SET Status = 1 WHERE Id = @new_id;
					END
			END

		-- COMMIT TRAN
		COMMIT TRAN 
		RETURN (1)
	END
GO
/****** Object:  StoredProcedure [dbo].[web_roulette_useritem_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_roulette_useritem_get]
(
	@itemid int,
	@userId varchar(20) = NULL
)
As
BEGIN
IF @userId IS NOT NULL
	SELECT 
		i.Name,
		u.Amount
	FROM
	(
		SELECT
			l.Username,
			ISNULL(u.ItemId, @itemid) As ItemId,
			ISNULL(u.Amount, 0) AS Amount
		FROM WebLogin l WITH (NOLOCK)
		LEFT JOIN WebRouletteUserItem u WITH (NOLOCK)
		ON u.AccountIdx = l.Id AND u.ItemId = @itemid
		WHERE Username = @userId
	) u
	INNER JOIN WebRouletteItem i WITH (NOLOCK)
	ON i.Id = u.ItemId
	WHERE i.Id = @itemid;
ELSE
	SELECT 
		i.Name,
		0 AS Amount
	FROM WebRouletteItem i WITH (NOLOCK)
	WHERE i.Id = @itemId;
END
GO
/****** Object:  StoredProcedure [dbo].[web_roulette_userluck_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_roulette_userluck_get]
(
	@rid int,
	@userId varchar(20) = NULL
)
As
BEGIN
	SET NOCOUNT ON
	DECLARE @accountIdx int;
	DECLARE @luck int;
	SET @luck = 0;

	--Check user exist
	SELECT @accountIdx = Id FROM WebLogin WITH (NOLOCK) WHERE Username = @userId;
	IF @accountIdx IS NOT NULL
		BEGIN
			SELECT
				@luck = Lucky
			From WebRouletteUserLucky
			WHERE RouletteId = @rid AND AccountIdx = @accountIdx;
		END
		
	SELECT @luck AS Lucky;
END
GO
/****** Object:  StoredProcedure [dbo].[web_ticket_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_ticket_add]
(
	@userID varchar(20),
	@subject varchar(200),
	@type int,
	@content VARCHAR(MAX),
	@ipaddress varchar(15)
)
As
	BEGIN
		SET NOCOUNT ON 		
		DECLARE @cnt int;
		SELECT @cnt = count(*) FROM WebTicketType WHERE Id = @type;
		IF @cnt = 0
		BEGIN
			RETURN (2)
		END

		-- TRAN START 
		BEGIN TRAN

		INSERT INTO WebTicket (UserID, Subject, TypeId)
		VALUES (@userID, @subject, @type);
			
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (3)
		END		

		INSERT INTO WebTicketDetail (Tid, Content, UserID, IP)
		VALUES (SCOPE_IDENTITY(), @content, @userID, @ipaddress);
			
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (4)
		END
		
		-- COMMIT TRAN
		COMMIT TRAN 

		RETURN (1)
	END
GO
/****** Object:  StoredProcedure [dbo].[web_ticket_detail_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_ticket_detail_add]
(
	@userID varchar(20),
	@id int,
	@content VARCHAR(MAX),
	@adminReply bit,
	@ipaddress varchar(15)
)
As
	BEGIN
		SET NOCOUNT ON 
		DECLARE @tid int;
		DECLARE @cnt int;
		SELECT @tid = Id FROM WebTicket WHERE Id = @id AND (UserID = @userID OR @adminReply = 1);
		IF @tid IS NULL OR @@ERROR <> 0
		BEGIN
			RETURN (2)
		END

		SELECT @cnt = count(*) FROM WebTicketDetail WHERE Tid = @id AND UserID = @userID AND @adminReply = 0 AND ReplyDate > DATEADD(minute, -5,  GETDATE());
		IF @cnt IS NOT NULL AND @cnt > 0
		BEGIN
			RETURN (3)
		END

		-- TRAN START 
		BEGIN TRAN

		INSERT INTO WebTicketDetail (Tid, Content, UserID, IP)
		VALUES (@tid, @content, @userID, @ipaddress);
			
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (4)
		END
		
		UPDATE WebTicket
		SET 
			Status = 0,
			LastUpdate = GETDATE()
		WHERE Id = @tid;
			
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (5)
		END
		
		-- COMMIT TRAN
		COMMIT TRAN 

		RETURN (1)
	END
GO
/****** Object:  StoredProcedure [dbo].[web_ticket_detail_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_ticket_detail_get_data]
(
	@userID varchar(20),
	@admin bit = 0,	
	@id int
)
As
	SELECT
		d.Id As DetailID,
		d.Content,
		d.UserId As ReplyUser,
		d.ReplyDate,
		d.IP AS ReplyIP
	FROM WebTicket t
	LEFT JOIN WebTicketDetail d
	ON d.Tid = t.Id
	INNER JOIN WebLogin l
	ON t.UserID = l.Username
	LEFT JOIN WebTicketType c
	ON c.Id = t.TypeId
	WHERE (l.Username = @userID OR @admin = 1)
	AND t.Id = @id
	ORDER BY d.ReplyDate DESC
GO
/****** Object:  StoredProcedure [dbo].[web_ticket_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_ticket_get_data]
(
	@userID varchar(20),
	@admin bit = 0,
	@id int = NULL
)
As
/*
	SELECT
		t.Id,
		ISNULL(c.Name, 'Unknown') AS Type,
		'#' + CONVERT(varchar(10), t.Id) + ' - ' + t.Subject AS Subject,
		CASE t.Status WHEN 0 THEN 'Open' ELSE 'Closed' END AS Status,		
		t.LastUpdate
	FROM WebTicket t
	INNER JOIN WebLogin l
	ON t.UserID = l.Username
	LEFT JOIN WebTicketType c
	ON c.Id = t.TypeId
	WHERE (l.Username = @userID OR @admin = 1)
	AND (@id IS NULL OR t.id = @id)
	ORDER BY t.TicketDate DESC
*/
	SELECT
		t.Id,
		ISNULL(c.Name, 'Unknown') AS Type,
		'#' + CONVERT(varchar(10), t.Id) + ' - ' + t.Subject AS Subject,
		CASE t.Status WHEN 0 THEN 'Open' ELSE 'Closed' END AS Status,		
		t.LastUpdate,
		d.UserID AS LastReply,
		maxdate.MaxDateTime AS LastReplyDate
	FROM WebTicket t
	INNER JOIN
	(
		SELECT Tid, MAX(ReplyDate) AS MaxDateTime
		FROM WebTicketDetail
		GROUP BY Tid
	) maxdate 
	ON t.ID = maxdate.Tid 
	INNER JOIN WebTicketDetail d
	ON t.Id = d.Tid 
	AND maxdate.MaxDateTime = d.ReplyDate
	INNER JOIN WebLogin l
	ON t.UserID = l.Username
	LEFT JOIN WebTicketType c
	ON c.Id = t.TypeId
	WHERE (l.Username = @userID OR @admin = 1)
	AND (@id IS NULL OR t.id = @id)
	ORDER BY t.TicketDate DESC
GO
/****** Object:  StoredProcedure [dbo].[web_ticket_update]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_ticket_update]
(
	@userID varchar(20),
	@id int,
	@adminReply bit
)
As
	BEGIN
		SET NOCOUNT ON 
		DECLARE @tid int;
		SELECT @tid = Id FROM WebTicket WHERE Id = @id AND (UserID = @userID OR @adminReply = 1) AND Status = 0;
		IF @tid IS NULL OR @@ERROR <> 0
		BEGIN
			RETURN (2)
		END

		-- TRAN START 
		BEGIN TRAN

		UPDATE WebTicket
		SET 
			Status = 1,
			LastUpdate = GETDATE()
		WHERE Id = @tid;
			
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (3)
		END
		
		-- COMMIT TRAN
		COMMIT TRAN 

		RETURN (1)
	END
GO
/****** Object:  StoredProcedure [dbo].[web_top_notice_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_top_notice_get]
As
	SELECT TOP 10
		n.Id,
		TypeId,
		Subject,
		Content,
		ContentPlain,
		NoticeUser,
		NoticeDate,
		Status,
		t.ColorId,
		t.Name
	FROM WebNotice n WITH (NOLOCK)
	INNER JOIN WebNoticeType t WITH (NOLOCK)
	ON n.TypeId = t.Id
	WHERE Status = 0
	ORDER BY NoticeDate DESC
GO
/****** Object:  StoredProcedure [dbo].[web_transaction_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_transaction_add]
(
	@id int,
	@uid VARCHAR(20),
	@oid int,
	@new int,
	@total int,
	@client_ip varchar(20),
	@app_id varchar(50),
	@client_country_code varchar(20),
	@client_payout decimal,
	@oname varchar(50)
)
As

begin
	SET NOCOUNT ON 
	DECLARE @cnt int;
	SELECT @cnt = count(*) FROM WebTransaction WHERE Id = @id;
	If @cnt < 1
		BEGIN			
			-- TRAN START 
			BEGIN TRAN

			INSERT INTO WebTransaction(Id, Uid, Oid, New, Total, Time, ClientIP, AppId, ClientCountryCode, ClientPayout, OfferName)
			VALUES (@id,@uid,@oid,@new,@total,getdate(), @client_ip, @app_id, @client_country_code, @client_payout, @oname);
			
			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (2)
			END

			UPDATE m
			SET realcash += @new
			FROM userMoneyDB m
			INNER JOIN userMemberDB u
			on m.accountIDX = u.accountIDX
			WHERE u.userID = @uid;

			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (3)
			END		

			-- COMMIT TRAN
			COMMIT TRAN 

			RETURN (1)
		END
	ELSE
		-- TRAN START 
		BEGIN TRAN

		UPDATE WebTransaction
		SET
			Uid = @uid, 
			Oid = @oid, 
			New = @new, 
			Total = @total, 
			Time = getdate(),
			ClientIP = @client_ip,
			AppId = @app_id,
			ClientCountryCode = @client_country_code,
			ClientPayout = @client_payout,
			OfferName = @oname
		WHERE Id = @id;
		
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
		BEGIN
			ROLLBACK TRAN
			RETURN (4)
		END

		-- COMMIT TRAN
		COMMIT TRAN 

		RETURN (1)
end
GO
/****** Object:  StoredProcedure [dbo].[web_tutorial_pass]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_tutorial_pass]  
  
 @ACCOUNT_IDX  INT   
  
AS  
  UPDATE userGameDB SET userState = '-1' WHERE accountIDX = @ACCOUNT_IDX;
GO
/****** Object:  StoredProcedure [dbo].[web_user_check]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[web_user_check]
(
    @userID varchar(12)
,    @userPWD varchar(24)
)
As
	DECLARE @RET int;
	DECLARE @RET1 int;

	SET @RET1 = 0;
    SET @RET=(select count(*) as result from WebLogin where Username = @userID and Password = @userPWD)
	RETURN @RET
GO
/****** Object:  StoredProcedure [dbo].[web_userinfo]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_userinfo]
(
	@userID varchar(20)
)
As
	select top 1 
		u.accountIDX AS idx, 
		nickName AS Nickname ,
		w.RegDate, 
		w.Verify, 
		m.realCash AS Cash,
		m.bonusCash AS BonusCash,
		 g.userLevel AS Level,
		 g.userEXP AS Exp,
		 g.gameMoney,
		 g.connDate AS LastLogin,
		 RANK() OVER (ORDER BY g.userLevel DESC, g.userEXP DESC) AS Rank
	from WebLogin w  WITH (NOLOCK)
	inner join userMemberDB u WITH (NOLOCK)
	on w.Username = u.userID
	inner join userMoneyDB m WITH (NOLOCK)
	on u.accountIDX = m.accountIDX
	inner join userGameDB g WITH (NOLOCK)
	on g.accountIDX = m.accountIDX
	inner join userItemEtcDB e with (nolock)
	on g.accountIDX = e.accountIDX
	where u.userID = @userID;
GO
/****** Object:  StoredProcedure [dbo].[web_userinfo_get_data]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_userinfo_get_data]
(
	@userID varchar(20)
)
As
	select top 1 
		u.accountIDX AS idx, 
		nickName AS Nickname ,
		w.RegDate, 
		w.Verify, 
		m.realCash AS Cash,
		m.bonusCash AS BonusCash,
		 g.userLevel AS Level,
		 g.userEXP AS Exp,
		 w.Email
	from WebLogin w  WITH (NOLOCK)
	inner join userMemberDB u WITH (NOLOCK)
	on w.Username = u.userID
	inner join userMoneyDB m WITH (NOLOCK)
	on u.accountIDX = m.accountIDX
	inner join userGameDB g WITH (NOLOCK)
	on g.accountIDX = m.accountIDX
	where u.userID = @userID;
GO
/****** Object:  StoredProcedure [dbo].[web_valentine_daily_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_valentine_daily_add]
(
	@userId varchar(20)
)
As
	BEGIN
		SET NOCOUNT ON
		DECLARE @cnt int;
		DECLARE @accountIdx int;
		DECLARE @amount_1 int;
		DECLARE @amount_2 int;
		DECLARE @rewardId_1 int;
		DECLARE @rewardId_2 int;
		DECLARE @missionCnt int;
		SET @missionCnt = 0;
		SET @rewardId_1 = 1;
		SET @rewardId_2 = 2;
		SET @amount_1 = 0;
		SET @amount_2 = 0;

		--Check user exist
		SELECT @accountIdx = Id FROM WebLogin WHERE Username = @userId;
		IF @accountIdx IS NULL
		BEGIN
			RETURN (-1)
		END

		--Check Event Available
		IF NOT GETDATE() BETWEEN '2019-02-04 07:00' AND '2019-02-18 05:00'
		BEGIN
			RETURN (-2)
		END

		--Check Mission Complete
		SELECT @cnt = count(*) FROM WebEventValentineDailyLog WHERE CONVERT(DATE, CompleteDate) = CONVERT(DATE, GETDATE()) AND AccountIdx = @accountIdx AND ItemId IN (@rewardId_1, @rewardId_2);
		IF @cnt > 0
		BEGIN
			RETURN (-3)
		END

		--Check User Mission
		--1 Seed form each kill at TDM mode
		SELECT
			@missionCnt = ISNULL(SUM(kill_count), 0)
		FROM (
			SELECT
				accountIDX,
				sum(l.[kill]) AS 'kill_count'
			FROM  [LosaLogData].[dbo].[log_data_play] l WITH (NOLOCK)
			WHERE playTime > 0
			AND peso > 0
			AND l.modeType = 2
			AND DATEADD(day, DATEDIFF(day, 0, GETDATE() - 1), 0) = DATEADD(day, DATEDIFF(day, 0, regDate), 0) 
			GROUP BY accountIDX
		) a
		WHERE accountIDX = @accountIdx
		GROUP BY accountIDX;

		IF @missionCnt IS NULL
		BEGIN
			SET @missionCnt = 0
		END

		IF @missionCnt > 0
		BEGIN
			--Max 35 per day
			IF @missionCnt > 35
			BEGIN
				SET @missionCnt = 35
			END
			SET @amount_1 = @missionCnt * 2
		END	

		--1 Golden Seed from each 100BP Donation
		SELECT
			@missionCnt = ISNULL(SUM(New), 0)
		FROM WebTransaction
		WHERE DATEADD(day, DATEDIFF(day, 0, GETDATE() - 1), 0) = DATEADD(day, DATEDIFF(day, 0, Time), 0)
		AND Uid = @userId

		IF @missionCnt IS NULL
		BEGIN
			SET @missionCnt = 0
		END

		IF @missionCnt > 0
		BEGIN
			--Max 50*100 per day
			IF @missionCnt > 5000
			BEGIN
				SET @missionCnt = 5000
			END
			SET @amount_2 = @missionCnt / 100
		END

		IF @amount_1 < 1 AND @amount_2 < 1
		BEGIN
			RETURN (-4)
		END

		-- TRAN START
		BEGIN TRAN		
		-- Reward 1
		IF @amount_1 > 0
		BEGIN
			SELECT @cnt = count(*) FROM WebEventValentineUserItem WHERE ItemId = @rewardId_1 AND AccountIdx = @accountIdx;
			IF @cnt = 0
				BEGIN
					INSERT INTO WebEventValentineUserItem (AccountIdx, ItemId, Amount) VALUES (@accountIdx, @rewardId_1, @amount_1);
				END
			ELSE
				BEGIN
					UPDATE WebEventValentineUserItem SET Amount += @amount_1 WHERE AccountIdx = @accountIdx AND ItemId = @rewardId_1;
				END

			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
				BEGIN
					ROLLBACK TRAN
					RETURN (-5)
				END

			-- Log
			INSERT INTO WebEventValentineDailyLog (AccountIdx, ItemId, Amount, CompleteDate ) VALUES (@accountIdx, @rewardId_1, @amount_1, GETDATE());
			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
				BEGIN
					ROLLBACK TRAN
					RETURN (-6)
				END	
		END

		IF @amount_2 > 0
		BEGIN
			SELECT @cnt = count(*) FROM WebEventValentineUserItem WHERE ItemId = @rewardId_2 AND AccountIdx = @accountIdx;
			IF @cnt = 0
				BEGIN
					INSERT INTO WebEventValentineUserItem (AccountIdx, ItemId, Amount) VALUES (@accountIdx, @rewardId_2, @amount_2);
				END
			ELSE
				BEGIN
					UPDATE WebEventValentineUserItem SET Amount += @amount_2 WHERE AccountIdx = @accountIdx AND ItemId = @rewardId_2;
				END

			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
				BEGIN
					ROLLBACK TRAN
					RETURN (-5)
				END

			-- Log
			INSERT INTO WebEventValentineDailyLog (AccountIdx, ItemId, Amount, CompleteDate ) VALUES (@accountIdx, @rewardId_2, @amount_2, GETDATE());
			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
				BEGIN
					ROLLBACK TRAN
					RETURN (-6)
				END	
		END

		-- COMMIT TRAN
		COMMIT TRAN 
		RETURN (1)
	END
GO
/****** Object:  StoredProcedure [dbo].[web_valentine_goal_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_valentine_goal_add]
(
	@userId varchar(20),
	@gid int
)
As
	BEGIN
		SET NOCOUNT ON
		DECLARE @cnt int;
		DECLARE @accountIdx int;
		DECLARE @required int;
		DECLARE @item int;
		DECLARE @rewardType int;
		DECLARE @rewardValue1 int;
		DECLARE @rewardValue2 int;
		DECLARE @rewardName varchar(255);

		--Check user exist
		SELECT @accountIdx = Id FROM WebLogin WHERE Username = @userId;
		IF @accountIdx IS NULL
		BEGIN
			RETURN (-1)
		END

		--Check Event Available
		IF NOT GETDATE() BETWEEN '2019-02-04 07:00' AND '2019-02-18 05:00'
		BEGIN
			RETURN (-2)
		END

		--Check Mission Complete
		SELECT @cnt = count(*) FROM WebEventValentineGoalLog WHERE GoalId = @gid AND AccountIdx = @accountIdx;
		IF @cnt > 0
		BEGIN
			RETURN (-3)
		END

		--Get Mission Goal
		SELECT @item = ItemId, @required = Plant, @rewardType = PresentType, @rewardValue1 = Value1, @rewardValue2 = Value2, @rewardName = RewardName FROM WebEventValentineGoal WHERE Id = @gid;
		IF @item IS NULL OR @required IS NULL
		BEGIN
			RETURN (-6)
		END

		--Check User Complete
		IF @item = 0
			BEGIN
				SELECT 
					@cnt = ISNULL(SUM(Amount),0)
				FROM WebEventValentineDailyLog
				WHERE AccountIdx = @accountIdx
				AND ItemId IN (3, 4, 5)
				GROUP BY AccountIdx
			END
		ELSE IF @item > 0
			BEGIN
				SELECT 
					@cnt = ISNULL(SUM(Amount),0)
				FROM WebEventValentineDailyLog
				WHERE AccountIdx = @accountIdx
				AND ItemId = @item
				GROUP BY AccountIdx
			END

		IF @cnt < @required
		BEGIN
			RETURN (-4)
		END

		-- TRAN START
		BEGIN TRAN		

		-- Reward
		INSERT INTO dbo.userPresentDB (sendIDX, receiveIDX, presentType, value1, value2, value3, value4, msgType, flag, limitDate, regDate) VALUES
		(1, @accountIdx, @rewardType, @rewardValue1, @rewardValue2, 0, 0, 1011, 0, DATEADD(DAY, 14, GETDATE()), GETDATE());

		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-5)
			END	

		-- Log
		INSERT INTO WebEventValentineGoalLog (AccountIdx, GoalId) VALUES (@accountIdx,@gid);
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-6)
			END	

		-- COMMIT TRAN
		COMMIT TRAN 
		RETURN (1)
	END
GO
/****** Object:  StoredProcedure [dbo].[web_valentine_item_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_valentine_item_add]
(
	@userId varchar(20),
	@vid int,
	@aid int,
	@rose1 int,
	@rose2 int,
	@rose3 int
)
As
	BEGIN
		SET NOCOUNT ON
		DECLARE @cnt int;
		DECLARE @accountIdx int;
		DECLARE @rewardId_1 int;
		DECLARE @rewardId_2 int;
		DECLARE @rewardId_3 int;
		SET @rewardId_1 = 3;
		SET @rewardId_2 = 4;
		SET @rewardId_3 = 5;

		--Check user exist
		SELECT @accountIdx = Id FROM WebLogin WHERE Username = @userId;
		IF @accountIdx IS NULL
		BEGIN
			RETURN (-1)
		END

		--Check Event Available
		IF NOT GETDATE() BETWEEN '2019-02-04 07:00' AND '2019-02-18 05:00'
		BEGIN
			RETURN (-2)
		END

		--Check Valid Item
		If @vid NOT IN (1, 2)
		BEGIN
			RETURN (-3)
		END

		--Check Item Enough
		SELECT @cnt = sum(Amount) FROM WebEventValentineUserItem WHERE ItemId = @vid AND AccountIdx = @accountIdx GROUP BY AccountIdx;
		IF @cnt IS NULL OR @cnt < @aid
		BEGIN
			RETURN (-4)
		END

		-- TRAN START
		BEGIN TRAN		
		--Deduce
		UPDATE WebEventValentineUserItem SET Amount -= @aid WHERE AccountIdx = @accountIdx AND ItemId = @vid;
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-5)
			END	

		-- Rose 1
		IF @rose1 > 0
		BEGIN
			SELECT @cnt = count(*) FROM WebEventValentineUserItem WHERE ItemId = @rewardId_1 AND AccountIdx = @accountIdx;
			IF @cnt = 0
				BEGIN
					INSERT INTO WebEventValentineUserItem (AccountIdx, ItemId, Amount) VALUES (@accountIdx, @rewardId_1, @rose1);
				END
			ELSE
				BEGIN
					UPDATE WebEventValentineUserItem SET Amount += @rose1 WHERE AccountIdx = @accountIdx AND ItemId = @rewardId_1;
				END

			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
				BEGIN
					ROLLBACK TRAN
					RETURN (-5)
				END

			-- Log
			INSERT INTO WebEventValentineDailyLog (AccountIdx, ItemId, Amount, CompleteDate ) VALUES (@accountIdx, @rewardId_1, @rose1, GETDATE());
			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
				BEGIN
					ROLLBACK TRAN
					RETURN (-6)
				END	
		END

		-- Rose 2
		IF @rose2 > 0
		BEGIN
			SELECT @cnt = count(*) FROM WebEventValentineUserItem WHERE ItemId = @rewardId_2 AND AccountIdx = @accountIdx;
			IF @cnt = 0
				BEGIN
					INSERT INTO WebEventValentineUserItem (AccountIdx, ItemId, Amount) VALUES (@accountIdx, @rewardId_2, @rose2);
				END
			ELSE
				BEGIN
					UPDATE WebEventValentineUserItem SET Amount += @rose2 WHERE AccountIdx = @accountIdx AND ItemId = @rewardId_2;
				END

			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
				BEGIN
					ROLLBACK TRAN
					RETURN (-5)
				END

			-- Log
			INSERT INTO WebEventValentineDailyLog (AccountIdx, ItemId, Amount, CompleteDate ) VALUES (@accountIdx, @rewardId_2, @rose2, GETDATE());
			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
				BEGIN
					ROLLBACK TRAN
					RETURN (-6)
				END	
		END

		-- Rose 3
		IF @rose3 > 0
		BEGIN
			SELECT @cnt = count(*) FROM WebEventValentineUserItem WHERE ItemId = @rewardId_3 AND AccountIdx = @accountIdx;
			IF @cnt = 0
				BEGIN
					INSERT INTO WebEventValentineUserItem (AccountIdx, ItemId, Amount) VALUES (@accountIdx, @rewardId_3, @rose3);
				END
			ELSE
				BEGIN
					UPDATE WebEventValentineUserItem SET Amount += @rose3 WHERE AccountIdx = @accountIdx AND ItemId = @rewardId_3;
				END

			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
				BEGIN
					ROLLBACK TRAN
					RETURN (-5)
				END

			-- Log
			INSERT INTO WebEventValentineDailyLog (AccountIdx, ItemId, Amount, CompleteDate ) VALUES (@accountIdx, @rewardId_3, @rose3, GETDATE());
			IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
				BEGIN
					ROLLBACK TRAN
					RETURN (-6)
				END	
		END

		-- COMMIT TRAN
		COMMIT TRAN 
		RETURN (1)
	END
GO
/****** Object:  StoredProcedure [dbo].[web_valentine_mygoal_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_valentine_mygoal_get]
(
	@userID varchar(20)
)
As
BEGIN
DECLARE @accountIdx INT;
--Check user exist
SELECT @accountIdx = Id FROM WebLogin WHERE Username = @userId;
IF @userId IS NULL OR  @accountIdx IS NULL
BEGIN
	SELECT 
		0 AS Goal,
		0 AS Goal1,
		0 AS Goal2,
		0 As Goal3
END
ELSE
	SELECT
		ISNULL(SUM(CASE WHEN ItemId IN (3, 4, 5) THEN ISNULL(Amount, 0) END ),0) AS Goal,
		ISNULL(SUM(CASE WHEN ItemId = 3 THEN ISNULL(Amount, 0) END ),0) AS Goal1,
		ISNULL(SUM(CASE WHEN ItemId = 4 THEN ISNULL(Amount, 0) END ),0) AS Goal2,
		ISNULL(SUM(CASE WHEN ItemId = 5 THEN ISNULL(Amount, 0) END ),0) AS Goal3
	FROM WebEventValentineDailyLog
	WHERE AccountIdx = @accountIdx
	GROUP BY AccountIdx
END
GO
/****** Object:  StoredProcedure [dbo].[web_valentine_myitem_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_valentine_myitem_get]
(
	@userID varchar(20)
)
As
BEGIN
DECLARE @accountIdx INT;
--Check user exist
SELECT @accountIdx = Id FROM WebLogin WHERE Username = @userId;
IF @userId IS NULL OR  @accountIdx IS NULL
BEGIN
	SELECT 
		0 AS Seed1,
		0 AS Seed2,
		0 AS Rose1,
		0 AS Rose2,
		0 As Rose3
END
ELSE
	SELECT
		ISNULL(SUM(CASE WHEN ItemId = 1 THEN ISNULL(Amount, 0) END ),0) AS Seed1,
		ISNULL(SUM(CASE WHEN ItemId = 2 THEN ISNULL(Amount, 0) END ),0) AS Seed2,
		ISNULL(SUM(CASE WHEN ItemId = 3 THEN ISNULL(Amount, 0) END ),0) AS Rose1,
		ISNULL(SUM(CASE WHEN ItemId = 4 THEN ISNULL(Amount, 0) END ),0) AS Rose2,
		ISNULL(SUM(CASE WHEN ItemId = 5 THEN ISNULL(Amount, 0) END ),0) AS Rose3
	FROM WebEventValentineUserItem 
	WHERE AccountIdx = @accountIdx
	GROUP BY AccountIdx
END
GO
/****** Object:  StoredProcedure [dbo].[web_valentine_ranking_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_valentine_ranking_get]
(
	@rankType int
)
As
SELECT
	m.nickName AS Name,
	Point
FROM WebEventValentineRanking r
INNER JOIN userMemberDB m
ON r.AccountIdx = m.accountIDX
WHERE RankType = @rankType
ORDER BY Point desc
GO
/****** Object:  StoredProcedure [dbo].[web_valentine_ranking_update]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_valentine_ranking_update]
As
BEGIN
	-- TRAN START
	BEGIN TRAN
	--Delete
	DELETE FROM WebEventValentineRanking;

	--Add Sending
	INSERT INTO WebEventValentineRanking (AccountIdx, RankType, Point)
	SELECT TOP 10
		AccountIdx,
		1,
		SUM(Point)
	FROM 
	(
		SELECT
			AccountIdx,
			CASE ItemId WHEN 3 THEN Amt * 2 WHEN 4 THEN Amt * 5 WHEN 5 THEN Amt * 10 END AS Point
		FROM
		(
			SELECT
				SendIdx AS AccountIdx,
				ItemId,
				ISNULL(SUM(Amount), 0) AS Amt
			FROM WebEventValentineHistory
			GROUP BY SendIdx, ItemId
		) t
	) t2
	GROUP BY AccountIdx
	ORDER BY SUM(Point) DESC

	--Add Receiving
	INSERT INTO WebEventValentineRanking (AccountIdx, RankType, Point)
	SELECT TOP 10
		AccountIdx,
		2,
		SUM(Point)
	FROM 
	(
		SELECT
			AccountIdx,
			CASE ItemId WHEN 3 THEN Amt * 2 WHEN 4 THEN Amt * 5 WHEN 5 THEN Amt * 10 END AS Point
		FROM
		(
			SELECT
				ReceiveIdx AS AccountIdx,
				ItemId,
				ISNULL(SUM(Amount), 0) AS Amt
			FROM WebEventValentineHistory
			GROUP BY ReceiveIdx, ItemId
		) t
	) t2
	GROUP BY AccountIdx
	ORDER BY SUM(Point) DESC

	-- COMMIT TRAN
	COMMIT TRAN 
	RETURN (1)
END
GO
/****** Object:  StoredProcedure [dbo].[web_valentine_send_add]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_valentine_send_add]
(
	@userId varchar(20),
	@vid int,
	@receiveName varchar(20),
	@amount int
)
As
	BEGIN
		SET NOCOUNT ON
		DECLARE @cnt int;
		DECLARE @accountIdx int;
		DECLARE @receiveIdx int;

		--Check user exist
		SELECT @accountIdx = Id FROM WebLogin WHERE Username = @userId;
		IF @accountIdx IS NULL
		BEGIN
			RETURN (-1)
		END

		--Check Event Available
		IF NOT GETDATE() BETWEEN '2019-02-04 07:00' AND '2019-02-18 05:00'
		BEGIN
			RETURN (-2)
		END

		--Check user exist
		SELECT TOP 1 @receiveIdx = accountIDX FROM userMemberDB WHERE nickName = @receiveName AND userType = 100;
		IF @receiveIdx IS NULL
		BEGIN
			RETURN (-3)
		END

		--Yourself
		IF @accountIdx = @receiveIdx
		BEGIN
			RETURN (-4)
		END

		--Check Valid Item
		If @vid NOT IN (3, 4, 5)
		BEGIN
			RETURN (-5)
		END
		
		--Check Item Enough
		SELECT @cnt = sum(Amount) FROM WebEventValentineUserItem WHERE ItemId = @vid AND AccountIdx = @accountIdx GROUP BY AccountIdx;
		IF @cnt IS NULL OR @cnt < @amount
		BEGIN
			RETURN (-6)
		END

		-- TRAN START
		BEGIN TRAN		

		-- Send
		INSERT INTO WebEventValentineHistory (SendIdx, ReceiveIdx, ItemId, Amount) VALUES (@accountIdx, @receiveIdx, @vid, @amount);

		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-7)
			END	

		-- Deduce
		UPDATE WebEventValentineUserItem SET Amount -= @amount WHERE AccountIdx = @accountIdx AND ItemId = @vid;
		IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN
				RETURN (-8)
			END	

		-- COMMIT TRAN
		COMMIT TRAN 
		RETURN (1)
	END
GO
/****** Object:  StoredProcedure [dbo].[web_valentine_server_goal_get]    Script Date: 2020-05-01 오후 6:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[web_valentine_server_goal_get]
As
	SELECT
		CASE WHEN ISNULL(SUM(Amount), 0) * 100 / 99999  > 100 
		THEN 100
		 ELSE ISNULL(SUM(Amount), 0) * 100 / 99999 END As ServerGoal
	FROM WebEventValentineDailyLog
	WHERE ItemId IN (3,4,5);
GO
USE [master]
GO
ALTER DATABASE [LosaGame] SET  READ_WRITE 
GO
