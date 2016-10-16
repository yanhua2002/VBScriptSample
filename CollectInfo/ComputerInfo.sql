USE [TestData]
GO

/****** Object:  Table [dbo].[ComputerInfo]    Script Date: 10/16/2016 7:43:08 PM ******/

CREATE TABLE [dbo].[ComputerInfo](
	[DNSHostname] [nvarchar](50) NULL,
	[DomainUser] [nvarchar](50) NULL,
	[Memory] [nvarchar](50) NULL,
	[Model] [nvarchar](50) NULL,
	[Version] [nvarchar](10) NULL,
	[SerialNumber] [nvarchar](50) primary key NOT NULL,
	[UUID] [nvarchar](50) NULL,
	[MAC] [nvarchar](50) NULL,
	[LastCom] [datetime] NULL
) ON [PRIMARY]

GO


