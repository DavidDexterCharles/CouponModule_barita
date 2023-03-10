USE [CouponsDB]
GO
ALTER TABLE [dbo].[securities] DROP CONSTRAINT [DF__securitie__statu__7A672E12]
GO
ALTER TABLE [dbo].[coupons] DROP CONSTRAINT [DF__coupons__status___00200768]
GO
ALTER TABLE [dbo].[coupons] DROP CONSTRAINT [DF__coupons__record___7F2BE32F]
GO
ALTER TABLE [dbo].[coupons] DROP CONSTRAINT [DF__coupons__payment__7E37BEF6]
GO
ALTER TABLE [dbo].[coupons] DROP CONSTRAINT [DF__coupons__isin_co__7D439ABD]
GO
/****** Object:  Table [dbo].[status_codes]    Script Date: 2023-02-15 10:10:58 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[status_codes]') AND type in (N'U'))
DROP TABLE [dbo].[status_codes]
GO
/****** Object:  Table [dbo].[securities]    Script Date: 2023-02-15 10:10:58 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[securities]') AND type in (N'U'))
DROP TABLE [dbo].[securities]
GO
/****** Object:  Table [dbo].[coupons]    Script Date: 2023-02-15 10:10:58 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[coupons]') AND type in (N'U'))
DROP TABLE [dbo].[coupons]
GO
/****** Object:  Table [dbo].[coupons]    Script Date: 2023-02-15 10:10:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[coupons](
	[coupon_id] [int] IDENTITY(1,1) NOT NULL,
	[isin_code] [varchar](20) NULL,
	[payment_date] [datetime2](0) NULL,
	[record_date] [datetime2](0) NULL,
	[status_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[coupon_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[securities]    Script Date: 2023-02-15 10:10:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[securities](
	[isin_code] [varchar](20) NOT NULL,
	[description] [varchar](max) NOT NULL,
	[status_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[isin_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[status_codes]    Script Date: 2023-02-15 10:10:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[status_codes](
	[status_id] [int] IDENTITY(1,1) NOT NULL,
	[status_name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[status_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[coupons] ON 

INSERT [dbo].[coupons] ([coupon_id], [isin_code], [payment_date], [record_date], [status_id]) VALUES (3, N'GOJ TBILL 2015Z', CAST(N'2023-02-15T00:00:00.0000000' AS DateTime2), CAST(N'2023-02-15T00:00:00.0000000' AS DateTime2), 3)
INSERT [dbo].[coupons] ([coupon_id], [isin_code], [payment_date], [record_date], [status_id]) VALUES (4, N'TREASURY BILL', CAST(N'2023-02-15T00:00:00.0000000' AS DateTime2), CAST(N'2023-02-15T00:00:00.0000000' AS DateTime2), 3)
INSERT [dbo].[coupons] ([coupon_id], [isin_code], [payment_date], [record_date], [status_id]) VALUES (6, N'US896292AF68', CAST(N'2023-02-15T00:00:00.0000000' AS DateTime2), CAST(N'2023-02-15T00:00:00.0000000' AS DateTime2), 2)
INSERT [dbo].[coupons] ([coupon_id], [isin_code], [payment_date], [record_date], [status_id]) VALUES (7, N'US470160BC55', CAST(N'2023-02-15T00:00:00.0000000' AS DateTime2), CAST(N'2023-02-15T00:00:00.0000000' AS DateTime2), 1)
INSERT [dbo].[coupons] ([coupon_id], [isin_code], [payment_date], [record_date], [status_id]) VALUES (8, N'JMB201400158', CAST(N'2023-02-15T00:00:00.0000000' AS DateTime2), CAST(N'2023-02-15T00:00:00.0000000' AS DateTime2), 2)
INSERT [dbo].[coupons] ([coupon_id], [isin_code], [payment_date], [record_date], [status_id]) VALUES (10, N'BJV36416A087', CAST(N'2023-02-15T00:00:00.0000000' AS DateTime2), CAST(N'2023-02-15T00:00:00.0000000' AS DateTime2), 1)
SET IDENTITY_INSERT [dbo].[coupons] OFF
GO
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'BJU00318B268', N'Bank of Jamaica Variable Rate Certificate of Deposit 20180226', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'BJU36416B094', N'3.25% US-INDEXED NOTE 2016A', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'BJU36516B034', N'3.25% US-INDEXED NOTE 2016', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'BJV00216M195', N'Bank of Jamaica variable Rate Certificate of Deposit 20161219', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'BJV00217B097', N'Bank of Jamaica variable Rate Certificate of Deposit 20170209', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'BJV00217B246', N'Bank of Jamaica Variable Rate Certificate of Deposit ', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'BJV36415M183', N'Bank of Jamaica variable Rate Certificate of Deposit 20151218', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'BJV36416A087', N'Bank of Jamaica Variable Rate Certificate of Deposit 20160108', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'BJV36516B264', N'Bank of Jamaica Variable Rate Certificate of Deposit 20200216', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'BJV36616B114', N'Bank of Jamaica variable Rate Certificate of Deposit 20160211', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'BOJ REPO', N'BOJ REPO', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'GBF00315B241', N'Fixed Rate 7.20% Benchmark Investment Notes 2015', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'GBF01122D287', N'FR 8.75% BMI Notes 2022', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'GOJ TBILL (2015)', N'GOVERNMENT OF JAMAICA TREASURY BILL 20150119', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'GOJ TBILL -2015', N'GOVERNMENT OF JAMAICA TREASURY BILL 20150320', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'GOJ TBILL 2015Y', N'GOVERNMENT OF JAMAICA TREASURY BILL 20150522', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'GOJ TBILL 2015Z', N'GOVERNMENT OF JAMAICA TREASURY BILL 20150220', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'GOJ TBILL2015', N'GOVERNMENT OF JAMAICA TREASURY BILL 20150619', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'GUB00616B243', N'Fixed Rate 7.25% USD Benchmark Notes 2016', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'JMB201400034', N'Bank of Jamaica $US Certificate of Deposit 20181217', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'JMB201400158', N'Bank of Jamaica $US Certificate of Deposit 20191217', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'JMB201400166', N'Bank of Jamaica $US Certificate of Deposit 20211217', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'JMB201500015', N'Bank of Jamaica $US Certificate of Deposit 20220110', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'JMB201500023', N'Bank of Jamaica $US Certificate of Deposit 20221002', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'JMB201500031', N'BOJ USD COD_7 YEARS_20150227', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'JMB201500049', N'BOJ USD COD_5 YEARS_20150227', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'JMB201500106', N'Bank of Jamaica $US Certificate of Deposit 20190119', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'JMB201500114', N'Bank of Jamaica $US Certificate of Deposit 20220210', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'JMB201500205', N'Bank of Jamaica $US Certificate of Deposit 20200109', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'JMB201500221', N'Bank of Jamaica $US Certificate of Deposit 20200210', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'TREASURY BILL', N'GOJ TBILL', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'US470160AQ50', N'Government of Jamaica 11.625% notes due 2022', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'US470160AR34', N'Governmennt of Jamaica 10.625% notes due 2017', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'US470160AS17', N'Government of Jamaica 9.0% notes due 2015', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'US470160AT99', N'Government of Jamaica 9.25% notes due 2025', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'US470160BB72', N'Government of Jamaica 8.55% ( 144A) notes due 2020', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'US470160BC55', N'Government of Jamaica 8.55% (regulation S) notes due 2020', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'US470160BD39', N'Government of Jamaica 8.425% (144A) notes due 2017', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'US470160BE12', N'Government of Jamaica 8.425% (Regulation S) notes due 2017', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'US470160BF86', N'Government of Jamaica 12.625% (144A)notes due 2016', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'US470160BG69', N'Government of Jamaica 12.625% (Regulation S) notes due 2016', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'US470160BP68', N'Government of Jamaica 8.5% notes due 2021', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'US60468AAA43', N'Mirant JPSCO Finance Ltd. (Funding Corp), 144A, Senior Notes Due 2016', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'US716558AC52', N'PETROLEOS DE VENEZUELA S 12.75% (144A) DUE 2022', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'US896292AF68', N'Rep of Trinidad & Tobago USD FGN BD (144A) 9.7500% DUE 07/01/2020', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'USG6149AAA72', N'Mirant JPSCO Finance Ltd. (Funding Corp), Regulation S,Senior Notes Due 2016', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'USP17625AD98', N'REPUBLIC OF VENEZUELA REG-S, DUE 2031', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'USP71647NAF69', N'PETROBRAS GLOBAL FINANCE 4.375% due 2023', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'USP7807HAM71', N'PETROLEOS DE VENEZUELA S 12.75% (Regulation S) DUE 2022', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'USP7807HAP03', N'PETROLEOS DE VENEZUELA SA (Regulation S) Due 11/17/2021 @ 9% S&P CCC+  ', 5)
INSERT [dbo].[securities] ([isin_code], [description], [status_id]) VALUES (N'USP93960AA38', N'Rep of Trinidad & Tobago USD FGN BD (Regulation S) 9.7500% DUE 07/01/2020', 5)
GO
SET IDENTITY_INSERT [dbo].[status_codes] ON 

INSERT [dbo].[status_codes] ([status_id], [status_name]) VALUES (1, N'PENDING')
INSERT [dbo].[status_codes] ([status_id], [status_name]) VALUES (2, N'ACTIVE')
INSERT [dbo].[status_codes] ([status_id], [status_name]) VALUES (3, N'CANCELLED')
SET IDENTITY_INSERT [dbo].[status_codes] OFF
GO
ALTER TABLE [dbo].[coupons] ADD  DEFAULT (NULL) FOR [isin_code]
GO
ALTER TABLE [dbo].[coupons] ADD  DEFAULT (NULL) FOR [payment_date]
GO
ALTER TABLE [dbo].[coupons] ADD  DEFAULT (NULL) FOR [record_date]
GO
ALTER TABLE [dbo].[coupons] ADD  DEFAULT (NULL) FOR [status_id]
GO
ALTER TABLE [dbo].[securities] ADD  DEFAULT (NULL) FOR [status_id]
GO
