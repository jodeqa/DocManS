object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 575
  Top = 289
  Height = 447
  Width = 664
  object adcSAGDEV01: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=mydbaccess;Persist Security Info=Tr' +
      'ue;User ID=dbaccess;Initial Catalog=SurroundingCommon;Data Sourc' +
      'e=SAGDEV01.oto.co.id\solos4g'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 39
    Top = 18
  end
  object adqEmp: TADOQuery
    Connection = adcSAGDEV01
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'bc'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 3
        Value = '000'
      end>
    SQL.Strings = (
      'select'
      '  tee.employeeName'
      '  , tee.NTUserName'
      'from tr_emp_employee tee'
      'where'
      '  tee.compid = 2'
      '  and tee.branchcode = :bc'
      '  and tee.NTUserName <> '#39#39
      '  and tee.resigndate is null'
      'order by '
      '  tee.employeeName')
    Left = 111
    Top = 18
  end
  object dsqEmp: TDataSource
    DataSet = adqEmp
    Left = 111
    Top = 69
  end
  object adqMenu: TADOQuery
    Connection = adcSAGDEV01
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select'
      'tms.ModulSubID'
      ', tms.ModulSubName'
      ', tms.Resource'
      'from tu_modulSub tms '
      'where tms.ModulID = 120 ')
    Left = 183
    Top = 18
  end
  object dsqMenu: TDataSource
    DataSet = adqMenu
    Left = 183
    Top = 69
  end
  object adOTO: TADSI
    Left = 39
    Top = 69
  end
  object sqlDBCfg: TDISQLite3Database
    DatabaseName = 'D:\QProject\Delphi\DocManS\DocManS v1\dmsConf.db'
    Mutex = moFullMutex
    Left = 39
    Top = 279
  end
  object qrDBCfg: TDISQLite3UniDirQuery
    Database = sqlDBCfg
    InsertSQL = 
      'insert or ignore into ScanToConfig (id, fldDisplay, fldValue) va' +
      'lues (:id, :fdisp, :fval)'
    ModifySQL = 
      'insert or ignore into ScanToConfig (id, fldDisplay, fldValue) va' +
      'lues (:id, :fdisp, :fval)'
    SelectSQL = 'Select * from ScanToConfig'
    Left = 93
    Top = 279
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fdisp'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fval'
        ParamType = ptUnknown
      end>
  end
  object dspDBCfg: TDataSetProvider
    DataSet = qrDBCfg
    Constraints = True
    Left = 141
    Top = 279
  end
  object cdsDBCfg: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDBCfg'
    Left = 195
    Top = 279
    object cdsDBCfgid: TAutoIncField
      FieldName = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object cdsDBCfgfldDisplay: TWideStringField
      FieldName = 'fldDisplay'
    end
    object cdsDBCfgfldValue: TWideStringField
      FieldName = 'fldValue'
    end
  end
  object dsDBCfg: TDataSource
    DataSet = cdsDBCfg
    Left = 249
    Top = 279
  end
  object qrDBGrp: TDISQLite3UniDirQuery
    Database = sqlDBGrp
    ParamCheck = False
    SelectSQL = 'select * from scantogroup'
    Left = 93
    Top = 327
  end
  object dspDBGrp: TDataSetProvider
    DataSet = qrDBGrp
    Constraints = True
    Left = 141
    Top = 327
  end
  object cdsDBGrp: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDBGrp'
    Left = 195
    Top = 327
    object cdsDBGrpid: TAutoIncField
      FieldName = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object cdsDBGrpGroup: TWideStringField
      FieldName = 'Group'
    end
    object cdsDBGrpDocument: TWideStringField
      FieldName = 'Document'
    end
    object cdsDBGrpisADFScan: TLargeintField
      FieldName = 'isADFScan'
    end
    object cdsDBGrpisFBScan: TLargeintField
      FieldName = 'isFBScan'
    end
    object cdsDBGrpisPrint: TLargeintField
      FieldName = 'isPrint'
    end
    object cdsDBGrpisEmail: TLargeintField
      FieldName = 'isEmail'
    end
  end
  object dsDBGrp: TDataSource
    DataSet = cdsDBGrp
    Left = 249
    Top = 327
  end
  object sqlDBGrp: TDISQLite3Database
    DatabaseName = 'D:\QProject\Delphi\DocManS\DocManS v1\dmsConf.db'
    Mutex = moFullMutex
    Left = 39
    Top = 327
  end
  object adqCU: TADOQuery
    Connection = adcSAGDEV01
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'currUsr'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 25
        Value = 'dhemits'
      end>
    SQL.Strings = (
      'select'
      'tm.ModulID'
      ', tms.ModulSubID'
      ', tm.ModulName'
      ', tm.ModulDescription'
      ', tms.ModulSubName'
      ', tms.Resource'
      ', tum.RoleID'
      'from'
      'tu_modul tm inner join'
      
        'tu_modulSub tms on tms.ModulID = tm.ModulID and tm.ModulID = 120' +
        ' inner join'
      
        'tu_UserModul tum on tum.ModulID = tms.ModulID and tum.ModulSubID' +
        ' = tms.ModulSubID '
      'where'
      '  tum.NTUserName = :currUsr')
    Left = 255
    Top = 18
  end
  object dsCU: TDataSource
    DataSet = adqCU
    Left = 255
    Top = 69
  end
  object adqCA: TADOQuery
    Connection = adcSAGDEV01
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select'
      'tm.ModulID'
      ', tms.ModulSubID'
      ', tm.ModulName'
      ', tm.ModulDescription'
      ', tms.ModulSubName'
      ', tms.Resource'
      ', tum.NTUserName'
      'from'
      'tu_modul tm inner join'
      
        'tu_modulSub tms on tms.ModulID = tm.ModulID and tm.ModulID = 120' +
        ' inner join'
      
        'tu_UserModul tum on tum.ModulID = tms.ModulID and tum.ModulSubID' +
        ' = tms.ModulSubID ')
    Left = 327
    Top = 18
  end
  object dsCA: TDataSource
    DataSet = adqCA
    Left = 327
    Top = 69
  end
  object adcCom: TADOCommand
    Connection = adcSAGDEV01
    Parameters = <>
    Left = 389
    Top = 42
  end
  object adcDocManS: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=mydbaccess;Persist Security Info=Tr' +
      'ue;User ID=dbaccess;Initial Catalog=docmans;Data Source=SAGDEV01' +
      '.oto.co.id\solos4g'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 42
    Top = 132
  end
  object adqScanTo: TADOQuery
    Connection = adcDocManS
    Parameters = <>
    Left = 111
    Top = 132
  end
  object dqScanTo: TDataSource
    DataSet = adqScanTo
    Left = 111
    Top = 186
  end
  object adqSGroup: TADOQuery
    Connection = adcDocManS
    Parameters = <>
    SQL.Strings = (
      'select'
      '  idsg'
      '  , groupDir'
      '  , groupName'
      '  , docInfo'
      '  , docMail'
      'from tb_Scangroup')
    Left = 183
    Top = 132
  end
  object dqSGroup: TDataSource
    DataSet = adqSGroup
    Left = 183
    Top = 186
  end
  object adqLogCat: TADOQuery
    Connection = adcDocManS
    Parameters = <>
    Left = 255
    Top = 132
  end
  object dqLogCat: TDataSource
    DataSet = adqLogCat
    Left = 255
    Top = 186
  end
  object adqLog: TADOQuery
    Connection = adcDocManS
    Parameters = <>
    Left = 327
    Top = 132
  end
  object dqLog: TDataSource
    DataSet = adqLog
    Left = 327
    Top = 186
  end
  object adcLog: TADOCommand
    Connection = adcDocManS
    Parameters = <>
    Left = 390
    Top = 132
  end
  object adcScanTo: TADOCommand
    Connection = adcDocManS
    Parameters = <>
    Left = 393
    Top = 186
  end
  object adqGroup: TADOQuery
    Connection = adcDocManS
    Parameters = <>
    SQL.Strings = (
      'select ids, GroupDir, fCrow'
      'from vw_group'
      'where ids <= 4')
    Left = 457
    Top = 133
  end
  object dqGroup: TDataSource
    DataSet = adqGroup
    Left = 460
    Top = 186
  end
  object adqLay: TADOQuery
    Connection = adcDocManS
    Parameters = <>
    SQL.Strings = (
      'select *'
      'from tb_layout')
    Left = 517
    Top = 132
  end
  object dqLay: TDataSource
    DataSet = adqLay
    Left = 520
    Top = 185
  end
  object adcMail: TADOCommand
    Connection = adcDocManS
    Parameters = <>
    Left = 573
    Top = 132
  end
end
