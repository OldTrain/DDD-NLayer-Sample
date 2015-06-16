﻿IF object_id(N'[auth].[FK_auth.Role_User_auth.User_User_Id]', N'F') IS NOT NULL
    ALTER TABLE [auth].[Role_User] DROP CONSTRAINT [FK_auth.Role_User_auth.User_User_Id]
IF object_id(N'[auth].[FK_auth.Role_User_auth.Role_Role_Id]', N'F') IS NOT NULL
    ALTER TABLE [auth].[Role_User] DROP CONSTRAINT [FK_auth.Role_User_auth.Role_Role_Id]
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_User_Id' AND object_id = object_id(N'[auth].[Role_User]', N'U'))
    DROP INDEX [IX_User_Id] ON [auth].[Role_User]
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_Role_Id' AND object_id = object_id(N'[auth].[Role_User]', N'U'))
    DROP INDEX [IX_Role_Id] ON [auth].[Role_User]
IF schema_id('auth') IS NULL
    EXECUTE('CREATE SCHEMA [auth]')
CREATE TABLE [auth].[RoleGroup_User] (
    [User_Id] [uniqueidentifier] NOT NULL,
    [RoleGroup_Id] [uniqueidentifier] NOT NULL,
    CONSTRAINT [PK_auth.RoleGroup_User] PRIMARY KEY ([User_Id], [RoleGroup_Id])
)
CREATE INDEX [IX_User_Id] ON [auth].[RoleGroup_User]([User_Id])
CREATE INDEX [IX_RoleGroup_Id] ON [auth].[RoleGroup_User]([RoleGroup_Id])
ALTER TABLE [auth].[User] ADD [Role_Id] [uniqueidentifier]
CREATE INDEX [IX_Role_Id] ON [auth].[User]([Role_Id])
ALTER TABLE [auth].[User] ADD CONSTRAINT [FK_auth.User_auth.Role_Role_Id] FOREIGN KEY ([Role_Id]) REFERENCES [auth].[Role] ([Id])
DROP TABLE [auth].[Role_User]
ALTER TABLE [auth].[RoleGroup_User] ADD CONSTRAINT [FK_auth.RoleGroup_User_auth.User_User_Id] FOREIGN KEY ([User_Id]) REFERENCES [auth].[User] ([Id]) ON DELETE CASCADE
ALTER TABLE [auth].[RoleGroup_User] ADD CONSTRAINT [FK_auth.RoleGroup_User_auth.RoleGroup_RoleGroup_Id] FOREIGN KEY ([RoleGroup_Id]) REFERENCES [auth].[RoleGroup] ([Id]) ON DELETE CASCADE
INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
VALUES (N'201506161423201_ModifyRoleUser', N'NLayer.Repository.Migrations.Configuration',  0x1F8B0800000000000400ED5DDB6EE436127D5F60FF41D0D366E1B46CCF4B627427F0B6C70323E30BDC9E64DF0C5A62B785E8D29128C78DC57E591EF249F98590BA35AF1229A92FF6340264A645B258C53AAC2A9245CE5F7FFC39FEF1350CAC1798A47E1C4DEC93D1B16DC1C88D3D3F5A4CEC0CCDBFFDCEFEF1877FFE63FCD10B5FAD9FAB7A1F483DDC324A27F63342CB33C749DD6718827414FA6E12A7F11C8DDC387480173BA7C7C7DF3B27270EC4246C4CCBB2C6F75984FC10E63FF0CF691CB9708932105CC71E0CD2F23B2E99E554AD1B10C274095C38B16F3E83154C46F77019A73E8A93D5E84BE4A3DBF92F71F2AB6D9D073EC03CCD6030B72D1045310208737CF625853394C4D162B6C41F40F0B05A425C6F0E821496929CADABEB0A757C4A8472D60D2B526E96A238342478F2A11C25876FDE69ACED7A14F1387EC4E38D5644EA7C2C27F6358C32DBE23B3A9B0609A9540FF3052EF5A3111EBE64B64A110CB182B2008ECE178B042E0082E98850C23FF33F8F2CA6DD518D180C2CF2DF9135CD0294257012C10C252038B2EEB2A7C0777F82AB87F857184DA22C0868CE31EFB88CF9803FDD25F1122668750FE7A53C579E6D396C3B876F5837A3DA14D27ECA7CFCF71BDC37780A608D0BA7B139F97F4500830BCF18DBBA06AF9F61B440CF7884C1AB6D5DFAAFD0ABBE9454315EF104C38D5092B57632C53537DEC99724D8781F057036DECD2C4ED06DE2C1A4EAE92A421F4E8D753B4D2006778D8F0BFCE3C127EA6EA373035EFC453E97388A773009FD944C86D4B6EE6190D7499FFD6561ADF2E9F3C854BA4CE2F03E0ECAC94A973DCEE22C71C960C68A0A0F205940C4723776D656A0D136AC090D6B21D6740F76E24DDA89739740601BD6626FA771E137FBCEDF6A7A2AE76F35C175D92264E4768594A8F8E2CB04BE840AA67C11B320E78B94A8F8E2CB04BE840A32BEB4ED1DA1398CA5239488A5237F1E6CDCD046E102A66EE22F8B88F86B35406D7184D17CE7E308A54130B1439F92385BAA79A3AA709CD52572BED6C5A65CA9AD504EB82CE6B8C9BFCA39298A7AC558D4280C6578727295F5C97F1C4CD0C1046DC004B5041B3A135C1A6888F37FA03023272A4618C56779705196F58A2B08A161A6372923339BFC7998D4434FB4CFF1C28FB6D7D3DDEFDEC63BFA88A1B1F9555A67D3C20F0B48513E34393E37AF85AABB016D626562BA99203ECA9099A7A10244A3859794B1AE1B4DE7691ABB7ECE0FE549185E58193F469ED516B91650A99C0F460B367EFE129B3BCCC0C4FEB7306E0D346B47B0A6496F8535521E3B9474CD42D37850F12605C79AADC2B3E88B2A7577ECC8951E7B50217534AB865C4F7177A0592EFC69049E64B1D313CA92E84A43C52736EFF86FA30B184004AD62BB0F9B7990BAC0138D219EE65E8F812A82B64691B83558F3001D8F46276D63C4AEDCCC2066209FB019A8624ABDB3BF66ADD872DC94D69AD9D9C8C429BCC3348E108E5F6152857A79544B1FE60A91335652193CA7A5A7E70521846710516AC0FE6DED8D98111590C236665CA440821E851642E5724920516058A371153B48299493BA854CB940122814B0E71A536A631961C306AA9A6AEF8907A98643AF39AF07CE31A052E195A2C2F0CCCF0556548D61608239710494BEBDD5BB531C97CA6A905BE6CFB981AB781C46E216C5377B7B3D7F6F3E005B553CBFB5A140BFC2FBEBF87F73E48B1E7F5320A0F74915924BDC799B43379798F5DF6D90E920A8788C278ADBECDDF5FC3BC57AE9A51A4457BAE5DE68AF966AB5335EA75E3945EE55F961EC2892B4C6D760B9C4EB742A69ABFC62CD8A8CADE9B733F304A6B0A0E1B8A9248FA9E6B6EE09C5095840AEB43815BFF49314E1153E780264413FF542A19A107A289C69D51D1D5D885AAB5C6C559BFC9D0E71E4B96B4550C2515B0FE625962F8411CA45851C7AC46616499D03014824DB71D338C8C248B5A5D7D4BAD823A3DB175FF42914690A3485E28B3E853CFB8026907FD06F5FE521D124AA6FFA54A8BD799A10F5D9604CAA5D346658AA8F229DB1C3618287A02360505801B080D6827BB3C1EB087A2A8C36877E53E3F73B01A8241C9A0CF5F900634B0DE322D0180CC0F922CE1CBAF266FB0A5AE6D49326C4141C606735C34EB92EEC813DE95A4313808AB60714BE5B14AAD6681D0198EF1E99634FDE6C5F61479D0ED364A8CF86B4F2F35F8154FE559F5279C04B93293F6D0EB44AA9B8E35B4636AEAC035505C15D4C2B761D2D5A7876E7C0C08CB30D65C65A1DEC928D0249868E6CDB411C30AD29979393CDBBFC30A16ADC81AD721FA3235B6B4A86CCF11B22C6BA6676810D8C65DD4666121BB70E25094FDC0E72C741CC290DA05BC996740FB415BB9ABBD06A97192C3694E9D76806ABB6C9F741CBEF6106F3DBF926B69A6AA6B3AE53194261F77ECBF34587B37EA8DB854ECB8300137D964D74C254D58831E71AFBE065998392ADA8CFCAEF717B7E9E067195924CBA3A8B4E43CCDEDA174F6E0C36DE9BADB791E5561DF97454424E6E0054A8CE90F6646A0B07517C953AB4AF0FA4B883A7717908D4FE8480702A5454B12DCCFB8BEF9113A122117B442A8C66BF05D3C0C78B8975856B10F97398A2229FDA3E3D3E39E5DE1ED89F77009C34F598746FC56300ACC2B690109E45FE6F19C4C389D999FB64BFA5477278F40212F71924FF0AC1EB373425D3CBB3BD085157637BD1612FCBF72225DC22F10990FBDD21F1F00FD49E2FDDE5C2F90185FD0909D7B4DF2A802413A3F2862AE50939835791075F27F6FF720267D6D57F1F4B1A47562ED599756CFD7F28208BE1FFD70561C9F5B8F7833D769DD5038034A14DA15096817E80E2DB84A2D985C3AF58E7C245BEFED4A8CB7ABD883117F2FA8509039933F9A5BB7E23C65FACEB656B8730B30D165614C8C8C0F68B59D57B3D62DDC64DD2F689BA85A1D4522927460F6E184A9B70A00DA7317AEA556FB7CBA1A0DABE6DD76EDD538FF12C69F4D2EE9B098E9A4E6286576ECFB9BB2FDADDDFB9DB7EA758BAFFCADD2B68BD5BB8A1FB769C23E1B9A08BDA2E8362CCC184A80204532C354A802FA63FDC257EE4FA4B10D0B28B3BC03A112291AC26C7975CC0258C0830E472EAF4D8701A5253E706BA6D084C2FA8B6ED96538A542851ADC0770A2843256F1F56AD27CE5B00575BF20677CFADF59EF286B0C446413C13BA6F0674459222B770700C3566DE18FAFF6D83A7C528C995B7859700F6084666AADD3A96DA7237B60528837869D72649E1DEF8A2376F940C1DDB1E58A537182FED1A50DB8D973AC06A1FE2A5A68BF57BE7EEB496936FD1B969AF15F7C0A7A91E2430D553CB93425AAEF08D2DD5B55DDC6E17E8462F2CEDEA3925632F371056144F090C8E15435FD290CA383862B86C422AC5867D0F82579DF88094F2FDA8226B7062830C3D63FD165B97864F4BB5BC2C25ED82AED0D25161D3842E8ACF52E2459106D9D2A74A6957C9F1AA0EF4DFAC523E5925A52D7DCD4AC67CA302F80A4A311E0D34C1AD75A552690FDDA396A07C002BEDB355502EB2177AD57A2CAC7EF6A6FDCD3045BAB4E0B9F94B17A25151EF8AAAAFD6B524A57711BD7AAB474374794AB6C2A1C8F3D3F76518644F9C353E97D6AE77DA1EAC2F6834092C9D7492FB76C38AAB5678FB1D39F972467A6F7F8F04D79BE99A57DA7A6B5C0171BE6878D15B14BFC599BECD61E056E77D1FC6EB0A792DAFB0BB97EFCC1C9616F0F7E3753BE129BB46C18C613DCCDB75E2D520BCB4A0FE0D52BCB249FDC59A04B9C91641975954D475AEA2795C2D6E388EAA2A42D63A021E5E719C27C89F0317E162176271C9EBF63F832083243FF0097A57D16D869619C222C3F02958D18341D6484DFDE70FF4B13C8F6FF3F4D7740811309B3EC9E6BB8DFE93F98157F37D2949D55090208BAF4F107F2F7489D772082E5635A59B38D224540E5FBD667C80E13220FF4EC66D34032FB00B6F787E7D860BE0AEAA1B5E6A22ED8A60877D7CE1834502C2B4A4B16E8F7F620C7BE1EB0F7F0383AC60488A770000 , N'6.1.3-40302')