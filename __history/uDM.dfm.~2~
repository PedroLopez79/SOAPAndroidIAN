object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 369
  Width = 504
  object cdsBitacoraServ: TDAMemDataTable
    Fields = <
      item
        Name = 'BITACORAID'
        DataType = datInteger
        Required = True
      end
      item
        Name = 'USUARIOID'
        DataType = datInteger
      end
      item
        Name = 'FECHA'
        DataType = datDateTime
      end
      item
        Name = 'NOTA'
        DataType = datString
        Size = 200
      end
      item
        Name = 'ACTIVIDAD'
        DataType = datString
        Size = 1000
      end
      item
        Name = 'FRECUENCIA'
        DataType = datString
        Size = 1000
      end
      item
        Name = 'OBSERVACIONES'
        DataType = datString
        Size = 1000
      end
      item
        Name = 'ESTACIONID'
        DataType = datInteger
      end
      item
        Name = 'FIRMA'
        DataType = datBlob
      end
      item
        Name = 'FECHAHORA'
        DataType = datDateTime
      end
      item
        Name = 'FOLIO'
        DataType = datInteger
      end
      item
        Name = 'FOTO1'
        DataType = datBlob
      end>
    LogicalName = 'dbo.BITACORAESTACION'
    Params = <>
    RemoteDataAdapter = RemoteDataAdapter
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming]
    IndexDefs = <>
    Left = 103
    Top = 9
  end
  object dsBitacoraServ: TDADataSource
    DataSet = cdsBitacoraServ.Dataset
    DataTable = cdsBitacoraServ
    Left = 104
    Top = 56
  end
  object Channel: TROWinInetHTTPChannel
    UserAgent = 'RemObjects SDK'
    DispatchOptions = []
    ServerLocators = <>
    TargetURL = 'http://IANSERVICES.DDNS.NET:8001/BIN'
    TrustInvalidCA = False
    Left = 16
    Top = 8
  end
  object Message: TROBinMessage
    Envelopes = <>
    Left = 16
    Top = 56
  end
  object RemoteService: TRORemoteService
    ServiceName = 'ServiceIngresos'
    Channel = Channel
    Message = Message
    Left = 16
    Top = 104
  end
  object RemoteDataAdapter: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = RemoteService
    GetDataCall.RemoteService = RemoteService
    UpdateDataCall.RemoteService = RemoteService
    GetScriptsCall.RemoteService = RemoteService
    RemoteService = RemoteService
    DataStreamer = DataStreamer
    Left = 16
    Top = 200
  end
  object DataStreamer: TDABin2DataStreamer
    Left = 16
    Top = 152
  end
  object cdsFirmaDefaultUsuario: TDAMemDataTable
    Fields = <
      item
        Name = 'IDEMPLEADO'
        DataType = datInteger
        Required = True
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
        Required = True
      end
      item
        Name = 'USERPASSWORD'
        DataType = datString
        Size = 10
        Required = True
      end
      item
        Name = 'FIRMADEFAULT'
        DataType = datBlob
      end>
    LogicalName = 'dbo.USUARIO'
    Params = <
      item
        Name = 'USUARIOID'
        DataType = datInteger
        Value = ''
        ParamType = daptInput
      end>
    RemoteDataAdapter = RemoteDataAdapter
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming]
    IndexDefs = <>
    Left = 207
    Top = 9
  end
  object dsFirmaDefaultUsuario: TDADataSource
    DataSet = cdsFirmaDefaultUsuario.Dataset
    DataTable = cdsFirmaDefaultUsuario
    Left = 208
    Top = 56
  end
  object cdsMaestro: TDACDSDataTable
    Fields = <>
    LogicalName = 'Reporte'
    MasterMappingMode = mmDataRequest
    Params = <>
    RemoteDataAdapter = rdaMaestro
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming]
    IndexDefs = <>
    Left = 384
    Top = 152
  end
  object cdsDetalle: TDACDSDataTable
    Fields = <>
    LogicalName = 'Reporte'
    MasterMappingMode = mmDataRequest
    Params = <>
    RemoteDataAdapter = rdaDetalle
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming]
    IndexDefs = <>
    Left = 456
    Top = 104
  end
  object dsMaestro: TDADataSource
    DataSet = cdsMaestro.Dataset
    DataTable = cdsMaestro
    Left = 384
    Top = 200
  end
  object dsDetalle: TDADataSource
    DataSet = cdsDetalle.Dataset
    DataTable = cdsDetalle
    Left = 456
    Top = 152
  end
  object dbpMaestro: TppDBPipeline
    DataSource = dsMaestro
    UserName = 'dbpMaestro'
    Left = 384
    Top = 56
  end
  object dbpDetalle: TppDBPipeline
    DataSource = dsDetalle
    UserName = 'dbpDetalle'
    Left = 456
    Top = 8
  end
  object repReportes: TppReport
    AutoStop = False
    DataPipeline = dbpMaestro
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.SaveDeviceSettings = False
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    Template.SaveTo = stDatabase
    Template.Format = ftASCII
    AllowPrintToArchive = True
    AllowPrintToFile = True
    ArchiveFileName = '($MyDocuments)\ReportArchive.raf'
    DeviceType = 'PDF'
    DefaultFileDeviceType = 'PDF'
    EmailSettings.ReportFormat = 'PDF'
    LanguageID = 'Default'
    ModalCancelDialog = False
    ModalPreview = False
    OpenFile = False
    OutlineSettings.CreateNode = False
    OutlineSettings.CreatePageNodes = False
    OutlineSettings.Enabled = False
    OutlineSettings.Visible = False
    ThumbnailSettings.Enabled = True
    ThumbnailSettings.Visible = True
    ThumbnailSettings.DeadSpace = 30
    PDFSettings.EmbedFontOptions = [efUseSubset]
    PDFSettings.EncryptSettings.AllowCopy = True
    PDFSettings.EncryptSettings.AllowInteract = True
    PDFSettings.EncryptSettings.AllowModify = True
    PDFSettings.EncryptSettings.AllowPrint = True
    PDFSettings.EncryptSettings.Enabled = False
    PDFSettings.EncryptSettings.KeyLength = kl40Bit
    PDFSettings.FontEncoding = feAnsi
    PDFSettings.ImageCompressionLevel = 25
    PreviewFormSettings.WindowState = wsMaximized
    PreviewFormSettings.ZoomSetting = zs100Percent
    RTFSettings.DefaultFont.Charset = DEFAULT_CHARSET
    RTFSettings.DefaultFont.Color = clWindowText
    RTFSettings.DefaultFont.Height = -13
    RTFSettings.DefaultFont.Name = 'Arial'
    RTFSettings.DefaultFont.Style = []
    ShowCancelDialog = False
    ShowPrintDialog = False
    TextFileName = '($MyDocuments)\Report.pdf'
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    XLSSettings.AppName = 'ReportBuilder'
    XLSSettings.Author = 'ReportBuilder'
    XLSSettings.Subject = 'Report'
    XLSSettings.Title = 'Report'
    Left = 384
    Top = 8
    Version = '15.02'
    mmColumnWidth = 0
    DataPipelineName = 'dbpMaestro'
    object ppParameterList1: TppParameterList
    end
  end
  object rdaMaestro: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = RemoteService
    GetDataCall.RemoteService = RemoteService
    GetDataCall.MethodName = 'AbreDataSetReportes'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SQL'
        DataType = rtString
        Flag = fIn
        Value = Null
      end
      item
        Name = 'Parametros'
        DataType = rtUserDefined
        Flag = fIn
        TypeName = 'TParametros'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = RemoteService
    GetScriptsCall.RemoteService = RemoteService
    RemoteService = RemoteService
    DataStreamer = DataStreamer
    Left = 384
    Top = 104
  end
  object rdaDetalle: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = RemoteService
    GetDataCall.RemoteService = RemoteService
    GetDataCall.MethodName = 'AbreDataSetReportes'
    GetDataCall.Params = <
      item
        Name = 'Result'
        DataType = rtBinary
        Flag = fResult
        Value = Null
      end
      item
        Name = 'SQL'
        DataType = rtString
        Flag = fIn
      end
      item
        Name = 'Parametros'
        DataType = rtUserDefined
        Flag = fIn
        TypeName = 'TParametros'
        Value = Null
      end>
    GetDataCall.Default = False
    GetDataCall.OutgoingTableNamesParameter = 'aTableNameArray'
    GetDataCall.OutgoingTableRequestInfosParameter = 'aTableRequestInfoArray'
    GetDataCall.IncomingDataParameter = 'Result'
    UpdateDataCall.RemoteService = RemoteService
    GetScriptsCall.RemoteService = RemoteService
    RemoteService = RemoteService
    DataStreamer = DataStreamer
    Left = 456
    Top = 56
  end
  object rdaReportesWEB: TDARemoteDataAdapter
    GetSchemaCall.RemoteService = RemoteService
    GetDataCall.RemoteService = RemoteService
    UpdateDataCall.RemoteService = RemoteService
    GetScriptsCall.RemoteService = RemoteService
    RemoteService = RemoteService
    DataStreamer = DataStreamer
    Left = 384
    Top = 256
  end
  object cdsReportes: TDACDSDataTable
    Fields = <
      item
        Name = 'ReporteID'
        DataType = datInteger
      end
      item
        Name = 'Nombre'
        DataType = datString
        Size = 50
      end
      item
        Name = 'Tipo'
        DataType = datInteger
      end
      item
        Name = 'Parametros'
        DataType = datString
        Size = 10
      end
      item
        Name = 'Template'
        DataType = datMemo
      end
      item
        Name = 'TemplateMedia'
        DataType = datMemo
      end
      item
        Name = 'TemplateBaja'
        DataType = datMemo
      end
      item
        Name = 'TemplateExportar'
        DataType = datMemo
      end
      item
        Name = 'SQL1'
        DataType = datMemo
      end
      item
        Name = 'SQL2'
        DataType = datMemo
      end
      item
        Name = 'CampoJoin'
        DataType = datString
        Size = 30
      end
      item
        Name = 'IdentificadorID'
        DataType = datInteger
      end
      item
        Name = 'Usuarios'
        DataType = datString
        Size = 80
      end>
    LogicalName = 'ReportesWEB'
    MasterMappingMode = mmDataRequest
    Params = <
      item
        Name = 'Nombre'
        Value = ''
        ParamType = daptInput
      end>
    RemoteDataAdapter = rdaReportesWEB
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming]
    IndexDefs = <>
    Left = 384
    Top = 304
  end
  object cdsAlmacenNum: TDAMemDataTable
    Fields = <
      item
        Name = 'IDALMACEN'
        DataType = datInteger
        Required = True
        InPrimaryKey = True
      end
      item
        Name = 'NOMBRE'
        DataType = datString
        Size = 70
      end
      item
        Name = 'NUMEROESTACION'
        DataType = datInteger
      end>
    LogicalName = 'dbo ALMACEN'
    Params = <>
    RemoteDataAdapter = RemoteDataAdapter
    RemoteUpdatesOptions = []
    StreamingOptions = [soDisableEventsWhileStreaming]
    IndexDefs = <>
    Left = 207
    Top = 249
  end
  object dsAlmacenNum: TDADataSource
    DataSet = cdsAlmacenNum.Dataset
    DataTable = cdsAlmacenNum
    Left = 208
    Top = 296
  end
end
