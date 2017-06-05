object ServerDataModule: TServerDataModule
  OldCreateOrder = False
  OnCreate = ModuleCreate
  Height = 600
  Width = 660
  object Server: TROIndyHTTPServer
    Dispatchers = <
      item
        Name = 'Message'
        Message = Message
        Enabled = True
      end>
    Left = 48
    Top = 56
  end
  object Message: TROBinMessage
    Left = 144
    Top = 56
  end
  object DriverManager: TDADriverManager
    DriverDirectory = '%SYSTEM%\'
    TraceActive = False
    TraceFlags = []
    Left = 48
    Top = 8
  end
  object ConnectionManager: TDAConnectionManager
    MaxPoolSize = 10
    PoolTimeoutSeconds = 60
    PoolBehaviour = pbWait
    WaitIntervalSeconds = 1
    Connections = <
      item
        Name = 'Connection to facturaelectronica'
        ConnectionString = 'SDAC?Server=localhost;Database=facturaelectronica;UserID=DESARROLLO;Password=Cistem32;Schemas=1;Integrated Security=SSPI;'
        ConnectionType = 'MSSQL'
        Description = ''
        Default = True
        Tag = 0
      end>
    DriverManager = DriverManager
    PoolingEnabled = True
    Left = 144
    Top = 8
  end
  object DataDictionary: TDADataDictionary
    Fields = <>
    Left = 240
    Top = 8
  end
  object SessionManager: TROInMemorySessionManager
    Left = 336
    Top = 8
  end
  object LocalDataAdapter: TDALocalDataAdapter
    Left = 432
    Top = 8
    ServiceName = 'DataService'
    ReconcileProvider = ReconcileProvider
  end
  object ReconcileProvider: TDAVCLReconcileProvider
    Left = 524
    Top = 8
  end    
  object tbl_dbo_TipoCambio: TDAMemDataTable
  ScriptingProvider = sp_tbl_dbo_TipoCambio.Owner
  Fields = <
    item
      Name = 'TipoCambioID'
      DataType = datInteger
    end
    item
      Name = 'TipoCambio'
      DataType = datFloat
    end
    item
      Name = 'EstacionID'
      DataType = datInteger
    end
    item
      Name = 'Fecha'
      DataType = datDateTime
    end>
  LogicalName = 'dbo.TipoCambio'
  Params = <>
  RemoteDataAdapter = LocalDataAdapter.Owner
  RemoteUpdatesOptions = []
  StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
  IndexDefs = <>
  Left = 240
  Top = 104
end
object ds_dbo_TipoCambio: TDADataSource
  DataSet = tbl_dbo_TipoCambio.Dataset
  DataTable = tbl_dbo_TipoCambio.Owner
  Left = 48
  Top = 104
end
object sp_tbl_dbo_TipoCambio: TDASpiderMonkeyScriptProvider
  ScriptableComponent = tbl_dbo_TipoCambio.Owner
  Left = 144
  Top = 104
end
object tbl_dbo_usuarios: TDAMemDataTable
  ScriptingProvider = sp_tbl_dbo_usuarios.Owner
  Fields = <
    item
      Name = 'IDEMPLEADO'
      DataType = datInteger
    end
    item
      Name = 'CODIGO'
      DataType = datString
      Size = 10
    end
    item
      Name = 'NOMBRE'
      DataType = datString
      Size = 70
    end
    item
      Name = 'USERNAME'
      DataType = datString
      Size = 10
    end
    item
      Name = 'USERPASSWORD'
      DataType = datString
      Size = 10
    end>
  LogicalName = 'dbo.usuarios'
  Params = <>
  RemoteDataAdapter = LocalDataAdapter.Owner
  RemoteUpdatesOptions = []
  StreamingOptions = [soDisableEventsWhileStreaming, soDisableFiltering]
  IndexDefs = <>
  Left = 528
  Top = 104
end
object ds_dbo_usuarios: TDADataSource
  DataSet = tbl_dbo_usuarios.Dataset
  DataTable = tbl_dbo_usuarios.Owner
  Left = 336
  Top = 104
end
object sp_tbl_dbo_usuarios: TDASpiderMonkeyScriptProvider
  ScriptableComponent = tbl_dbo_usuarios.Owner
  Left = 432
  Top = 104
end

end
