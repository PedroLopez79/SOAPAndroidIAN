object DataService: TDataService
  OldCreateOrder = True
  RequiresSession = True
  SessionManager = ServerDataModule.SessionManager
  ServiceSchema = Schema
  ServiceDataStreamer = DataStreamer
  ExportedDataTables = <>
  ScriptProvider = EcmaScriptProvider
  Height = 212
  Width = 216
  object DataStreamer: TDABin2DataStreamer
    Left = 32
    Top = 8
  end
  object Schema: TDASchema
    ConnectionManager = ServerDataModule.ConnectionManager
    DataDictionary = ServerDataModule.DataDictionary
    
  Datasets = <
    item
      Params = <>
      Statements = <
        item
          Connection = 'Connection to facturaelectronica'
          ConnectionType = 'MSSQL'
          TargetTable = 'dbo.TipoCambio'
          StatementType = stAutoSQL
          ColumnMappings = <
            item
              DatasetField = 'TipoCambioID'
              TableField = 'TipoCambioID'
            end
            item
              DatasetField = 'TipoCambio'
              TableField = 'TipoCambio'
            end
            item
              DatasetField = 'EstacionID'
              TableField = 'EstacionID'
            end
            item
              DatasetField = 'Fecha'
              TableField = 'Fecha'
            end>
        end>
      Name = 'dbo.TipoCambio'
      BusinessRulesClient.CompileOnServer = False
      BusinessRulesClient.RunOnClientAndServer = False
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
    end
    item
      Params = <>
      Statements = <
        item
          Connection = 'Connection to facturaelectronica'
          ConnectionType = 'MSSQL'
          TargetTable = 'dbo.usuarios'
          StatementType = stAutoSQL
          ColumnMappings = <
            item
              DatasetField = 'IDEMPLEADO'
              TableField = 'IDEMPLEADO'
            end
            item
              DatasetField = 'CODIGO'
              TableField = 'CODIGO'
            end
            item
              DatasetField = 'NOMBRE'
              TableField = 'NOMBRE'
            end
            item
              DatasetField = 'USERNAME'
              TableField = 'USERNAME'
            end
            item
              DatasetField = 'USERPASSWORD'
              TableField = 'USERPASSWORD'
            end>
        end>
      Name = 'dbo.usuarios'
      BusinessRulesClient.CompileOnServer = False
      BusinessRulesClient.RunOnClientAndServer = False
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
    end>
  JoinDataTables = <>
  UnionDataTables = <>
  Commands = <>
  RelationShips = <>
  UpdateRules = <>
  Version = 0
  Left = 48
  Top = 152

    Left = 32
    Top = 56
  end
  
  object EcmaScriptProvider: TDASpiderMonkeyScriptProvider
    Left = 88
    Top = 8
  end
  
end
