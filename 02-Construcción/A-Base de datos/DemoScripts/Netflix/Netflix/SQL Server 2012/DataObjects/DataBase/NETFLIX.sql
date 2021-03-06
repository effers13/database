CREATE DATABASE NETFLIX
ON PRIMARY
(
NAME     = 'DB1_Data.MDF',
FILENAME = 'c:\program files\microsoft sql server\mssql\data\DB1_Data.MDF',
MAXSIZE  = UNLIMITED
)
GO
ALTER DATABASE NETFLIX
SET MULTI_USER ,
CURSOR_CLOSE_ON_COMMIT ON ,
CURSOR_DEFAULT GLOBAL ,
AUTO_CLOSE ON ,
AUTO_CREATE_STATISTICS ON ,
AUTO_SHRINK ON ,
AUTO_UPDATE_STATISTICS ON ,
AUTO_UPDATE_STATISTICS_ASYNC OFF ,
ANSI_NULLS OFF ,
ANSI_NULL_DEFAULT OFF ,
DATE_CORRELATION_OPTIMIZATION OFF ,
TRUSTWORTHY OFF ,
ALLOW_SNAPSHOT_ISOLATION OFF ,
READ_COMMITTED_SNAPSHOT OFF ,
DB_CHAINING OFF ,
PARAMETERIZATION SIMPLE ,
PAGE_VERIFY NONE ,
HONOR_BROKER_PRIORITY OFF ,
COMPATIBILITY_LEVEL = 80 ,
CHANGE_TRACKING     = OFF ,
AUTO_CLEANUP        = OFF ,
ENCRYPTION OFF ,
ANSI_PADDING ON ,
ANSI_WARNINGS ON ,
ARITHABORT ON ,
CONCAT_NULL_YIELDS_NULL ON ,
NUMERIC_ROUNDABORT ON ,
QUOTED_IDENTIFIER OFF ,
RECURSIVE_TRIGGERS ON ,
RECOVERY FULL ,
TORN_PAGE_DETECTION ON
GO
