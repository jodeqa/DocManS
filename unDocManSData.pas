unit unDocManSData;

interface

uses
  forms, SysUtils, Classes, DB, ADODB, ADSI, DBXpress, SqlExpr, DBClient,
  DISQLite3Database, DISQLite3DataSet, Provider, midaslib;

function setLog(idCat:Integer; lInfo : String) : boolean;
function setScanTo(idsg,remindIn:Integer; scanName,remindWhen : String; isReminder,remindOnce : byte ) : boolean;
function readScanGroup(resColumn:integer) : TStringList;
function getScanGroup(idxCB:integer) : TStringList;
function readGroup(resColumn:integer) : TStringList;
function getGroup(idxCB:integer) : TStringList;
function getLayOut(idxCB:integer) : TStringList;
function docCheck(dtLayOut:TStringList):Integer;
function docLayOut(dtLayOut:TStringList):TStringList;
function getDBConfig(configID : integer) : String;

type
  Tdm = class(TDataModule)
    adcSAGDEV01: TADOConnection;
    adqEmp: TADOQuery;
    dsqEmp: TDataSource;
    adqMenu: TADOQuery;
    dsqMenu: TDataSource;
    adOTO: TADSI;
    sqlDBCfg: TDISQLite3Database;
    qrDBCfg: TDISQLite3UniDirQuery;
    dspDBCfg: TDataSetProvider;
    cdsDBCfg: TClientDataSet;
    dsDBCfg: TDataSource;
    qrDBGrp: TDISQLite3UniDirQuery;
    dspDBGrp: TDataSetProvider;
    cdsDBGrp: TClientDataSet;
    dsDBGrp: TDataSource;
    cdsDBGrpid: TAutoIncField;
    cdsDBGrpGroup: TWideStringField;
    cdsDBGrpDocument: TWideStringField;
    cdsDBGrpisADFScan: TLargeintField;
    cdsDBGrpisFBScan: TLargeintField;
    cdsDBGrpisPrint: TLargeintField;
    cdsDBGrpisEmail: TLargeintField;
    cdsDBCfgid: TAutoIncField;
    cdsDBCfgfldDisplay: TWideStringField;
    cdsDBCfgfldValue: TWideStringField;
    sqlDBGrp: TDISQLite3Database;
    adqCU: TADOQuery;
    dsCU: TDataSource;
    adqCA: TADOQuery;
    dsCA: TDataSource;
    adcCom: TADOCommand;
    adcDocManS: TADOConnection;
    adqScanTo: TADOQuery;
    dqScanTo: TDataSource;
    adqSGroup: TADOQuery;
    dqSGroup: TDataSource;
    adqLogCat: TADOQuery;
    dqLogCat: TDataSource;
    adqLog: TADOQuery;
    dqLog: TDataSource;
    adcLog: TADOCommand;
    adcScanTo: TADOCommand;
    adqGroup: TADOQuery;
    dqGroup: TDataSource;
    adqLay: TADOQuery;
    dqLay: TDataSource;
    adcMail: TADOCommand;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{$R *.dfm}

function setLog(idCat:Integer; lInfo : String) : boolean;
begin
  dm.adcLog.CommandText := 'insert into tr_log (logBy,idcat,loginfo) ' +
                           ' values (' + QuotedStr(trim(dm.adOTO.CurrentUserName)) + ','+ IntToStr(idCat) +','+ QuotedStr(lInfo) + ');';
  dm.adcLog.Execute;
end;

function setScanTo(idsg,remindIn:Integer; scanName,remindWhen : String; isReminder,remindOnce : byte ) : boolean;
begin
  dm.adcScanTo.CommandText :=   'insert into tr_ScanTo (scanBy, idsg, scanName, isReminder, remindWhen, remindOnce, isNoticed, noticedBy, noticedWhen) ' +
                                ' values (' + QuotedStr(trim(dm.adOTO.CurrentUserName))
                                + ','+ IntToStr(idsg)
                                + ','+ QuotedStr(scanName)
                                + ','+ IntToStr(isReminder)
                                + ','+ IntToStr(remindIn)
                                + ','+ QuotedStr(remindWhen)
                                + ','+ IntToStr(remindOnce) + ');';
  dm.adcScanTo.Execute;
end;

function setMail(scMailTo, scBody, scAttach : String ) : boolean;
begin
  dm.adcMail.CommandText :=   'insert into tr_mail (scanBy,scMailTo, scBody, scAttach) ' +
                              ' values (' + QuotedStr(trim(dm.adOTO.CurrentUserName))
                                + ','+ QuotedStr(scMailTo)
                                + ','+ QuotedStr(scBody)
                                + ','+ QuotedStr(scAttach) + ');';
  dm.adcMail.Execute;
end;

function readScanGroup(resColumn:integer) : TStringList;
var i : integer;
begin
  result := TStringList.Create;
  dm.adqSGroup.Open;
  dm.adqSGroup.First;
    for i := 0 to dm.adqSGroup.RecordCount - 1 do
      begin
        result.Add(dm.adqSGroup.Fields[resColumn].AsString);
        dm.adqSGroup.Next;
      end;
  dm.adqSGroup.Close;
end;

function getScanGroup(idxCB:integer) : TStringList;
begin
  result := TStringList.Create;
  if not dm.adqSGroup.Active then dm.adqSGroup.Open;
  dm.adqSGroup.Locate('idsg',idxCB, []);
  result.Add(dm.adqSGroup.Fields[1].asString);      // 0 GroupDir
  result.Add(dm.adqSGroup.Fields[2].asString);      // 1 GroupName
  result.Add(dm.adqSGroup.Fields[3].asString);      // 2 DocInfo
  result.Add(dm.adqSGroup.Fields[4].asString);      // 3 DocMail
  if dm.adqSGroup.Active then dm.adqSGroup.Close;
end;

function readGroup(resColumn:integer) : TStringList;
var i : integer;
begin
  result := TStringList.Create;
  dm.adqGroup.Open;
  dm.adqGroup.First;
    for i := 0 to dm.adqGroup.RecordCount - 1 do
      begin
        result.Add(dm.adqGroup.Fields[resColumn].AsString);
        dm.adqGroup.Next;
      end;
  dm.adqGroup.Close;
end;

function getGroup(idxCB:integer) : TStringList;
begin
  result := TStringList.Create;
  if not dm.adqGroup.Active then dm.adqGroup.Open;
  dm.adqGroup.Locate('ids',idxCB, []);
  result.Add(dm.adqGroup.Fields[1].asString);            // 0 GroupDir
  result.Add(dm.adqGroup.Fields[2].asString);            // 1 fCrow
  if dm.adqGroup.Active then dm.adqGroup.Close;
end;

function getLayOut(idxCB:integer) : TStringList;
begin
  result := TStringList.Create;
  if not dm.adqLay.Active then dm.adqLay.Open;
  dm.adqLay.Locate('idlay',idxCB, []);
  result.Add(dm.adqLay.Fields[1].asString);              // 0 layComp
  result.Add(dm.adqLay.Fields[2].asString);              // 1 layLogo
  result.Add(BoolToStr(dm.adqLay.Fields[3].AsBoolean));  // 2 isSimple
  result.Add(BoolToStr(dm.adqLay.Fields[4].AsBoolean));  // 3 isCOP
  result.Add(BoolToStr(dm.adqLay.Fields[5].AsBoolean));  // 4 isBPK
  result.Add(BoolToStr(dm.adqLay.Fields[6].AsBoolean));  // 5 isOle
  result.Add(BoolToStr(dm.adqLay.Fields[7].AsBoolean));  // 6 isInt
  result.Add(BoolToStr(dm.adqLay.Fields[8].AsBoolean));  // 7 isOth
  result.Add(IntToStr(dm.adqLay.Fields[9].AsInteger));   // 8 DocCheck
  if dm.adqLay.Active then dm.adqLay.Close;
end;

function getDBConfig(configID : integer) : String;
begin
  if not dm.cdsDBCfg.Active then dm.cdsDBCfg.Open;
  dm.cdsDBCfg.Locate('id',configID, []);
  Result := dm.cdsDBCfg.Fields[2].asString;
  if dm.cdsDBCfg.Active then dm.cdsDBCfg.Close;
end;

function docCheck(dtLayOut:TStringList):Integer;
var i : Integer;
begin
  result := 0;
  for i := 3 to 5 do //isCOP, isBPK, isOLE
    begin
      if dtLayOut.Strings[i] <> '0' then
        begin
          if FileExists( ExtractFilePath(Application.ExeName) + (getGroup(i-2)).Strings[1] + '.dat' ) then inc(result,1);
        end;
    end;
end;

function docLayOut(dtLayOut:TStringList):TStringList;
var i : Integer;
begin
  result := TStringList.Create;
  for i := 3 to 5 do //isCOP, isBPK, isOLE, isInt
    begin
      if dtLayOut.Strings[i] <> '0'
         then Result.Add((getGroup(i-2)).Strings[0]+'|'+(getGroup(i-2)).Strings[1])
         else Result.Add('-');
    end;
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  dm.sqlDBCfg.DatabaseName := ExtractFilePath(Application.ExeName) + '\dmsConf.db';
  dm.sqlDBGrp.DatabaseName := ExtractFilePath(Application.ExeName) + '\dmsConf.db';
end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin
{}
end;


end.
