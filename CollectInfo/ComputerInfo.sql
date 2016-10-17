USE [TestData]
GO

/****** Object:  Table [dbo].[ComputerInfo]    Script Date: 10/16/2016 7:43:08 PM ******/

CREATE TABLE [dbo].[ComputerInfo](
	[DNSHostName] [nvarchar](20) NULL,
	[Domain] [nvarchar](20) NULL,
	[Model] [nvarchar](50) NULL,
	[Memory] [nvarchar](20) NULL,
	[SerialNumber] [nvarchar](20) primary key NOT NULL,
	[UUID] [nvarchar](50) NULL,
	[MAC] [nvarchar](20) NULL,
	[IPAddress] [nvarchar](50) NULL,
	[NetDriver] [nvarchar](20) NULL,
	[LastMachineCom] [datetime] NULL,
	[UserName] [nvarchar](20) NULL,
	[UserDomain] [nvarchar](20) NULL,
	[CTIUser] [nvarchar](20) NULL,
	[EXTUser] [nvarchar](20) NULL,
	[CTIMachine] [nvarchar](20) NULL,
	[EXTMachine] [nvarchar](20) NULL,
	[LastUserCom] [datetime] NULL
) ON [PRIMARY]

GO


