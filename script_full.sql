USE [SHEMS]
GO
ALTER TABLE [dbo].[ServiceLocation] DROP CONSTRAINT [FK__ServiceLo__cust___4BAC3F29]
GO
ALTER TABLE [dbo].[EnergyLog] DROP CONSTRAINT [FK__EnergyLog__dev_i__5629CD9C]
GO
ALTER TABLE [dbo].[Device] DROP CONSTRAINT [FK__Device__sl_id__4E88ABD4]
GO
ALTER TABLE [dbo].[ActivityLog] DROP CONSTRAINT [FK__ActivityL__dev_i__534D60F1]
GO
/****** Object:  Table [dbo].[PriceList]    Script Date: 12/21/2023 12:56:24 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PriceList]') AND type in (N'U'))
DROP TABLE [dbo].[PriceList]
GO
/****** Object:  Table [dbo].[ActivityLog]    Script Date: 12/21/2023 12:56:24 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActivityLog]') AND type in (N'U'))
DROP TABLE [dbo].[ActivityLog]
GO
/****** Object:  View [dbo].[VwWeeklyEnergyConsumption]    Script Date: 12/21/2023 12:56:24 AM ******/
DROP VIEW [dbo].[VwWeeklyEnergyConsumption]
GO
/****** Object:  View [dbo].[VwCustomerEnergyUsageByDeviceType]    Script Date: 12/21/2023 12:56:24 AM ******/
DROP VIEW [dbo].[VwCustomerEnergyUsageByDeviceType]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 12/21/2023 12:56:24 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Customer]') AND type in (N'U'))
DROP TABLE [dbo].[Customer]
GO
/****** Object:  View [dbo].[VwEnergyUsagePerZipCode]    Script Date: 12/21/2023 12:56:24 AM ******/
DROP VIEW [dbo].[VwEnergyUsagePerZipCode]
GO
/****** Object:  View [dbo].[VwEnergyUsagePerUser]    Script Date: 12/21/2023 12:56:24 AM ******/
DROP VIEW [dbo].[VwEnergyUsagePerUser]
GO
/****** Object:  Table [dbo].[EnergyLog]    Script Date: 12/21/2023 12:56:24 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EnergyLog]') AND type in (N'U'))
DROP TABLE [dbo].[EnergyLog]
GO
/****** Object:  Table [dbo].[DeviceModel]    Script Date: 12/21/2023 12:56:24 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeviceModel]') AND type in (N'U'))
DROP TABLE [dbo].[DeviceModel]
GO
/****** Object:  Table [dbo].[Device]    Script Date: 12/21/2023 12:56:24 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Device]') AND type in (N'U'))
DROP TABLE [dbo].[Device]
GO
/****** Object:  Table [dbo].[ServiceLocation]    Script Date: 12/21/2023 12:56:24 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLocation]') AND type in (N'U'))
DROP TABLE [dbo].[ServiceLocation]
GO
/****** Object:  Table [dbo].[ServiceLocation]    Script Date: 12/21/2023 12:56:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceLocation](
	[sl_id] [int] NOT NULL,
	[cust_id] [int] NULL,
	[sl_unit_no] [nvarchar](10) NULL,
	[sl_addr] [nvarchar](255) NULL,
	[sl_city] [nvarchar](100) NULL,
	[sl_state] [nvarchar](100) NULL,
	[sl_zip] [nvarchar](20) NULL,
	[sl_boughtat] [date] NULL,
	[sl_squarefootage] [int] NULL,
	[sl_bedrooms] [int] NULL,
	[sl_occupants] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[sl_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Device]    Script Date: 12/21/2023 12:56:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Device](
	[dev_id] [int] NOT NULL,
	[sl_id] [int] NULL,
	[mid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[dev_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeviceModel]    Script Date: 12/21/2023 12:56:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceModel](
	[mid] [int] NOT NULL,
	[m_type] [nvarchar](100) NULL,
	[m_name] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[mid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EnergyLog]    Script Date: 12/21/2023 12:56:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnergyLog](
	[el_id] [int] NOT NULL,
	[dev_id] [int] NULL,
	[el_time] [datetime] NULL,
	[el_val] [float] NULL,
	[el_price] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[el_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VwEnergyUsagePerUser]    Script Date: 12/21/2023 12:56:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VwEnergyUsagePerUser] AS
SELECT 
    sl.cust_id AS CustomerID,
    sl.sl_id AS ServiceLocationID,
    dm.m_type AS DeviceType,
    SUM(el.el_val) AS TotalEnergyUsed,
    COUNT(el.el_id) AS NumberOfLogs,
    MIN(el.el_time) AS FirstLogDate,
    MAX(el.el_time) AS LastLogDate
FROM 
    dbo.ServiceLocation sl
INNER JOIN dbo.Device d ON sl.sl_id = d.sl_id
INNER JOIN dbo.DeviceModel dm ON d.mid = dm.mid
INNER JOIN dbo.EnergyLog el ON d.dev_id = el.dev_id
GROUP BY 
    sl.cust_id,
    sl.sl_id,
    dm.m_type;


GO
/****** Object:  View [dbo].[VwEnergyUsagePerZipCode]    Script Date: 12/21/2023 12:56:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VwEnergyUsagePerZipCode] AS
SELECT 
    sl.sl_zip AS ZipCode,
    CAST(el.el_time AS DATE) AS LogDate, -- This casts the datetime to date for daily energy usage
    SUM(el.el_val) AS TotalEnergyUsed
FROM 
    dbo.ServiceLocation sl
INNER JOIN dbo.Device d ON sl.sl_id = d.sl_id
INNER JOIN dbo.EnergyLog el ON d.dev_id = el.dev_id
GROUP BY 
    sl.sl_zip,
    CAST(el.el_time AS DATE);




GO
/****** Object:  Table [dbo].[Customer]    Script Date: 12/21/2023 12:56:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[cust_id] [int] NOT NULL,
	[cust_fname] [nvarchar](100) NULL,
	[cust_lname] [nvarchar](100) NULL,
	[cust_email] [nvarchar](100) NULL,
	[cust_phone] [nvarchar](20) NULL,
	[bill_addr] [nvarchar](255) NULL,
	[bill_addr_city] [nvarchar](100) NULL,
	[bill_addr_state] [nvarchar](100) NULL,
	[bill_addr_zip] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[cust_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VwCustomerEnergyUsageByDeviceType]    Script Date: 12/21/2023 12:56:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VwCustomerEnergyUsageByDeviceType] AS
SELECT 
    c.cust_id AS CustomerID,
    dm.m_type AS DeviceType,
    SUM(el.el_val) AS TotalEnergyUsed
FROM 
    dbo.Customer c
INNER JOIN dbo.ServiceLocation sl ON c.cust_id = sl.cust_id
INNER JOIN dbo.Device d ON sl.sl_id = d.sl_id
INNER JOIN dbo.DeviceModel dm ON d.mid = dm.mid
INNER JOIN dbo.EnergyLog el ON d.dev_id = el.dev_id
GROUP BY 
    c.cust_id,
    dm.m_type;

GO
/****** Object:  View [dbo].[VwWeeklyEnergyConsumption]    Script Date: 12/21/2023 12:56:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VwWeeklyEnergyConsumption] AS
SELECT 
    dev_id AS ServiceLocationID,
    DATEPART(week, el_time) AS WeekOfYear,
    DATEPART(year, el_time) AS Year,
    SUM(el_val) AS TotalEnergyUsed
FROM 
    EnergyLog
WHERE
    el_time >= '2022-07-01' AND el_time < '2023-01-01'
GROUP BY 
    dev_id,
    DATEPART(week, el_time),
    DATEPART(year, el_time);
GO
/****** Object:  Table [dbo].[ActivityLog]    Script Date: 12/21/2023 12:56:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityLog](
	[act_id] [int] NOT NULL,
	[dev_id] [int] NULL,
	[act_time] [datetime] NULL,
	[act_label] [nvarchar](100) NULL,
	[act_val] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[act_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PriceList]    Script Date: 12/21/2023 12:56:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PriceList](
	[zip] [nvarchar](20) NOT NULL,
	[hourofday] [int] NOT NULL,
	[price_per_kw] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[zip] ASC,
	[hourofday] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (1, 1, CAST(N'2023-11-30T15:14:06.610' AS DateTime), N'door_open', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (2, 2, CAST(N'2022-08-01T08:00:00.000' AS DateTime), N'door_open', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (3, 3, CAST(N'2022-09-01T08:00:00.000' AS DateTime), N'door_open', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (4, 2, CAST(N'2022-08-01T08:35:00.000' AS DateTime), N'door_close', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (5, 1, CAST(N'2023-11-30T15:19:19.033' AS DateTime), N'door_close', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (6, 3, CAST(N'2022-09-01T08:40:00.000' AS DateTime), N'door_close', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (7, 11, CAST(N'2022-09-16T15:27:40.000' AS DateTime), N'switched_off', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (8, 20, CAST(N'2022-08-13T03:23:26.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (9, 21, CAST(N'2022-09-24T11:23:56.000' AS DateTime), N'switched_off', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (10, 20, CAST(N'2022-09-08T00:57:32.000' AS DateTime), N'value_changed', 76.79)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (11, 18, CAST(N'2022-09-04T16:08:55.000' AS DateTime), N'switched_off', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (12, 19, CAST(N'2022-09-21T18:07:09.000' AS DateTime), N'door_close', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (13, 17, CAST(N'2022-08-01T17:06:56.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (14, 16, CAST(N'2022-09-10T02:49:15.000' AS DateTime), N'switched_off', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (15, 5, CAST(N'2022-09-02T15:04:19.000' AS DateTime), N'value_changed', 0.76)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (16, 16, CAST(N'2022-08-20T06:53:12.000' AS DateTime), N'door_close', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (17, 12, CAST(N'2022-09-22T12:42:41.000' AS DateTime), N'switched_off', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (18, 20, CAST(N'2022-08-06T22:11:43.000' AS DateTime), N'switched_off', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (19, 20, CAST(N'2022-08-16T08:46:44.000' AS DateTime), N'switched_off', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (20, 16, CAST(N'2022-09-12T03:05:30.000' AS DateTime), N'switched_off', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (21, 18, CAST(N'2022-09-01T19:44:39.000' AS DateTime), N'value_changed', 0.56)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (22, 11, CAST(N'2022-09-05T04:37:15.000' AS DateTime), N'switched_off', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (23, 9, CAST(N'2022-09-24T17:16:47.000' AS DateTime), N'switched_off', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (24, 11, CAST(N'2022-08-04T20:23:03.000' AS DateTime), N'value_changed', 0.8)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (25, 18, CAST(N'2022-08-20T00:44:22.000' AS DateTime), N'value_changed', 76.31)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (26, 16, CAST(N'2022-09-25T17:41:35.000' AS DateTime), N'value_changed', 0.58)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (27, 13, CAST(N'2022-09-28T09:43:55.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (28, 15, CAST(N'2022-08-04T18:11:34.000' AS DateTime), N'value_changed', 0.42)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (29, 12, CAST(N'2022-09-18T23:58:14.000' AS DateTime), N'door_open', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (30, 18, CAST(N'2022-09-21T06:07:30.000' AS DateTime), N'switched_off', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (31, 5, CAST(N'2022-09-17T12:07:15.000' AS DateTime), N'value_changed', 70.39)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (32, 12, CAST(N'2022-08-04T22:29:31.000' AS DateTime), N'switched_off', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (33, 17, CAST(N'2022-09-11T19:27:41.000' AS DateTime), N'value_changed', 0.9)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (34, 23, CAST(N'2022-09-24T20:15:38.000' AS DateTime), N'value_changed', 75.6)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (35, 18, CAST(N'2022-09-18T03:04:39.000' AS DateTime), N'switched_off', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (36, 13, CAST(N'2022-08-31T15:28:15.000' AS DateTime), N'value_changed', 0.82)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (37, 8, CAST(N'2022-08-26T18:09:16.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (38, 16, CAST(N'2022-08-09T18:56:53.000' AS DateTime), N'switched_off', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (39, 22, CAST(N'2022-09-27T08:32:04.000' AS DateTime), N'door_open', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (40, 15, CAST(N'2022-08-03T06:44:18.000' AS DateTime), N'value_changed', 0.53)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (41, 20, CAST(N'2022-08-13T04:02:40.000' AS DateTime), N'switched_off', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (42, 17, CAST(N'2022-08-01T17:46:10.000' AS DateTime), N'switched_off', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (43, 13, CAST(N'2022-09-28T10:23:09.000' AS DateTime), N'switched_off', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (44, 8, CAST(N'2022-08-26T18:48:30.000' AS DateTime), N'switched_off', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (85, 11, CAST(N'2022-09-16T14:52:58.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (86, 21, CAST(N'2022-09-24T10:49:14.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (87, 18, CAST(N'2022-09-04T15:34:13.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (88, 16, CAST(N'2022-09-10T02:14:33.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (89, 12, CAST(N'2022-09-22T12:07:59.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (90, 20, CAST(N'2022-08-06T21:37:01.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (91, 20, CAST(N'2022-08-16T08:12:02.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (92, 16, CAST(N'2022-09-12T02:30:48.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (93, 11, CAST(N'2022-09-05T04:02:33.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (94, 9, CAST(N'2022-09-24T16:42:05.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (95, 18, CAST(N'2022-09-21T05:32:48.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (96, 12, CAST(N'2022-08-04T21:54:49.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (97, 18, CAST(N'2022-09-18T02:29:57.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (98, 16, CAST(N'2022-08-09T18:22:11.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (99, 20, CAST(N'2022-08-13T03:27:58.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (100, 17, CAST(N'2022-08-01T17:11:28.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (101, 13, CAST(N'2022-09-28T09:48:27.000' AS DateTime), N'switched_on', NULL)
INSERT [dbo].[ActivityLog] ([act_id], [dev_id], [act_time], [act_label], [act_val]) VALUES (102, 8, CAST(N'2022-08-26T18:13:48.000' AS DateTime), N'switched_on', NULL)
GO
INSERT [dbo].[Customer] ([cust_id], [cust_fname], [cust_lname], [cust_email], [cust_phone], [bill_addr], [bill_addr_city], [bill_addr_state], [bill_addr_zip]) VALUES (1, N'John', N'Doe', N'johndoe@email.com', N'555-1234', N'123 Main St', N'New York', N'NY', N'10001')
INSERT [dbo].[Customer] ([cust_id], [cust_fname], [cust_lname], [cust_email], [cust_phone], [bill_addr], [bill_addr_city], [bill_addr_state], [bill_addr_zip]) VALUES (2, N'Jane', N'Smith', N'janesmith@email.com', N'555-5678', N'456 Park Ave', N'New York', N'NY', N'10002')
INSERT [dbo].[Customer] ([cust_id], [cust_fname], [cust_lname], [cust_email], [cust_phone], [bill_addr], [bill_addr_city], [bill_addr_state], [bill_addr_zip]) VALUES (3, N'Alice', N'Johnson', N'alicej@email.com', N'555-1235', N'789 Broadway', N'New York', N'NY', N'10003')
GO
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (1, 1, 1)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (2, 2, 2)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (3, 3, 3)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (4, 1, 9)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (5, 2, 4)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (6, 2, 6)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (7, 2, 8)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (8, 3, 4)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (9, 3, 5)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (10, 3, 10)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (11, 4, 7)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (12, 4, 8)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (13, 4, 4)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (14, 4, 5)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (15, 5, 4)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (16, 5, 9)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (17, 1, 4)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (18, 1, 5)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (19, 5, 10)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (20, 1, 10)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (21, 5, 1)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (22, 4, 2)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (23, 3, 1)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (14400, 441, 5)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (14401, 441, 5)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (14402, 441, 8)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (14403, 441, 6)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (14404, 441, 10)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (3554220, 224553, 5)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (3554221, 224553, 5)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (3554222, 224553, 3)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (3554223, 224553, 8)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (3554224, 224553, 9)
INSERT [dbo].[Device] ([dev_id], [sl_id], [mid]) VALUES (3554225, 224553, 10)
GO
INSERT [dbo].[DeviceModel] ([mid], [m_type], [m_name]) VALUES (1, N'Refrigerator', N'Model X')
INSERT [dbo].[DeviceModel] ([mid], [m_type], [m_name]) VALUES (2, N'Refrigerator', N'Samsung 8000 Dual Cool')
INSERT [dbo].[DeviceModel] ([mid], [m_type], [m_name]) VALUES (3, N'Refrigerator', N'Onida 6789 Super')
INSERT [dbo].[DeviceModel] ([mid], [m_type], [m_name]) VALUES (4, N'Light Bulb', N'Phillips 5643')
INSERT [dbo].[DeviceModel] ([mid], [m_type], [m_name]) VALUES (5, N'Light Bulb', N'Havells 4323')
INSERT [dbo].[DeviceModel] ([mid], [m_type], [m_name]) VALUES (6, N'Dryer', N'Whirlpool 45 Dryer')
INSERT [dbo].[DeviceModel] ([mid], [m_type], [m_name]) VALUES (7, N'Dryer', N'IBM 1901')
INSERT [dbo].[DeviceModel] ([mid], [m_type], [m_name]) VALUES (8, N'Washer', N'Whirlpool Oni')
INSERT [dbo].[DeviceModel] ([mid], [m_type], [m_name]) VALUES (9, N'Television', N'Samsung CurveLED 4321')
INSERT [dbo].[DeviceModel] ([mid], [m_type], [m_name]) VALUES (10, N'Heater', N'Honeywell Thermos 121')
GO
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (1, 1, CAST(N'2023-11-30T14:34:54.553' AS DateTime), 0.5, 0.1)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (2, 2, CAST(N'2022-08-01T08:00:00.000' AS DateTime), 0.4, 0.1)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (3, 3, CAST(N'2022-09-01T08:00:00.000' AS DateTime), 0.6, 0.18)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (4, 4, CAST(N'2022-08-04T06:15:00.000' AS DateTime), 0.74, 0.259)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (5, 5, CAST(N'2022-08-05T09:30:00.000' AS DateTime), 1.01, 0.293)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (6, 6, CAST(N'2022-08-06T12:45:00.000' AS DateTime), 1.35, 0.338)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (7, 7, CAST(N'2022-08-07T14:00:00.000' AS DateTime), 1.23, 0.332)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (8, 8, CAST(N'2022-08-08T16:20:00.000' AS DateTime), 0.77, 0.47)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (9, 9, CAST(N'2022-08-09T18:30:00.000' AS DateTime), 0.96, 0.614)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (10, 10, CAST(N'2022-08-10T21:00:00.000' AS DateTime), 0.64, 0.224)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (11, 11, CAST(N'2022-08-11T23:15:00.000' AS DateTime), 1.22, 0.561)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (12, 12, CAST(N'2022-08-12T02:30:00.000' AS DateTime), 1.16, 0.673)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (13, 13, CAST(N'2022-08-13T04:45:00.000' AS DateTime), 1.04, 0.426)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (14, 14, CAST(N'2022-08-14T07:15:00.000' AS DateTime), 0.82, 0.508)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (15, 15, CAST(N'2022-08-15T10:30:00.000' AS DateTime), 0.53, 0.159)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (16, 16, CAST(N'2022-08-16T13:45:00.000' AS DateTime), 1.2, 0.576)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (17, 17, CAST(N'2022-08-17T15:00:00.000' AS DateTime), 1.47, 0.676)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (18, 18, CAST(N'2022-08-18T17:20:00.000' AS DateTime), 0.81, 0.599)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (19, 19, CAST(N'2022-08-19T19:30:00.000' AS DateTime), 1.12, 0.762)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (20, 20, CAST(N'2022-08-20T22:00:00.000' AS DateTime), 1.1, 0.572)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (21, 5, CAST(N'2022-08-17T01:54:31.000' AS DateTime), 1.47, 0.867)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (22, 4, CAST(N'2022-08-20T17:37:39.000' AS DateTime), 1.08, 0.594)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (23, 6, CAST(N'2022-09-06T06:28:09.000' AS DateTime), 0.59, 0.118)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (24, 8, CAST(N'2022-08-27T08:31:23.000' AS DateTime), 0.51, 0.178)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (25, 16, CAST(N'2022-09-20T21:42:06.000' AS DateTime), 0.82, 0.238)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (26, 17, CAST(N'2022-08-12T10:55:50.000' AS DateTime), 1.34, 0.335)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (27, 6, CAST(N'2022-08-18T11:58:12.000' AS DateTime), 0.89, 0.24)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (28, 2, CAST(N'2022-09-14T18:01:18.000' AS DateTime), 0.79, 0.482)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (29, 15, CAST(N'2022-08-15T23:33:46.000' AS DateTime), 0.55, 0.352)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (30, 9, CAST(N'2022-10-09T14:39:07.000' AS DateTime), 1.12, 0.392)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (31, 2, CAST(N'2022-10-04T11:07:51.000' AS DateTime), 0.78, 0.359)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (32, 14, CAST(N'2022-08-15T08:07:37.000' AS DateTime), 0.57, 0.331)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (33, 1, CAST(N'2022-09-17T06:33:20.000' AS DateTime), 1.03, 0.422)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (34, 11, CAST(N'2022-08-20T07:16:58.000' AS DateTime), 1.3, 0.806)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (35, 19, CAST(N'2022-10-11T11:05:27.000' AS DateTime), 0.8, 0.24)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (36, 17, CAST(N'2022-09-22T00:29:28.000' AS DateTime), 1.04, 0.499)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (37, 7, CAST(N'2022-09-04T04:33:49.000' AS DateTime), 0.63, 0.29)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (38, 7, CAST(N'2022-10-16T22:49:31.000' AS DateTime), 1.38, 1.021)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (39, 12, CAST(N'2022-09-19T15:52:02.000' AS DateTime), 0.64, 0.435)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (40, 4, CAST(N'2022-09-16T03:59:20.000' AS DateTime), 0.67, 0.348)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (41, 10, CAST(N'2022-09-26T15:05:34.000' AS DateTime), 1.31, 0.721)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (42, 2, CAST(N'2022-09-04T00:31:25.000' AS DateTime), 1.3, 0.39)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (43, 5, CAST(N'2022-10-04T05:22:29.000' AS DateTime), 0.59, 0.389)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (44, 17, CAST(N'2022-09-21T07:12:00.000' AS DateTime), 0.67, 0.181)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (45, 4, CAST(N'2022-10-03T12:20:33.000' AS DateTime), 0.82, 0.344)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (46, 14, CAST(N'2022-10-14T21:37:37.000' AS DateTime), 1.09, 0.556)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (47, 7, CAST(N'2022-10-23T06:55:25.000' AS DateTime), 0.55, 0.22)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (48, 16, CAST(N'2022-10-17T05:33:47.000' AS DateTime), 1.23, 0.553)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (49, 7, CAST(N'2022-09-25T13:28:06.000' AS DateTime), 0.98, 0.265)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (50, 14, CAST(N'2022-09-19T03:42:09.000' AS DateTime), 0.81, 0.308)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (51, 6, CAST(N'2022-10-07T02:59:28.000' AS DateTime), 0.68, 0.469)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (52, 10, CAST(N'2022-10-11T04:04:02.000' AS DateTime), 0.8, 0.464)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (53, 3, CAST(N'2022-09-03T13:38:21.000' AS DateTime), 1.44, 0.403)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (54, 20, CAST(N'2022-10-03T19:27:04.000' AS DateTime), 0.55, 0.193)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (55, 11, CAST(N'2022-10-17T03:51:33.000' AS DateTime), 1.17, 0.597)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (56, 17, CAST(N'2022-10-08T00:44:27.000' AS DateTime), 1, 0.6)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (57, 7, CAST(N'2022-09-15T09:18:08.000' AS DateTime), 1.22, 0.317)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (58, 2, CAST(N'2022-09-25T15:25:27.000' AS DateTime), 1.07, 0.631)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (59, 3, CAST(N'2022-11-04T17:48:45.000' AS DateTime), 1.06, 0.784)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (60, 10, CAST(N'2022-10-18T10:04:36.000' AS DateTime), 1.1, 0.517)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (61, 22, CAST(N'2022-10-24T12:01:59.000' AS DateTime), 1.41, 0.51)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (62, 23, CAST(N'2022-10-02T17:03:39.000' AS DateTime), 0.59, 0.46)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (63, 22, CAST(N'2022-10-13T23:53:01.000' AS DateTime), 1.16, 0.25)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (64, 23, CAST(N'2022-10-07T16:15:05.000' AS DateTime), 0.88, 0.27)
INSERT [dbo].[EnergyLog] ([el_id], [dev_id], [el_time], [el_val], [el_price]) VALUES (65, 22, CAST(N'2022-11-09T03:16:13.000' AS DateTime), 0.86, 0.74)
GO
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 0, 0.59)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 1, 0.43)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 2, 0.58)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 3, 0.54)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 4, 0.28)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 5, 0.65)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 6, 0.35)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 7, 0.54)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 8, 0.51)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 9, 0.31)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 10, 0.46)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 11, 0.28)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 12, 0.2)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 13, 0.22)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 14, 0.23)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 15, 0.46)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 16, 0.37)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 17, 0.74)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 18, 0.66)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 19, 0.68)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 20, 0.65)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 21, 0.72)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 22, 0.52)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10001', 23, 0.38)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 0, 0.58)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 1, 0.55)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 2, 0.26)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 3, 0.3)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 4, 0.34)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 5, 0.53)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 6, 0.59)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 7, 0.21)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 8, 0.66)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 9, 0.29)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 10, 0.71)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 11, 0.6)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 12, 0.25)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 13, 0.26)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 14, 0.27)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 15, 0.59)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 16, 0.22)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 17, 0.59)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 18, 0.27)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 19, 0.39)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 20, 0.3)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 21, 0.55)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 22, 0.26)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10002', 23, 0.37)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 0, 0.44)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 1, 0.37)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 2, 0.36)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 3, 0.2)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 4, 0.55)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 5, 0.66)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 6, 0.31)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 7, 0.35)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 8, 0.27)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 9, 0.24)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 10, 0.42)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 11, 0.47)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 12, 0.3)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 13, 0.31)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 14, 0.32)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 15, 0.34)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 16, 0.61)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 17, 0.74)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 18, 0.64)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 19, 0.43)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 20, 0.47)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 21, 0.35)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 22, 0.47)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10003', 23, 0.69)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 0, 0.26)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 1, 0.3)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 2, 0.58)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 3, 0.54)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 4, 0.41)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 5, 0.6)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 6, 0.66)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 7, 0.62)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 8, 0.69)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 9, 0.28)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 10, 0.62)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 11, 0.27)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 12, 0.51)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 13, 0.37)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 14, 0.4)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 15, 0.49)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 16, 0.6)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 17, 0.45)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 18, 0.37)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 19, 0.36)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 20, 0.54)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 21, 0.63)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 22, 0.38)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10004', 23, 0.46)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 0, 0.6)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 1, 0.23)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 2, 0.41)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 3, 0.66)
GO
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 4, 0.41)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 5, 0.44)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 6, 0.29)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 7, 0.65)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 8, 0.67)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 9, 0.71)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 10, 0.3)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 11, 0.66)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 12, 0.34)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 13, 0.48)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 14, 0.75)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 15, 0.37)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 16, 0.49)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 17, 0.67)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 18, 0.25)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 19, 0.27)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 20, 0.28)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 21, 0.38)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 22, 0.61)
INSERT [dbo].[PriceList] ([zip], [hourofday], [price_per_kw]) VALUES (N'10005', 23, 0.69)
GO
INSERT [dbo].[ServiceLocation] ([sl_id], [cust_id], [sl_unit_no], [sl_addr], [sl_city], [sl_state], [sl_zip], [sl_boughtat], [sl_squarefootage], [sl_bedrooms], [sl_occupants]) VALUES (1, 1, N'Apt 1', N'123 Main St', N'New York', N'NY', N'10001', CAST(N'2022-01-01' AS Date), 1000, 2, 4)
INSERT [dbo].[ServiceLocation] ([sl_id], [cust_id], [sl_unit_no], [sl_addr], [sl_city], [sl_state], [sl_zip], [sl_boughtat], [sl_squarefootage], [sl_bedrooms], [sl_occupants]) VALUES (2, 2, N'Apt 2', N'456 Park Ave', N'New York', N'NY', N'10002', CAST(N'2022-02-01' AS Date), 1200, 3, 3)
INSERT [dbo].[ServiceLocation] ([sl_id], [cust_id], [sl_unit_no], [sl_addr], [sl_city], [sl_state], [sl_zip], [sl_boughtat], [sl_squarefootage], [sl_bedrooms], [sl_occupants]) VALUES (3, 3, N'Apt 3', N'789 Broadway', N'New York', N'NY', N'10003', CAST(N'2022-03-01' AS Date), 950, 2, 2)
INSERT [dbo].[ServiceLocation] ([sl_id], [cust_id], [sl_unit_no], [sl_addr], [sl_city], [sl_state], [sl_zip], [sl_boughtat], [sl_squarefootage], [sl_bedrooms], [sl_occupants]) VALUES (4, 2, N'Apt 6', N'345 Tuppence Ct', N'North Potomac', N'MD', N'10004', CAST(N'2021-08-05' AS Date), 1500, 3, 4)
INSERT [dbo].[ServiceLocation] ([sl_id], [cust_id], [sl_unit_no], [sl_addr], [sl_city], [sl_state], [sl_zip], [sl_boughtat], [sl_squarefootage], [sl_bedrooms], [sl_occupants]) VALUES (5, 3, N'Apt 33', N'67 American Rd', N'Jersey City', N'NJ', N'10005', CAST(N'2021-09-11' AS Date), 900, 1, 2)
INSERT [dbo].[ServiceLocation] ([sl_id], [cust_id], [sl_unit_no], [sl_addr], [sl_city], [sl_state], [sl_zip], [sl_boughtat], [sl_squarefootage], [sl_bedrooms], [sl_occupants]) VALUES (441, 2, N'143', N'W 42nd St', N'Atlanta', N'GA', N'65780', CAST(N'2022-06-21' AS Date), 1100, 4, 3)
INSERT [dbo].[ServiceLocation] ([sl_id], [cust_id], [sl_unit_no], [sl_addr], [sl_city], [sl_state], [sl_zip], [sl_boughtat], [sl_squarefootage], [sl_bedrooms], [sl_occupants]) VALUES (224553, 1, N'11', N'Bleeker St', N'New York', N'NY', N'10006', CAST(N'2022-09-05' AS Date), 950, 2, 4)
GO
ALTER TABLE [dbo].[ActivityLog]  WITH CHECK ADD FOREIGN KEY([dev_id])
REFERENCES [dbo].[Device] ([dev_id])
GO
ALTER TABLE [dbo].[Device]  WITH CHECK ADD FOREIGN KEY([sl_id])
REFERENCES [dbo].[ServiceLocation] ([sl_id])
GO
ALTER TABLE [dbo].[EnergyLog]  WITH CHECK ADD FOREIGN KEY([dev_id])
REFERENCES [dbo].[Device] ([dev_id])
GO
ALTER TABLE [dbo].[ServiceLocation]  WITH CHECK ADD FOREIGN KEY([cust_id])
REFERENCES [dbo].[Customer] ([cust_id])
GO
