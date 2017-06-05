object LoginService: TLoginService
  OldCreateOrder = True
  SessionManager = ServerDataModule.SessionManager
  ExportedDataTables = <>
  OnLogout = LoginServiceLogout
  OnLogin = LoginServiceLogin
  Height = 300
  Width = 300
end
